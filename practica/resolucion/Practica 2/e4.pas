program e4;
uses sysUtils;
const
    valorAlto = 9999;
type
    red = record
        cod_usuario: Integer;
        fecha: String;
        tiempo_total_de_sesiones_abiertas: real;
        end;
    
    terminal = record
        cod_usuario: Integer;
        fecha: String;
        tiempo_sesion: real;
        end;

    detalle = file of terminal;

    maestro = file of red;

    detalles = array[1..5] of detalle;

    terminales = array[1..5] of terminal;

procedure abrirDet(var vector: detalles);
var
    i: Integer;
    nombre: String;
begin
    for i:= 1 to 5 do
    begin
        nombre:= 'detalle';
        nombre:= nombre + intToStr(i);
        assign(vector[i], nombre);
        reset(vector[i]);
    end;
end;

procedure cerrarDet(var vector: detalles);
var 
    i: Integer;
begin
    for i:= 1 to 5 do
        close(vector[i]);
end;

procedure leerDet(var arc: detalle; var aux: terminal);
begin
    if EOF(arc) then    
        aux.cod_usuario:= valorAlto
    else
        read(arc, aux);
end;

procedure minCod(var vector: detalles; var min: terminal; var arregloT: terminales);
var
    i, minI: Integer;
begin
    minI:= valorAlto;
    min.cod_usuario:= valorAlto;
    for i:= 1 to 5 do
    begin
        if (arregloT[i].cod_usuario < min.cod_usuario) then
        begin
            minI:= i;
            min.cod_usuario:= arregloT[i].cod_usuario;
        end;
    end;
    if (minI <> valorAlto) then
        leerDet(vector[minI], arregloT[minI]);
end;

procedure mergeMaestro(var mae: maestro; var vector: detalles);
var
    min: terminal;
    arregloT: terminales;
    aux: red;
begin
    minCod(vector, min, arregloT);
    while(min.cod_usuario <> valorAlto) do
    begin
        aux.cod_usuario:= min.cod_usuario;
        while (aux.cod_usuario = min.cod_usuario) do
        begin
            aux.fecha:= min.fecha;
            aux.tiempo_total_de_sesiones_abiertas:= 0;
            while (aux.fecha = min.fecha) AND (aux.cod_usuario = min.cod_usuario) do
            begin
                aux.tiempo_total_de_sesiones_abiertas:= aux.tiempo_total_de_sesiones_abiertas + min.tiempo_sesion;
                minCod(vector, min, arregloT);
            end;
            write(mae, aux);
        end;
    end;
end;

begin
    
end.