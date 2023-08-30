unit vectores_usuarios;

interface
         uses crt,archivos_usuarios;
         const
              N=100;
         type
             r_ordenar_usuarios = record
                                   campo:string;
                                   pos_archivo:integer;
                             end;
             v_usuarios=array[1..N] of r_ordenar_usuarios;
    procedure ordenar_nombre_usuario(var arch:t_usuarios; nom_arch:string; var vec:v_usuarios);
    procedure listado_usuario(var arch:t_usuarios ; nom_arch:string; v:v_usuarios);
    procedure inicializar_vector_usuario(var v:v_usuarios);

implementation
    procedure inicializar_vector_usuario(var v:v_usuarios);
    var
       i:integer;
       reg:r_ordenar_usuarios;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;

    procedure ordenar_nombre_usuario(var arch:t_usuarios; nom_arch:string; var vec:v_usuarios);
    var
       reg:registro_usuario;
       aux:r_ordenar_usuarios;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_usuario(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_usuario(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.nombre_usuario;
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

    procedure listado_usuario(var arch:t_usuarios ; nom_arch:string; v:v_usuarios);
              var
                 i:integer;
                 reg:registro_usuario;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
              begin
                   w:=3;
                   ordenar_nombre_usuario(arch, nom_arch, v);
                   abrir_archivo_usuario(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(21,1);
                   writeln('Listado ordenado de Usuarios por nombre');
                   Gotoxy (1,2);
                   writeln ('| Nombre del Usuario |     Direccion     |      Ciudad      |      Telefono      |      DNI     |');
                   Gotoxy (1,3);
                   Writeln ('_________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                        begin
                             with v[i] do
                                  begin
                                       leer_usuario(arch, nom_arch, pos_archivo, reg);
                                  end;
                                  if (reg.estado_usuario = true) then
                                     begin
                                          Inc (w);
                                          Gotoxy (2,w);
                                          writeln(reg.nombre_usuario);
                                          Gotoxy (23,w);
                                          writeln(reg.direccion_usuario);
                                          Gotoxy (43,w);
                                          writeln(reg.ciudad_usuario);
                                          Gotoxy (62,w);
                                          writeln(reg.tel_usuario);
                                          Gotoxy (83,w);
                                          writeln(reg.dni_usuario);
                                          Inc (w);
                                          Gotoxy (1,w);
                                          Writeln ('_____________________________________________________________________________________________');
                                     end;
                        end
                           else
                               begin
                                    with v[i] do
                                         begin
                                              leer_usuario(arch, nom_arch, pos_archivo, reg);
                                         end;
                                         if (reg.estado_usuario = true) then;
                                            begin
                                                 Inc (w);
                                                 Gotoxy (2,w);
                                                 writeln(reg.nombre_usuario);
                                                 Gotoxy (23,w);
                                                 writeln(reg.direccion_usuario);
                                                 Gotoxy (43,w);
                                                 writeln(reg.ciudad_usuario);
                                                 Gotoxy (62,w);
                                                 writeln(reg.tel_usuario);
                                                 Gotoxy (79,w);
                                                 writeln(reg.dni_usuario);
                                                 Inc (w);
                                                 Gotoxy (1,w);
                                                 Writeln ('_____________________________________________________________________________________________');
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
                                                                 writeln('                                                                                                               ');
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
                                                                 writeln('                                                                                                                ');
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
                    writeln('Presione ESC para salir.');
                    gotoxy(1,1);
              end;
begin
end.
