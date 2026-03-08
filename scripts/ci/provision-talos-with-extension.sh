#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${TALOS_CLUSTER_NAME:-imp-runtime}"
WORKDIR="${TALOS_WORKDIR:-/tmp/talos-runtime}"
EXT_REPO_DIR="${EXT_REPO_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

mkdir -p "$WORKDIR"

install_talosctl() {
  if command -v talosctl >/dev/null 2>&1; then
    talosctl version --client || true
    return
  fi
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) TALOS_ARCH="amd64" ;;
    aarch64|arm64) TALOS_ARCH="arm64" ;;
    *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;;
  esac
  curl -fsSL "https://github.com/siderolabs/talos/releases/latest/download/talosctl-linux-${TALOS_ARCH}" -o /usr/local/bin/talosctl
  chmod +x /usr/local/bin/talosctl
}

install_kubectl() {
  if command -v kubectl >/dev/null 2>&1; then
    kubectl version --client=true --output=yaml >/dev/null || true
    return
  fi
  ARCH="$(uname -m)"
  case "$ARCH" in
    x86_64) K_ARCH="amd64" ;;
    aarch64|arm64) K_ARCH="arm64" ;;
    *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;;
  esac
  K_VER="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
  curl -fsSL "https://dl.k8s.io/release/${K_VER}/bin/linux/${K_ARCH}/kubectl" -o /usr/local/bin/kubectl
  chmod +x /usr/local/bin/kubectl
}

ensure_docker() {
  if command -v docker >/dev/null 2>&1; then
    if docker info >/dev/null 2>&1; then
      return
    fi
  fi

  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends docker.io

  mkdir -p /var/run
  nohup dockerd --host=unix:///var/run/docker.sock --storage-driver=vfs --iptables=false >/tmp/dockerd.log 2>&1 &

  for _ in $(seq 1 90); do
    if docker info >/dev/null 2>&1; then
      return
    fi
    sleep 1
  done

  echo "Docker daemon failed to start" >&2
  tail -n 200 /tmp/dockerd.log || true
  exit 1
}

install_buildx_fallback() {
  local arch bx_arch bx_version plugin_dir
  arch="$(uname -m)"
  case "$arch" in
    x86_64) bx_arch="amd64" ;;
    aarch64|arm64) bx_arch="arm64" ;;
    *) echo "Unsupported arch for buildx: $arch" >&2; exit 1 ;;
  esac

  bx_version="$(curl -fsSL https://api.github.com/repos/docker/buildx/releases/latest | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
  if [ -z "$bx_version" ]; then
    echo "Could not resolve latest docker/buildx release" >&2
    exit 1
  fi

  plugin_dir="$HOME/.docker/cli-plugins"
  mkdir -p "$plugin_dir"
  curl -fsSL "https://github.com/docker/buildx/releases/download/${bx_version}/buildx-${bx_version}.linux-${bx_arch}" -o "$plugin_dir/docker-buildx"
  chmod +x "$plugin_dir/docker-buildx"
}

ensure_docker_buildx() {
  if docker buildx version >/dev/null 2>&1; then
    return
  fi

  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends docker-buildx-plugin || true

  if docker buildx version >/dev/null 2>&1; then
    return
  fi

  install_buildx_fallback

  if docker buildx version >/dev/null 2>&1; then
    return
  fi

  echo "docker buildx is required for BuildKit-based extension build" >&2
  exit 1
}

ensure_qemu() {
  if command -v qemu-system-x86_64 >/dev/null 2>&1 || command -v qemu-kvm >/dev/null 2>&1; then
    return
  fi

  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends qemu-system-x86 qemu-utils ovmf
}

build_extension_image() {
  local tag="local/talos-ext-firecracker:ci"
  echo "Building extension image from $EXT_REPO_DIR"
  DOCKER_BUILDKIT=1 docker build --build-arg BUILDPLATFORM=linux/amd64 -t "$tag" "$EXT_REPO_DIR"
  echo "Built extension image: $tag"
}

create_talos_cluster() {
  # Best-effort cleanup from prior runs.
  talosctl cluster destroy --name "$CLUSTER_NAME" >/dev/null 2>&1 || true

  talosctl cluster create qemu --name "$CLUSTER_NAME"

  talosctl kubeconfig "$WORKDIR/kubeconfig"
  export KUBECONFIG="$WORKDIR/kubeconfig"

  kubectl wait --for=condition=Ready node --all --timeout=10m
  kubectl get nodes -o wide
}

write_runtime_env() {
  cat > "$WORKDIR/runtime.env" <<ENV
export TALOS_CLUSTER_NAME=${CLUSTER_NAME}
export KUBECONFIG=${WORKDIR}/kubeconfig
export TALOS_RUNTIME_WORKDIR=${WORKDIR}
ENV
}

install_talosctl
install_kubectl
ensure_docker
ensure_docker_buildx
ensure_qemu
build_extension_image
create_talos_cluster
write_runtime_env

echo "Talos cluster is ready. Source $WORKDIR/runtime.env in subsequent steps."
