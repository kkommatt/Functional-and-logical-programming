unitprod(Nonterminals, Terminals, Rules, ResultNonterminals, ResultTerminals, ResultRules) :-
    assert_nonterminals(Nonterminals),
    assert_terminals(Terminals),
    assert_rules(Rules),
    removeUnitProductionsStep(Rules, Result),
    findall(N, nonterminal(N), ResultNonterminals),
    findall(T, terminal(T), ResultTerminals),
    findall(N -> R, rule(N, R), ResultRules),
    write(Result),
    retract_rules(Rules),
    retract_nonterminals(Nonterminals),
    retract_terminals(Terminals).

% Predicate to expand a rule
expandRule(Rules, A, B, Result) :-
    findall((A, C), (member((X -> Y), Rules), X == B, split(Y, Ys), member(C, Ys), \+ isUnitProduction(C)), Result).

% Predicate to remove unit productions from a grammar
removeUnitProductionsStep(Rules, Result) :-
    removeUnitProductionsStep(Rules, [], Result).

removeUnitProductionsStep([], Acc, Acc).
removeUnitProductionsStep([(A -> B)|Rest], Acc, Result) :-
    (isUnitProduction(B) ->
        expandRule(Rules, A, B, Expanded),
        append(Acc, Expanded, NewAcc)
    ; 
        NewAcc = [ (A -> B) | Acc]
    ),
    removeUnitProductionsStep(Rest, NewAcc, Result).


isUnitProduction(S) :-
    atom(S),
    atom_length(S, 1),
    char_type(S, upper).

assert_nonterminals([]).
assert_nonterminals([N | Rest]) :-
    assertz(nonterminal(N)),
    assert_nonterminals(Rest).

assert_terminals([]).
assert_terminals([T | Rest]) :-
    assertz(terminal(T)),
    assert_terminals(Rest).

assert_rules([]).
assert_rules([N -> R | Rest]) :-
    assertz(rule(N, R)),
    assert_rules(Rest).

retract_nonterminals([]).
retract_nonterminals([N | Rest]) :-
    retract(nonterminal(N)),
    retract_nonterminals(Rest).

retract_terminals([]).
retract_terminals([T | Rest]) :-
    retract(terminal(T)),
    retract_terminals(Rest).

retract_rules([]).
retract_rules([N -> R | Rest]) :-
    retract(rule(N, R)),
    retract_rules(Rest).
