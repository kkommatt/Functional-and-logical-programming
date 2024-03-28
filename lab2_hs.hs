import Data.List (unfoldr)

splitList :: [a] -> [[a]]
splitList xs = reverse $ splitListHelper (reverse xs) 1 []

splitListHelper :: [a] -> Int -> [[a]] -> [[a]]
splitListHelper [] _ acc = acc
splitListHelper inputList n acc =
  let (subList, remaining) = takePowerElements inputList n
      subListLength = length subList
      nextN = n + 1
      reversedSubList = reverse subList
   in splitListHelper remaining nextN (reversedSubList : acc)


takePowerElements :: [a] -> Int -> ([a], [a])
takePowerElements list n =
  let listLength = length list
      nth = n ^ n
   in if listLength >= nth
        then splitAt nth list
        else (list, [])
        
reverseOutput :: [[a]] -> [[a]]
reverseOutput = reverse

main :: IO ()
main = do
  putStrLn "Enter a list of integers separated by space:"
  input <- getLine
  let inputList = map read $ words input :: [Int]
  let outputListsReversed = splitList inputList
  let outputLists = reverse outputListsReversed
  putStrLn "Output with sublists:"
  putStrLn $ show outputLists
