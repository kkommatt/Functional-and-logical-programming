% Read automaton data from a file
read_automata(File) :-
    consult(File).

% Main predicate for checking word acceptance
accepted(W) :-
    read_automata("lab3_pl.txt"), % Read automaton data
    startState(Q0),
    accepted1(Q0, W).

% Helper predicate for checking acceptance
accepted1(Q, []) :-
    finalStates(F),
    member(Q, F).
accepted1(Q, [A|W]) :-
    transition(Q, A, Q1),
    accepted1(Q1, W).

% Generates words of a given length that are accepted by the automaton
generate_accepted_words(K, Words) :-
    read_automata("lab3_pl.txt"), % Read automaton data
    findall(Word, (length(Word, K), l_power_k(Word, K), accepted(Word)), Words).

% Helper predicate for generating words (unchanged from the original code)
l_power_k([], 0).
l_power_k([WHead|WTail], K) :-
    symbols(Symbols),
    member(WHead, Symbols),
    K1 is K - 1,
    l_power_k(WTail, K1).
