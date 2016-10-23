FROM haskell

RUN cabal update && cabal install idris
CMD idris
