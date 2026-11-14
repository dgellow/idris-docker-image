# syntax=docker/dockerfile:1

ARG DEBIAN_VERSION=bookworm

FROM debian:${DEBIAN_VERSION}-slim AS build

ARG IDRIS_VERSION=1.3.4
# Idris 1 is only tested against GHC 8.6 and 8.8.
ARG GHC_VERSION=8.8.4
ARG CABAL_VERSION=3.16.1.0
ARG GHCUP_VERSION=0.2.6.2
# Hackage snapshot used to resolve dependencies, for reproducible builds.
ARG HACKAGE_INDEX_STATE=2021-10-31T00:00:00Z

ENV GHCUP_INSTALL_BASE_PREFIX=/opt \
    PATH=/opt/.ghcup/bin:$PATH

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      g++ \
      gcc \
      libc6-dev \
      libffi-dev \
      libgmp-dev \
      libncurses-dev \
      libtinfo5 \
      make \
      xz-utils \
      zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /usr/local/bin/ghcup \
      "https://downloads.haskell.org/~ghcup/${GHCUP_VERSION}/$(uname -m)-linux-ghcup-${GHCUP_VERSION}" \
 && chmod +x /usr/local/bin/ghcup \
 && ghcup install ghc "${GHC_VERSION}" --set \
 && ghcup install cabal "${CABAL_VERSION}" --set

# Idris locates its libraries and RTS through an absolute path into the cabal
# store, so the store lives at the same path in both stages. Only bin/ and
# share/ of the idris package are needed at runtime.
RUN cabal update "hackage.haskell.org,${HACKAGE_INDEX_STATE}" \
 && cabal --store-dir=/opt/idris/store install "idris-${IDRIS_VERSION}" \
      --constraint="idris +release" \
      --installdir=/opt/idris/bin \
      --install-method=symlink \
 && pkg="$(dirname "$(dirname "$(readlink -f /opt/idris/bin/idris)")")" \
 && mkdir -p /out \
 && cp -a --parents "${pkg}/bin" "${pkg}/share" /opt/idris/bin /out \
 && strip "/out${pkg}"/bin/*

FROM debian:${DEBIAN_VERSION}-slim

ARG IDRIS_VERSION=1.3.4

LABEL org.opencontainers.image.title="Idris" \
      org.opencontainers.image.description="Idris 1, a dependently typed functional programming language" \
      org.opencontainers.image.version="${IDRIS_VERSION}" \
      org.opencontainers.image.url="https://www.idris-lang.org/" \
      org.opencontainers.image.source="https://github.com/dgellow/idris-docker-image" \
      org.opencontainers.image.licenses="BSD-3-Clause"

# The C backend needs a C compiler to produce executables.
RUN apt-get update \
 && apt-get install -y --no-install-recommends gcc libc6-dev \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /out/ /

ENV PATH=/opt/idris/bin:$PATH

ENTRYPOINT ["idris"]
