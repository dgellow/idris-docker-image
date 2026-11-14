# syntax=docker/dockerfile:1

ARG DEBIAN_VERSION=trixie

FROM debian:${DEBIAN_VERSION}-slim AS build

ARG IDRIS2_VERSION=v0.8.0

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      chezscheme \
      gcc \
      libc6-dev \
      libgmp-dev \
      make \
 && rm -rf /var/lib/apt/lists/*

ADD https://github.com/idris-lang/Idris2.git#${IDRIS2_VERSION} /src
WORKDIR /src

# The install prefix is baked into the compiler, so it has to be the same path
# in the final image. Only idris2.so is run by the launcher script: the
# bootstrap compiler and the Scheme sources installed next to it are dropped.
RUN make bootstrap SCHEME=chezscheme PREFIX=/opt/idris2 \
 && make install PREFIX=/opt/idris2 \
 && rm /opt/idris2/bin/idris2_app/idris2-boot.so \
       /opt/idris2/bin/idris2_app/idris2-boot.ss \
       /opt/idris2/bin/idris2_app/idris2.ss

FROM debian:${DEBIAN_VERSION}-slim

ARG IDRIS2_VERSION=v0.8.0

LABEL org.opencontainers.image.title="Idris 2" \
      org.opencontainers.image.description="Idris 2, a purely functional programming language with first class types" \
      org.opencontainers.image.version="${IDRIS2_VERSION}" \
      org.opencontainers.image.url="https://www.idris-lang.org/" \
      org.opencontainers.image.source="https://github.com/dgellow/idris-docker-image" \
      org.opencontainers.image.licenses="BSD-3-Clause"

# Chez Scheme runs the compiler itself and is its default code generator.
RUN apt-get update \
 && apt-get install -y --no-install-recommends chezscheme \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/idris2 /opt/idris2

ENV PATH=/opt/idris2/bin:$PATH

ENTRYPOINT ["idris2"]
