unit vectores_autos;

interface
         uses crt, archivos_autos;
         const
              N=100;
         type
             r_ordenar_autos = record
                                   campo:string; //Campo por el cual se va a ordenar el vector
                                   pos_archivo:integer; //posicion real del registro dentro del archivo
                             end;
             v_autos=array[1..N] of r_ordenar_autos;
    procedure ordenar_marca_autos(var arch:t_autos; nom_arch:string; var vec:v_autos);
    procedure listado_autos(var arch:t_autos ; nom_arch:string; v:v_autos);
    procedure inicializar_vector_autos(var v:v_autos);

implementation
    procedure inicializar_vector_autos(var v:v_autos);
    var
       i:integer;
       reg:r_ordenar_autos;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure ordenar_marca_autos(var arch:t_autos; nom_arch:string; var vec:v_autos);
    var
       reg:r_auto;
       aux:r_ordenar_autos;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_auto(arch, nom_arch); //Abrir archivo indicado
         lim:=filesize(arch);                //Establecer tamaño del archivo
         close(arch);
         for i:=1 to lim do
             begin
                  leer_auto(arch, nom_arch, pos, reg); //lee el registro en la posicion especificada dentro del archivo
                  with vec[i] do
                       begin
                            campo:=reg.marca; //almacena el campo marca de cada registro
                            pos_archivo:=pos; //almacena la posicion real dentro del archivo
                       end;
                  inc(pos);
             end;

         for i:=1 to lim-1 do            //
             begin                      //Implementamos ordenamiento burbuja
                  for j:=1 to lim-i do //
                      begin
                           if vec[j].campo > vec[j+1].campo then // la condicion del ordenamiento es la almacenada en el atributo campo
                              begin
                                   aux:=vec[j];        //
                                   vec[j]:=vec[j+1];  //el ordenamiento se realiza sobre el vector precargado anteriormente
                                   vec[j+1]:=aux;    //
                              end;
                      end;
             end;
    end;

    procedure listado_autos(var arch:t_autos ; nom_arch:string; v:v_autos);
              var
                 i:integer;
                 reg:r_auto;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
              begin
                   w:=3;
                   ordenar_marca_autos(arch, nom_arch, v);
                   abrir_archivo_auto(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(22,1);
                   writeln ('Listado de autos ordenados por Marca');
                   Gotoxy (1,2);
                   writeln ('| Marca del auto |      Modelo      |     Patente     |        Tipo       |       Combustible    |');
                   Gotoxy (1,3);
                   Writeln ('__________________________________________________________________________________________________');
                   for i:=1 to lim do //Recorremos todo el archivo
                   begin
                        if (i mod 17)<>0 then
                           begin
                                with v[i] do //recoremos todo el vector ordenado previamente
                                     begin                                             //   
                                          leer_auto(arch, nom_arch, pos_archivo, reg); //leemos cada registro dentro del archivo en la posicion
                                     end;                                              //que tiene almacenado el vector
                                if (reg.estado_auto) then
                                   begin
                                        Inc (w);
                                        Gotoxy (2,w);
                                        writeln (reg.marca);
                                        Gotoxy (24,w);
                                        writeln (reg.modelo);
                                        Gotoxy (46,w);
                                        Writeln (reg.patente);
                                        Gotoxy (60,w);
                                        Writeln (reg.tipo);
                                        Gotoxy (79,w);
                                        writeln (reg.combustible);
                                        Inc (w);
                                        Gotoxy (1,w);
                                        Writeln ('________________________________________________________________________________________________');
                                   end;
                           end
                              else
                                  begin
                                       with v[i] do
                                            begin
                                                 leer_auto(arch, nom_arch, pos_archivo, reg);
                                            end;
                                       if (reg.estado_auto) then
                                          begin
                                               Inc (w);
                                               Gotoxy (2,w);
                                               writeln (reg.marca);
                                               Gotoxy (24,w);
                                               writeln (reg.modelo);
                                               Gotoxy (46,w);
                                               Writeln (reg.patente);
                                               Gotoxy (60,w);
                                               Writeln (reg.tipo);
                                               Gotoxy (79,w);
                                               writeln (reg.combustible);
                                               Inc (w);
                                               Gotoxy (1,w);
                                               Writeln ('________________________________________________________________________________________________');
                                          end;
                                       writeln('s: Siguiente; a: Volver al principio; ESC: salir');
                                    gotoxy(1,1);
                                    repeat
                                          control:=readkey;
                                          keypressed;
                                          case control of
                                               's':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                                ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                   end;
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='s') or (control='a') or (control=#27);
                               end;
                               if i=lim then
                                  begin
                                       writeln('a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='a') or (control=#27);
                                  end;
                   end;

              end;


begin
end.
