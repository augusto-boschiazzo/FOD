program e10;
const
    valorAlto = '9999';
type
    n15 = 1..15;

    empleado = record
        departamento: String;
        division: Integer;
        cod: Integer;
        cat: n15;
        horas: Integer;
        end;

    categoria = record
        num: Integer;
        valor: real;
        end;

    archivo = file of empleado;

    categorias = array[1..15] of real;

    procedure leerCat(var arc: Text; var v: categorias);
    var
        aux: categoria;
    begin
        while NOT(EOF(arc)) do
        begin
            readln(arc, aux.num, aux.valor);
            v[aux.num]:= aux.valor;
        end;
    end;

    procedure impEmp(e: empleado; v: categorias);
    begin
        writeln('Numero de empleado Total de Hs. Importe a cobrar');
        with e do
            writeln('       ', cod, '               ', horas, '              ', v[cat] * horas);
    end;

    procedure leerEmp(var arc: archivo; var aux: empleado);
    begin
        if EOF(arc) then
            aux.departamento:= valorAlto
        else
            read(arc, aux);
    end;

    procedure impEmpleados(var emp: archivo);
    var
        v: categorias;
        categ: Text;
        e, act: empleado;
        horasDiv, horasDep: Integer;
        totDiv, totDep: real;
    begin
        assign(categ, 'categorias.dat');
        reset(categ);
        reset(emp);
        leerCat(categ, v);
        leerEmp(emp, e);
        while (e.departamento <> valorAlto) do
        begin
            horasDep:= 0;
            totDep:= 0;
            act:= e;
            writeln('Departamento ', e.departamento);
            while (e.departamento = act.departamento) do
            begin
                horasDiv:= 0;
                totDiv:= 0;
                writeln('Division ', e.division);
                while (e.division = act.division) AND (e.departamento <> valorAlto) do
                begin
                    horasDiv:= horasDiv + e.horas;
                    totDiv:= totDiv + (e.horas * v[e.cat]);
                    impEmp(e, v);
                    leerEmp(emp, e);
                end;
                horasDep:= horasDep + horasDiv;
                totDep:= totDep + totDiv;
                writeln('   Total de horas division: ', horasDiv);
                writeln('   Monto total por division: ', totDiv);
            end;
            writeln('   Total de horas departamento: ', horasDep);
            writeln('   Monto total departamento: ', totDep);
        end;        
    end;


begin
end.

