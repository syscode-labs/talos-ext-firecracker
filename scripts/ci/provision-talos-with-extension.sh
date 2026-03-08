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

  echo "docker buildx is required for BuildKit-based extension build" >&2
  exit 1
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

  talosctl cluster create --name "$CLUSTER_NAME" --provisioner docker --wait-timeout 15m

  talosctl kubeconfig --nodes 127.0.0.1 --endpoints 127.0.0.1 "$WORKDIR/kubeconfig"
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
build_extension_image
create_talos_cluster
write_runtime_env

echo "Talos cluster is ready. Source $WORKDIR/runtime.env in subsequent steps."
