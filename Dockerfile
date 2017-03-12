FROM haskell

ARG VERSION

RUN apt-get update && apt-get -y install build-essential &&\
    cabal update && cabal install idris${VERSION} &&\
    apt-get remove build-essential &&\
    rm -rf /var/lib/apt/lists/*
CMD idris
