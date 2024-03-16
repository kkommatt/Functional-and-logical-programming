import Data.List (group)

filterEvenOccurrences :: Eq a => [a] -> [a]
filterEvenOccurrences xs = filter (\x -> even $ length $ filter (== x) xs) xs

main :: IO ()
main = do
    putStrLn "Correct input always is expected"
    putStrLn ""
    putStrLn "Enter a list of INTEGERS separated by spaces:"
    input <- getLine
    let integers = map read (words input) :: [Integer]
    putStrLn $ "Entered list: " ++ show integers
    let filteredList = filterEvenOccurrences integers
    putStrLn $ "List with elements that have even occurrences: " ++ show filteredList
