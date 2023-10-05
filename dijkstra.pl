%Definir arcos y distancias entre nodos
grafo(cachi,turrialba,40).
grafo(cachi,paraiso,10).
grafo(cachi,orosi,12).
grafo(cartago,paraiso,10).
grafo(cartago,pacayas,13).
grafo(cartago,tresrios,8).
grafo(cartago,sanjose,20).
grafo(cartago,musgoverde,10).
grafo(cervantes,cachi,7).
grafo(cervantes,juanvinas,5).
grafo(cervantes,pacayas,8).
grafo(corralillo,musgoverde,6).
grafo(corralillo,sanjose,22).
grafo(juanvinas,turrialba,4).
grafo(musgoverde,cartago,10).
grafo(musgoverde,corralillo,6).
grafo(orosi,cachi,12).
grafo(orosi,paraiso,8).
grafo(pacayas,cervantes,8).
grafo(pacayas,cartago,13).
grafo(pacayas,tresrios,15).
grafo(paraiso,cervantes,4).
grafo(paraiso,cachi,10).
grafo(paraiso,orosi,8).
grafo(sanjose,cartago,20).
grafo(sanjose,corralillo,22).
grafo(tresrios,pacayas,15).
grafo(turrialba,cachi,40).
grafo(turrialba,pacayas,18).

%[[[a,b,c,d,e],11],[[a,b,c,e],8],[[a,b,d,e],11],[[a,c,d,e],7],[[a,c,e],4]]
%[sanjosé,orosi,turrialba,tresríos]
%[[sanjosé,orosi],[orosi,turrialba],[turrialba,tresríos]]

%aqui tengo un problema, no se está leyendo la primera sublista.
resultado([]).
resultado([[X,Y]|Resto]):-dijkstra(X,Y),resultado(Resto).

%write("Este es X ": X),nl,write("Este es Y ": Y),nl,

%resultado([[X,Y]|Lista]):-write(X),nl,write(Y),nl,write(Lista).


% Entradas: Una lista que contiene el origen, destinos intermedios y el
% destino final
% Utilidad: Estas 3 reglas permiten crear la lista con sublistas
% para utilizar el dijkstra.
% Salida: Una lista de sublistas para ser utilizada en el dijkstra
%
crear_sublistas([],[]). %Este es el caso en el que ambas listas estan vacias entonces se debe detener.
crear_sublistas([_],[]). %En este caso se verifica cuando en la lista original queda solo 1 elemento.

crear_sublistas([X, Y| Resto], [[X, Y] | SublistasResto]) :-
    crear_sublistas([Y| Resto], SublistasResto), muestra(SublistasResto). %En esta regla se realiza la recursion.


% Entrada: Una lista que contiene sublista, cada sublitas tiene 2
% elementos, el primero corresponde a la ruta que se puede usar y el
% segundo elemento corresponde al costo en total de la ruta
% Este predicado permite encontrar la ruta minima de todas las posibles rutas
% que retorna el dijkstra
% Salida: Retorna la ruta más corta
min_lista([[Lista, Numero]], [Lista, Numero]).
min_lista([[Lista, Numero] | Resto], Min) :-
    min_lista(Resto, [_, MinNumero]),
    Numero < MinNumero,
    Min = [Lista, Numero].
min_lista([[_, Numero] | Resto], Min) :-
    min_lista(Resto, [MinLista, MinNumero]),
    Numero >= MinNumero,
    Min = [MinLista, MinNumero].



% Predicado para encontrar el camino más corto
shortest_path(Start, End, Path, Length) :-
    shortest_path(Start, End, [Start], Path1, Length), reverse(Path,Path1).

% Caso base: cuando llegamos al destino
shortest_path(End, End, Path, Path, 0).

% Caso recursivo: encontrar el camino más corto
shortest_path(Start, End, Visited, Path, Length) :-
    grafo(Start, X, D),                % Encontrar un vecino X
    \+ member(X, Visited),            % Asegurarse de que X no esté en la lista visitada
    shortest_path(X, End, [X|Visited], Path, RestLength),   % Recursión
    Length is D + RestLength.


dijkstra(Origen,Destino):-findall([Ruta,Costo],shortest_path(Origen, Destino, Ruta, Costo),Rutas), min_lista(Rutas, RutaMin), muestra_rutas(RutaMin).

muestra_rutas([X,Y]):-write("La ruta es: "),lista_a_cadena(X, Cadena),write(Cadena), write(" y el costo es de ":Y).

% Predicado para concatenar dos listas
concatenar([], Lista, Lista).
concatenar([X|Resto1], Lista2, [X|Resto3]) :-
    concatenar(Resto1, Lista2, Resto3).


iniciardikstra([]).
iniciardikstra([X,Y|Resto]):-dijkstra(X,Y),nl,iniciardikstra([Y|Resto]).

% Predicado para convertir una lista en una cadena
lista_a_cadena([], '').
lista_a_cadena([X], Atom) :- atom_number(Atom, X).
lista_a_cadena([X|Resto], Cadena) :-
    atom_number(Atom, X),
    lista_a_cadena(Resto, RestoCadena),
    atomic_concat(Atom, ', ', AtomComa),
    atomic_concat(AtomComa, RestoCadena, Cadena).

% Ejemplo de uso
%?- Lista = [1, 2, 3],
%   lista_a_cadena(Lista, Cadena),
%   write(Cadena).





























































