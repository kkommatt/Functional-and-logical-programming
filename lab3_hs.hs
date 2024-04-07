import Data.List (nub)

-- Define types for states, symbols, transitions, etc.
type State = String
type Symbol = Char
type Transition = ((State, Symbol), State)

-- Main predicate for checking word acceptance
accepted :: [State] -> State -> [Symbol] -> [Transition] -> Bool
accepted finalStates q [] _ = q `elem` finalStates
accepted finalStates q (a : w) transitions =
  case lookup (q, a) transitions of
    Just q' -> accepted finalStates q' w transitions
    Nothing -> False

-- Parse automaton from file
parseAutomaton :: FilePath -> IO ([State], [Symbol], State, [State], [Transition])
parseAutomaton filename = do
  contents <- readFile filename
  let (statesLine : symbolsLine : startStateLine : finalStatesLines : transitionLines) = lines contents
      states = words statesLine
      symbols = map head $ words symbolsLine
      startState = head $ words startStateLine
      finalStates = words finalStatesLines
      transitions = map parseTransition transitionLines
      parseTransition line =
        let [from, symbol, to] = words line
        in ((from, head symbol), to)
  return (states, symbols, startState, finalStates, transitions)


-- Generate words of a given length that are accepted by the automaton
generateAcceptedWords :: Int -> [Symbol] -> [State] -> [Transition] -> [String]
generateAcceptedWords k symbols finalStates transitions =
  nub [w | w <- mapM (const symbols) [1 .. k], accepted finalStates "q0" w transitions]

main :: IO ()
main = do
  (states, symbols, startState, finalStates, transitions) <- parseAutomaton "lab3_hs.txt"
  putStrLn "Enter word length: "
  input <- getLine
  let k = read input :: Int
      wordsLength = generateAcceptedWords k symbols finalStates transitions
  putStrLn $ "Accepted words of length " ++ show k ++ ": " ++ show wordsLength
