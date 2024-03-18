split_list(InputList, OutputLists) :-
    reverse(InputList, ReversedInputList), 
    split_list_helper(ReversedInputList, 1, OutputLists).

split_list_helper([], _, []).
split_list_helper(InputList, N, OutputLists) :-
    take_power_elements(InputList, N, SubList, Remaining),
    reverse(SubList, ReversedSubList), 
    length(ReversedSubList, SubListLength),
    NextN is N + 1,
    split_list_helper(Remaining, NextN, RestOutputLists),
    append(RestOutputLists, [ReversedSubList], OutputLists), 
    format('Sub-list with ~d elements: ~w~n', [SubListLength, ReversedSubList]).




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
    split_list(InputList, _),
    halt.

:- initialization(main).
