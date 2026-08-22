#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCKERFILE="${ROOT_DIR}/Dockerfile"
MANIFEST="${ROOT_DIR}/manifest.yaml"

fail() {
  echo "verification failed: $*" >&2
  exit 1
}

require_file() {
  [[ -f "$1" ]] || fail "missing file: $1"
}

require_file "${DOCKERFILE}"
require_file "${MANIFEST}"

grep -q '^  name: firecracker$' "${MANIFEST}" || fail "manifest name is not pinned"
grep -Eq '^  version: [0-9]+\.[0-9]+\.[0-9]+([-.][0-9A-Za-z.]+)?$' "${MANIFEST}" \
  || fail "manifest version is not a semantic version"
grep -q 'pinned Imp guest vmlinux' "${MANIFEST}" || fail "manifest description is missing the guest kernel"

grep -q 'FIRECRACKER_VERSION=v1\.15\.0' "${DOCKERFILE}" || fail "Firecracker version is not pinned"
grep -q 'FIRECRACKER_CI_PREFIX=https://s3\.amazonaws\.com/spec\.ccfc\.min/firecracker-ci/v1\.15' "${DOCKERFILE}" \
  || fail "guest kernel source is not pinned"
grep -q 'KERNEL_VERSION=6\.1\.155' "${DOCKERFILE}" || fail "guest kernel version is not pinned"

for digest in \
  00cadf7f21e709e939dc0c8d16e2d2ce7b975a62bec6c50f74b421cc8ab3cab4 \
  58325e6c3c539482a412ec0b60e6f539c3320adebcf8179c7629d06736aee0bd \
  e20e46d0c36c55c0d1014eb20576171b3f3d922260d9f792017aeff53af3d4f2 \
  e3544b10603acbf3db492cb52e000d22ba202cb4b63b9add027565683e11c591; do
  grep -q "${digest}" "${DOCKERFILE}" || fail "missing SHA-256 pin: ${digest}"
done

grep -q 'amd64) ARCH="x86_64"' "${DOCKERFILE}" || fail "amd64 architecture mapping is missing"
grep -q 'arm64) ARCH="aarch64"' "${DOCKERFILE}" || fail "arm64 architecture mapping is missing"

for path in \
  /usr/local/bin/firecracker \
  /usr/local/bin/jailer \
  /usr/local/share/imp/vmlinux; do
  grep -q "${path}" "${DOCKERFILE}" || fail "required installed path is missing: ${path}"
done

if [[ "${VERIFY_REMOTE:-false}" == "true" ]]; then
  command -v curl >/dev/null 2>&1 || fail "curl is required for VERIFY_REMOTE=true"
  command -v sha256sum >/dev/null 2>&1 || fail "sha256sum is required for VERIFY_REMOTE=true"

  tmp_dir="$(mktemp -d)"
  trap 'rm -rf "${tmp_dir}"' EXIT
  base="https://s3.amazonaws.com/spec.ccfc.min/firecracker-ci/v1.15"
  curl -fsSL "${base}/x86_64/vmlinux-6.1.155" -o "${tmp_dir}/x86_64"
  curl -fsSL "${base}/aarch64/vmlinux-6.1.155" -o "${tmp_dir}/aarch64"
  printf '%s  %s\n' e20e46d0c36c55c0d1014eb20576171b3f3d922260d9f792017aeff53af3d4f2 "${tmp_dir}/x86_64" | sha256sum -c -
  printf '%s  %s\n' e3544b10603acbf3db492cb52e000d22ba202cb4b63b9add027565683e11c591 "${tmp_dir}/aarch64" | sha256sum -c -
fi

echo "Firecracker extension pins and installed paths verified"
