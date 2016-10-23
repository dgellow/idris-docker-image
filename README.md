# Docker image for [Idris lang](http://www.idris-lang.org/)

The image is available on dockerhub: [dgellow/idris](https://hub.docker.com/r/dgellow/idris/)

Based on the [official haskell image](https://hub.docker.com/r/_/haskell/), latest idris installed and compiled via cabal.

## Tags

- `dgellow/idris:latest`: full haskell image + idris
- `dgellow/idris:no-ghc_no-cabal`: haskell image + idris - cabal - haskell (save ~500Mo)

## Usage

From the cli:

```
$ docker run dgellow/idris idris --help
```

From a `Dockerfile`:

```
FROM dgellow/idris

ADD . /app
WORKDIR /app

RUN idris main.idr -o hello.o
CMD ["/app/hello.o"]
```
