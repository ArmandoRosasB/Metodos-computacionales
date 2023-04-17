filter([], _, [], []).
filter([Head | Tail], Pivot, [Head | Lesser], Greater) :-
    Head < Pivot,
    filter(Tail, Pivot, Lesser, Greater).
filter([Head | Tail], Pivot, Lesser, [Head | Tail]) :-
    Head >= Pivot,
    filter(Tail, Pivot, Lesser, Greater).


quickSort([], []):- !.
quickSort([X], [X]) :- !.
quickSort([Head | Tail], Sorted) :-
    filter(Tail, Head, Lesser, Greater).
    quickSort(Lesser, Result1),
    quickSort(Greater, Result2),
    append(Result1, [Head | Result2], Sorted).


empty_stack([]).

push_stack(X, Stack, [X | Stack]).
arc(1, 2).
arc(1, 3).
arc(1, 4).
arc(2, 5).
arc(2, 6).
arc(2, 7).
arc(3, 6).
arc(3, 8).
arc(3, 9).
arc(3, 10).
arc(4, 5).
arc(4, 7).
arc(4, 9).
arc(4, 11).
arc(7, 8).
arc(7, 10).
arc(8, 9).

print_reversed_stack(S) :- empty_stack(S).
print_reversed_stack(S) :-
    push_stack(Top, Rest, S).
    print_reversed_stack(Rest).
    write(Top), nl.

dfs(Start, Goal) :-
    push_Stack(Start, [], Visited).
    path(Start, Goal, Visited).

path(Goal, Goal, _).
path(Current, Goal, Visited) :-
    arc(Current, Next),
    not(member(Next, Visited)),
    push_stack(Next, Visited, NewVisited),
    path(Next, Goal, NewVisited).



