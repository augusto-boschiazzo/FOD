program ej3;
type
	str15 = String[15];
	str8 = String[8];
	empleado = record
		cod: Integer;
		apellido: str15;
		nombre: str15;
		edad: Integer;
		DNI: str8;
		end;
	
	arcEmp = file of empleado;
	
	txtEmp = Text;

procedure crearArchivo(var archivo: arcEmp);
var
	aux: empleado;
begin
	Rewrite(archivo);
	writeln('Ingrese el apellido del empleado');
	readln(aux.apellido);
	while(aux.apellido <> 'fin') do
	begin
		writeln('Ingrese el nombre del empleado');
		readln(aux.nombre);
		writeln('Ingrese la edad del empleado');
		readln(aux.edad);
		writeln('Ingrese el DNI del empleado');
		readln(aux.DNI);
		writeln('Ingrese el codigo del empleado');
		readln(aux.cod);
		Write(archivo, aux);
		writeln('Ingrese el apellido del empleado');
		readln(aux.apellido);
	end;
	Close(archivo);
end;

procedure impEmp(aux: empleado);
var
	long, calc, i: Integer;
begin
	write('| ', aux.cod, '    | ', aux.nombre);
	long:= length(aux.nombre);
	calc:= 15 - long;
	for i:= 0 to calc do
		write(' ');
	write('| ', aux.apellido);
	long:= length(aux.apellido);
	calc:= 15 - long;
	for i:= 0 to calc do
		write(' ');
	write('| ', aux.edad, '   | ', aux.DNI);
	long:= length(aux.DNI);
	calc:= 8 - long;
	for i:= 0 to calc do
		write(' ');
	writeln('|');
end;


procedure impArc(var archivo: arcEmp);
var
	aux: empleado;
begin
	Seek(archivo, 0);
	writeln('================================================================');
	writeln('                  Lista de todos los empleados                  ');
	writeln('================================================================');
	writeln('| Codigo | Nombre          | Apellido        | Edad | DNI      |');
	while not EOF(archivo) do
	begin 
		Read(archivo, aux);
		impEmp(aux);
	end;	
end;

procedure buscarEmp(var archivo: arcEmp);
var
	aux: empleado;
	nombre: String;
begin
	Seek(archivo, 0);
	write('Ingrese nombre o apellido del empleado a buscar: ');
	readln(nombre);
	Read(archivo, aux);
	while ((not EOF(archivo)) AND (aux.nombre <> nombre) AND (aux.apellido <> nombre)) do
	begin
		Read(archivo, aux);
	end;
	writeln('| Codigo | Nombre          | Apellido        | Edad | DNI      |');
	impEmp(aux);
end;

procedure empJub(var archivo: arcEmp);
var
	aux: empleado;
begin
	Seek(archivo, 0);
	writeln('================================================================');
	writeln('                Lista de empleados por jubilarse                ');
	writeln('================================================================');
	writeln('| Codigo | Nombre          | Apellido        | Edad | DNI      |');
	while not EOF(archivo) do
	begin
		Read(archivo, aux);
		if (aux.edad > 70) then
			impEmp(aux);
	end;
end;

procedure agregarEmp(var archivo: arcEmp);
var
	aux: empleado;
begin
	Seek(archivo, 0);
	write('Ingrese el apellido del empleado: ');
	readln(aux.apellido);
	write('Ingrese el nombre del empleado: ');
	readln(aux.nombre);
	write('Ingrese la edad del empleado: ');
	readln(aux.edad);
	write('Ingrese el DNI del empleado: ');
	readln(aux.DNI);
	write('Ingrese el codigo del empleado: ');
	readln(aux.cod);
	while not EOF(archivo) do
		Seek(archivo, filePos(archivo) +1);
	Write(archivo, aux);
end;

procedure modEdad(var archivo: arcEmp);
var
	cod, edad: Integer;
	aux: empleado;
	cont: String;
begin
	repeat
		Seek(archivo, 0);
		write('Ingrese el codigo del empleado a modificar: ');
		readln(cod);
		writeln('================================================');
		write('Ingrese la edad del empleado a modificar: ');
		readln(edad);
		Read(archivo, aux);
		while NOT(EOF(archivo)) AND (aux.cod <> cod) do
			Read(archivo, aux);
		if (aux.cod = cod) then
		begin
			aux.edad:= edad;
			Seek(archivo, filePos(archivo) -1);
			Write(archivo, aux);
		end
		else
			writeln('No se encontro el empleado.');
		write('Desea modificar otro empleado? ("N" para finalizar): ');
		readln(cont);
	until(cont = 'N');
end;

procedure expArc(var archivo: arcEmp; ok: boolean);
var
	txt: txtEmp;
	aux: empleado;
	calc, long, i: Integer;
	longNom, longApe, longDNI: String;
begin
	Seek(archivo, 0);
	if(ok) then
		assign(txt, 'faltaDNIEmpleado.txt')
	else
		assign(txt, 'todos_empleados.txt');
	Rewrite(txt);
	writeln(txt, '================================================================');
	writeln(txt, '                       Lista de empleados                       ');
	writeln(txt, '================================================================');
	writeln(txt, '| Codigo | Nombre          | Apellido        | Edad | DNI      |');
	while not EOF(archivo) do
	begin
		Read(archivo, aux);
		longNom:= '';
		longApe:= '';
		longDNI:= '';
		long:= length(aux.nombre);
		calc:= 15 - long;
		for i:= 0 to calc do
			longNom:= longNom + ' ';
		long:= length(aux.apellido);
		calc:= 15 - long;
		for i:= 0 to calc do
			longApe:= longApe + ' ';
		long:= length(aux.DNI);
		calc:= 8 - long;
		for i:= 0 to calc do
			longDNI:= longDNI + ' ';
		Writeln(txt, '| ', aux.cod, '    | ', aux.nombre, longNom, '| ', aux.apellido, longApe, '| ', aux.edad, '   | ', aux.DNI, longDNI, '|');
	end;
	Close(txt);
end;

procedure expDNI(var archivo: arcEmp);
var
	arcDNI: arcEmp;
	aux: empleado;
begin
	Seek(archivo, 0);
	assign(arcDNI, 'pepe.dat');
	Rewrite(arcDNI);
	while not EOF(archivo) do
	begin
		Read(archivo, aux);
		if (aux.DNI = '00') then
			Write(arcDNI, aux);
	end;
	expArc(arcDNI, true);
	Close(arcDNI);
end;

procedure abrirArchivo(var archivo: arcEmp);
var
	opcion: String;
begin
	Reset(archivo);
	repeat
		writeln('===============================================================');
		writeln('               Ingrese la opcion correspondiente               ');
		writeln(' 1: Listar empleados | 2: Buscar empleado | 3: Listar jubilados');
		writeln(' 4: Agregar empleado | 5: Modificar edad  | 6: Exportar a TXT  ');
		writeln('                     | 7: Exportar DNI 0  |                    ');
		writeln('===============================================================');
		readln(opcion);
		case (opcion) of
			'1': impArc(archivo);
			'2': buscarEmp(archivo);
			'3': empJub(archivo);
			'4': agregarEmp(archivo);
			'5': modEdad(archivo);
			'6': expArc(archivo, false);
			'7': expDNI(archivo);
			end;
	until opcion = 'fin';
	Close(archivo);
end;


var
	arc: arcEmp;
	nomArc: String;
	opcion: String;
BEGIN
	writeln('=============================');
	writeln('Ingrese el nombre del archivo');
	writeln('=============================');
	readln(nomArc);
	assign(arc, nomArc);
	writeln();
	write('Presione "a" para crear un archivo, o "b" para abrir un archivo existente: ');
	readln(opcion);
	case (opcion) of
		'a': crearArchivo(arc);
		'b': abrirArchivo(arc);
		end;
END.

