#!/usr/bin/env bash
set -euo pipefail

IMP_REPO_DIR="${IMP_REPO_DIR:-/tmp/imp}"
E2E_LABEL_FILTER="${E2E_LABEL_FILTER:-runtime-real}"
TALOS_RUNTIME_WORKDIR="${TALOS_RUNTIME_WORKDIR:-/tmp/talos-runtime}"

if [ -f "$TALOS_RUNTIME_WORKDIR/runtime.env" ]; then
  # shellcheck disable=SC1090
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

cd "$IMP_REPO_DIR"

echo "Using kubeconfig: $KUBECONFIG"
kubectl get nodes -o wide

go test -tags e2e ./test/e2e/... -v -timeout 30m -ginkgo.label-filter="$E2E_LABEL_FILTER"
