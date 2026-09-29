# OmiGA 1.8.17
# Tag must match conda version: quay.io/bioinfortools/omiga:1.8.17
FROM public.ecr.aws/docker/library/ubuntu:22.04

LABEL org.opencontainers.image.title="omiga" \
      org.opencontainers.image.version="1.8.17" \
      org.opencontainers.image.description="OmiGA Omics Genetic Analysis toolkit (CPU build)" \
      org.opencontainers.image.source="https://github.com/SiYangming/OmiGA"

ENV DEBIAN_FRONTEND=noninteractive \
    OMIGA_HOME=/opt/omiga \
    PATH=/opt/omiga/bin:$PATH

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Build context must include upstream/OmiGA-build-v1.8.17-x86_64.tar.xz (gitignored)
COPY upstream/OmiGA-build-v1.8.17-x86_64.tar.xz /tmp/omiga.tar.xz

RUN mkdir -p /opt \
    && tar -xJf /tmp/omiga.tar.xz -C /opt \
    && mv /opt/OmiGA-build-v1.8.17 ${OMIGA_HOME} \
    && rm -f /tmp/omiga.tar.xz \
    && chmod +x ${OMIGA_HOME}/bin/omiga \
    && omiga --init || true

WORKDIR /data
