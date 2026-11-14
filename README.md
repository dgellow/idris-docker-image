# Docker images for [Idris](https://www.idris-lang.org/) and [Idris 2](https://github.com/idris-lang/Idris2)

[![Build](https://github.com/dgellow/idris-docker-image/actions/workflows/build.yml/badge.svg)](https://github.com/dgellow/idris-docker-image/actions/workflows/build.yml)

![](https://img.shields.io/badge/image-dgellow%2Fidris2-blue)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dgellow/idris2)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/dgellow/idris2)

![](https://img.shields.io/badge/image-dgellow%2Fidris-blue)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/dgellow/idris)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/dgellow/idris)

## Images

| Image | Source | Contents |
| --- | --- | --- |
| [`dgellow/idris2`](https://hub.docker.com/r/dgellow/idris2/) | [`idris2/Dockerfile`](idris2/Dockerfile) | [Idris 2](https://github.com/idris-lang/Idris2) bootstrapped from source with Chez Scheme, on `debian:trixie-slim`. `linux/amd64` and `linux/arm64`. |
| [`dgellow/idris`](https://hub.docker.com/r/dgellow/idris/) | [`idris/Dockerfile`](idris/Dockerfile) | [Idris 1](https://github.com/idris-lang/Idris-dev) built from [Hackage](https://hackage.haskell.org/package/idris) with GHC 8.8, on `debian:bookworm-slim`. `linux/amd64` only. Idris 1 is no longer developed upstream. |

Both are multi-stage builds: the final image only holds the compiler, its
libraries and what it needs to produce executables.

- `dgellow/idris2` ships Chez Scheme, the default code generator. The RefC
  backend additionally needs `gcc` and `libgmp-dev`, the Racket, Gambit and
  Node backends need their respective runtimes.
- `dgellow/idris` ships `gcc` for the C backend.

## Tags

Idris 2:
- `dgellow/idris2:latest`
- `dgellow/idris2:v0.8.0`
- `dgellow/idris2:v0.3.0`
- `dgellow/idris2:v0.1.0`

Idris:
- `dgellow/idris:latest`
- `dgellow/idris:v1.3.4`
- `dgellow/idris:v1.3.3`
- `dgellow/idris:v1.3.2`
- `dgellow/idris:v1.1.1`
- `dgellow/idris:v1.0`
- `dgellow/idris:v0.99.1`
- `dgellow/idris:v0.99`
- `dgellow/idris:v0.12.3`

## Usage

The compiler is the entrypoint of both images:

```
$ docker run --rm -it dgellow/idris2 --version
$ docker run --rm -it -v "$PWD:/app" -w /app dgellow/idris2 Main.idr
```

From a `Dockerfile`, Idris 2:

```dockerfile
FROM dgellow/idris2

WORKDIR /app
COPY . .

RUN idris2 Main.idr -o hello
ENTRYPOINT ["/app/build/exec/hello"]
```

Idris 1:

```dockerfile
FROM dgellow/idris

WORKDIR /app
COPY . .

RUN idris Main.idr -o hello
ENTRYPOINT ["/app/hello"]
```

## Build the images

Requires Docker with BuildKit (the default builder since Docker 23).

```
$ docker build -t dgellow/idris2:v0.8.0 idris2
$ docker build -t dgellow/idris:v1.3.4 idris
```

Bootstrapping Idris 2 takes around 15 minutes, compiling Idris 1 and its
Haskell dependencies can take more than 30 minutes.

Build arguments:

| Dockerfile | Argument | Default | |
| --- | --- | --- | --- |
| `idris2` | `IDRIS2_VERSION` | `v0.8.0` | Git tag, branch or commit of [idris-lang/Idris2](https://github.com/idris-lang/Idris2) |
| `idris2` | `DEBIAN_VERSION` | `trixie` | Debian release of both stages |
| `idris` | `IDRIS_VERSION` | `1.3.4` | Version on Hackage |
| `idris` | `GHC_VERSION` | `8.8.4` | GHC used for the build |
| `idris` | `CABAL_VERSION` | `3.16.1.0` | cabal-install used for the build |
| `idris` | `GHCUP_VERSION` | `0.2.6.2` | GHCup used to install GHC and cabal |
| `idris` | `HACKAGE_INDEX_STATE` | `2021-10-31T00:00:00Z` | Hackage snapshot used to resolve dependencies |
| `idris` | `DEBIAN_VERSION` | `bookworm` | Debian release of both stages |

## Tests

`tests/smoke.sh` checks the version an image reports, then compiles and runs a
small program in it:

```
$ tests/smoke.sh idris2 dgellow/idris2:v0.8.0 v0.8.0
$ tests/smoke.sh idris dgellow/idris:v1.3.4 v1.3.4
```

## CI

[`.github/workflows/build.yml`](.github/workflows/build.yml) lints the
Dockerfiles with [hadolint](https://github.com/hadolint/hadolint), builds both
images and runs the smoke test on every pull request, on every push to
`master`, and once a week from scratch.

Runs on `master` also push to Docker Hub once these are set in the repository
settings:

- variable `DOCKERHUB_USERNAME`
- secret `DOCKERHUB_TOKEN`, a Docker Hub access token with write access

The pushed tags are `v<version>` and `latest`, where the version is the default
of `IDRIS2_VERSION` / `IDRIS_VERSION` in the Dockerfile. Releasing a new
version is a change of that default.
