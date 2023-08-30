unit vectores_turnos;

interface
         uses crt,archivos_turnos;
         const
              N=10;

         type
             r_ordenar_turnos = record
                                   campo:integer;
                                   pos_archivo:integer;
                             end;
             v_turnos=array[1..N] of r_ordenar_turnos;
    procedure ordenar_codigo_turno(var arch:t_turnos; nom_arch:string; var vec:v_turnos);
    procedure listado_turnos(var arch:t_turnos ; nom_arch:string; v:v_turnos);
    procedure inicializar_vector_turno(var v:v_turnos);

implementation
    procedure inicializar_vector_turno(var v:v_turnos);
    var
       i:integer;
       reg:r_ordenar_turnos;
    begin
         reg.campo:=0;
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure ordenar_codigo_turno(var arch:t_turnos; nom_arch:string; var vec:v_turnos);
    var
       reg:r_turno;
       aux:r_ordenar_turnos;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_turno(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_turno(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.codigo_turno;
                            pos_archivo:=pos;
                       end;
                  inc(pos);
             end;

         for i:=1 to lim-1 do
             begin
                  for j:=1 to lim-i do
                      begin
                           if vec[j].campo > vec[j+1].campo then
                              begin
                                   aux:=vec[j];
                                   vec[j]:=vec[j+1];
                                   vec[j+1]:=aux;
                              end;
                      end;
             end;
    end;

    procedure listado_turnos(var arch:t_turnos ; nom_arch:string; v:v_turnos);
              var
                 i:integer;
                 reg:r_turno;
                 lim,w:integer;
                 control:char;
                 y,j,x:integer;
              begin
                   w:=3; //w: variable para controlar la escritura del listado con gotoxy (valor de la y)
                   ordenar_codigo_turno(arch, nom_arch, v);
                   abrir_archivo_turno(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(54,1);
                   writeln('Listado de Turnos');
                   Gotoxy (1,2);
                   writeln ('|        Fecha        |  DNI usuario  |   Patente auto   |  Motivo Servicio |    Codigo Turno   |');
                   Gotoxy (1,3);
                   Writeln ('_________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<> 0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_turno(arch, nom_arch, pos_archivo, reg);
                                     end;
                                     if reg.estado_turno then
                                        begin
                                             Inc (w);
                                             Gotoxy (2,w);
                                             writeln(reg.dia_hora);
                                             Gotoxy (24,w);
                                             writeln(reg.dni_usuario);
                                             Gotoxy (46,w);
                                             writeln(reg.patente);
                                             Gotoxy (60,w);
                                             Writeln (reg.motivo);
                                             Gotoxy (79,w);
                                             Writeln (reg.codigo_turno);
                                             Inc (w);
                                             Gotoxy (1,w);
                                             Writeln ('_________________________________________________________________________________________________');
                                        end;
                           end
                              else
                                  begin
                                       with v[i] do
                                       begin
                                          leer_turno(arch, nom_arch, pos_archivo, reg);
                                       end;
                                       if reg.estado_turno then
                                          begin
                                                  Inc (w);
                                                  Gotoxy (2,w);
                                                  writeln(reg.dia_hora);
                                                  Gotoxy (24,w);
                                                  writeln(reg.dni_usuario);
                                                  Gotoxy (46,w);
                                                  writeln(reg.patente);
                                                  Gotoxy (60,w);
                                                  Writeln (reg.motivo);
                                                  Gotoxy (79,w);
                                                  Writeln (reg.codigo_turno);
                                                  Inc (w);
                                                  Gotoxy (1,w);
                                                  Writeln ('_________________________________________________________________________________________________');
                                          end;
                                       writeln('s: Siguiente; a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       x:=wherex();
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                                  's':begin
                                                           y:=4; //y: variable utilizada para controlar el borrado de los datos en pantalla con gotoxy (valor de la y)
                                                           for j:=1 to 18 do
                                                               begin
                                                                    Gotoxy (1,y);
                                                                    writeln('                                                                                                                                                                       ');
                                                                    writeln('                                                                                                                                                                       ');
                                                                    y:=y+2;
                                                               end;
                                                           w:=3;
                                                      end;
                                                  'a':begin
                                                           y:=4;
                                                           for j:=1 to 18 do
                                                               begin
                                                                    Gotoxy (1,y);
                                                                    writeln('                                                                                                                                                                       ');
                                                                    writeln('                                                                                                                                                                       ');
                                                                    y:=y+2;
                                                               end;
                                                           w:=3;
                                                           //i:=0; esto lo cambie 10/8/23 revisar
                                                         end;
                                                  #27:begin
                                                           exit;
                                                      end;
                                                  #75:begin   //#37: Flecha hacia la izquierda

                                                           if x>5 then
                                                              begin
                                                                   x:=x-5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if x>1 then
                                                                        begin
                                                                             x:=x-1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                                  #77:begin   //#39: Flecha hacia la derecha
                                                           if (x>5) and (x<170) then
                                                              begin
                                                                   x:=x+5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if (x>0) and (x<170)  then
                                                                        begin
                                                                             x:=x+1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                             end;
                                    until (control='s') or (control='a') or (control=#27);
                               end;
                               if i=lim then
                                  begin
                                       writeln('a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       x:=wherex();
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                                                                                       ');
                                                                 writeln('                                                                                                                                                                       ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        //i:=0; esto lo cambie el 10/8/23 revisar
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               #75:begin   //#37: Flecha hacia la izquierda

                                                           if x>5 then
                                                              begin
                                                                   x:=x-5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if x>1 then
                                                                        begin
                                                                             x:=x-1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                                  #77:begin   //#39: Flecha hacia la derecha
                                                           if (x>5) and (x<170) then
                                                              begin
                                                                   x:=x+5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if (x>0) and (x<170)  then
                                                                        begin
                                                                             x:=x+1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                               end;
                                    until (control='a') or (control=#27);
                                  end;
                   end;
                   
              end;


begin
end.
