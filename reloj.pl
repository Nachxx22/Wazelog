% Predicado para convertir la hora en formato militar
convertirHora(Hora) :-
    get_time(Tiempo),
    stamp_date_time(Tiempo, FechaHora, 'UTC'),
    date_time_value(hour, FechaHora, Hora24), Hora is Hora24 ,writeln('La hora actual es: '),writeln(Hora).

% Predicado para multiplicar un dato por otro dato dependiendo de si la hora es menor o mayor que 12
multiplicarDato(Dato, Resultado) :-
    convertirHora(Hora),
    Hora < 12,
    %writeln(Resultado),writeln(Dato),
    Resultado is Dato * 2,writeln(Resultado).
multiplicarDato(Dato, Resultado) :-
    convertirHora(Hora),
    Hora >= 12,
    %writeln(Dato),writeln(Resultado),
    Resultado is Dato * 4,writeln(Resultado).

%Predicado solo para multiplicar el dato para el tiempo estimado
multiplicarDato2(Dato, Resultado) :-
    Resultado is Dato * 2,writeln(Resultado).

%Esta regla es para encontrar el tiempo estimado pero en presa, tomando en cuenta la hora  de costa rica
%Si la hora es mayor que 12 el tiempo estimado se multiplica por 6
%
tiempopresa(Tiempoestimado,Tiempoenpresa):-multiplicarDato(Tiempoestimado,Resultado),Tiempoenpresa is Resultado.

%Esta regla es para encontrar el tiempo estimado de la ruta segun los kilometros
tiempoestimado(Kilometros,Tiempoestimado):-multiplicarDato2(Kilometros,Resultado),Tiempoestimado is Resultado.