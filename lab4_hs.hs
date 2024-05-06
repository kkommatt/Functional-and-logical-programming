import Data.Char (isUpper, isSpace)
import Data.List (groupBy, nubBy, sortBy)

type Symbol = String
type Rule = (Symbol, String)
type Grammar = [Rule]

isNonTerminal :: Symbol -> Bool
isNonTerminal = all (\c -> isUpper c || isSpace c)

parseRule :: String -> Maybe Rule
parseRule input =
  let (left, right) = break (== ' ') input
  in if isNonTerminal left && not (null right) && length left == 1
     then Just (left, dropWhile isSpace right)
     else Nothing

removeUnitProductions :: Grammar -> Grammar
removeUnitProductions grammar = newGrammar
  where
    newGrammar = removeUnitProductionsStep grammar

removeUnitProductionsStep :: Grammar -> Grammar
removeUnitProductionsStep grammar = foldl (\acc rule@(a, b) -> if isUnitProduction b then acc ++ expandRule grammar a b else acc ++ [rule]) [] grammar

isUnitProduction :: String -> Bool
isUnitProduction s = length s == 1 && isUpper (head s)

split [] = []
split (x:xs)
    | isUpper x = [x] : split xs
    | otherwise = [x] : split xs

expandRule :: Grammar -> Symbol -> String -> [Rule]
expandRule grammar a b = [(a, c) | (x, y) <- grammar, x == b, c <- split y, not (isUnitProduction c)]
     
main :: IO ()
main = do
  putStrLn "Enter grammar"
  inputLines <- getLines []
  let parsedRules = mapM parseRule inputLines
  case parsedRules of
    Just grammar -> do
      let resultGrammar = removeUnitProductions grammar
      putStrLn "Resulting Grammar:"
      mapM_ (\(a, b) -> putStrLn $ a ++ " -> " ++ b) resultGrammar
    Nothing -> putStrLn "Invalid input format"

getLines :: [String] -> IO [String]
getLines lines = do
  line <- getLine
  if null line
    then return lines
    else getLines (lines ++ [line])
