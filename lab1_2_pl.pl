is_power_of_2(1).
is_power_of_2(N) :-
    N > 1,
    N mod 2 =:= 0,
    N1 is N // 2,
    is_power_of_2(N1).

divide_list([], [], []).
divide_list([X|Xs], [X|Powers], NonPowers) :-
    is_power_of_2(X),
    divide_list(Xs, Powers, NonPowers).
divide_list([X|Xs], Powers, [X|NonPowers]) :-
    \+ is_power_of_2(X),
    divide_list(Xs, Powers, NonPowers).

read_input(InputList) :-
    read_line_to_codes(user_input, InputCodes),
    ( InputCodes = [] -> InputList = [] ; 
      atom_codes(Atom, InputCodes),
      atomic_list_concat(Atoms, ' ', Atom),
      maplist(atom_number, Atoms, InputList)
    ).

main :-
    writeln("Correct input is expected"),
    writeln('Enter a list of integers separated by space:'),
    read_input(InputList),
    divide_list(InputList, PowersOf2, NonPowers),
    writeln('List of powers of 2:'),
    writeln(PowersOf2),
    writeln('List of non-powers of 2:'),
    writeln(NonPowers).

