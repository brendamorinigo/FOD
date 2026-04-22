program ej8;
const valorAlto=99999;
type

regMae=record
    codP:integer;
    prov:String[12];
    hab:integer;
    kilos:real;
end;

regDet=record   
    codP:integer;
    kilos:real;
end;

detalle:file of regDet;
maestro: file of regMae;

var
vectorDet:array [1..16] of detalle;
vecAux: array[1..16] of regDet;

procedure leer(var arch:detalle; var info:regDet);
begin
    if(not EOF(arch)) then begin{
        read(arch,info);

    }else
        info.codP:=valorAlto;
end;

procedure buscarMinimo(var det:vectorDet; var aux:vecAux; var info:regDet);
var min,i,pos:integer;
begin
    min:=valorAlto;
    pos:=-1;
    for i:=1 to 16 do begin 
        if(aux[i].codP<min)then begin
            pos:=i;
            min:=aux[i].codP;
    end;
    
    if(min<>valorAlto)then begin    
        info:=aux[pos]; 
        leer(det[pos],aux[pos]);
    end
    else    
        info.codP:=valorAlto;
    end;    
end;






begin
    
end.