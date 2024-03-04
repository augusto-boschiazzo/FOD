program e3;
const
    valorAlto = 9999;
type
    novela = record
        cod: Integer;
        genero: String;
        nombre: String;
        duracion: real;
        director: String;
        precio: real;
        end;

    archivo = file of novela;

    procedure crearArchivo(var arc: archivo);
    var
        n: novela;
    begin
        Rewrite(arc);
        n.cod:= 0;
        write(arc, n);
        write('Escriba el codigo: '); readln(n.cod);
        while (n.cod <> -1) do
        begin
            with n do
            begin
                write('Escriba el genero: '); readln(genero);
                write('Escriba el nombre: '); readln(nombre);
                write('Escriba la duracion: '); readln(duracion);
                write('Escriba el director: '); readln(director);
                write('Escriba el precio: '); readln(precio);
            end;
            write(arc, n);
            write('Escriba el codigo: '); readln(n.cod);
        end;
        Close(arc);
    end;

    procedure leer(var arc: archivo; var aux: novela);
    begin
        if EOF(arc) then
            aux.cod:= valorAlto
        else
            read(arc, aux);
    end;

    procedure agregarNov(var arc: archivo);
    var
        aux, nov: novela;
        cod: Integer;
    begin
        Reset(arc);
        leer(arc, aux);
        cod:= aux.cod;
        with aux do
        begin
            write('Escriba el codigo: '); readln(cod);
            write('Escriba el genero: '); readln(genero);
            write('Escriba el nombre: '); readln(nombre);
            write('Escriba la duracion: '); readln(duracion);
            write('Escriba el director: '); readln(director);
            write('Escriba el precio: '); readln(precio);
        end;
        if (cod = 0) then
        begin
            Seek(arc, FileSize(arc));
            write(arc, aux);
        end
        else
        begin
            Seek(arc, (cod * (-1)));
            read(arc, nov);
            Seek(arc, 0);
            write(arc, nov);
            Seek(arc, (cod * (-1)));
            write(arc, aux);
        end;
        Close(arc);
    end;

    procedure modNov(var arc: archivo);
    var
        aux, modif: novela;
    begin
        Reset(arc);
        with modif do
        begin
            write('Escriba el nombre: '); readln(nombre);
            write('Escriba el genero: '); readln(genero);
            write('Escriba la duracion: '); readln(duracion);
            write('Escriba el director: '); readln(director);
            write('Escriba el precio: '); readln(precio);
        end;
        leer(arc, aux);
        while (modif.nombre <> aux.nombre) AND (aux.cod <> valorAlto) do
        begin
            leer(arc, aux);
        end;
        if (modif.nombre = aux.nombre) then
        begin
            modif.cod:= aux.cod;
            Seek(arc, FilePos(arc) -1);
            write(arc, modif);
            writeln('Se modifico la novela de codigo ', aux.cod, '.');
        end
        else
            writeln('No se encontro.');
        Close(arc);
    end;

    procedure elimNov(var arc: archivo);
    var
        aux, nov: novela;
        nombre: String;
        terminado: boolean;
    begin
        Reset(arc);
        terminado:= false;
        write('Ingrese el nombre de la novela a eliminar: ');
        readln(nombre);
        leer(arc, aux);
        leer(arc, nov);
        while (nov.cod <> valorAlto) AND NOT(terminado) do
        begin
            if (nov.nombre = nombre) then
            begin    
                terminado:= true;
                nov.cod:= aux.cod;
                Seek(arc, FilePos(arc) -1);
                aux.cod:= (FilePos(arc)) * -1;
                write(arc, nov);
                Seek(arc, 0);
                write(arc, aux);
            end
            else
                leer(arc, nov);
        end;
        if terminado then
            writeln('Se elimino con exito.')
        else
            writeln('No se encontro la novela. No se elimino.');
        Close(arc);
    end;

    procedure abrirArchivo(var arc: archivo);
    var
        opcion: String;
    begin
        repeat
            writeln('|===============================================================|');
            writeln('|               Ingrese la opcion correspondiente               |');
            writeln('| 1: Agregar novela   | 2: Modificar datos | 3: Eliminar novela |');
            writeln('|===============================================================|');
            readln(opcion);
            case (opcion) of
                '1': agregarNov(arc);
                '2': modNov(arc);
                '3': elimNov(arc);
                end;
        until opcion = 'fin';
    end;

    procedure listarArchivo(var arc: archivo);
    var
        aux: novela;
        txt: Text;
    begin
        Reset(arc);
        assign(txt, 'novelas.txt');
        Rewrite(txt);
        while NOT(EOF(arc)) do
        begin
            read(arc, aux);
            with aux do
                writeln(txt, 'Codigo: ', cod, ' Nombre: ', nombre, ' Genero: ', genero, ' Duracion: ', duracion, ' Director: ', director, ' Precio: ', precio);
        end;
        Close(arc);
        Close(txt);
    end;



var
    opcion: String;
    arc: archivo;
begin
    assign(arc, 'novelas.dat');
    repeat
        writeln('|===============================================================|');
        writeln('|               Ingrese la opcion correspondiente               |');
        writeln('| a: Crear archivo    | b: Abrir archivo   | c: Listar novelas  |');
        writeln('|===============================================================|');
        readln(opcion);
        case (opcion) of
            'a': crearArchivo(arc);
            'b': abrirArchivo(arc);
            'c': listarArchivo(arc);
            end;
    until opcion = 'fin';
end.