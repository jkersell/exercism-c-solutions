{-# LANGUAGE NamedFieldPuns #-}

module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    , left
    , right
    ) where

import Data.List

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show, Enum)

right :: Bearing -> Bearing
right North = East
right East = South
right South = West
right West = North

left :: Bearing -> Bearing
left North = West
left West = South
left South = East
left East = North

type Coordinates = (Integer, Integer)

data Robot = Robot { bearing :: Bearing
                   , coordinates :: Coordinates
                   } deriving (Eq, Show)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

move :: Robot -> String -> Robot
move = foldl' execute
  where
    execute robot@Robot {bearing, coordinates} instruction = case instruction of
      'R' -> robot {bearing = right bearing}
      'L' -> robot {bearing = left bearing}
      'A' -> robot {coordinates = advance bearing coordinates}
      _   -> error ("Unknown instruction " ++ [instruction])

    advance :: Bearing -> Coordinates -> Coordinates
    advance b (x, y) = case b of
      North -> (x, succ y)
      East -> (succ x, y)
      South -> (x, pred y)
      West -> (pred x, y)
