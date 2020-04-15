# Docker image for [Idris lang](http://www.idris-lang.org/)

Latest idris installed and compiled via cabal. Based on the [official haskell image](https://hub.docker.com/r/_/haskell/).

Latest image version: ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dgellow/idris) ![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/dgellow/idris)

The image is available on dockerhub: [dgellow/idris](https://hub.docker.com/r/dgellow/idris/).

## Tags

- `dgellow/idris:latest`
- `dgellow/idris:v1.3.2`
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

## Build the image

> Note: building idris can easily take **more than 30 minutes** depending on your machine and how much CPU/RAM is dedicated to docker

```
$ docker build -t dgellow/idris:v1.3.2 .
```