
% --------------------------- RECURSI�N ---------------------------
% OJO: El orden en el que se ponen las reglas es en el que se aplican

fact(1, 1).
fact(N, X) :-
    X > 1, % NO est� igualando -> X1 tal que sea el predecesor de X
    X1 is X - 1,
    fact(N1, X1),
    N is X * N1.

% fact_tail(1, 1, 1). %(n, ans, acc)
fact_tail(1, Res, Res) :- !.
fact_tail(X, Res, Acc) :-
    NewX is X - 1,
    NewAcc is Acc * X,
    fact_tail(NewX, Res, NewAcc).

sum_head(End, End, End).
sum_head(Start, End, Result) :-
    Start < End,
    NewStart is Start + 1,
    sum_head(NewStart, End, PrevResult),
    Result is PrevResult + Start.

sum_tail(End, End, Acc, Result) :-
    Result is Acc + End.

sum_tail(Start, End, Acc, Result) :-
    Start < End,
    NewAcc is Acc + Start,
    NewStart is Start + 1,
    sum_tail(NewStart, End, NewAcc, Result).

% sum_tail(1, 100, 0, X).

fib_head(1, 1).
fib_head(2, 1).
fib_head(N, Result) :-
    N > 2,
    N1 is N - 1,
    fib_head(N1, R1),
    N2 is N - 2,
    fib_head(N2, R2),
    Result is R1 + R2.

% fib_head(8, X).

fib_tail(_, _, Result, Result).
fib_tail(N, A, B, Result) :-
    N > 2,
    NewN is N - 1,
    C is A + B,
    fib_tail(NewN, B, C, Result).

% fib_tail(8, 1, 1, Result).



% --------------------------- LISTAS ---------------------------
first([Head | _], Head).
rest([_ | Tail], Tail).
second([_ | [Second | _]], Second).

% first([1, 2, 3, 4], Head).

len([], 0).
len([_ | Tail], Result) :-
    len(Tail, R1),
    Result is R1 + 1.

% len([1, 2, 3, 4], X).

sum_list([], 0).
sum_list([Head | Tail], Result) :-
    sum_list(Tail, R1),
    Result is Head + R1.

find_list([Head | _], Head).
find_list([Head | Tail], X) :-
    Head \== X,
    find_list(Tail, X).

add2([], []).
add2([Head | Tail], [NewHead | NewTail]) :- % [input],[listaResultante]
    NewHead is Head + 2,
    add2(Tail, NewTail).

% add2([1, 2, 3, 4], X).

remove_from_list(_, [], []). % remove_from_list(X, L1, L2).
remove_from_list(Head, [Head | Tail], NewTail) :-
    remove_from_list(Head, Tail, NewTail).
remove_from_list(X, [Head | Tail], [Head | NewTail]) :-
    X \== Head,
    remove_from_list(X, Tail, NewTail).

% remove_from_list(2, [1, 2, 3, 2], X).

%% my_append(L1, L2, Result).
my_append([], L2, L2).
my_append(L1, [], L1).
my_append([Head | Tail], L2, [Head | NewTail]) :-
    my_append(Tail, L2, NewTail).


% my_merge(L1, L2, Result).
my_merge([], L2, L2). % L1.empty -> L2
my_merge(L1, [], L1).
my_merge([H1 | T1], [H2 | T2], [H1 | Temp]) :-
    H1 < H2, % 1er elem -> H1 porque es el menor
             % rest -> merge de lo que falta de la lista
    my_merge(T1, [H2 | T2], Temp).
my_merge([H1 | T1], [H2 | T2], [H2 | Temp]) :-
    H1 >= H2,
    my_merge([H1 | T1], T2, Temp).


% my_merge([1, 3, 5, 7, 9, 11], [2, 4, 6], X).

% split(Input, Output1, Output2).
split([], [], []).
split([X], [X], []). % Con un solo elem, uno de los 2 outputs debe estar vac�o
split([Head | Tail], [Head | R1], R2) :-
    split(Tail, R2, R1). % INVERTIR: para ir a�adiendo a uno y luego otro

% split([1, 2, 3, 4, 5, 6], L1, L2).

% merge_sort(Unsorted, Sorted).
merge_sort([], []) :- !.
merge_sort([X], [X]) :- !.
merge_sort(Unsorted, Sorted) :-
    split(Unsorted, L1, L2),
    merge_sort(L1, S1),
    merge_sort(L2, S2),
    my_merge(S1, S2, Sorted), !.
% ESTE C�MO LO PROB�
