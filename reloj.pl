% Predicado para convertir la hora en formato militar
convertirHora(Hora) :-
    get_time(Tiempo), %Para obtener la hora de la computadora
    stamp_date_time(Tiempo, FechaHora, 'UTC'), %Esto es para obetener la FechaHora que nos sirve para encontar la hora que esta en el dia, importante agarra el horario UTC que es diferente a costa rica
    date_time_value(hour, FechaHora, Hora24),  %Esto nos da la hora en formato de hora en integer siendo esta de 0 a 23
    Hora is Hora24 ,writeln('La hora actual es: '),writeln(Hora).%Para que la hora sea igual que la de Costa rica en Hora is Hora24 hay que restarle 6, quedando Hora is Hora24 - 6

% Predicado para multiplicar un dato por otro dato dependiendo de si la hora es menor o mayor que 12
multiplicarDato(Dato, Resultado) :-
    convertirHora(Hora),
    Hora < 12, 
    Resultado is Dato * 2,writeln(Resultado).
multiplicarDato(Dato, Resultado) :-
    convertirHora(Hora),
    Hora >= 12,
    Resultado is Dato * 4,writeln(Resultado).

%Predicado solo para multiplicar el dato para el tiempo estimado
multiplicarDato2(Dato, Resultado) :-
    Resultado is Dato * 2,writeln(Resultado).

%Esta regla es para encontrar el tiempo estimado pero en presa, tomando en cuenta la hora  de costa rica
%Si la hora es mayor que 12 el tiempo estimado se multiplica por 6
%si la hora es menor que 12 el tiempo estimado se multiplica por 2
%El dato lo regresa como Tiempoenpresa
tiempopresa(Tiempoestimado,Tiempoenpresa):-multiplicarDato(Tiempoestimado,Resultado),Tiempoenpresa is Resultado.

%Esta regla es para encontrar el tiempo estimado de la ruta segun los kilometros, actualmente se multiplica simplente por 2 y lo da como resultado de Tiempoestimado
tiempoestimado(Kilometros,Tiempoestimado):-multiplicarDato2(Kilometros,Resultado),Tiempoestimado is Resultado.