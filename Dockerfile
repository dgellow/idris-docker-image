FROM haskell

ARG version

RUN cabal update && cabal install idris${version}
CMD idris
