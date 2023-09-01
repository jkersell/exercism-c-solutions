{-# LANGUAGE BangPatterns #-}

module CollatzConjecture (collatz) where

import Data.List

collatz :: Integer -> Maybe Integer
collatz n
    | n <= 0 = Nothing
    | otherwise = Just (genericLength $ takeWhile (/= 1) $ iterate next n)
    where
  next m
    | even m = m `div` 2
    | otherwise = (m * 3) + 1
