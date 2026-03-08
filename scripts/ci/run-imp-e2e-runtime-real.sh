#!/usr/bin/env bash
set -euo pipefail

IMP_REPO_DIR="${IMP_REPO_DIR:-/tmp/imp}"
E2E_LABEL_FILTER="${E2E_LABEL_FILTER:-runtime-real}"
TALOS_RUNTIME_WORKDIR="${TALOS_RUNTIME_WORKDIR:-/tmp/talos-runtime}"
IMAGE_TTL_TAG="${IMAGE_TTL_TAG:-12h}"
IMP_E2E_EVENTUALLY_TIMEOUT="${IMP_E2E_EVENTUALLY_TIMEOUT:-5m}"
IMP_E2E_EVENTUALLY_POLL_INTERVAL="${IMP_E2E_EVENTUALLY_POLL_INTERVAL:-2s}"

if [ -f "$TALOS_RUNTIME_WORKDIR/runtime.env" ]; then
  # shellcheck disable=SC1090,SC1091
  source "$TALOS_RUNTIME_WORKDIR/runtime.env"
fi

if [ -z "${KUBECONFIG:-}" ] || [ ! -f "$KUBECONFIG" ]; then
  echo "KUBECONFIG is not set to a valid file. Did provisioning run?" >&2
  exit 1
fi

if [ ! -d "$IMP_REPO_DIR" ]; then
  echo "IMP repo directory not found: $IMP_REPO_DIR" >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required to build/publish runtime-real images" >&2
  exit 1
fi

cd "$IMP_REPO_DIR"

echo "Using kubeconfig: $KUBECONFIG"
kubectl get nodes -o wide

suffix="${CIRRUS_CHANGE_IN_REPO:-$(date +%s)}"
suffix="${suffix:0:12}"
operator_repo="ttl.sh/imp-operator-${suffix}"
agent_repo="ttl.sh/imp-agent-${suffix}"

echo "Building and publishing runtime images"
DOCKER_BUILDKIT=1 docker build -f Dockerfile.operator -t "${operator_repo}:${IMAGE_TTL_TAG}" .
DOCKER_BUILDKIT=1 docker build -f Dockerfile.agent -t "${agent_repo}:${IMAGE_TTL_TAG}" .
docker push "${operator_repo}:${IMAGE_TTL_TAG}"
docker push "${agent_repo}:${IMAGE_TTL_TAG}"

echo "Operator image: ${operator_repo}:${IMAGE_TTL_TAG}"
echo "Agent image: ${agent_repo}:${IMAGE_TTL_TAG}"

IMP_E2E_OPERATOR_IMAGE_REPOSITORY="$operator_repo" \
IMP_E2E_OPERATOR_IMAGE_TAG="$IMAGE_TTL_TAG" \
IMP_E2E_AGENT_IMAGE_REPOSITORY="$agent_repo" \
IMP_E2E_AGENT_IMAGE_TAG="$IMAGE_TTL_TAG" \
IMP_E2E_EVENTUALLY_TIMEOUT="$IMP_E2E_EVENTUALLY_TIMEOUT" \
IMP_E2E_EVENTUALLY_POLL_INTERVAL="$IMP_E2E_EVENTUALLY_POLL_INTERVAL" \
go test -tags e2e ./test/e2e/... -v -timeout 30m -ginkgo.label-filter="$E2E_LABEL_FILTER"
