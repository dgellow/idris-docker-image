# Docker image for [Idris lang](http://www.idris-lang.org/)

The image is available on dockerhub: [dgellow/idris](https://hub.docker.com/r/dgellow/idris/)

Based on the [official haskell image](https://hub.docker.com/r/_/haskell/), latest idris installed and compiled via cabal.

## Tags

- `dgellow/idris:latest`
- `dgellow/idris:v1.1.1`
- `dgellow/idris:v1.0`
- `dgellow/idris:v0.99.1`
- `dgellow/idris:v0.99`
- `dgellow/idris:v0.12.3`

## Usage

From the cli:

```
$ docker run -it dgellow/idris --help
```

From a `Dockerfile`:

```
FROM dgellow/idris

ADD . /app
WORKDIR /app

RUN idris main.idr -o hello.o
CMD ["/app/hello.o"]
```
