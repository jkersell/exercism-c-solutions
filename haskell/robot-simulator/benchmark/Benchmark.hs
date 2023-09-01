module Main where

import Criterion
import Criterion.Main (defaultMain)

import Robot (
    Bearing(North,East,South,West)
    , left
    , right
    )

main :: IO ()
main = do
    defaultMain
      [ bgroup "Turn benchmarks"
        [ bench "Turn left without enums" $ whnf left $ left $ left $ North
        , bench "Turn left with enums" $ whnf leftEnum $ leftEnum $ leftEnum $ North 
        , bench "Turn right without enums" $ whnf right $ right $ right $ North 
        , bench "Turn right with enums" $ whnf rightEnum $ rightEnum $ rightEnum $ North 
        ]
      ]

rightEnum :: Bearing -> Bearing
rightEnum direction = toEnum $ mod (succ $ fromEnum direction) 4

leftEnum :: Bearing -> Bearing
leftEnum direction = toEnum $ mod (pred $ fromEnum direction) 4
