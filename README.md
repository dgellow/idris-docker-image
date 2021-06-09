# Docker images for [Idris lang](http://www.idris-lang.org/) and [Idris2](https://github.com/edwinb/Idris2)

![](https://img.shields.io/badge/image-dgellow%2Fidris-blue)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dgellow/idris)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/dgellow/idris)

![](https://img.shields.io/badge/image-dgellow%2Fidris2-blue)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dgellow/idris2)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/dgellow/idris2)

# Images

- `dgellow/idris`: Published at https://hub.docker.com/r/dgellow/idris/. Latest idris installed and compiled via Cabal. Based on the [official haskell image](https://hub.docker.com/r/_/haskell/).
- `dgellow/idris2`: Published at https://hub.docker.com/r/dgellow/idris2/. Build from source of [idris2](https://github.com/edwinb/Idris2).

## Tags

Idris:
- `dgellow/idris:latest`
- `dgellow/idris:v1.3.3`
- `dgellow/idris:v1.3.2`
- `dgellow/idris:v1.1.1`
- `dgellow/idris:v1.0`
- `dgellow/idris:v0.99.1`
- `dgellow/idris:v0.99`
- `dgellow/idris:v0.12.3`

Idris2:
- `dgellow/idris2:latest`
- `dgellow/idris2:v0.1.0`

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

To build idris2 (also quite a long process)
```
$ docker build -t dgellow/idris2:v0.1.0 -f Dockerfile_idris2 .
```
