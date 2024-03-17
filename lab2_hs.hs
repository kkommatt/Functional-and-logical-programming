powerSequence :: Int -> [Int]
powerSequence n = map (\x -> x^x) [n..]

splitList :: [a] -> [Int] -> [[a]]
splitList [] _ = []
splitList xs [] = [xs]
splitList xs (n:ns) = first : splitList rest ns
  where
    (first, rest) = splitAt n xs

main :: IO ()
main = do
    putStrLn "Enter space-separated numbers:"
    input <- getLine
    let numbers = map read (words input) :: [Int]
        maxLength = length numbers
        powers = reverse (takeWhile (<= maxLength) (concatMap powerSequence [1..]))
        sublists = splitList numbers powers
    putStrLn "Sublists: "
    mapM_ print sublists
