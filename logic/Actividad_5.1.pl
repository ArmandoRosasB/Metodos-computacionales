% (lasto lst x)
% Función lógica que tiene éxito si x es el último elemento de lst

lasto([HEAD | []], HEAD).
lasto([_ | Tail], X) :-
    lasto(Tail, X).

% lasto(Y, 5).
% lasto([], X).
% lasto([1, 2, 3, 4], X).




% (butlasto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst excepto el último

butlasto([HEAD | []], []).
butlasto([HEAD1 | TAIL1], [HEAD1 | TAIL]):-
    butlasto(TAIL1, TAIL).

% butlasto([1, 2, 3, 4], X).
% butlasto(X, [1, 2, 3, 4]).
% butlasto(X, Y).




% (enlisto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst pero cada uno colacado dentro de una lista

enlisto([], []).
enlisto([HEAD1 | TAIL1], [[HEAD1] | TAIL]):-
    enlisto(TAIL1, TAIL).

% enlisto([a, b, c, d, e], X).
% enlisto(X, [a, b, c, d, e]).
% enlisto(X, [[a], [b], [c], [d], [e]]).
% enlisto(X, Y).




% (duplicateo lst result)
% Función lógica que tiene éxito si cada elemento en lst aparece duplicado en result

duplicateo([], []).
duplicateo([HEAD1 | TAIL1], [HEAD1 | [HEAD1 | TAIL]]):-
    duplicateo(TAIL1, TAIL).

% duplicateo([1, 2, 3, 4], X).
% duplicateo(X, [a, a, b, b, c, c]).
% duplicateo(X, [a, a, b, b, c, c, d]).
% duplicateo(X, Y).




% ---------------------- CHECAR ----------------------
% (removeo x lst result)
% Función lógica que tiene éxito si se puede eliminar la primera ocurrencia de x en lst obteniendo result

removeo(X, false, _).

removeo(HEAD, [HEAD | TAIL], TAIL):- !.

removeo(X, [HEAD | TAIL], [HEAD | TAIL1]):-
    removeo(X, TAIL, TAIL1).


% removeo(3, [1, 2, 3, 4], X).
% removeo(5, [1, 2, 3, 4], X).
% removeo(X, [1, 2, 3, 4], [1, 2, 4]).
% removeo(0, X, [1, 2, 3, 4]).
% removeo(X, [1, 2, 3, 4], Y).


% (reverseo lst result)
% Función lógica que tiene éxito si result es la reversa de lst

reverseo([], []).
reverseo([HEAD | []], [HEAD]).
reverseo([HEAD | TAIL], LIST):-
    reverseo(TAIL, TAIL1),
    append(TAIL1, [HEAD], LIST).

% reverseo([a, b, c, d], X).
% reverseo(X, [a, b, c, d]).
% reverseo([a, b, c, d], [e, d, c, b, a]).




% (palindromeo lst)
% Función lógica que tiene éxito si lst es un palíndromo (se lee igual de izquierda a derecha que de derecha a izquierda)

palindromeo(X):-
    reverseo(X, R1),
    X == R1,
    write("yes").
    
% palindromeo([a, b, c, d, c, b, a]).
% palindromeo([a, b, c, d, e, f, g]).
% palindromeo([]).




% (rotateo lst result)
% Función lógica que tiene éxito cuando result es el resultado de girar lst hacia la izquierda una posición. 
% En otras palabras, el primer elemento de lst se convierte en el último elemento de result.

rotateo([HEAD | TAIL], X):-
    append([TAIL], [HEAD], X).

% rotateo([a, b, c, d, e], X).
% rotateo(X, [a, b, c, d, e]).
% rotateo([a, b, c, d, e], [a, b, c, d, e]).




% (evensizeo lst) y (oddsizeo lst)
% Estas dos funciones lógicas deben definirse de manera mutuamente recursiva.
% Es decir, cada una debe definirse en términos de la otra. 
% Estas funciones tienen éxito si el número de elementos en lst es par o impar, respectivamente.

oddsizeo([HEAD | []]):- write("yes").
oddsizeo([HEAD | TAIL]):-
    evensizeo(TAIL).

evensizeo([]):- write("yes").
evensizeo([HEAD | TAIL]):-
    oddsizeo(TAIL).

% evensizeo([a,b,c,d]).
% oddsizeo([a,b,c]).
% oddsizeo([a,b,c,d]).
% evensizeo(X).


