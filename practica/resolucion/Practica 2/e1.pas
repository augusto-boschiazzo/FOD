program e1;
const
    valorAlto = 9999;
type
    empleado = record
        cod: Integer;
        nombre: String;
        monto: real;
        end;
    
    archivo = file of empleado;

procedure leerArc(var arc: archivo; var aux: empleado);
begin
    if (EOF(arc)) then
        aux.cod:= valorAlto
    else
        read(arc, aux);
end;

procedure compactarArc(var arc: archivo);
var
    aux, act: empleado;
    total: real;
    res: archivo;
begin
    assign(res, 'todoCompacto');
    rewrite(res);
    reset(arc);
    leerArc(arc, aux);
    while (aux.cod <> valorAlto) do
    begin
        total:= 0;
        act:= aux;
        while (aux.cod = act.cod) AND (aux.cod <> valorAlto) do
        begin
            total:= total + aux.monto;
            leerArc(arc, aux);
        end;
        act.monto:= total;
        write(res, act);
    end;
    close(arc);
end;

procedure crearArc(var arc: archivo);
var
    aux: empleado;
    i: Integer;
begin
    rewrite(arc);
    for i:= 1 to 3 do
    begin
        with aux do
        begin
            cod:= 1;
            nombre:= 'Augus';
            monto:= 100.0;
        end;
        write(arc, aux);
    end;
    for i:= 1 to 2 do
    begin
        with aux do
        begin
            cod:= 3;
            nombre:= 'Bauti';
            monto:= 100.0;
        end;
        write(arc, aux);
    end;
end;

var
    arc: archivo;
begin
    assign(arc, 'arcEmp');
    compactarArc(arc);
end.