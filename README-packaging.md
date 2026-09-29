# Packaging notes (fork of SCAU-AnimalGenetics/OmiGA)

| Field | Value |
|-------|-------|
| Version | `1.8.17` (conda == Docker tag) |
| Upstream binary | `OmiGA-build-v1.8.17-x86_64.tar.xz` from https://omiga.bio |
| SHA256 | `6cfbed0b52085489d5a4b4b549c2343e6ae53921474087cdf28876c2c214ea23` |
| Conda | `YangmingSi::omiga=1.8.17` |
| Docker | `quay.io/bioinfortools/omiga:1.8.17` |

The official tarball is ~238 MB (extracted ~1.4 GB Julia runtime). It is **not** stored in git; download from the matching GitHub Release asset or omiga.bio `releases/latest.json`.

## Build

```bash
# Place tarball next to Dockerfile for local docker build:
#   upstream/OmiGA-build-v1.8.17-x86_64.tar.xz
conda activate conda_build

docker build --platform linux/amd64 -t quay.io/bioinfortools/omiga:1.8.17 .
docker push quay.io/bioinfortools/omiga:1.8.17

rattler-build build -r recipe --target-platform linux-64
anaconda upload -u YangmingSi output/linux-64/omiga-*.conda
```

After first release upload, recipe `source.url` points at:
`https://github.com/SiYangming/OmiGA/releases/download/1.8.17/OmiGA-build-v1.8.17-x86_64.tar.xz`
