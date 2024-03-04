program e2;
const
    valorAlto = 9999;
type
    alumno = record
        cod: Integer;
        nombre: String;
        sinFin: Integer;
        conFin: Integer;
        end;

    detalle = record
        cod: Integer;
        materia: boolean;
        end;
    
    master = file of alumno;

    detail = file of detalle;

procedure leerDet(var det: detail; var aux: detalle);
begin
    if (EOF(det)) then
        aux.cod:= valorAlto
    else
        read(det, aux);
end;

procedure actMaes(var mae: master; var det: detail);
var
    auxD: detalle;
    auxM: alumno;
begin
    reset(mae);
    reset(det);
    read(mae, auxM);
    leerDet(det, auxD);
    while (auxM.cod <> valorAlto) do
    begin
        while (auxM.cod <> auxD.cod) do
            read(mae, auxM);
        while (auxD.cod = auxM.cod) AND (auxD.cod <> valorAlto) do
        begin
            if (auxD.materia) then
                auxM.conFin:= auxM.conFin + 1
            else
                auxM.sinFin:= auxM.sinFin + 1;
            leerDet(det, auxD);
        end;
        seek(mae, filepos(mae) -1);
        write(mae, auxM);
        read(mae, auxM);
    end;
    close(mae);
    close(det);
end;

procedure listarAlu(var arc: master);
var 
    aux: alumno;
    txt: Text;
begin
    reset(arc);
    assign(txt, 'alumnos4materias.txt');
    rewrite(txt);
    while NOT(EOF(arc)) do
    begin
        read(arc, aux);
        if (aux.sinFin > 4) then
            with aux do
                write(txt, cod, ' ', sinFin, ' ', conFin, ' ', nombre);
    end;
    close(arc);
    close(txt);
end;

begin
end.