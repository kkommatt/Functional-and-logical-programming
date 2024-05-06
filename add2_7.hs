import Data.Char (digitToInt)

-- Function to convert an integer to its binary representation
toBinary :: Int -> String
toBinary 0 = "0"
toBinary n = reverse $ toBinary' n
    where toBinary' 0 = ""
          toBinary' m = let (q, r) = m `divMod` 2 in (show r) ++ toBinary' q

-- Function to find the penultimate digit of a binary string
penultimateDigit :: String -> Maybe Int
penultimateDigit [] = Nothing
penultimateDigit [_] = Nothing
penultimateDigit (x:y:[]) = Just (digitToInt x)
penultimateDigit (_:xs) = penultimateDigit xs

main :: IO ()
main = do
    putStrLn "Enter a positive integer:"
    input <- getLine
    let num = read input :: Int
    let binary = toBinary num
    case penultimateDigit binary of
        Just digit -> putStrLn $ "The penultimate digit of the binary representation is: " ++ show digit
        Nothing -> putStrLn "Invalid input or number too small"
