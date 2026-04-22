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
    if(not EOF(arch)) then begin
        read(arch,info);

    else
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
    end;
    
    if(min<>valorAlto)then begin    
        info:=aux[pos]; 
        leer(det[pos],aux[pos]);
    end
    else    
        info.codP:=valorAlto;
    end;    
end;

procedure actualizarMaestro(var archDetalle:vectorDet; var archMaestro:maestro);
var i,codAct:integer; mae:regMae; det:regDet; aux:vecAux; kilosTot:real;
begin
    for i:=1 to 16 do begin 
        assign(archDetalle[i],'det'+i);
        reset(archDetalle[i]);
         leer(det[i],aux[i]);
    end;
    buscarMinimo(archDetalle,aux,det);
    reset(archMaestro);

    while(det.codP<>valorAlto) do begin   
        kilosTot:=0;
        codAct:=det.codP;
        while(det.codP<>nil)and (codAct=det.codP) do begin
            kilosTot:=det.kilos +kilosTot;
            buscarMinimo(archDetalle,aux,det);
        end;
        
        read(archMaestro,mae);
        while(not eof(archMaestro)) and (mae.codP<>codAct) do begin 
            read(archMaestro,mae);
        end;
        mae.kilos:=kilosTot;
        seek(archMaestro,filePos(archMaestro)-1);
        write(archMaestro,mae);
    end;
end;


var 
    detalles:vectorDet;
    maeArch:maestro;

begin
for i:=1 to 16 do begin 
   assign(detalles[i],i);
   
end; 
assign(maeArch,'/rutaDelMaestro.txt')
actualizarMaestro(detalles,maeArch);
end.