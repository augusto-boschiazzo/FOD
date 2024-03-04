program ej2; //ES EL EJERCICIO 2 TARADOOO
const
    valor = 9999;
type
    asistente = record
        nro: Integer;
        dni: String;
        nombre: String;
        email: String;
        telefono: String;
        end;
    
    arc_asis = File of asistente;

procedure bajaLogica(var arc: arc_asis);
var
    aux: asistente;
begin
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        if(aux.nro < 1000) then
        begin
            aux.nombre:= '@' + aux.nombre;
            Seek(arc, filepos(arc) -1);
            write(arc, aux);
        end;
    end;
end;


var
    arc: arc_asis;
BEGIN
    assign(arc, 'asistentes.bin');
    Reset(arc);
    bajaLogica(arc);
    Close(arc);
END.