import Data.List

main :: IO ()
main = do
    putStrLn "Enter a list of items separated by spaces:"
    input <- getLine
    let items = words input
        uniqueItems = nub items
        itemCount = length uniqueItems
    putStrLn $ "Number of unique items: " ++ show itemCount
