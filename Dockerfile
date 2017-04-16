FROM dgellow/idris-base:latest

ARG VERSION

RUN apt-get update && apt-get -y install build-essential &&\
    cabal update && cabal install idris${VERSION} &&\
    apt-get remove -y build-essential &&\
    rm -rf /var/lib/apt/lists/*
CMD idris
