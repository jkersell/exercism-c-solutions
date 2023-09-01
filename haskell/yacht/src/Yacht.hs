{-# LANGUAGE ViewPatterns #-}

module Yacht (yacht, Category(..)) where

import Data.List
import qualified Data.MultiSet as MultiSet

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht category (MultiSet.fromList -> dice) =
  let ns :: Int -> Int
      ns n = n * MultiSet.occur n dice
  in  case category of
    Ones -> ns 1
    Twos -> ns 2
    Threes -> ns 3
    Fours -> ns 4
    Fives -> ns 5
    Sixes -> ns 6
    FullHouse | isFullHouse -> (sum . MultiSet.elems) dice
      where
        isFullHouse = (sort . map snd . MultiSet.toOccurList) dice == [2,3]
    FourOfAKind -> MultiSet.foldOccur (\key value total -> if value >= 4 then 4 * key else total) 0 dice
    LittleStraight | isLittleStraight -> 30
      where
        isLittleStraight = (MultiSet.distinctSize dice) == 5 && MultiSet.findMax dice < 6
    BigStraight | isBigStraight -> 30
      where
        isBigStraight = (MultiSet.distinctSize dice) == 5 && MultiSet.findMin dice > 1
    Choice -> (sum . MultiSet.elems) dice
    Yacht -> if MultiSet.distinctSize dice == 1 then 50 else 0
    _ -> 0
