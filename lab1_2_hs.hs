import Data.Bits ((.&.))

isPowerOf2 :: Int -> Bool
isPowerOf2 n = n > 0 && (n .&. (n - 1)) == 0

splitByPowerOf2 :: [Int] -> ([Int], [Int])
splitByPowerOf2 xs = partition isPowerOf2 xs
  where
    partition p = foldr (\x (yes, no) -> if p x then (x : yes, no) else (yes, x : no)) ([], [])

readIntList :: IO [Int]
readIntList = do
    putStrLn "Correct input is expected"
    putStrLn "Enter a space-separated list of integers:"
    input <- getLine
    let numbers = map read (words input)  
    return numbers

main :: IO ()
main = do
    myList <- readIntList
    let (powerOf2List, nonPowerOf2List) = splitByPowerOf2 myList
    putStrLn $ "Power of 2 list: " ++ show powerOf2List
    putStrLn $ "Non-power of 2 list: " ++ show nonPowerOf2List
