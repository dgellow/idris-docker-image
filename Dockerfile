# Idris doesn't build with GHC 8.8
# See https://github.com/idris-lang/Idris-dev/issues/4845
FROM haskell:8.6 as base

RUN apt-get update && apt-get -y install build-essential gnupg2 &&\
    cabal update

FROM base as idris-install
ARG VERSION=1.3.2
USER root

RUN apt-get update && apt-get -y install build-essential &&\
    cabal update && cabal install idris-$VERSION &&\
    apt-get remove -y build-essential &&\
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["idris"]
CMD ["--help"]
