%importaciones de archivos:
:- consult('BNF.pl').
:- consult('dijkstra.pl').
:- consult('reloj.pl').

%regla para iniciar el programa:
leer([]):-write('bienvenido a wazelog, su
navegador fiable.Por favor digame donde se encuentra: '),nl,
 read_line_to_string(user_input, String), tokenize_atom(String, Lista_result),%consulta el origen
 consulta_inicial(Lista_result,Result1),
 write('Excelente, estamos en: '),write( Result1),nl,write('favor digite su destino. '),nl,
 read_line_to_string(user_input, String2), tokenize_atom(String2, Lista_result2),%consulta el destino.
 consulta_inicial(Lista_result2,Result2),nl,write('Perfecto, vamos hacia: '),write(Result2),nl,
 write('Existe algun destino intermedio?, favor digite no en caso de que no haya, en caso contrario favor digite el destino intermedio.  '),nl,
 read_line_to_string(user_input, String3), tokenize_atom(String3, SIONO),%linea que consulta si existen destinos intermedios
 tomar_decision(SIONO,Lista_resultado,0), %linea que retorna la lista resultado de destinos intermedios, en caso de que el usuario
 %diga que no , retorna vacio.
 concatenado([Result1],Lista_resultado,X),%concatena el origen con la lista resultado
 concatenado(X,[Result2],Y),nl,write('la lista intermedia es: '),nl,%concatena el origen y la lista resultado con el destino
 write(Y),
 inicia_dijkstra(Y),nl,%proceso que inicia el dikstra.
 %iniciardikstra(Y),nl,
 write('su consulta ha sido exitosa, que tenga un bonito viaje. '),!.
% ###########################################################################3
% HECHOS NECESARIOS PARA EL FUNCIONAMIENTO DEL PROGRAMA:
maximo(3). %MAXIMO 3 DESTINOS INTERMEDIOS
decision([no]).% DECISION DEL USUARIO SI A�ADIR MAS DESTINOS INTERMEDIOS O NO.
% #########################################################################3
% definicion de reglas , para determinar las palabras clave respecto a
% LUGARES: %la palabra clave es un lugar especifico?
lugar(ciudad).
lugar(pueblo).
lugar(panaderia).
lugar(supermercado).
lugar(gasolinera).
lugar(pulperia).
lugar(universidad).
% UBICACIONES, ESTAS SON LAS PALABRAS CLAVES PARA IR A BUSCAR AL
% DIKSTRA#################
%############################
% REGLAS PARA IDENTIFICAR PALABRAS GENERALES COMO GASOLINERA PUEBLO Y
% ESO.
ubicacion(corralillo).
ubicacion(tresrios).
ubicacion(musgoverde).
ubicacion(cartago).
ubicacion(pacayas).
ubicacion(paraiso).
ubicacion(cervantes).
ubicacion(orosi).
ubicacion(cachi).
ubicacion(juanvinas).
ubicacion(turrialba).
ubicacion(sanjose).



destino_general([X|_],X):-lugar(X),!. %elimine la linea de arriba
%EL PROGRAMA DEBERIA DE TERMINAR ACA.
destino_general([_|Entrada],Salida):-destino_general(Entrada,Salida).
% Predicado para dividir una cadena en palabras y convertir
% Predicado para leer una l�nea de entrada y convertirla en una lista de palabras.
% ########################################################################

% el siguiente codigo es utilizado para las 2 primeras lineas, necesita
% que el usuario le envie un lugar en especifico,CONSULTAS DE
% INICIACION################################################
consulta_inicial(Lista,Pclave):-oracion(Lista,[]),destino_general(Lista,Pgeneral),consultarlugar_inicial(Pgeneral,Pclave),!. %caso 1, la palabra clave es un lugar general
consulta_inicial(Lista,Pclave):-oracion(Lista,[]),ubicaciones(Lista,Pclave),!.%caso 2, la palabra clave es un lugar intermedio.
consulta_inicial(Lista,Pclave):- write('no entendi a que se referia con: '),write(Lista),nl,
    write('favor redigite su consulta de otra manera. '),nl,
    read_line_to_string(user_input, X), tokenize_atom(X, Lista2),
    consulta_inicial(Lista2,Pclave). %la linea anterior es para cuando prolog no comprendio la palabra clave o
% no pasa el bnf ,solicita al usuario que escriba de nuevo la respuesta y
% prolog manda de manera recursiva a consultar nuevamente con la
% respuesta en mano
% ################################################################################################3
% CONSULTAS DE DESTINOS INTERMEDIOS#################################:
procesar_consulta(Lista,Lista2,NUMBER):-oracion(Lista,[]),destino_general(Lista,Pclave),consultarlugar(Pclave,Lista2,NUMBER),!.
% busca una palabra clave si el usuario inserta un destino general tanto
% en el inicio como en el destino, similar a procesar consulta pero para
% el flujo inicial, Lista es el imput del usuario, lsita2 el destino
% especifico del grafo a buscar, number es el numero de veces o
% consultas a destinos intermedio, max 3
procesar_consulta(Lista,[X|Y],NUMBER):-oracion(Lista,[]),ubicaciones(Lista,X),NUM1 is NUMBER+1, consultarintermedio([X|Y],NUM1),!.
procesar_consulta(Lista,Lista2,NUMBER):- write('no entendi a que se referia con: '),nl,write(Lista),nl,
    write('favor redigite su consulta de otra manera. '),nl,
    read_line_to_string(user_input, X), tokenize_atom(X, Listas),
    procesar_consulta(Listas,Lista2,NUMBER), %esto deberia de estar bien.
    write('la palabra clave es: ').
% #############################################FIN CONSULTAR
% INTERMEDIOS########################################
% CONSULTAR LUGARES GENERALES (PANADERIA GASOLNERA ETC).
% #################################
consultarlugar_inicial(Pclave,Respuesta):-write('digame donde se encuentra tal '),write(Pclave),nl, read_line_to_string(user_input, Z), tokenize_atom(Z, Lista2),consulta_inicial(Lista2,Respuesta).
% consulta segun el flujo de un lugar general, le pregunta al usuario
% que especifique en caso de que de un lugar general, la linea de arriba
% es para el inicio del flujo de la respuesta
% LAS 2 LINEAS DE ABAJO ES PARA EL FLUJO DE INFORMACION RESPECTO A
% LUGARES INTERMEDIOS, BUSCA FORZAR AL USUARIO A ESPECIFICAR UN LUGAR
% DADA UNA RESPUESTA CON LUGARES GENERALES(panaderia,gasolinera)etc.
consultarlugar(Pclave,[],NUM):-maximo(NUM), write('Perfecto, se ha calculado la ruta: '),nl,write(Pclave),!.
%caso donde maximo sea 3 , esto es condicion de parada.
consultarlugar(Pclave,Lista,NUM):-write('indiqueme donde se encuentra tal '),write(Pclave),nl,
    read_line_to_string(user_input, Z), tokenize_atom(Z, Lista2),procesar_consulta(Lista2,Lista,NUM).
% ----------------------------------------------------------------------
% %CONSULTA LUGARES ESPECIFICOS EN EL GRAFO
ubicaciones([X|_],X):-ubicacion(X),!.
ubicaciones([_|Entrada],Salida):-ubicaciones(Entrada,Salida).
%#####################################################################3
% CODIGO DE CONSULTA DE INTERMEDIOS, SIMILAR A CONSULTAR LUGARES PERO
% DIRECTAMENTE EL USUARIO LE INGRESA UN LUGAR DEL GRAFO
consultarintermedio([Pclave|[]],NUM):-maximo(NUM), write('perfecto, se va a concluir con su ultima consulta: '),nl,write(Pclave),!.
consultarintermedio([X|Y],NUM):-write('Excelente, existe otro destino aparte de '),write(X), write(' que desea ir? por favor digitelo '),nl,read_line_to_string(user_input, Z), tokenize_atom(Z, Lista),tomar_decision(Lista,Y,NUM).
% ########################################################################
% ##############3
%#CODIGO QUE INICIA EL PROCESO DE BUSCAR DESTINOS INTERMEDIOS O NO%
% el codigo siguiente toma decisiones y contiene la condicion de parada
% en caso de que el usuario dijite no a seguir buscando mas destinos
% intermedios
tomar_decision(SIONO,[],Numero):-decision(SIONO),write(Numero).%lista en caso de que sea no
tomar_decision(Lista_Destino,Lista_resultado,Numero):-not(decision(Lista_Destino)) ,procesar_consulta(Lista_Destino,Lista_resultado,Numero).%en caso de que sea SI.
%#######################################################33
%funcion que une un elemento con una lista
concatenado([],L,L).
concatenado([X|L1],L2,[X|L3]):-concatenado(L1,L2,L3).
% devuelve la lista concatenada del punto origen, destino y puntos
% intermedios.
