{-# LANGUAGE BangPatterns #-}

module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance = distanceWorker 0
    where
  distanceWorker !d (x:xs) (y:ys) = distanceWorker (d + (check x y)) xs ys
  distanceWorker !d [] [] = Just d
  distanceWorker _ _ _ = Nothing
  check a b
        | a == b = 0
        | otherwise = 1
