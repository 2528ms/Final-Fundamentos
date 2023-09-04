unit archivos_turnos;

interface
         uses crt, archivos_usuarios, archivos_autos;

         type
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_turno=record
                     dia_hora:st20;
                     codigo_turno:integer;
                     dni_usuario:longint;
                     motivo:st20;
                     patente:st20;
                     estado_turno:boolean;
                     end;
         t_turnos = file of r_turno;

         procedure abrir_archivo_turno(var arch:t_turnos; nom_arch:string);
         procedure leer_turno(var arch:t_turnos; nom_arch:string; var pos:integer; var dato_leido:r_turno);
         procedure guardar_turno(var arch:t_turnos ; nom_arch:string ; var escribir_dato:r_turno);
         procedure modificar_turno(var arch:t_turnos; var arch_u:t_usuarios ; var arch_a:t_autos ;nom_arch:string; nom_arch_u:string; nom_arch_a:string ;pos:integer);
         procedure busqueda_turno(var arch:t_turnos; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_turno(var arch:t_turnos; var arch_u:t_usuarios; var arch_a:t_autos; nom_arch_a:string ;nom_arch_u:string; nom_arch:string; var reg:r_turno);
         procedure baja_turno(var arch:t_turnos; nom_arch:string; var pos:integer);
         procedure alta_estado_turno(var arch:t_turnos; nom_arch:string; var pos:integer);
         procedure busqueda_patente(var arch:t_autos; nom_arch_a:string; buscado:st20; var pos:integer);
         procedure eliminar_archivo_turno(var arch:t_turnos);

implementation
              procedure abrir_archivo_turno(var arch:t_turnos;  nom_arch:string); //Abre archivo con motivo de escritura o lectura
              begin
                   assign(arch, nom_arch);         //Enlaza el archivo logico con el archivo fisico
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);               // Abrimos el archivo para lectura y/o escritura
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el archivo o hay un problema. Crea el archivo
                   //close(arch);
              end;
              procedure leer_turno(var arch:t_turnos; nom_arch:string; var pos:integer; var dato_leido:r_turno); //lee registro en archivo
              begin
                   abrir_archivo_turno(arch, nom_arch); 
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //lee los datos donde se posiciono el puntuero y los retorna en la segunda variable
                   close(arch);
              end;

              procedure guardar_turno(var arch:t_turnos ; nom_arch:string ; var escribir_dato:r_turno); //Escribe registro en archivo 
              var
                 reg_control:r_turno;
                 pos:integer;
              begin
                   pos:=0;
                   leer_turno(arch,nom_arch, pos, reg_control);
                   abrir_archivo_turno(arch, nom_arch);
                   seek(arch, filesize(arch));
                   if filepos(arch)=1 then //instruccion filepos devuelve la posicion actual del puntero
                      begin
                           if reg_control.codigo_turno=0 then         //
                              begin                                 // Debido a la inicializacion la posicion 0 ya esta ocupada
                                   seek(arch, 0);                   // Cuando filepos(Que indica la posicion el puntero en el archivo) sea 1
                                   write(arch, escribir_dato);      // los datos que hay que guardar hay que guardarlas en la posicion 0
                              end                                   //
                                 else
                                     begin
                                          seek(arch, filesize(arch));
                                          write(arch, escribir_dato);
                                     end;
                      end
                         else
                             begin
                                   seek(arch, filesize(arch));         //filesize devuelve la cantidad de registros que tiene el archivo, posicionamos el puntero al final del archivo
                                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                             end;         
                   close(arch);
              end;

              procedure modificar_turno(var arch:t_turnos; var arch_u:t_usuarios ; var arch_a:t_autos ;nom_arch:string; nom_arch_u:string; nom_arch_a:string ;pos:integer);
              var
                 reg:r_turno;
                 control:char;
                 validacion,x,y,i:integer;
                 posi:integer;
                 reg_u:registro_usuario;
                 reg_a:r_auto;
              begin
                   clrscr;
                   leer_turno(arch, nom_arch, pos, reg);
                   if reg.estado_turno then
                   begin
                   clrscr;
                 textcolor (blue);
                 x:=20;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=60;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=15;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=102;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=1;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   gotoxy(21,4);
                   writeln('Fecha del turno: ', reg.dia_hora);
                   gotoxy(21,5);
                   writeln('DNI del usuario: ', reg.dni_usuario);
                   gotoxy(21,6);
                   writeln('motivo: ', reg.motivo);
                   gotoxy(21,7);
                   writeln('Patente auto: ', reg.patente);
                   gotoxy(61,2);
                   writeln('Elegir la opcion para modificar ');
                   gotoxy(61,3);
                   writeln();
                   gotoxy(61,4);
                   writeln('1: Fecha del turno: ');
                   gotoxy(61,5);
                   writeln('2: DNI del Usuario: ');
                   gotoxy(61,6);
                   writeln('3: motivo: ');
                   gotoxy(61,7);
                   writeln('4: Patente auto: ');
                   gotoxy(61,13);
                   writeln('ESC: Salir');
                   repeat
                         gotoxy(21,16);
                         writeln('                                                                                   ');
                         gotoxy(21,13);
                         control:=readkey;
                         keypressed;
                         case control of
                         '1':begin
                                  gotoxy(81,4);
                                   writeln('                   ');
                                   gotoxy(81,4);
                                  readln(reg.dia_hora);
                                  gotoxy(38,4);
                                  writeln('                ');
                                  gotoxy(40,4);
                                  writeln(reg.dia_hora);
                                  abrir_archivo_turno(arch, nom_arch);
                                  seek(arch, pos);
                                  write(arch, reg);
                                  close(arch);
                             end;
                         '2':begin
                                  gotoxy(81,5);
                                  writeln('                  ');
                                  gotoxy(81,5);
                                  {$I-}
                                       readln(reg.dni_usuario);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          busqueda_dni_usuario(arch_u, nom_arch_u, reg.dni_usuario, posi);
                                          if posi>-1 then
                                             begin
                                                  leer_usuario(arch_u, nom_arch_u, posi, reg_u);
                                                  if reg_u.estado_usuario then
                                                     begin
                                                          gotoxy(38,5);
                                                          writeln('                     ');
                                                          gotoxy(40,5);
                                                          writeln(reg.dni_usuario);
                                                          abrir_archivo_turno(arch, nom_arch);
                                                          seek(arch, pos);
                                                          write(arch, reg);
                                                          close(arch);
                                                     end
                                                        else
                                                            begin
                                                                 gotoxy(21,16);
                                                                 writeln('                                                                   ');
                                                                 gotoxy(21,16);
                                                                 Textcolor(red);
                                                                 writeln('El usuario esta dado de baja. Debe darlo de alta primero');
                                                                 Textcolor(white);
                                                                 readkey;
                                                            end;
                                             end
                                                else
                                                    begin
                                                         gotoxy(21,16);
                                                         writeln('                                                                   ');
                                                         textcolor(red);
                                                         gotoxy(21,16);
                                                         writeln('El usuario no esta registrado. Debe registrar el usuario primero');
                                                         textcolor(white);
                                                         readkey;
                                                    end;
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                                                   ');
                                                 textcolor(red);
                                                 gotoxy(21,16);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         '3':begin
                                  gotoxy(72,8);
                                  writeln('                    ');
                                  textcolor(yellow);
                                  gotoxy(21,16);
                                  writeln('Presione "s":Service ; "m":Motor; "f":Frenos');
                                  textcolor(white);
                                  gotoxy(81,6);
                                  writeln('                       ');
                                  gotoxy(81,6);
                                  reg.motivo:=readkey;
                                  keypressed;
                                  if (reg.motivo='s') or (reg.motivo='m') or (reg.motivo='f') then
                                     begin
                                          if reg.motivo='s' then
                                             begin
                                                  reg.motivo:='Service';
                                                  gotoxy(81,6);
                                                  writeln(reg.motivo);
                                                  gotoxy(21,11);
                                                  writeln('                       ');
                                                  gotoxy(21,12);
                                                  writeln('                       ');
                                                  gotoxy(61,11);
                                                  writeln('                      ');
                                                  gotoxy(61,12);
                                                  writeln('                      ');
                                                  abrir_archivo_turno(arch, nom_arch);
                                                  seek(arch, pos);
                                                  write(arch, reg);
                                                  close(arch);
                                             end
                                             else
                                                 if reg.motivo='m' then
                                                    begin
                                                         reg.motivo:='Motor';
                                                         gotoxy(81,6);
                                                         writeln(reg.motivo);
                                                         abrir_archivo_turno(arch, nom_arch);
                                                         seek(arch, pos);
                                                         write(arch, reg);
                                                         close(arch);
                                                    end
                                                    else
                                                        begin
                                                             reg.motivo:='Frenos';
                                                             gotoxy(81,6);
                                                             writeln(reg.motivo);
                                                             abrir_archivo_turno(arch, nom_arch);
                                                             seek(arch, pos);
                                                             write(arch, reg);
                                                             close(arch);
                                                        end;
                                          gotoxy(29,6);
                                          writeln('                       ');
                                          gotoxy(40,6);
                                          writeln(reg.motivo);
                                       end
                                          else
                                              begin
                                                   gotoxy(21,16);
                                                   writeln('                                      ');
                                                   gotoxy(21,16);
                                                   textcolor(red);
                                                   writeln('Letra erronea');
                                                   textcolor(white);
                                                   readkey;
                                              end;

                             end;
                         '4':begin
                                  gotoxy(81,7);
                                  writeln('                    ');
                                  gotoxy(81,7);
                                  {$I-}
                                       readln(reg.patente);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          busqueda_patente(arch_a, nom_arch_a, reg.patente, posi);
                                          if posi>-1 then
                                             begin
                                                  leer_auto(arch_a, nom_arch_a, posi, reg_a);
                                                  if reg_a.estado_auto then
                                                     begin
                                                          gotoxy(34,7);
                                                          writeln('                     ');
                                                          gotoxy(40,7);
                                                          writeln(reg.patente);
                                                          abrir_archivo_turno(arch, nom_arch);
                                                          seek(arch, pos);
                                                          write(arch, reg);
                                                          close(arch);
                                                     end
                                                        else
                                                            begin
                                                                 gotoxy(21,16);
                                                                 writeln('                                                                   ');
                                                                 gotoxy(21,16);
                                                                 Textcolor(red);
                                                                 writeln('La patente esta dada de baja. Debe darlo de alta primero');
                                                                 Textcolor(white);
                                                                 readkey;
                                                            end;
                                             end
                                                else
                                                    begin
                                                         gotoxy(21,16);
                                                         writeln('                                                                   ');
                                                         gotoxy(21,16);
                                                         Textcolor(red);
                                                         writeln('La patente no esta registrada. Debe registrar el auto primero');
                                                         Textcolor(white);
                                                         readkey;
                                                    end;
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                                                   ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         end;
                   until control=#27;
                   end
                      else
                          begin
                               textcolor(red);
                               writeln('El turno esta dado de baja');
                               textcolor(white);
                               readkey;
                          end;
              end;

              procedure busqueda_turno(var arch:t_turnos; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_turno;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_turno(arch, nom_arch);  //abrimos el archivo para lectura
                   while not eof(arch) do                //instruccion eof devuelve true cuando se llego al final del archivo
                   begin
                        read(arch, reg_aux);             //leemos el archivo en la posicion que esta el puntero
                        if reg_aux.codigo_turno = buscado then //comparamos con el campo que buscamos
                           begin
                                pos:=i;
                           end;
                        i:=i+1;         //actualizamos variable de control
                        seek(arch, i); //actualizamos puntero dentro del archivo
                   end;
                   close(arch);
              end;

          procedure busqueda_patente(var arch:t_autos; nom_arch_a:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_auto;
                 i:integer;
              begin
                   i:=0;
                   pos:=-1;
                   abrir_archivo_auto(arch, nom_arch_a); //Abrir el archivo para recorrerlo
                   while not eof(arch) do //instruccion eof devuelve true al alcanzar el final del archivo
                   begin
                        read(arch, reg_aux); //leemos archivo
                        if reg_aux.patente = buscado then //realizamos comparacion
                           begin
                                pos:=i;
                           end;
                        i:=i+1;          //actualizamos variable de control
                        seek(arch, i);   //pasamos VC actualizada al puntero
                   end;
                   close(arch);
              end;


              procedure baja_turno(var arch:t_turnos; nom_arch:string; var pos:integer);
              var
                 reg:r_turno;
              begin
                   leer_turno(arch, nom_arch, pos, reg); //leemos archivo en pos indicada
                   reg.estado_turno:=false;              //al registro que devuelve le asignamos el estado false
                   abrir_archivo_turno(arch, nom_arch);  //abrimos archivo para escritura
                   seek(arch, pos);                      //posicionamos el puntero dentro del archivo
                   write(arch, reg);                     //escribimos el registro con el nuevo valor de estado
                   close(arch);
              end;

              procedure alta_estado_turno(var arch:t_turnos; nom_arch:string; var pos:integer);
              var
                 reg:r_turno;
              begin
                   leer_turno(arch, nom_arch, pos, reg);
                   reg.estado_turno:=true;
                   abrir_archivo_turno(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

     procedure alta_turno(var arch:t_turnos; var arch_u:t_usuarios; var arch_a:t_autos; nom_arch_a:string ;nom_arch_u:string; nom_arch:string; var reg:r_turno);
     var
          posi,x,y,i:integer;
          control:char;
          aux_hora:st20;
          validacion:integer;
          reg_a:r_auto;
          reg_aux_t:r_turno;
          ultima_posicion:integer;
     begin
          abrir_archivo_turno(arch,nom_arch); //
          if filesize(arch)=0 then           //
               begin                           //
                    reg.codigo_turno:=0;        //  Inicializacion del archivo
                    write(arch, reg)          //
               end;                           //
          close(arch);                     //
          clrscr;
          textcolor (white);
          x:=44;
          y:=2;
          For i:=1 to 20 do
          Begin
               Gotoxy (x,y);
               Writeln('|');
               inc (y);
          End;
          x:=45;
          y:=21;
          For i:=1 to 29 do
          Begin
               Gotoxy (x,y);
               Writeln ('_');
               x:=x+2
          End;
          x:=102;
          y:=2;
          For i:=1 to 20 do
          Begin
               Gotoxy (x,y);
               Writeln('|');
               inc (y);
          End;
          x:=45;
          y:=1;
          For i:=1 to 29 do
          Begin
               Gotoxy (x,y);
               Writeln ('_');
               x:=x+2
          End;
          textcolor (white);
          posi:=-1;
          gotoxy(66,2);
          writeln('Alta de Turno');
          gotoxy(45,4);
          writeln('Fecha del turno: ');
          gotoxy(45,5);
          writeln('DNI del usuario: ');
          gotoxy(45,6);
          writeln('Patente auto: ');
          gotoxy(45,11);
          writeln('motivo: ');
          gotoxy(45,15);
          writeln('Codigo: ');
          gotoxy(63,4);
          readln(aux_hora);
          abrir_archivo_turno(arch, nom_arch); //
          ultima_posicion:=filesize(arch)-1;  // lectura de la posicion del ultimo registro
          close(arch);                        //
          leer_turno(arch, nom_arch, ultima_posicion, reg_aux_t); //
          reg.codigo_turno:=reg_aux_t.codigo_turno+1;                // generar codigo de turno automaticamente
          gotoxy(53,15);
          writeln(reg.codigo_turno);
          if posi = -1 then
               begin
                    reg.dia_hora:=aux_hora;
                    repeat
                         gotoxy(63,5);
                         writeln('                                      ');
                         gotoxy(63,5);
                         {$I-}
                              readln(reg.dni_usuario);
                         {$I+}
                         validacion:=ioresult();
                         if validacion<>0 then
                              begin
                                   gotoxy(45,16);
                                   Textcolor (red);
                                   writeln('Debe ingresar solo numeros');
                                   Textcolor (white);
                              end;
                    until validacion=0;
                    gotoxy(45,16);
                    writeln('                                           ');
                  busqueda_dni_usuario(arch_u, nom_arch_u, reg.dni_usuario, posi);  //Verifica si existe el usuario para continuar
                  if posi>-1 then
                    begin
                     leer_auto(arch_a, nom_arch_a, posi, reg_a);   // Verifica si existe el auto dado de alta para continuar
                     if reg_a.estado_auto then
                        begin
                             repeat
                                   gotoxy(63,6);
                                   writeln('                                     ');
                                   gotoxy(63,6);
                                   {$I-}
                                        readln(reg.patente);
                                   {$I-}
                                   validacion:=ioresult();
                                   if validacion<>0 then
                                      begin
                                           gotoxy(45,16);
                                           Textcolor (red);
                                           writeln('Debe ingresar solo numeros');
                                           Textcolor (white);
                                      end;
                             until validacion = 0;
                             gotoxy(45,16);
                             writeln('                                           ');
                              busqueda_patente(arch_a, nom_arch_a, reg.patente, posi);// Verifica si la patente existe para continuar
                              if posi>-1 then
                                   begin
                                        leer_auto(arch_a, nom_arch_a, posi, reg_a);
                                        if reg_a.estado_auto then
                                        begin
                                             gotoxy(45,16);
                                             writeln('                                                         ');
                                             repeat
                                                  gotoxy(45,16);
                                                  writeln('Presione "s":Service ; "m":Motor; "f":Freno');
                                                  gotoxy(55,11);
                                                  writeln('                             ');
                                                  gotoxy(55,11);
                                                  control:=readkey;
                                                  keypressed;
                                                  case control of
                                                       's':begin
                                                                 reg.motivo:='Service';
                                                                 gotoxy(55,11);
                                                                 writeln(reg.motivo);
                                                            end;
                                                       'm':begin
                                                                 reg.motivo:='Motor';
                                                                 gotoxy(55,11);
                                                                 writeln(reg.motivo);
                                                            end;
                                                       'f':begin
                                                                 reg.motivo:='Freno';
                                                                 gotoxy(55,11);
                                                                 writeln(reg.motivo);
                                                            end;
                                                       else
                                                            begin
                                                                 gotoxy(45,16);
                                                                 Textcolor (red);
                                                                 writeln('La letra ingresada es erronea:...');
                                                                 Textcolor (white);
                                                            end;
                                                  end;
                                             until (reg.motivo = 'Service') or (reg.motivo = 'Motor') or (reg.motivo = 'Freno');
                                          gotoxy(45,16);
                                          writeln('                                                         ');
                                             reg.estado_turno:=true;
                                             guardar_turno(arch, nom_arch, reg);
                                             gotoxy(45,16);
                                             Textcolor (green);
                                             writeln('Turno creado correctamente!');
                                             Textcolor (white);
                                             gotoxy(45,18);
                                             writeln('tocar cualquier tecla para volver al menu');
                                             textcolor(white);
                                             readkey;
                                        end;
                                   end
                                   else
                                        begin
                                             gotoxy(45,16);
                                             Textcolor (red);
                                             writeln('el auto no esta registrado.');
                                             gotoxy(45,17);
                                             writeln('Registre primero el auto para continuar');
                                             Textcolor (white);
                                             readkey;
                                        end;
                         end
                              else
                              begin
                                   gotoxy(45,16);
                                   Textcolor (red);
                                   writeln('El usuario esta dado de baja.');
                                   Gotoxy (45,17);
                                   writeln ('Dar de alta para continuar');
                                   Textcolor (white);
                                   readkey;
                              end;
                    end
                         else
                              begin
                                   gotoxy(45,16);
                                   Textcolor (red);
                                   writeln('El usuario no esta registrado.');
                                   Gotoxy(46,17);
                                   Writeln ('Registre primero el usuario para continuar');
                                   Textcolor (white);
                                   readkey;
                              end;
               end
               {else
                    begin
                         leer_turno(arch, nom_arch, posi, reg);
                         if (reg.estado_turno) then
                              begin
                                   repeat
                                        gotoxy(45,16);
                                        writeln('Este turno ya esta registrada.' ,#168,'Que desea hacer?');
                                        gotoxy(45,17);
                                        writeln('1: Modificar');
                                        gotoxy(45,18);
                                        writeln('2: Dar baja');
                                        gotoxy(45,19);
                                        writeln('ESC: Volver');
                                        control:=readkey;
                                        keypressed;
                                        if (control = '1') then
                                             modificar_turno(arch, arch_u ,arch_a,nom_arch, nom_arch_u, nom_arch_a,posi)
                                             else
                                                  if (control='2') then
                                                       begin
                                                            gotoxy(45,16);
                                                            writeln('                                                         ');
                                                            gotoxy(45,17);
                                                            writeln('                ');
                                                            gotoxy(45,18);
                                                            writeln('                     ');
                                                            gotoxy(45,19);
                                                            writeln('              ');
                                                            baja_turno (arch,nom_arch, posi);
                                                            gotoxy(45,16);
                                                            writeln('Listo!');
                                                            readkey;
                                                       end
                                                       else
                                                       if (control=#27) then
                                                            clrscr
                                                                 else
                                                                 begin
                                                                      gotoxy(45,16);
                                                                      writeln('                                                         ');
                                                                      gotoxy(45,17);
                                                                      writeln('                ');
                                                                      gotoxy(45,18);
                                                                      writeln('                     ');
                                                                      gotoxy(45,19);
                                                                      writeln('              ');
                                                                      gotoxy(45,16);
                                                                      Textcolor (red);
                                                                      writeln('La tecla ingresada es erronea...');
                                                                      Textcolor (white);
                                                                      readkey;
                                                                 end;
                                   until (control = '1') or (control='2') or (control = #27);
                              end
                              else
                              begin
                                   repeat
                                        gotoxy(45,16);
                                        writeln('Este turno esta registrado pero esta dado de baja.');
                                        gotoxy(45,17);
                                        writeln('1: Dar de alta');
                                        gotoxy(45,18);
                                        writeln('ESC: Volver');
                                        control:=readkey;
                                        keypressed;
                                        if (control = '1') then
                                             begin
                                                  gotoxy(45,16);
                                                  writeln('                                                         ');
                                                  gotoxy(45,17);
                                                  writeln('               ');
                                                  gotoxy(45,18);
                                                  writeln('            ');
                                                  alta_estado_turno(arch, nom_arch, posi);
                                                  gotoxy(45,16);
                                                  Textcolor (green);
                                                  writeln('Listo!');
                                                  Textcolor (white);
                                                  readkey;
                                             end
                                                  else
                                                  if (control=#27) then
                                                       clrscr
                                                            else
                                                            begin
                                                                 gotoxy(45,16);
                                                                 writeln('                                                         ');
                                                                 gotoxy(45,17);
                                                                 writeln('               ');
                                                                 gotoxy(45,18);
                                                                 writeln('            ');
                                                                 gotoxy(45,16);
                                                                 Textcolor (red);
                                                                 writeln('La letra ingresada es erronea...');
                                                                 Textcolor (white);
                                                                 readkey;
                                                            end;
                                   until (control = '1') or (control = #27);
                              end;
                    end; }
     end;

              procedure eliminar_archivo_turno(var arch:t_turnos);
              begin
                   erase(arch);
              end;

begin

end.