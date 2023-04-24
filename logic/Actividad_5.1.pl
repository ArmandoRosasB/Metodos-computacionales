% Authors
% Ramona Najera Fuentes
% Rodrigo Teran Hernandez
% Jose Armando Rosas Balderas


% (lasto lst x)
% Función lógica que tiene éxito si x es el último elemento de lst

lasto([HEAD | []], HEAD).
lasto([_ | Tail], X) :-
    lasto(Tail, X).

% lasto(Y,5).
% lasto([],X).
% lasto([1,2,3,4],X).




% (butlasto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst excepto el último

butlasto([HEAD | []], []).
butlasto([HEAD1 | TAIL1], [HEAD1 | TAIL]):-
    butlasto(TAIL1, TAIL).

% butlasto([1,2,3,4],X).
% butlasto(X,[1,2,3,4]).
% butlasto(X,Y).




% (enlisto lst result)
% Función lógica que tiene éxito si result contiene los mismos elementos que lst pero cada uno colacado dentro de una lista

enlisto([], []).
enlisto([HEAD1 | TAIL1], [[HEAD1] | TAIL]):-
    enlisto(TAIL1, TAIL).

% enlisto([a,b,c,d,e],X).
% enlisto(X, [a,b,c,d,e]).
% enlisto(X,[[a],[b],[c],[d],[e]]).
% enlisto(X,Y).




% (duplicateo lst result)
% Función lógica que tiene éxito si cada elemento en lst aparece duplicado en result

duplicateo([], []).
duplicateo([HEAD1 | TAIL1], [HEAD1 | [HEAD1 | TAIL]]):-
    duplicateo(TAIL1, TAIL).

% duplicateo([1,2,3,4],X).
% duplicateo(X,[a,a,b,b,c,c]).
% duplicateo(X,[a,a,b,b,c,c,d]).
% duplicateo(X,Y).




% (removeo x lst result)
% Función lógica que tiene éxito si se puede eliminar la primera ocurrencia de x en lst obteniendo result

removeo(X, false, _).
removeo(HEAD, [HEAD | TAIL], TAIL).
removeo(X, [HEAD | TAIL], [HEAD | TAIL1]):-
    removeo(X, TAIL, TAIL1).

% removeo(3,[1,2,3,4],X).
% removeo(5,[1,2,3,4],X).
% removeo(X,[1,2,3,4],[1,2,4]).
% removeo(0,X,[1,2,3, 4]).
% removeo(X,[1,2,3,4],Y).


% (reverseo lst result)
% Función lógica que tiene éxito si result es la reversa de lst

reverseo([], []).
reverseo([HEAD | []], [HEAD]).
reverseo([HEAD | TAIL], LIST):-
    reverseo(TAIL, TAIL1),
    append(TAIL1, [HEAD], LIST).

% reverseo([a,b,c,d],X).
% reverseo(X,[a,b,c,d]).
% reverseo([a,b,c,d],[e,d,c,b,a]).




% (palindromeo lst)
% Función lógica que tiene éxito si lst es un palíndromo (se lee igual de izquierda a derecha que de derecha a izquierda)

palindromeo(X):-
    reverseo(X, R1),
    X == R1,
    write("yes").
    
% palindromeo([a,b,c,d,c,b,a]).
% palindromeo([a,b,c,d,e,f,g]).
% palindromeo([]).




% (rotateo lst result)
% Función lógica que tiene éxito cuando result es el resultado de girar lst hacia la izquierda una posición. 
% En otras palabras, el primer elemento de lst se convierte en el último elemento de result.

rotateo([HEAD | TAIL], X):-
    append([TAIL], [HEAD], X).

% rotateo([a,b,c,d,e],X).
% rotateo(X,[a,b,c,d,e]).
% rotateo([a,b,c,d,e],[a,b,c,d,e]).




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




% (splito lst a b)
% Función lógica que tiene éxito cuando al dividir lst se obtiene a y b
% Los elementos primero, tercero, quinto, etc. de lst van en a, mientras que los elementos segundo, cuarto, sexto, etc. van en b.

splito([], [], []).
splito([HEAD | []], [HEAD], []).
splito([HEAD | [SECOND | []]], [HEAD], [SECOND]).
splito([HEAD | [SECOND | TAIL]], [HEAD | L1], [SECOND | L2]):-
    splito(TAIL, L1, L2).

% splito([a,1,b,2,c,3,d,4,e],X,Y).
% splito(X,[a,b,c,d,e],[1,2,3,4]).
% splito([a,b,c],[a,b,c],X).
% splito([a,b,c],[a,c],X).




% (swappero a b lst result)
% Función lógica que tiene éxito solo si result contiene los mismos elementos que lst excepto que cada ocurrencia de a se intercambia por b, y viceversa
swappero(X, Y, [], []).
swappero(X, Y, [HEAD1 | []], [HEAD2 | []]) :-
    HEAD1 == X,
    HEAD2 == Y.
swappero(X, Y, [HEAD1 | []], [HEAD2 | []]) :-
    HEAD1 == Y,
    HEAD2 == X.
swappero(X, Y, [HEAD1 | []], [HEAD2 | []]) :-
    HEAD1 \== Y,
    HEAD1 \== X,
    HEAD1 == HEAD2.
swappero(X, Y, [HEAD1 | TAIL1], [HEAD2 | TAIL2]) :-
    TAIL1 \== [],
    TAIL2 \== [],
    swappero(X, Y, [HEAD1], [HEAD2]),
    swappero(X, Y, TAIL1, TAIL2).

% swappero(1,2,[],[]).
% swappero(1,2,[2],[1]).
% swappero(1,2,[3],[3]).
% swappero(1,2,[1],[2]).
% swappero(1,2,[3],[4]).
% swappero(1,2,[1,2,3,4,5],[6,7,8,8,9]).
% swappero(1,2,[1,2,3,4,5],[2,1,3,4,5]).


% swappero
swappero(_,_,[],[]).
swappero(X,Y,[HEAD | TAIL], [Y | R]):-
    HEAD == X,
    swappero(X, Y, TAIL, R).

swappero(X,Y,[HEAD | TAIL], [X | R]):-
    HEAD == Y,
    swappero(X, Y, TAIL, R).


swappero(X,Y,[HEAD | TAIL], [HEAD | R]):-
    HEAD \== X,
    HEAD \==Y,
    swappero(X, Y, TAIL, R).

%swappero(a,b,[a,b,a,b,b,b,a],X).
%swappero(a,b,X,[]).
%swappero(purr,kitty,[soft,kitty,warm,kitty,little,ball,of,fur,happy,kitty,sleepy,kitty,purr,purr,purr],X).


% (equalo lst)
% Función lógica que tiene éxito solo si todos los elementos contenidos en lst se unifican con el
% mismo valor. La función siempre debe tener éxito si lst está vacía o tiene un solo elemento.
equalo([]).
equalo([HEAD | []]).
equalo([HEAD | [SECOND | TAIL]]) :-
    HEAD == SECOND,
    equalo([SECOND | TAIL]).
    
% equalo([]).
% equalo([1]).
% equalo([1,1,1,1,1,1,1,1]).
% equalo([1,1,1,1,1,2,1,1]).
% equalo([1,2,2,2,2,2,2,2]).
% equalo([2,2,2,2,2,2,2,2]).
% equalo([2,2,2,2,2,2,2,3]).



% (subseto a b)
% Función lógica que tiene éxito si todos los elementos de la lista a son miembros a su vez
% también de la lista b.
subseto([], _).
subseto([HEAD | TAIL], RESULT) :-
    member(HEAD, RESULT),
    subseto(TAIL, RESULT).

% subseto([],[]).
% subseto([1,2],[]).
% subseto([1,2],[3,4]).
% subseto([1,2],[1,4]).
% subseto([1,2],[1,2]).
% subseto([1,2],[1,2,3,4]).
% subseto([1,5],[1,2,3,4]).




% (compresso lst result)
% Función lógica que tiene éxito si result tiene los mismos elementos que lst
% excepto que si algunos de estos están repetidos de manera consecutivos se reemplazan por una sola instancia.
% El orden de los elementos no debe modificarse.
compresso([], []).
compresso([HEAD], [HEAD]).
compresso([HEAD, HEAD | TAIL], RESULT) :-
    compresso([HEAD | TAIL], RESULT).
compresso([HEAD1, HEAD2 | TAIL2], [HEAD1 | RESULT]) :-
    dif(HEAD1, HEAD2),
    compresso([HEAD2 | TAIL2], RESULT).
% compresso([],[]).
% compresso([1,1,1,1,1,1,1],[1]).
% compresso([1,1,1,1,1,1,1],[2]).
% compresso([1,1,1,1,2],[1,2]).
% compresso([1,1,2,2,1,1,2,2,1,1],[1,2,1,2,1]).
% compresso([1,1,1,1,2,2,2],[1,2,2]).
% compresso([1,1,1,1,2,2,2],[1,2]).
% compresso([1,1,1,1,2,2,2],[1,2,3]).
% compresso([1,1,1,1,2,2,2],[]).
% compresso([1,2,3,4],[1,2,3,4]).
% compresso([1,2,3,4],[3,2,1,4]).