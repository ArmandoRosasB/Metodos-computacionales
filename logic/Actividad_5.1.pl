% (lasto lst x)
% Función lógica que tiene éxito si x es el último elemento de lst

lasto([HEAD | []], HEAD, HEAD).
lasto([_ | Tail], X, R) :-
    lasto(Tail, X, R).

% lasto(Y, 5, 5).
% lasto([], X, X).
% lasto([1, 2, 3, 4], X, X).
