fibonacci :: Int -> [Int]
fibonacci n = take n fibs
  where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

isValid :: Int -> Bool
isValid n = n > 0

generateFibonacciList :: Int -> [Int]
generateFibonacciList n
  | isValid n = filter (\k -> sqrt (fromIntegral n) <= fromIntegral k && k <= n) (fibonacci n)
  | otherwise = error "Invalid input: n must be a positive integer"

main :: IO ()
main = do
  putStrLn "Enter a positive integer value of n:"
  n <- readLn :: IO Int
  let result = generateFibonacciList n
  putStrLn $ "Ascending list of Fibonacci numbers satisfying the condition: " ++ show result
