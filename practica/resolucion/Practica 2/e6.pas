program e6;
uses sysUtils;
const
    valorAlto = 9999;
type
    localidad = record
        cod: Integer;
        cepa: Integer;
        activos: Integer;
        nuevos: Integer;
        recuperados: Integer;
        fallecidos: Integer;
        end;

    provincia = record
        loc: localidad;
        nombre: String;
        end;

    detalle = file of localidad;

    maestro = file of provincia;

    detalles = array[1..10] of detalle;

    localidades = array[1..10] of localidad;

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

    procedure leerDet(var arc: detalle; var aux: localidad);
    begin
        if EOF(arc) then    
            aux.cod:= valorAlto
        else
            read(arc, aux);
    end;

    procedure minimo(var vector: detalles; var min: localidad; var minI: Integer; var arreglo: localidades);
    var
        i: Integer;
    begin
        minI:= valorAlto;
        min.cod:= valorAlto;
        for i:= 1 to 10 do
        begin
            if (arreglo[i].cod < min.cod) then
            begin
                minI:= i;
                min.cod:= arreglo[i].cod;
            end;
        end;
        if (minI <> valorAlto) then
            leerDet(vector[minI], arreglo[minI]);
    end;

    procedure mergeMaestro(var mae: maestro; var vector: detalles);
    var
        min: localidad;
        arreglo: localidades;
        aux: provincia;
        minI: Integer;
    begin
        minimo(vector, min, minI, arreglo);
        while(min.cod <> valorAlto) do
        begin
            read(mae, aux);
            while (aux.loc.cod <> min.cod) do
                read(mae, aux);
            aux.loc.fallecidos:= aux.loc.fallecidos + min.fallecidos;
            aux.loc.recuperados:= aux.loc.recuperados + min.recuperados;
            aux.loc.nuevos:= min.nuevos;
            aux.loc.activos:= min.activos;
            leerDet(vector[minI], arreglo[minI]);
            if (min.cod = valorAlto) then
                minimo(vector, min, minI, detalles);
            write(mae, aux);
        end;
    end;

begin
    
end.