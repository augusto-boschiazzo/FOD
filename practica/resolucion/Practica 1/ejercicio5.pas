program ejercicio5;
const
    valorAlto = 'AAAAAAA';
type
    celular = record
        cod: Integer;
        nombre: String;
        desc: String;
        marca: String;
        precio: Real;
        min: Integer;
        disp: Integer;
        end;

    archivo = file of celular;

procedure crearArc(var arc: archivo; var txt: Text);
var
    aux: celular;
begin
    rewrite(arc);
    reset(txt);
    while NOT(EOF(txt)) do
    begin
        with aux do
        begin    
            readln(txt, cod, precio, marca);
            readln(txt, disp, min, desc);
            readln(txt, nombre);
        end;
        write(arc, aux);
    end;
    close(arc);
    close(txt);
end;

procedure stockBajo(var arc: archivo);
var 
    aux: celular;
begin
    reset(arc);
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        if(aux.disp < aux.min) then
        begin
            with aux do
            begin
                writeln('Nombre: ', nombre, ' Marca: ', marca, ' Precio: ', precio:2:0, ' Descripcion: ', desc, ' Codigo: ', cod, ' Stock minimo: ', min, ' Disponible: ', disp);
            end;
        end;
    end;
    close(arc);
end;

procedure impDesc(var arc: archivo);
var 
    aux: celular;
    descripcion: String;
begin
    reset(arc);
    write('Escriba la descripcion a buscar: ');
    readln(descripcion);
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        if (0 <> pos(aux.desc, Descripcion)) then
            with aux do
            begin
                writeln('Nombre: ', nombre, ' Marca: ', marca, ' Precio: ', precio:2:0, ' Descripcion: ', desc, ' Codigo: ', cod, ' Stock minimo: ', min, ' Disponible: ', disp);
            end;
    end;
    close(arc);
end;

procedure expTxt(var arc: archivo; var txt: Text);
var
    aux: celular;
begin
    rewrite(txt);
    reset(arc);
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        with aux do
        begin    
            writeln(txt, cod, ' ', precio, marca);
            writeln(txt, disp, ' ', min, desc);
            writeln(txt, nombre);
        end;
    end;
    close(arc);
    close(txt);
end;

procedure agregarCel(var arc: archivo);
var 
    aux: celular;
    opcion: String;
begin
    reset(arc);
    repeat
        writeln('Ingrese los datos del celular: ');
        with aux do
        begin
            readln(cod);
            readln(nombre);
            readln(desc);
            readln(marca);
            readln(precio);
            readln(min);
            readln(disp);
        end;
        seek(arc, Filesize(arc));
        write(arc, aux);
        write('Desea ingresar otro celular? (Escriba "N" para terminar): ');
        readln(opcion);
    until (opcion = 'N');
    close(arc);
end;

procedure leerCel(var arc: archivo; var aux: celular);
begin
    if (EOF(arc)) then
        aux.nombre:= valorAlto
    else
        read(arc, aux);
end;

procedure modStock(var arc: archivo);
var
    stock: integer;
    nombre: String;
    aux: celular;
begin
    reset(arc);
    write('Ingrese el nombre del celular a modificar: ');
    readln(nombre);
    leerCel(arc, aux);
    while (aux.nombre <> valorAlto) AND (aux.nombre <> nombre) do
    begin
        leerCel(arc, aux);
    end;
    if (aux.nombre = nombre) then
    begin
        write('Se encontro el celular. El stock es: ', aux.disp, ' Ingrese el nuevo stock: ');
        readln(stock);
        aux.disp:= stock;
        seek(arc, filepos(arc) -1);
        write(arc, aux);
    end
    else
        writeln('No se encontro el celular.');
    close(arc);
end;

procedure sinStock(var arc: archivo);
var
    aux: celular;
    txt: Text;
begin
    assign(txt, 'SinStock.txt');
    rewrite(txt);
    reset(arc);
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        if (aux.disp = 0) then
            with aux do
            begin    
                writeln(txt, cod, ' ', precio, marca);
                writeln(txt, disp, ' ', min, desc);
                writeln(txt, nombre);
            end;
    end;
    close(arc);
    close(txt);
end;

var
    arc: archivo;
    nombre, opcion: String;
    txt: Text;
begin
    readln(nombre);
    assign(arc, nombre);
    assign(txt, 'celulares.txt');
    repeat
		writeln('===============================================================');
		writeln('               Ingrese la opcion correspondiente               ');
		writeln(' 1: Crear archivo    | 2: Stocks Bajos    | 3: Con descripcion ');
		writeln(' 4: Exportar TXT     | 5: Agregar Celular | 6: Modificar Stock ');
		writeln('                     | 7: Sin stock       |                    ');
		writeln('===============================================================');
		readln(opcion);
		case (opcion) of
			'1': crearArc(arc, txt);
			'2': stockBajo(arc);
            '3': impDesc(arc);
            '4': expTxt(arc, txt);
            '5': agregarCel(arc);
            '6': modStock(arc);
            '7': sinStock(arc);
			end;
	until opcion = 'fin';
    
end.