FROM haskell:8.6 as base

RUN apt-get update && apt-get -y install build-essential gnupg2 &&\
    cabal update

FROM base as nix-install

RUN useradd -ms /bin/bash nix && mkdir -m 0755 /nix && chown nix /nix

USER nix
WORKDIR /home/nix

RUN curl -o install-nix-2.3.4 https://releases.nixos.org/nix/nix-2.3.4/install &&\
    curl -o install-nix-2.3.4.asc https://releases.nixos.org/nix/nix-2.3.4/install.asc &&\
    gpg2 --recv-keys B541D55301270E0BCF15CA5D8170B4726D7198DE &&\
    gpg2 --verify ./install-nix-2.3.4.asc &&\
    sh ./install-nix-2.3.4 &&\
    rm install-nix-2.3.4 install-nix-2.3.4.asc

FROM nix-install as idris-install
ARG VERSION=1.3.2
USER root

RUN apt-get update && apt-get -y install build-essential &&\
    cabal update && cabal install idris-$VERSION &&\
    apt-get remove -y build-essential &&\
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["idris"]
CMD ["--help"]
