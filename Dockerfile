# syntax=docker/dockerfile:1
# Talos system extension: packages Firecracker + Jailer for Talos Linux nodes.
# Ref: https://www.talos.dev/latest/talos-guides/configuration/system-extensions/

ARG FIRECRACKER_VERSION=v1.9.0
ARG FIRECRACKER_SHA256_X86_64=95c13740c7ca1a6dfb40e0f51cd0a9eefee1f223cd2c3538755d03c3a9ba5237
ARG FIRECRACKER_SHA256_AARCH64=c5564e76dec2b8e8092c52f0f8a4c5f45cf31791e95a9302f4360a771df78f69

# -- download stage -----------------------------------------------------------
FROM --platform=${BUILDPLATFORM} alpine:3.21 AS download
ARG FIRECRACKER_VERSION
ARG FIRECRACKER_SHA256_X86_64
ARG FIRECRACKER_SHA256_AARCH64
ARG TARGETARCH

# hadolint ignore=DL3018
RUN apk add --no-cache curl && \
    case "${TARGETARCH}" in \
      amd64) ARCH="x86_64"; SHA256="${FIRECRACKER_SHA256_X86_64}" ;; \
      arm64) ARCH="aarch64"; SHA256="${FIRECRACKER_SHA256_AARCH64}" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}" >&2 && exit 1 ;; \
    esac && \
    URL="https://github.com/firecracker-microvm/firecracker/releases/download/${FIRECRACKER_VERSION}/firecracker-${FIRECRACKER_VERSION}-${ARCH}.tgz" && \
    curl -fsSL "${URL}" -o /tmp/firecracker.tgz && \
    printf '%s  %s\n' "${SHA256}" "/tmp/firecracker.tgz" > /tmp/firecracker.sha256 && \
    sha256sum -c /tmp/firecracker.sha256 && \
    tar -xzf /tmp/firecracker.tgz -C /tmp && \
    install -Dm755 \
      "/tmp/release-${FIRECRACKER_VERSION}-${ARCH}/firecracker-${FIRECRACKER_VERSION}-${ARCH}" \
      /out/rootfs/usr/local/bin/firecracker && \
    install -Dm755 \
      "/tmp/release-${FIRECRACKER_VERSION}-${ARCH}/jailer-${FIRECRACKER_VERSION}-${ARCH}" \
      /out/rootfs/usr/local/bin/jailer

# -- extension image ----------------------------------------------------------
# Files under /rootfs/ are overlaid onto the Talos node filesystem at boot.
FROM scratch
COPY --from=download /out/rootfs/ /rootfs/
COPY manifest.yaml /
