%Definir arcos y distancias entre nodos

grafo(cachi,cervantes,7).
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

%Caso de prueba: [sanjosé,orosi,turrialba,tresríos]

muestra_rutas([X,Y]):-write("La ruta es ":X), write(" y el costo es de ":Y).


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


% Esta regla es la que ayuda a encontrar el camino mas corto
posibles_rutas(Origen, Destino, Ruta, Longitud) :-
    posibles_rutas(Origen, Destino, [Origen], Ruta_acomodada, Longitud), reverse(Ruta,Ruta_acomodada). %Se usa reverse porque sino la ruta va a quedar ordenada al reves, o sea de destino a origen

% En este hecho se verifica cuando se llega al caso de parada.
posibles_rutas(Destino, Destino, Ruta, Ruta, 0).

% Este es el caso recursivo para encontrar el camino más corto
posibles_rutas(Origen, Destino, Visitados, Ruta, Longitud) :-
    grafo(Origen, X, D),                % Encontrar un vecino X
    \+ member(X, Visitados),            % Asegurarse de que X no esté en la lista visitada
    posibles_rutas(X, Destino, [X|Visitados], Ruta, Rest_longitud),   % Recursión
    Longitud is D + Rest_longitud.

% Esta es la llamada del dijkstra que junto con findall encuentra todas
% las rutas posibles, y usa a min_lista para escoger la mas corta y
% mostrarla con muestra_rutas.
dijkstra(Origen,Destino):-findall([Ruta,Costo], posibles_rutas(Origen, Destino, Ruta, Costo),Rutas), min_lista(Rutas, RutaMin), muestra_rutas(RutaMin).


% Entrada: Recibe una lista que contiene el origen, destinos intermedios
% y destino
% Esta es la llamada inicial que ejecuta el dijkstra
% Salida: Muestra el resultado en consola de la ruta mas corta con su
% distancia respectiva.
iniciar_dijkstra([]).
iniciar_dijkstra([X,Y|Resto]):-dijkstra(X,Y),nl,iniciar_dijkstra([Y|Resto]).






























































