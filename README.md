# Talos Firecracker Extension

[![CI](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/ci.yml/badge.svg)](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/ci.yml)
[![Release Please](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/release-please.yml/badge.svg)](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/release-please.yml)
[![Publish](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/release.yml/badge.svg)](https://github.com/syscode-labs/talos-ext-firecracker/actions/workflows/release.yml)
[![GHCR](https://img.shields.io/badge/registry-ghcr.io-blue)](https://ghcr.io/syscode-labs/talos-ext-firecracker)
[![Talos](https://img.shields.io/badge/talos-%3E%3D1.7-0f62fe)](https://www.talos.dev/)
[![Firecracker](https://img.shields.io/badge/firecracker-v1.9.0-orange)](https://github.com/firecracker-microvm/firecracker/releases/tag/v1.9.0)
[![Platforms](https://img.shields.io/badge/platforms-amd64%20%7C%20arm64-brightgreen)](#)
[![License](https://img.shields.io/badge/license-Apache--2.0-green)](https://www.apache.org/licenses/LICENSE-2.0)

This repo builds a **Talos system extension** that adds:

- `firecracker`
- `jailer`

In plain terms: it gives a Talos node the Firecracker binaries so that higher-level systems can start lightweight microVMs.

## What This Does

1. Downloads Firecracker release tarballs for `amd64` and `arm64`
2. Verifies tarball checksums before extracting
3. Packages binaries into a Talos extension image
4. Publishes multi-arch images to GHCR on tagged releases

## How Release Flow Works

```mermaid
flowchart LR
  A[Push to main] --> B[CI: lint + build]
  B --> C[Release Please opens/updates PR]
  C --> D[You review and merge release PR]
  D --> E[Tag created]
  E --> F[Publish workflow]
  F --> G[GHCR image + GitHub Release]
```

## Quick Start

Build locally:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t talos-ext-firecracker:test .
```

Run local checks:

```bash
pre-commit run --all-files
```

Install git hooks:

```bash
pre-commit install
pre-commit install --hook-type commit-msg
```

## Key Files

- [`Dockerfile`](Dockerfile): downloads, verifies, and installs Firecracker binaries
- [`manifest.yaml`](manifest.yaml): Talos extension metadata
- [`.github/workflows/ci.yml`](.github/workflows/ci.yml): lint/build checks
- [`.github/workflows/release-please.yml`](.github/workflows/release-please.yml): automated release PRs
- [`.github/workflows/release.yml`](.github/workflows/release.yml): publish on tags
- [`docs/release-process.md`](docs/release-process.md): release policy notes

## Links

- Talos extensions docs: https://www.talos.dev/latest/talos-guides/configuration/system-extensions/
- Firecracker docs: https://firecracker-microvm.github.io/
- Container image: https://ghcr.io/syscode-labs/talos-ext-firecracker
