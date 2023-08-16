unit archivos_usuarios;

interface
         uses crt;

         type
             st10=string[10];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             registro_usuario=record
                     nombre_usuario:st20;
                     direccion_usuario:st30;
                     ciudad_usuario:st30;
                     dni_usuario:integer;
                     tel_usuario:st30;
                     estado_usuario:boolean;
                     end;
         t_usuarios = file of registro_usuario;

         procedure abrir_archivo_usuario(var arch:t_usuarios; nom_arch:string);
         procedure leer_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer; var dato_leido:registro_usuario);
         procedure guardar_usuario(var arch:t_usuarios ; nom_arch:string ; var escribir_dato:registro_usuario);
         procedure modificar_usuario(var arch:t_usuarios; nom_arch:string ;pos:integer);
         procedure busqueda_nombre_usuario(var arch:t_usuarios; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_dni_usuario(var arch:t_usuarios; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_usuario(var arch:t_usuarios; nom_arch:string; var reg:registro_usuario);
         procedure baja_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer);
         procedure alta_estado_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer);
         procedure eliminar_archivo_usuario(var arch:t_usuarios);


implementation
              procedure abrir_archivo_usuario(var arch:t_usuarios;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.
              end;
              
              procedure leer_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer; var dato_leido:registro_usuario); //Lee en el archivo lo que esta en la posicion de pos y lo guarda en dato_leido
              begin
                   abrir_archivo_usuario(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_usuario(var arch:t_usuarios; nom_arch:string ; var escribir_dato:registro_usuario); //Va hasta el final del archivo y guarda lo que hay en escribir_dato
              begin
                   abrir_archivo_usuario(arch, nom_arch);
                   seek(arch, filesize(arch));          //Filesize nos da el tamaño del archivo. Con seek posicionamos en lo que nos de Filesize porque siempre va a ser la ultima posicion
                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                   close(arch);
              end;

              procedure modificar_usuario(var arch:t_usuarios; nom_arch:string ;pos:integer);
              var
                 x,y,i:integer;           //x;y son para el recuadro
                 reg:registro_usuario;          //reg es un registro auxiliar que nos sirve para levantar los datos que queremos modificar desde el archivo
                 control:char;
              begin
                   clrscr;
                   leer_usuario(arch, nom_arch, pos, reg);
                   if reg.estado_usuario then
                   begin
                   clrscr;
                 textcolor (white);
                 x:=20;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=60;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=16;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=102;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=2;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   gotoxy(53,1);
                   writeln('Modificar Usuario');
                   gotoxy(21,4);
                   writeln('Nombre: ', reg.nombre_usuario);
                   gotoxy(21,5);
                   writeln('Direccion: ', reg.direccion_usuario);
                   gotoxy(21,6);
                   writeln('Ciudad: ', reg.ciudad_usuario);
                   gotoxy(21,7);
                   writeln('Telefono: ', reg.tel_usuario);
                   gotoxy(61,3);
                   writeln(#168,'Que dato desea modificar?');
                   gotoxy(61,4);
                   writeln('1: Nombre: ');
                   gotoxy(61,5);
                   writeln('2: Direccion: ');
                   gotoxy(61,6);
                   writeln('3: Ciudad: ');
                   gotoxy(61,7);
                   writeln('4: Telefono: ');
                   gotoxy(61,8);
                   writeln('ESC: Salir ');
                   repeat
                         gotoxy(21,9);
                         control:=readkey;
                         keypressed;
                         case control of
                              '1':begin
                                       gotoxy(72,4);
                                       writeln('                  ');
                                       gotoxy(72,4);
                                       readln(reg.nombre_usuario);
                                       gotoxy(29,4);
                                       writeln('                  ');
                                       gotoxy(29,4);
                                       writeln(reg.nombre_usuario);
                                       reg.estado_usuario:=true;
                                       abrir_archivo_usuario(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '2':begin
                                       gotoxy(75,5);
                                       writeln('                  ');
                                       gotoxy(75,5);
                                       readln(reg.direccion_usuario);
                                       gotoxy(32,5);
                                       writeln('                  ');
                                       gotoxy(32,5);
                                       writeln(reg.direccion_usuario);
                                       reg.estado_usuario:=true;
                                       abrir_archivo_usuario(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '3':begin
                                       gotoxy(72,6);
                                       writeln('                  ');
                                       gotoxy(72,6);
                                       readln(reg.ciudad_usuario);
                                       gotoxy(29,6);
                                       writeln('                  ');
                                       gotoxy(29,6);
                                       writeln(reg.ciudad_usuario);
                                       reg.estado_usuario:=true;
                                       abrir_archivo_usuario(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '4':begin
                                       gotoxy(69,7);
                                       writeln('                  ');
                                       gotoxy(70,7);
                                       readln(reg.tel_usuario);
                                       gotoxy(27,7);
                                       writeln('                  ');
                                       gotoxy(27,7);
                                       writeln(reg.tel_usuario);
                                       reg.estado_usuario:=true;
                                       abrir_archivo_usuario(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                          end;
                   until control=#27;
                   end
                      else
                          begin
                               writeln('El usuario esta dado de baja');
                               readkey;
                          end;
              end;

               procedure busqueda_nombre_usuario(var arch:t_usuarios; nom_arch:string; buscado:st20; var pos:integer);
               var
                  reg_aux:registro_usuario;
                  i:integer;
               begin
                    i:=0;
                    pos := -1;
                    abrir_archivo_usuario(arch, nom_arch);
                    while not eof(arch) do
                    begin
                         read(arch, reg_aux);
                         if reg_aux.nombre_usuario = buscado then
                            begin
                                 pos:=i;
                            end;
                         i:=i+1;
                         seek(arch, i);
                    end;
                    close(arch);
               end;

               procedure busqueda_dni_usuario(var arch:t_usuarios; nom_arch:string; buscado:integer; var pos:integer);
               var
                  reg_aux:registro_usuario;
                  i:integer;
               begin
                    i:=0;
                    pos := -1;
                    abrir_archivo_usuario(arch, nom_arch);
                    while not eof(arch) do
                    begin
                         read(arch, reg_aux);
                         if reg_aux.dni_usuario = buscado then
                            begin
                                 pos:=i;
                            end;
                         i:=i+1;
                         seek(arch, i);
                    end;
                    close(arch);
               end;

              procedure baja_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer);
              var
                 reg:registro_usuario;
              begin
                   leer_usuario(arch, nom_arch, pos, reg);
                   reg.estado_usuario:=false;
                   abrir_archivo_usuario(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_usuario(var arch:t_usuarios; nom_arch:string; var pos:integer);
              var
                 reg:registro_usuario;
              begin
                   leer_usuario(arch, nom_arch, pos, reg);
                   reg.estado_usuario:=true;
                   abrir_archivo_usuario(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_usuario(var arch:t_usuarios; nom_arch:string; var reg:registro_usuario);
              var
                 posi,x,y,i:integer;
                 control:char;
                 aux_nombre:string;
                 validacion:integer;
              begin
                   clrscr;
                 textcolor (white);
                 x:=44;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=15;
                 For i:=1 to 27 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=97;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=1;
                 For i:=1 to 26 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   posi:=-1;
                   gotoxy(63,2);
                   writeln('ALTA DE USUARIO');
                   gotoxy(45,4);
                   writeln('Nombre y apellido: ');
                   gotoxy(45,5);
                   writeln('DNI: ');
                   gotoxy(45,6);
                   writeln('Direccion: ');
                   gotoxy(45,7);
                   writeln('Ciudad: ');
                   gotoxy(45,8);
                   writeln('Pais: ');
                   gotoxy(64,4);
                   readln(aux_nombre);
                   busqueda_nombre_usuario(arch, nom_arch, aux_nombre, posi);
                   if posi = -1 then
                      begin
                           reg.nombre_usuario:=aux_nombre;
                           repeat
                                  gotoxy(50,5);
                                  writeln('                   ');
                                  gotoxy(50,5);
                                 {$I-}
                                      readln(reg.dni_usuario);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion=0 then
                                    begin
                                         busqueda_dni_usuario(arch, nom_arch, reg.dni_usuario, posi);
                                         if posi>-1  then
                                            begin
                                                 gotoxy(45,10);
                                                 textcolor (red);
                                                 writeln('El DNI del usuario ingresado ya existe, por favor ingrese uno nuevo.');
                                                 textcolor (white);
                                            end;
                                    end
                                       else
                                           begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('El tipo de dato es solo numeros');
                                                textcolor (white);
                                           end;
                           until (posi=-1) and (validacion=0);
                           gotoxy(45,10);
                           writeln('                                                 ');
                           gotoxy(56,6);
                           readln(reg.direccion_usuario);
                           gotoxy(53,7);
                           readln(reg.ciudad_usuario);
                           gotoxy(51,8);
                           readln(reg.tel_usuario);
                           reg.estado_usuario:=true;
                           guardar_usuario(arch, nom_arch, reg);
                           gotoxy(45,10);
                           textcolor (green);
                           writeln('Usuario creado con Exito!');
                           textcolor (white);
                           readkey;
                      end
                         else
                             begin
                                  leer_usuario(arch, nom_arch, posi, reg);
                                  if (reg.estado_usuario) then
                                     begin
                                          repeat
                                                gotoxy(45,10);
                                                writeln('Este Usuario ya se encuentra registrado', #168'Que desea hacer?');
                                                gotoxy(45,11);
                                                writeln('1: Modificar');
                                                gotoxy(45,12);
                                                writeln('2: Dar de baja');
                                                gotoxy(45,13);
                                                writeln('3: Cargar Nuevamente');
                                                gotoxy(45,14);
                                                writeln('ESC: Volver al menu');
                                                control:=readkey;
                                                keypressed;
                                                if (control = '1') then
                                                   modificar_usuario(arch, nom_arch, posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  gotoxy(45,10);
                                                                  writeln('                                                 ');
                                                                  gotoxy(45,11);
                                                                  writeln('                         ');
                                                                  gotoxy(45,12);
                                                                  writeln('                         ');
                                                                  gotoxy(45,13);
                                                                  writeln('                         ');
                                                                  gotoxy(45,14);
                                                                  writeln('                        ');
                                                                  baja_usuario (arch,nom_arch, posi);
                                                                  gotoxy(45,10);
                                                                  textcolor (green);
                                                                  writeln('El usuario se dio de baja correctamente!');
                                                                  textcolor (white);
                                                                  readkey;
                                                             end
                                                             else
                                                                 if (control='3') then
                                                                    begin
                                                                         gotoxy(45,10);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,11);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,12);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,13);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,14);
                                                                         writeln('                                                 ');
                                                                         repeat
                                                                               gotoxy(50,5);
                                                                               writeln('                                        ');
                                                                               gotoxy(50,5);
                                                                               {$I-}
                                                                                    readln(reg.dni_usuario);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion=0 then
                                                                                  begin
                                                                                       busqueda_dni_usuario(arch, nom_arch, reg.dni_usuario, posi);
                                                                                       if posi>-1  then
                                                                                          begin
                                                                                               gotoxy(45,10);
                                                                                               textcolor (red);
                                                                                               writeln('El DNI del usuario ingresado ya existe, por favor ingrese uno nuevo.');
                                                                                               textcolor (white);
                                                                                          end;
                                                                                  end
                                                                                     else
                                                                                         begin
                                                                                              gotoxy(45,10);
                                                                                              textcolor (red);
                                                                                              writeln('El tipo de dato es solo numeros');
                                                                                              textcolor (white);
                                                                                         end;
                                                                         until (posi=-1) and (validacion=0);
                                                                         gotoxy(45,10);
                                                                         writeln('                                                 ');
                                                                         gotoxy(56,6);
                                                                         readln(reg.direccion_usuario);
                                                                         gotoxy(53,7);
                                                                         readln(reg.ciudad_usuario);
                                                                         gotoxy(51,8);
                                                                         readln(reg.tel_usuario);
                                                                         reg.estado_usuario:=true;
                                                                         guardar_usuario(arch, nom_arch, reg);
                                                                         gotoxy(45,10);
                                                                         textcolor (green);
                                                                         writeln('Usuario creado con Exito!');
                                                                         textcolor (white);
                                                                         readkey;
                                                                    end
                                                                       else
                                                                           if (control=#27) then
                                                                              clrscr
                                                                                 else
                                                                                     begin
                                                                                          gotoxy(45,10);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,11);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,12);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,13);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,14);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,10);
                                                                                          textcolor(red);
                                                                                          writeln('La tecla ingresada es erronea');
                                                                                          textcolor(white);
                                                                                          readkey;
                                                                                     end;
                                          until (control = '1') or (control='2') or (control='3') or (control = #27);
                                     end
                                     else
                                     begin
                                         repeat
                                               gotoxy(45,11);
                                               writeln('1: Dar de alta');
                                               gotoxy(45,10);
                                               writeln('Este Usuario se encuentra registrado, pero esta dado de baja');
                                               gotoxy(45,12);
                                               writeln('ESC: Volver');
                                               control:=readkey;
                                               keypressed;
                                               if (control = '1') then
                                                  begin
                                                       gotoxy(45,11);
                                                       writeln('                                                 ');
                                                       gotoxy(45,10);
                                                       writeln('                                                    ');
                                                       gotoxy(45,12);
                                                       writeln('                                                 ');
                                                       alta_estado_usuario(arch, nom_arch, posi);
                                                       gotoxy(45,10);
                                                       textcolor(green);
                                                       writeln('Usuario creado con Exito!');
                                                       readkey;
                                                  end
                                                     else
                                                         if (control=#27) then
                                                            clrscr
                                                               else
                                                                   begin
                                                                        gotoxy(45,11);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,10);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,12);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,10);
                                                                        textcolor(red);
                                                                        writeln('La tecla ingresada es erronea...');
                                                                        textcolor(white);
                                                                        readkey;
                                                                   end;
                                         until (control = '1') or (control = #27);
                                     end;
                             end;
              end;

              procedure eliminar_archivo_usuario(var arch:t_usuarios);
              begin
                   erase(arch);
              end;
begin

end.
