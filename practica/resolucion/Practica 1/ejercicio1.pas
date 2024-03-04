program ej1;
type
	arcInt = file of Integer;

procedure crearArchivo(var archivo: arcInt);
var
	lectura: Integer;
begin
	Rewrite(archivo);
	readln(lectura);
	while(lectura <> 30000) do
	begin
		Write(archivo, lectura);
		readln(lectura);
	end;
	Close(archivo);
end;

procedure imprimirContenidos(var archivo: arcInt);
var
	aux: Integer;
begin
	Reset(archivo);
	while not EOF(archivo) do
	begin
		read(archivo, aux);
		writeln(aux);
	end;
	Close(archivo);
end;

procedure menor1500(var archivo: arcInt);
var
	aux, cant: Integer;
begin
	cant:= 0;
	Reset(archivo);
	while not EOF(archivo) do
	begin
		read(archivo, aux);
		if(aux < 1500) then
		cant:= cant +1
	end;
	Close(archivo);
	writeln('La cantidad de numeros menores a 1500 es ', cant);
end;

procedure calcularPromedio(var archivo: arcInt);
var
	aux, total, cant: Integer;
	prom: real;
begin
	total:= 0; cant:= 0;
	Reset(archivo);
	while not EOF(archivo) do
	begin
		read(archivo, aux);
		total:= total + aux;
		cant:= cant +1;
	end;
	prom:= total / cant;
	writeln('El promedio de los numeros es ', prom:2:0);
	Close(archivo);
end;
	

var
	arc: arcInt;
	nombreArc: String;
BEGIN
	writeln('=============================');
	writeln('Ingrese el nombre del archivo');
	writeln('=============================');
	readln(nombreArc);
	assign(arc, nombreArc);
	writeln('=============================');
	writeln('Ingrese los enteros a cargar');
	writeln('=============================');
	crearArchivo(arc);
	menor1500(arc);
	calcularPromedio(arc);
END.

