:- consult('reloj.pl').

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

%Caso de prueba: [sanjose,orosi,turrialba,tresrios]

% Entrada: Una lista que contiene sublista, cada sublitas tiene 2
% elementos, el primero corresponde a la ruta que se puede usar y el
% segundo elemento corresponde al costo en total de la ruta
% Funcion: Este predicado permite encontrar la ruta minima de todas las
% posibles rutas que retorna el dijkstra
%Salida: Retorna la ruta m�s

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
    posibles_rutas(Origen, Destino, [Origen], Ruta_acomodada, Longitud), reverse(Ruta,Ruta_acomodada). %Se usa reverse
% porque sino la ruta va a quedar ordenada al reves, o sea de destino
% a origen

% En este hecho se verifica cuando se llega al caso de parada.
posibles_rutas(Destino, Destino, Ruta, Ruta, 0).

% Este es el caso recursivo para encontrar el camino m�s corto
posibles_rutas(Origen, Destino, Visitados, Ruta, Longitud) :-
    grafo(Origen, X, D),                % Encontrar un vecino X
    \+ member(X, Visitados),            % Asegurarse de que X no est� en la lista visitada
    posibles_rutas(X, Destino, [X|Visitados], Ruta, Rest_longitud),   % Recursi�n
    Longitud is D + Rest_longitud.

%Este hecho sirver para retornar los dos primeros elementos de una lista
primeros_dos_elementos([X, Y|_], X, Y).

% Entrada: Recibe una lista que contiene los numeros que se quieren
% sumar
% Funcion: Sirve para sumar los elementos de una lista
% Salida: Retorna la suma de los numeros de una lista
sumar_lista([], 0).  % Caso base: la suma de una lista vac�a es 0.
sumar_lista([X|Resto], Suma) :-
    sumar_lista(Resto, SumaResto),  % Llamada recursiva para sumar el resto de la lista.
    Suma is X + SumaResto.  % Suma el elemento actual (X) con la suma del resto (SumaResto).



% Entrada: Recibe Camino que es la ruta junto con los costos, Ruta es
% una lista de solo la ruta, Distancias es una lista con las
% distintas distancias
% Funcion: Este hecho verifica cuando se debe detener la llamada
% recursiva y muestra en consola la informacion deseada
% Salida: Muestra el resultado en consola de la ruta mas corta y la
% distancia respectiva.
dijkstra([_],Camino,Ruta,Distancias):-nl,reverse(Camino,Camino_Ordenado),
    write('esta es la ruta ':Camino_Ordenado),
    nl,write('esta es la ruta junta ':Ruta),
    nl, sumar_lista(Distancias,Km),
    writeln('este es el costo total ':Km),
    tiempoestimado(Km,L),
    tiempopresa(L,M),
    writeln('El tiempo estimado es: '),
    writeln(L:'Minutos'),
    writeln('El tiempo estimado en presa es: '),
    write_ln(M:'Minutos').
    
    /*
    KmTiempo is Km,
    %Para mostrar el tiempo estimado de la ruta
    tiempoestimado(KmTiempo,TiempoEstimado),
    writeln(TiempoEstimado),
    %Para mostar el tiempo estimado en presa de la ruta
    tiempopresa(TiempoEstimado,TiempoPresa),
    writeln(TiempoPresa).
*/


% Entrada: Recibe la lista con el origen, destinos intermedios y destino
% Funcion: Esta es la llamada del dijkstra que junto con findall
% encuentra todas las rutas posibles, y usa a min_lista para escoger la
% mas corta e ir formando una lista con el camino final y una lista con
% los distintos costos.
% Salida: Muestra el resultado en consola de la ruta mas corta con su
% distancia respectiva.
dijkstra([Origen,Destino|Resto], Resultado, Camino, Km):-
    findall([Ruta,Costo], posibles_rutas(Origen, Destino, Ruta, Costo),Rutas),
    min_lista(Rutas, RutaMin),
    primeros_dos_elementos(RutaMin, PrimerElemento, SegundoElemento),
    append(Camino,PrimerElemento,Camino2),
    dijkstra([Destino|Resto],[RutaMin|Resultado],Camino2, [SegundoElemento|Km]),
    !.

% Entrada: Recibe la lista con el origen, destinos intermedios y destino
% Funcion: Es un hecho intermedio para llamar a dijkstra con los
% parametros necesarios
inicia_dijkstra(Lista):-dijkstra(Lista,[],[],[]).
