program e3;
uses sysutils;
const
    valorAlto = 9999;
type
    producto = record
        cod: Integer;
        nombre: String;
        desc: String;
        disp: Integer;
        min: Integer;
        precio: real;
        end;

    venta = record
        cod: Integer;
        cant: Integer;
        end;
    
    maestro = file of producto;

    detalle = file of venta;

    sucursales = array[1..30] of detalle;

procedure leerMae(var mae: maestro; var aux: producto);
begin
    if (EOF(mae)) then
        aux.cod:= valorAlto
    else
        read(mae, aux);
end;

procedure abrirDet(var vector: sucursales);
var
    i: Integer;
    nombre: String;
begin
    for i:= 1 to 30 do
    begin
        nombre:= 'detalle';
        nombre:= nombre + intToStr(i);
        assign(vector[i], nombre);
        reset(vector[i]);
    end;
end;

procedure cerrarDet(var vector: sucursales);
var 
    i: Integer;
begin
    for i:= 1 to 30 do
        close(vector[i]);
end;

procedure actMaestro(var mae: maestro; var vector: sucursales);
var 
    i, minI, minCod: Integer;
    auxM: producto;
    auxD: venta;
begin
    reset(mae);
    abrirDet(vector);
    leerMae(mae, auxM);
    while (auxM.cod <> valorAlto) do
    begin
        minI:= 999;
        minCod:= 999;
        for i:= 1 to 30 do
        begin
            read(vector[i], auxD);
            seek(vector[i], filepos(vector[i]) -1);
            if (auxD.cod < minCod) then
            begin
                minI:= i;
                minCod:= auxD.cod;
            end;
        end;
        read(vector[minI], auxD);
        while (auxM.cod <> auxD.cod) AND (auxM.cod <> valorAlto) do
            leerMae(mae, auxM);
        while (auxD.cod = auxM.cod) do
        begin
            auxM.disp:= auxM.disp - auxD.cant;
            read(vector[minI], auxD);
        end;
        if (auxM.cod <> valorAlto) then
        begin
            seek(mae, filepos(mae) -1);
            write(mae, auxM);
        end;
        leerMae(mae, auxM);    
    end;
    close(mae);
    cerrarDet(vector);
end;

begin
end.