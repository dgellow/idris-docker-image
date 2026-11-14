module Main

import Data.Vect

xs : Vect 3 Integer
xs = [1, 2, 3]

main : IO ()
main = putStrLn ("sum: " ++ show (sum xs * 100000000000000000000))
