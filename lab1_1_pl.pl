:- use_module(library(readutil)).

% Predicate to read a list of integers from the console
read_list(List) :-
    write('Enter a list of integers (end without "."): '), nl,
    read_line_to_codes(user_input, Codes),
    (   Codes = [] ->  % if the line is empty, end the input
        List = []
    ;   atom_codes(Atom, Codes),
        atomic_list_concat(Atoms, ' ', Atom),
        (   Atoms = [''] ->  % if the line contains only spaces, end the input
            List = []
        ;   maplist(atom_number, Atoms, List)
        )
    ).



% Predicate to count the number of occurrences of an element in a list
count(_, [], 0) :- !.
count(X, [X|T], N) :-
    count(X, T, N2),
    N is N2 + 1.
count(X, [Y|T], N) :-
    X \= Y,
    count(X, T, N).

% Predicate to check if a number occurs an even number of times in a list
even_occurrences(X, List) :-
    count(X, List, N),
    0 is N mod 2.

% Predicate to create a list of integers with an even number of occurrences
even_occurrences_list([], _, []).
even_occurrences_list([H|T], Input, [H|Output]) :-
    even_occurrences(H, Input),
    even_occurrences_list(T, Input, Output).
even_occurrences_list([H|T], Input, Output) :-
    \+ even_occurrences(H, Input),
    even_occurrences_list(T, Input, Output).

% Main predicate
main :-
    read_list(List),
    even_occurrences_list(List, List, Output),
    write('The list of integers with an even number of occurrences is: '), write(Output), nl.
