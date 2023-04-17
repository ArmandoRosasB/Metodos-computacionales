% (lasto lst x)
% Función lógica que tiene éxito si x es el último elemento de lst

lasto([HEAD | []], HEAD, HEAD).
lasto([_ | Tail], X, R) :-
    lasto(Tail, X, R).

% lasto(Y, 5, 5).
% lasto([], X, X).
% lasto([1, 2, 3, 4], X, X).




% (butlasto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst excepto el último

butlasto([HEAD | []], []).
butlasto([HEAD1 | TAIL1], [HEAD1 | TAIL]):-
    butlasto(TAIL1, TAIL).

% butlasto([1, 2, 3, 4], X).
% butlasto(X, [1, 2, 3, 4]).
% butlasto(X, Y).




% (enlisto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst pero cada uno colacado dentro de una lista.

enlisto([], []).
enlisto([HEAD1 | TAIL1], [[HEAD1] | TAIL]):-
    enlisto(TAIL1, TAIL).

% enlisto([a, b, c, d, e], X).
% enlisto(X, [a, b, c, d, e]).
% enlisto(X, [[a], [b], [c], [d], [e]]).
% enlisto(X, Y).