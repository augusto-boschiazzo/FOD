program ejer16;
const
    valorAlto = 9999;
    fechaAlta = '9999';
type
    maestro = record
        fecha: String;
        cod: Integer;
        nom: String;
        desc: String;
        precio: real;
        stock: Integer;
        vendido: Integer;
        end;

    detalle = record
        fecha: String;
        cod: Integer;
        vendido: Integer;
        end;

    mae = file of maestro;

    det = file of detalle;

    detalles = array[1..10] of det;

    registros = array[1..10] of detalle;

    procedure leer(var arc: det; var aux: detalle);
    begin
        if EOF(arc) then
        begin
            aux.fecha:= fechaAlta;
            aux.cod:= valorAlto;
        end
        else
            read(arc, aux);
    end;

    procedure Minimo(var details: detalles; var min: detalle; var lectura: registros);
    var
        i, minI: Integer;
    begin
        min.fecha:= fechaAlta;
        min.cod:= valorAlto;
        for i:= 1 to 10 do
        begin
            if (lectura[i].cod = valorAlto) then 
                leer(details[i], lectura[i]);
            if (lectura[i].fecha < min.fecha) then
            begin
                min.fecha:= lectura[i].fecha;
                min.cod:= lectura[i].cod;
                minI:= i;
            end
            else if (lectura[i].fecha = min.fecha) then
            begin
                if (lectura[i].cod < min.cod) then
                begin
                    min.cod:= lectura[i].cod;
                    minI:= i;
                end;
            end;
        end;
        lectura[minI].cod:= valorAlto;
    end;

    procedure inicLect(var lectura: registros);
    var
        i: Integer;
    begin
        for i:= 1 to 10 do
        begin
            lectura[i].fecha:= fechaAlta;
            lectura[i].cod:= valorAlto;
        end;
    end;

    procedure Actualizar(var arc: mae; var details: detalles);
    var
        master: maestro;
        min: detalle;
        lectura: registros;
    begin
        inicLect(lectura);
        while not(eof(arc)) do
        begin
            read(arc, master);
            Minimo(details, min, lectura);
            while (master.fecha = min.fecha) do
            begin
                while (master.cod = min.cod) do
                begin
                    if (master.stock - min.vendido > 0) then
                    begin
                        master.stock:= master.stock - min.vendido;
                        master.vendido:= master.vendido + min.vendido;
                    end;
                    Minimo(details, min, lectura);
                end;
            end;
            if (min.fecha <> fechaAlta) then
            begin
                seek(arc, filePos(arc) -1);
                write(arc, master);
            end
            else
                seek(arc, fileSize(arc));
        end;
    end;

begin
    
end.