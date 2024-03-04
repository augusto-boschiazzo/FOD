program e4;
const
    valorAlto = 9999;
type
    flor = record
        nombre: String[45];
        cod: Integer;
        end;
    
    archivo = file of flor;

    procedure leer(var arc: archivo; var aux: flor);
    begin
        if EOF(arc) then
            aux.cod:= valorAlto
        else
            read(arc, aux);
    end;

    procedure agregarFlor(var arc: archivo; aux: flor);
    var
        cod: Integer;
        f: flor;
    begin
        Reset(arc);
        leer(arc, aux);
        cod:= aux.cod;
        if (cod = 0) then
        begin
            Seek(arc, FileSize(arc));
            write(arc, aux);
        end
        else
        begin
            Seek(arc, (cod * (-1)));
            read(arc, f);
            Seek(arc, 0);
            write(arc, f);
            Seek(arc, (cod * (-1)));
            write(arc, aux);
        end;
        Close(arc);
    end;

    procedure listarArchivo(var arc: archivo);
    var
        aux: flor;
    begin
        Reset(arc);
        while NOT(EOF(arc)) do
        begin
            read(arc, aux);
            if (aux.cod < 1) then
                with aux do
                    writeln('Codigo: ', cod, ' Nombre: ', nombre);
        end;
        Close(arc);
    end;

    procedure elimFlor(var arc: archivo);
    var
        aux, f: flor;
        nombre: String;
        terminado: boolean;
    begin
        Reset(arc);
        terminado:= false;
        write('Ingrese el nombre de la flor a eliminar: ');
        readln(nombre);
        leer(arc, aux);
        leer(arc, f);
        while (f.cod <> valorAlto) AND NOT(terminado) do
        begin
            if (f.nombre = nombre) then
            begin    
                terminado:= true;
                f.cod:= aux.cod;
                Seek(arc, FilePos(arc) -1);
                aux.cod:= (FilePos(arc)) * -1;
                write(arc, f);
                Seek(arc, 0);
                write(arc, aux);
            end
            else
                leer(arc, f);
        end;
        if terminado then
            writeln('Se elimino con exito.')
        else
            writeln('No se encontro la flor. No se elimino.');
        Close(arc);
    end;

begin
end.