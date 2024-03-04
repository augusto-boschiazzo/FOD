program e6;
const valorAlto = 9999;
type
    prenda = record
        cod: Integer;
        desc: String;
        colores: String;
        tipo: String;
        stock: Integer;
        precio: real;
        end;

    archivo = file of prenda;

    obsoletas = file of Integer;

    procedure leer(var arc: archivo; var aux: prenda);
    begin
        if EOF(arc) then
            aux.cod:= valorAlto
        else 
            read(arc, aux);
    end;

    procedure eliminar(var arc: archivo; cod: Integer);
    var
        aux: prenda;
    begin
        Reset (arc);
        leer(arc, aux);
        while (aux.cod <> cod) do
            leer(arc, aux);
        Seek(arc, FilePos(arc) -1);
        aux.stock:= aux.stock * -1;
        write(arc, aux);
        Close(arc);
    end;

    procedure actualizar(var arc: archivo; var obs: obsoletas);
    var 
        cod: Integer;
    begin
        Reset(obs);
        read(obs, cod);
        while NOT(EOF(obs)) do
        begin
            read(obs, cod);
            eliminar(arc, cod);
        end;
        Close(obs);
    end;

    procedure compactar(var arc: archivo);
    var
        aux: prenda;
        nuevo: archivo;
    begin
        Reset(arc);
        rename(arc, 'master_old.dat');
        assign(nuevo, 'master.dat');
        Rewrite(nuevo);
        leer(arc, aux);
        while (aux.cod <> valorAlto) do
        begin
            if (aux.stock >= 0) then
                write(nuevo, aux);
            leer(arc, aux);
        end;
        Close(arc);
        Close(nuevo);
    end;

begin
end.