:- consult('BNF.pl'). % Importa las reglas BNF desde el archivo bnf.pl

leer([]):-write('bienvenido a wazelog, su
navegador fiable.Por favor digame donde se encuentra:'),nl,
 read_line_to_string(user_input, String), tokenize_atom(String, Lista_result),%consulta el origen
 consulta_inicial(Lista_result,Result1),
 write('Excelente, estamos en: '),write( Result1),nl,write('favor digite su destino'),nl,
 read_line_to_string(user_input, String2), tokenize_atom(String2, Lista_result2),%consulta el destino.
 consulta_inicial(Lista_result2,Result2),nl,write('Perfecto, vamos hacia '),write(Result2),nl,
 write('Existe algun destino intermedio?, favor dijite no en caso de que no haya, en caso contrario favor dijite el destino intermedio'),nl,
 read_line_to_string(user_input, String3), tokenize_atom(String3, SIONO),
 tomar_decision(SIONO,Lista_resultado,0),
 concatenar([Result1],Lista_resultado,X),
 concatenar(X,[Result2],Y),
 write('su resultado'),nl,write(Y).
 %write(Lista_resultado).
maximo(3).
decision([no]).
% definicion de reglas , para determinar las palabras clave respecto a
% LUGARES: %la palabra clave es un lugar especifico?
lugar(ciudad).
lugar(pueblo).
lugar(panaderia).
lugar(supermercado).
lugar(gasolinera).
lugar(pulperia).
lugar(universidad).
intermedio(pulperia,la_Estrella,san_jose). %dicha pulperia tiene nombre?
intermedio(universidad,tec,cartago).
intermedio(gasolinera,el_joron,perez).
%UBICACIONES, ESTO ES
ubicacion(sanjose).
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
%de prueba:
ubicacion(heredia).
ubicacion(alajuela).
ubicacion(guanacaste).
ubicacion(puntarenas).
ubicacion(limon).
% logica es, busca palabras clave, e pregunta si la palabra clave
% encontrada es un lugar , si lo es primero el busca el lugar, si la
% palabra clave es un lugar va a pasar a un metodo que determina el tipo
% de lugar , luego pregunta cual supermercado
%BUSQUEDA DE LUGARES:
% CASO EXTRA, EL USUARIO PUEDE DECIR la gasolinera bonita o la
% gasolinera_nombre, por tanto , no pregunte el nombre o ponga casos
% tipo si despues viene vacio entonces pregunte nombre, si viene algo
% mas que solo pregunte la ubicacion.
oraciones([X|_],X):-lugar(X),!. %elimine la linea de arriba
%EL PROGRAMA DEBERIA DE TERMINAR ACA.
oraciones([_|Entrada],Salida):-oraciones(Entrada,Salida).
% Predicado para dividir una cadena en palabras y convertir
% Predicado para leer una l�nea de entrada y convertirla en una lista de palabras.



% la idea es que pregunte sobre la palabra clave, es un lugar? o es una
% ciudad especifica.
%CONSULTAS DE INICIACION################################################
consulta_inicial(Lista,Pclave):-oracion(Lista,[]),oraciones(Lista,Pclave),!. %caso 1, la palabra clave es un lugar general
consulta_inicial(Lista,Pclave):-oracion(Lista,[]),ubicaciones(Lista,Pclave),!.%caso 2, la palabra clave es un lugar intermedio.
consulta_inicial(Lista,Pclave):- write('no entendi a que se referia con'),nl,write(Lista),nl,
    write('favor redigite su consulta de otra manera'),nl,
    read_line_to_string(user_input, X), tokenize_atom(X, Lista2),
    consulta_inicial(Lista2,Pclave). %esto deberia de estar bien.
%CONSULTAS DE DESTINOS INTERMEDIOS#################################:
procesar_consulta(Lista,Lista2,NUMBER):-oraciones(Lista,Pclave),consultarlugar(Pclave,Lista2,NUMBER),!.%busca una palabra clave tal que
%pulperia, gasolinera
procesar_consulta(Lista,[X|Y],NUMBER):-ubicaciones(Lista,X),NUM1 is NUMBER+1, consultarintermedio([X|Y],NUM1),!.
procesar_consulta(Lista,[],NUMBER):- write('no entendi a que se referia con'),nl,write(Lista),nl,
    write('favor redigite su consulta de otra manera'),nl,
    read_line_to_string(user_input, X), tokenize_atom(X, Lista2),
    procesar_consulta(Lista2,Pclave,NUMBER), %esto deberia de estar bien.
    write('su consulta es:'),write(Pclave).
% SIENTO QUE EL ERROR ESTA EN QUE UN ARGUMENTO ES VACIO , CUANDO NO
% DEBERIA DE SERLO, PROBAR LUEGO,patch up con el corte , pero es
% necesario conocer la razon del error.
% ------------------------------------------------------------------------------
% codigo para seguir consultado EN CASO DE QUE EL USUARIO DIGA QUE ESTA
% EN UN SUPERMERCADO, CONSIDERE 3 DESTINOS INTERMEDIOS MAX, ESTO IMPLICA
% QUE SEA UN VALOR QUE SE PASA. -ESTE CODIGO DEBE DE TENER UN TIPO DE
% ITERACION EN CASO DE QUE NO ENTIENDA QUE LE METIO EL USUARIO.
% CONSIDERE QUE EL USUARIO PUEDE DECIR ESTOY EN LA PULPERIA LA ESTRELLA,
% ENTONCES NO TENDRIA QUE PREGUNTAR EL NOMBRE DE LA PULPERIA, esto es un
% caso extra, o me puedo quitar el tiro y no preguntar el nombre de
% dicha pulperai
consultarlugar(Pclave,[],NUM):-maximo(NUM), write('perfecto, se ha calculado la ruta'),nl,write(Pclave),!.
consultarlugar(Pclave,Lista,NUM):-write('indiqueme donde se encuentra tal'),write(Pclave),nl,
    read_line_to_string(user_input, Z), tokenize_atom(Z, Lista2),procesar_consulta(Lista2,Lista,NUM).
% ----------------------------------------------------------------------
% codigo para las ubicaciones , este debe de ser distinto , ya que debe
% de considerar 3 lugares intermedios max, y aca se debe de a�adir a una
% lista, donde esa lista es la que va a ser enviada despues al dikstra.
% -ESTE CODIGO DEBE DE TENER UN TIPO DE ITERACION EN CASO DE QUE NO
% ENTIENDA QUE LE METIO EL USUARIO.
ubicaciones([X|_],X):-ubicacion(X),!.
ubicaciones([_|Entrada],Salida):-ubicaciones(Entrada,Salida).

consultarintermedio([Pclave|[]],NUM):-maximo(NUM), write('perfecto, SE va a concluir con su ultima consulta'),nl,write(Pclave),!.
consultarintermedio([X|Y],NUM):-write('papito Existe otro destino aparte de'),write(X), write(' que desea ir? Favor digitelo'),nl,
   read_line_to_string(user_input, Z), tokenize_atom(Z, Lista),tomar_decision(Lista,Y,NUM).


tomar_decision(SIONO,[],Numero):-decision(SIONO),write(Numero).%lista en caso de que sea no
tomar_decision(Lista_Destino,Lista_resultado,Numero):-not(decision(Lista_Destino)) ,procesar_consulta(Lista_Destino,Lista_resultado,Numero).%en caso de que sea SI.

%funcion que une un elemento con una lista
concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).

% condicion que pregunta cual panaderia,gasolinera,etc, pregunta donde
% se ubica.







