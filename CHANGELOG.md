# Changelog

## [1.10.1](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.10.0...talos-ext-firecracker-v1.10.1) (2026-03-10)


### Bug Fixes

* **ci:** revert dispatch to send tag only not full image ref ([97c54ac](https://github.com/syscode-labs/talos-ext-firecracker/commit/97c54ac07d9644dc641c75f6dd53c95c6fbb5124))
* **ci:** send full image ref in dispatch payload; strip tag prefix ([78e9ee0](https://github.com/syscode-labs/talos-ext-firecracker/commit/78e9ee0424d35f90b7637a534e00f0eed1b77afb))
* use full semver in Talos compatibility constraint (&gt;=1.7.0) ([938ec04](https://github.com/syscode-labs/talos-ext-firecracker/commit/938ec04e43910cedadd80880e0c40151d8740c05))

## [1.10.0](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.9.0...talos-ext-firecracker-v1.10.0) (2026-03-10)


### Features

* **ci:** add gated release automation and commit quality checks ([bae1d24](https://github.com/syscode-labs/talos-ext-firecracker/commit/bae1d2481d0661474c22496768b4170ede712f44))
* **ci:** dispatch talos-images rebuild on release ([c0139c1](https://github.com/syscode-labs/talos-ext-firecracker/commit/c0139c136824230051c4af104760583105c65a3f))


### Miscellaneous

* add README with release flow and usage ([4dc3fd1](https://github.com/syscode-labs/talos-ext-firecracker/commit/4dc3fd106f35bfe5f5daa720d1044444d0c1d69a))
* add Talos runtime-real provisioning and imp e2e runner scripts ([0514bb7](https://github.com/syscode-labs/talos-ext-firecracker/commit/0514bb7414574a9f4a66c989ec160ebe6c385f20))
* derive kubeconfig from talos context ([f4dd3b9](https://github.com/syscode-labs/talos-ext-firecracker/commit/f4dd3b965488ccf39cce1420fb6d21d7ef83f57f))
* enable buildkit for extension image build ([51e5002](https://github.com/syscode-labs/talos-ext-firecracker/commit/51e5002b1a5d968bc86f819afd7b37136760d3ae))
* ensure docker buildx for buildkit ([23fd319](https://github.com/syscode-labs/talos-ext-firecracker/commit/23fd319927cf8811fece1ca46e1a8652ac01c44b))
* install buildx fallback for cirrus hosts ([57705ed](https://github.com/syscode-labs/talos-ext-firecracker/commit/57705ed94b8973cf360806bd32b4337b3900cd65))
* install ovmf for talos qemu provisioning ([98dfe2f](https://github.com/syscode-labs/talos-ext-firecracker/commit/98dfe2f0ca3a2b349f4215fb8a9f5be13bedacf4))
* publish runtime-real images and inject e2e image envs ([635c9d8](https://github.com/syscode-labs/talos-ext-firecracker/commit/635c9d8a90a33b725f2b296530ba17dab9890d93))
* remove unsupported wait-timeout flag for docker create ([0f94eda](https://github.com/syscode-labs/talos-ext-firecracker/commit/0f94eda4d258e867943466f1619978e8c8b864f5))
* **runtime:** set BUILDPLATFORM when building extension image ([1653059](https://github.com/syscode-labs/talos-ext-firecracker/commit/1653059ea91aba424f174d62b502d9c378fcb5ae))
* set runtime-real e2e eventually timeout env defaults ([cc40f3d](https://github.com/syscode-labs/talos-ext-firecracker/commit/cc40f3dc1daa26dc42d0cde881da9936deddd609))
* trigger release-please ([c53d33c](https://github.com/syscode-labs/talos-ext-firecracker/commit/c53d33cd52fd55d2942c4728d757dbe63542f2ec))
* use merged kubeconfig from qemu cluster create ([74566dd](https://github.com/syscode-labs/talos-ext-firecracker/commit/74566dd5ada3484054598519870979636618a498))
* use qemu talos provisioner on cirrus ([47ecf13](https://github.com/syscode-labs/talos-ext-firecracker/commit/47ecf1334b28fac3cea7b266f22a95d585fefc63))
* use talosctl docker subcommand for cluster create ([87120c6](https://github.com/syscode-labs/talos-ext-firecracker/commit/87120c631c193462cac6347e7ca6a986083c7a6e))

## Changelog

All notable changes to this project will be documented in this file.
