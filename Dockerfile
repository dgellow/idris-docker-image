# Idris doesn't build with GHC 8.8
# See https://github.com/idris-lang/Idris-dev/issues/4845
FROM haskell:8.6 as base
ARG VERSION=1.3.3

RUN apt-get update && apt-get -y install build-essential
RUN cabal update && mkdir -p /root/.cabal/bin && echo "user-install: False" >> /root/.cabal/config
RUN cabal install idris-${VERSION}

FROM ubuntu
COPY --from=base /usr/local/bin /usr/local/bin
COPY --from=base /usr/local/lib /usr/local/lib
COPY --from=base /usr/local/share /usr/local/share

ENTRYPOINT ["idris"]
