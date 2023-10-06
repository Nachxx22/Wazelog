%definicion del BNF del chatbot

%Hechos de los nodos del grafo/Ciudades que existen en el grafo y se comprueban para el sintagma nominal
nodo([cartago|S],S).
nodo([corralillo|S],S).
nodo([sanjose|S],S).
nodo([musgoverde|S],S).
nodo([tresrios|S],S).
nodo([pacayas|S],S).
nodo([cervantes|S],S).
nodo([paraiso|S],S).
nodo([turrialba|S],S).
nodo([cachi|S],S).
nodo([orosi|S],S).
nodo([juanvinas|S],S).

nodo(cartago).
%Hechos de los saludos posibles
saludo([hola|S],S).
saludo([buenosdias|S],S).
saludo([buenas|S],S).

%Hechos de las despedidas posibles
despedida([hastaluego|S],S).
despedida([adios|S],S).
despedida([nosvemos|S],S).

%Hechos para los verbos del sintagmaverbal
verbo([ir|S],S).
verbo([estoy|S],S).
verbo([quiero|S],S).
verbo([pasar|S],S).
verbo([necesito|S],S).
verbo([voy|S],S).
verbo([encuentro|S],S).
verbo([tengo|S],S).
verbo([dirijo|S],S).
verbo([pasar|S],S).
verbo([hacer|S],S).
verbo([viaje|S],S).
verbo([conocer|S],S).
verbo([interesa|S],S).
verbo([visitar|S],S).
verbo([es|S],S).
verbo([gustaria|S],S).
%%%

%Hechos para las preposiciones
preposicion([en|S],S).
preposicion([a|S],S).
preposicion([hasta|S],S).
preposicion([de|S],S).
preposicion([por|S],S).
preposicion([hacia|S],S).

%Hechos para pronombre
pronombre([me|S],S).
pronombre([mi|S],S).

%Hechos para adjetivos
adjetivo([posicionado|S],S).
adjetivo([establecido|S],S).
adjetivo([localizado|S],S).
adjetivo([instalado|S],S).
adjetivo([ubicado|S],S).

%Hechos para sustantivos
sustantivo([destino|S],S).
sustantivo([ubicacion|S],S).
sustantivo([ganas|S],S).
sustantivo([sitio|S],S).
sustantivo([lugar|S],S).


%hechos para conjuciones
conjucion([que|S],S).

%Hechos para articulos indefenidos
artiindefinido([un|S],S).
artiindefinido([una|S],S).

%Hechos para los lugares posibles en el sintagma nominal
lugar([supermercado|S],S).
lugar([gasolinera|S],S).
lugar([farmacia|S],S).
lugar([cine|S],S).

%Hechos para afirmaciones/negaciones
afirmacion([si|S],S).
afirmacion([porsupuesto|S],S).
negacion([no|S],S).
negacion([ninguno|S],S).

%definicion de hechos para cada lugar
% hechos para el primer lugar - supermercado
supermercado().
%hechos para el segundo lugar- gasolinera
gasolinera().
%hechos para el tercer lugar - farmacia
farmacia().
% hechos para el cuarto lugar - cine
cine().

%Hechos para nombres para la frase
nombre([wazelog|S],S).

%Definición de la gramatica
%Definicion de las posibles oraciones que se pueden recibir y son correctas con este BNF

%Definicion de frases de una sola palabra o sencillas
oracion(A,B):-saludo(A,B). %Para que la frase recibida solo sea un saludo de los posibles
oracion(A,B):-afirmacion(A,B). %Para que la frase recibida pueda ser solo una de las posibles afirmaciones
oracion(A,B):-negacion(A,B).%Para que la frase recibida pueda ser solo una de las posibles negaciones
oracion(A,B):-despedida(A,B). %Para que la frase recibida pueda ser solo una de las posibles despedidas
oracion(A,B):-despedida(A,C),despedida(C,B). %Para que la frase recibida sea una despedida de las posibles y uno de los nombres disponibles
oracion(A,B):-nodo(A,B). %Para que la frase pueda ser solo sea un nodo/ciudad que pertenece al grafo
oracion(A,B):-sintagmanominal(A,B).% para que la frase pueda ser un conector y el nodo como ejemplo [a,cartago]
oracion(A,B):-lugar(A,B).% para que la frase pueda ser un conector y el nodo como ejemplo [a,cartago]

%Definicion de frases más complejas
oracion(A,B):-sintagmaverbal(A,C),sintagmanominal(C,B). % Parteprincipal del BNF para frases relativamente complejas y que se usaran generalmente, conformadas por un sintagma verbal y un sintagma nominal
oracion(A,B):-saludo(A,C),sintagmaverbal(C,Z),sintagmanominal(Z,B).%Esta parte es para poder recibir una oración más compleja, que contenga un saludo, un sintagma verbal y un sintagma nominal
oracion(A,B):-saludo(A,C),nombre(C,Z),sintagmaverbal(Z,L),sintagmanominal(L,B). %Esta parte es para poder recibir una oración más compleja, que contenga un saludo, un nombre, un sintagma verbal y un sintagma nominal

%para la frase más compleja en proceso
oracion(A,B):-sintagmanominal(A,C),sintagmaverbal(C,B).%Esta parde es para recibir la oración más compleja hasta el momento del programa, siendo asi un nodo

%Definicion de los sintagmas

%Definicion de los sintagmas nominales
sintagmanominal(S0,S):-preposicion(S0,S1),nodo(S1,S).
sintagmanominal(S0,S):-nodo(S0,S).
sintagmanominal(S0,S):-artiindefinido(S0,S1),lugar(S1,S).
sintagmanominal(S0,S):-lugar(S0,S).
sintagmanominal(S0,S):-preposicion(S0,S1),sintagmanominal(S1,S).
sintagmanominal(S0,S):-verbo(S0,S1),nodo(S1,S).
sintagmanominal(S0,S):-verbo(S0,S1),sintagmanominal(S1,S).

%para la frase más compleja en proceso
sintagmanominal(S0,S):-lugar(S0,S),verbo(S0,S).
sintagmanominal(S0,S):-nodo(S0,S),verbo(S0,S).



%Definicion de los sintagmas verbales
sintagmaverbal(S0,S):-verbo(S0,S1),verbo(S1,S).
sintagmaverbal(S0,S):-verbo(S0,S1),sintagmanominal(S1,S).
sintagmaverbal(S0,S):-verbo(S0,S).
sintagmaverbal(S0,S):-verbo(S0,S1),sintagmaverbal(S1,S).
sintagmaverbal(S0,S):-pronombre(S0,S1),verbo(S1,S).
sintagmaverbal(S0,S):-verbo(S0,S1),conjucion(S1,S).
sintagmaverbal(S0,S):-verbo(S0,S1),adjetivo(S1,S).
sintagmaverbal(S0,S):-sustantivo(S0,S1),verbo(S1,S).
sintagmaverbal(S0,S):-verbo(S0,S1),sustantivo(S1,S).
sintagmaverbal(S0,S):-pronombre(S0,S1),sintagmaverbal(S1,S).
sintagmaverbal(S0,S):-artiindefinido(S0,S1),verbo(S1,S).

%para la frase más compleja en proceso
sintagmaverbal(S0,S):-artiindefinido(S0,S1),sintagmaverbal(S1,S).
sintagmaverbal(S0,S):-sustantivo(S0,S1),sintagmaverbal(S1,S).