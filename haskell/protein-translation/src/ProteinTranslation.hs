-- module ProteinTranslation(proteins) where
module ProteinTranslation (proteins) where

data Err = InvalidNucleotide | MalformedCodon | UnknownCodon
  deriving (Show)

data Codon = Codon Char Char Char
  deriving (Show)

codon :: String -> Either Err Codon
codon [a, b, c] = Codon <$> nucleotide a <*> nucleotide b <*> nucleotide c
codon _         = Left MalformedCodon

nucleotide :: Char -> Either Err Char
nucleotide c = if c `elem` "ACGU" then Right c else Left InvalidNucleotide

proteins :: String -> Maybe [String]
proteins = either (\_ -> Nothing) (\p -> Just p) . proteins'

proteins' :: String -> Either Err [String]
proteins' = mapM (>>= toProtein) . takeWhile (either (\_ -> False) (not . stop)) . toCodons
  where
    toCodons :: String -> [Either Err Codon]
    toCodons = map codon . splitEvery 3

    splitEvery :: Int -> String -> [String]
    splitEvery _ [] = []
    splitEvery n s  = let (as, bs) = splitAt n s in
      as : (splitEvery n bs)

    stop :: Codon -> Bool
    stop (Codon 'U' 'A' 'A') = True
    stop (Codon 'U' 'A' 'G') = True
    stop (Codon 'U' 'G' 'A') = True
    stop _                   = False

    toProtein :: Codon -> Either Err String
    toProtein (Codon 'A' 'U' 'G') = Right "Methionine"
    toProtein (Codon 'U' 'U' 'U') = Right "Phenylalanine"
    toProtein (Codon 'U' 'U' 'C') = Right "Phenylalanine"
    toProtein (Codon 'U' 'U' 'A') = Right "Leucine"
    toProtein (Codon 'U' 'U' 'G') = Right "Leucine"
    toProtein (Codon 'U' 'C' 'U') = Right "Serine"
    toProtein (Codon 'U' 'C' 'C') = Right "Serine"
    toProtein (Codon 'U' 'C' 'A') = Right "Serine"
    toProtein (Codon 'U' 'C' 'G') = Right "Serine"
    toProtein (Codon 'U' 'A' 'U') = Right "Tyrosine"
    toProtein (Codon 'U' 'A' 'C') = Right "Tyrosine"
    toProtein (Codon 'U' 'G' 'U') = Right "Cysteine"
    toProtein (Codon 'U' 'G' 'C') = Right "Cysteine"
    toProtein (Codon 'U' 'G' 'G') = Right "Tryptophan"
    toProtein _                   = Left UnknownCodon
