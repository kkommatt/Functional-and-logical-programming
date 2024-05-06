import Text.Read (readMaybe)

generateList :: Int -> [Int]
generateList n = [k^2 | k <- [1..n]]

validateInput :: Maybe Int -> Maybe Int
validateInput Nothing = Nothing
validateInput (Just n)
    | n <= 0    = Nothing
    | otherwise = Just n

main :: IO ()
main = do
    putStrLn "Enter a value for n:"
    input <- getLine
    let maybeN = readMaybe input :: Maybe Int
    case validateInput maybeN of
        Nothing -> putStrLn "Invalid input. Please enter a positive integer."
        Just n  -> do
            let resultList = generateList n
            putStrLn $ "List of elements k^2 for 1 <= k <= " ++ show n ++ ":"
            print resultList
