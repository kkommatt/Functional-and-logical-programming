import Data.Maybe (Maybe(..), isJust, fromJust)

-- Maybe function to calculate 1 / (x^2 - 25x + 1)
function6 :: Double -> Maybe Double
function6 x
    | denominator == 0 = Nothing
    | otherwise = Just (1 / denominator)
    where
        denominator = x^2 - 25 * x + 1

-- Maybe function to calculate 1 / (25x + lg x)
function2 :: Double -> Maybe Double
function2 x
    | x <= 0 || lgX == 0 = Nothing
    | otherwise = Just (1 / (25 * x + lgX))
    where
        lgX = log x

-- Maybe function to calculate 1 / (x - 25)
function5 :: Double -> Maybe Double
function5 x
    | x == 25 = Nothing
    | otherwise = Just (1 / (x - 25))

superposition_do_2 :: Double -> Maybe Double
superposition_do_2 x = do
    result1 <- function5 x
    result2 <- function2 result1
    result3 <- function6 result2
    return result3

superposition_2 :: Double -> Maybe Double
superposition_2 x =
    function5 x >>= \result1 ->
    function2 result1 >>= \result2 ->
    function6 result2 >>= \result3 ->
    return result3

-- Binary Maybe-function to calculate 1 / (x - n)
functionBinary :: Double -> Double -> Maybe Double
functionBinary x n
    | x == n = Nothing
    | otherwise = Just (1 / (x - n))


superposition_do_4 :: Double -> Maybe Double
superposition_do_4 x = do
    result1 <- function6 x
    result2 <- function2 x
    functionBinary result1 result2

superposition_4 :: Double -> Maybe Double
superposition_4 x =
    function6 x >>= \result1 ->
    function2 x >>= \result2 ->
    functionBinary result1 result2

main :: IO ()
main = do
    let x1 = 10
    putStrLn $ "Function 6: " ++ show (function6 x1)

    let x2 = 2
    putStrLn $ "Function 2: " ++ show (function2 x2)

    let x3 = 30
    putStrLn $ "Function 5: " ++ show (function5 x3)

    let x4 = 1000000 
    putStrLn $ "Superposition 2 do: " ++ show (superposition_do_2 x4)
    putStrLn $ "Superposition 2: " ++ show (superposition_2 x4)

    let x5 = 10
    let n1 = 20
    putStrLn $ "Binary function 5: " ++ show (functionBinary x5 n1)
    let x6 = 5
    putStrLn $ "Superposition 4 do: " ++ show (superposition_do_4 x6)
    putStrLn $ "Superposition 4: " ++ show (superposition_4 x6)
