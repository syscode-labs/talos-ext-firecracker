# Changelog

## [1.12.0](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.11.3...talos-ext-firecracker-v1.12.0) (2026-08-09)


### Features

* **ci:** add gated release automation and commit quality checks ([bae1d24](https://github.com/syscode-labs/talos-ext-firecracker/commit/bae1d2481d0661474c22496768b4170ede712f44))
* **ci:** dispatch talos-images rebuild on release ([c0139c1](https://github.com/syscode-labs/talos-ext-firecracker/commit/c0139c136824230051c4af104760583105c65a3f))
* Firecracker v1.15.0, fix CI gitleaks, undraft releases on publish ([ac535c1](https://github.com/syscode-labs/talos-ext-firecracker/commit/ac535c1b5d9e0ce22274028f52a4ed0137dc45aa))


### Bug Fixes

* **ci:** bump actions to Node.js 24 compatible versions ([a23e21c](https://github.com/syscode-labs/talos-ext-firecracker/commit/a23e21cd73618aaf74fe15edb2caf6f5aa075c14))
* **ci:** match release-please tag format in publish trigger ([9385732](https://github.com/syscode-labs/talos-ext-firecracker/commit/9385732106eabfebaac4ceae2263e1c3cfd8fad1))
* **ci:** revert dispatch to send tag only not full image ref ([97c54ac](https://github.com/syscode-labs/talos-ext-firecracker/commit/97c54ac07d9644dc641c75f6dd53c95c6fbb5124))
* **ci:** send full image ref in dispatch payload; strip tag prefix ([78e9ee0](https://github.com/syscode-labs/talos-ext-firecracker/commit/78e9ee0424d35f90b7637a534e00f0eed1b77afb))
* document signing key rotation ([9aad245](https://github.com/syscode-labs/talos-ext-firecracker/commit/9aad2450673019dc8064ab038f49896f06bfc677))
* use full semver in Talos compatibility constraint (&gt;=1.7.0) ([938ec04](https://github.com/syscode-labs/talos-ext-firecracker/commit/938ec04e43910cedadd80880e0c40151d8740c05))


### Miscellaneous

* add README with release flow and usage ([4dc3fd1](https://github.com/syscode-labs/talos-ext-firecracker/commit/4dc3fd106f35bfe5f5daa720d1044444d0c1d69a))
* add Talos runtime-real provisioning and imp e2e runner scripts ([0514bb7](https://github.com/syscode-labs/talos-ext-firecracker/commit/0514bb7414574a9f4a66c989ec160ebe6c385f20))
* allow manual publish dispatch ([dd10ffb](https://github.com/syscode-labs/talos-ext-firecracker/commit/dd10ffbda76f99bee8ab5da018db983bc2e026ca))
* derive kubeconfig from talos context ([f4dd3b9](https://github.com/syscode-labs/talos-ext-firecracker/commit/f4dd3b965488ccf39cce1420fb6d21d7ef83f57f))
* enable buildkit for extension image build ([51e5002](https://github.com/syscode-labs/talos-ext-firecracker/commit/51e5002b1a5d968bc86f819afd7b37136760d3ae))
* ensure docker buildx for buildkit ([23fd319](https://github.com/syscode-labs/talos-ext-firecracker/commit/23fd319927cf8811fece1ca46e1a8652ac01c44b))
* install buildx fallback for cirrus hosts ([57705ed](https://github.com/syscode-labs/talos-ext-firecracker/commit/57705ed94b8973cf360806bd32b4337b3900cd65))
* install ovmf for talos qemu provisioning ([98dfe2f](https://github.com/syscode-labs/talos-ext-firecracker/commit/98dfe2f0ca3a2b349f4215fb8a9f5be13bedacf4))
* **main:** release talos-ext-firecracker 1.10.0 ([#1](https://github.com/syscode-labs/talos-ext-firecracker/issues/1)) ([1354b3e](https://github.com/syscode-labs/talos-ext-firecracker/commit/1354b3e351d9c553bebfda1105c6c60b8f09137f))
* **main:** release talos-ext-firecracker 1.10.1 ([#2](https://github.com/syscode-labs/talos-ext-firecracker/issues/2)) ([577d8cc](https://github.com/syscode-labs/talos-ext-firecracker/commit/577d8ccfa395937543b8dd07cfa689c389660174))
* **main:** release talos-ext-firecracker 1.11.0 ([a9a5805](https://github.com/syscode-labs/talos-ext-firecracker/commit/a9a5805067544cbe6341f8ef5e49b088d4863f9d))
* **main:** release talos-ext-firecracker 1.11.0 ([cb177a6](https://github.com/syscode-labs/talos-ext-firecracker/commit/cb177a643dd38971d9d54aac86aba83aabaa1274))
* **main:** release talos-ext-firecracker 1.11.1 ([1567aa0](https://github.com/syscode-labs/talos-ext-firecracker/commit/1567aa0af1d1a48abeace4237d2c7f211b2e3290))
* **main:** release talos-ext-firecracker 1.11.1 ([64ac9d7](https://github.com/syscode-labs/talos-ext-firecracker/commit/64ac9d7f1638d53dcdf4d4916a02607d0cd01a4c))
* **main:** release talos-ext-firecracker 1.11.2 ([dd3f06a](https://github.com/syscode-labs/talos-ext-firecracker/commit/dd3f06a5686b459d92bbb93d1aa1409b677b8515))
* **main:** release talos-ext-firecracker 1.11.2 ([1a6a5a1](https://github.com/syscode-labs/talos-ext-firecracker/commit/1a6a5a1686a4eb6c7e811de62c21713891a15af6))
* **main:** release talos-ext-firecracker 1.11.3 ([#7](https://github.com/syscode-labs/talos-ext-firecracker/issues/7)) ([9c649b4](https://github.com/syscode-labs/talos-ext-firecracker/commit/9c649b47bc374cbc7e9bc02593457da10dfa9d3b))
* publish runtime-real images and inject e2e image envs ([635c9d8](https://github.com/syscode-labs/talos-ext-firecracker/commit/635c9d8a90a33b725f2b296530ba17dab9890d93))
* remove unsupported wait-timeout flag for docker create ([0f94eda](https://github.com/syscode-labs/talos-ext-firecracker/commit/0f94eda4d258e867943466f1619978e8c8b864f5))
* **runtime:** set BUILDPLATFORM when building extension image ([1653059](https://github.com/syscode-labs/talos-ext-firecracker/commit/1653059ea91aba424f174d62b502d9c378fcb5ae))
* set runtime-real e2e eventually timeout env defaults ([cc40f3d](https://github.com/syscode-labs/talos-ext-firecracker/commit/cc40f3dc1daa26dc42d0cde881da9936deddd609))
* sign extension image with cosign ([a634174](https://github.com/syscode-labs/talos-ext-firecracker/commit/a6341745cfc85ea05cb7d45a3fa649715b70e595))
* trigger release-please ([c53d33c](https://github.com/syscode-labs/talos-ext-firecracker/commit/c53d33cd52fd55d2942c4728d757dbe63542f2ec))
* use merged kubeconfig from qemu cluster create ([74566dd](https://github.com/syscode-labs/talos-ext-firecracker/commit/74566dd5ada3484054598519870979636618a498))
* use qemu talos provisioner on cirrus ([47ecf13](https://github.com/syscode-labs/talos-ext-firecracker/commit/47ecf1334b28fac3cea7b266f22a95d585fefc63))
* use talosctl docker subcommand for cluster create ([87120c6](https://github.com/syscode-labs/talos-ext-firecracker/commit/87120c631c193462cac6347e7ca6a986083c7a6e))

## [1.11.3](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.11.2...talos-ext-firecracker-v1.11.3) (2026-07-17)


### Miscellaneous

* allow manual publish dispatch ([dd10ffb](https://github.com/syscode-labs/talos-ext-firecracker/commit/dd10ffbda76f99bee8ab5da018db983bc2e026ca))

## [1.11.2](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.11.1...talos-ext-firecracker-v1.11.2) (2026-07-17)


### Miscellaneous

* sign extension image with cosign ([a634174](https://github.com/syscode-labs/talos-ext-firecracker/commit/a6341745cfc85ea05cb7d45a3fa649715b70e595))

## [1.11.1](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.11.0...talos-ext-firecracker-v1.11.1) (2026-03-16)


### Bug Fixes

* **ci:** bump actions to Node.js 24 compatible versions ([a23e21c](https://github.com/syscode-labs/talos-ext-firecracker/commit/a23e21cd73618aaf74fe15edb2caf6f5aa075c14))

## [1.11.0](https://github.com/syscode-labs/talos-ext-firecracker/compare/talos-ext-firecracker-v1.10.1...talos-ext-firecracker-v1.11.0) (2026-03-16)


### Features

* Firecracker v1.15.0, fix CI gitleaks, undraft releases on publish ([ac535c1](https://github.com/syscode-labs/talos-ext-firecracker/commit/ac535c1b5d9e0ce22274028f52a4ed0137dc45aa))

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
