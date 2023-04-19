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

reverseo([HEAD | []], HEAD).
reverseo([HEAD | TAIL], [TAIL1 | HEAD]):-
    reverseo(TAIL, TAIL1).