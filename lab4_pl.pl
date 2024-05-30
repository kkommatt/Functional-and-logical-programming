:- dynamic rule/2.

% Check if a symbol is non-terminal
is_non_terminal(Symbol) :-
    string_chars(Symbol, Chars),
    maplist(is_upper, Chars).

is_upper(Char) :-
    char_type(Char, upper).

% Parse a rule from input string
parse_rule(Input, (Left, Right)) :-
    split_string(Input, " ", "", [Left|RightParts]),
    atomic_list_concat(RightParts, " ", Right),
    is_non_terminal(Left),
    string_length(Left, 1),
    Right \= "".

% Find all unit productions
find_unit_productions([], []).
find_unit_productions([(A, B)|Rest], [(A, B)|Units]) :-
    is_unit_production(B),
    find_unit_productions(Rest, Units).
find_unit_productions([_|Rest], Units) :-
    find_unit_productions(Rest, Units).

is_unit_production(String) :-
    string_length(String, 1),
    string_chars(String, [Char]),
    char_type(Char, upper).

% Expand unit productions
expand_unit_productions([], _, []).
expand_unit_productions([(A, B)|Rest], Grammar, Expanded) :-
    findall((A, C), (member((B, C), Grammar), \+ is_unit_production(C)), DirectExpansions),
    expand_unit_productions(Rest, Grammar, RestExpanded),
    append(DirectExpansions, RestExpanded, Expanded).

% Remove unit productions from the grammar
remove_unit_productions(Grammar, NewGrammar) :-
    find_unit_productions(Grammar, UnitProductions),
    expand_unit_productions(UnitProductions, Grammar, ExpandedUnitProductions),
    exclude(is_unit_production_rule, Grammar, NonUnitProductions),
    append(NonUnitProductions, ExpandedUnitProductions, Combined),
    sort(Combined, NewGrammar).

is_unit_production_rule((_, Right)) :-
    is_unit_production(Right).

grammar([
    ('S', 'aA'),
    ('A', 'B'),
    ('B', 'c')
]).

% Run the removal of unit productions
test_remove_unit_productions(NewGrammar) :-
    grammar(Grammar),
    remove_unit_productions(Grammar, NewGrammar).
