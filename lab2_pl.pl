split_list(InputList, OutputLists) :-
    reverse(InputList, ReversedInputList),
    split_list_helper(ReversedInputList, 1, [], OutputLists).

split_list_helper([], _, Accumulator, OutputLists) :-
    reverse(Accumulator, OutputLists).
split_list_helper(InputList, N, Accumulator, OutputLists) :-
    take_power_elements(InputList, N, SubList, Remaining),
    reverse(SubList, ReversedSubList),
    append(Accumulator, [ReversedSubList], NewAccumulator),
    NextN is N + 1,
    split_list_helper(Remaining, NextN, NewAccumulator, OutputLists).

take_power_elements(List, N, Taken, Remaining) :-
    length(List, ListLength),
    Nth is N ** N,
    (ListLength >= Nth ->
        take(Nth, List, Taken, Remaining)
    ;
        Taken = List, Remaining = []
    ).

take(0, List, [], List).
take(N, [X|Xs], [X|Ys], Zs) :-
    N > 0,
    N1 is N - 1,
    take(N1, Xs, Ys, Zs).

main :-
    write('Enter a list of integers separated by space: '),
    read_line_to_codes(user_input, Input),
    atom_codes(Atom, Input),
    atomic_list_concat(StrList, ' ', Atom),
    maplist(atom_number, StrList, InputList),
    split_list(InputList, OutputLists),
    format('Output list: ~w~n', [OutputLists]),
    halt.

:- initialization(main).
