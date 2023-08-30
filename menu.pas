Unit menu;
Interface
         Uses crt, archivos_turnos, archivos_autos, archivos_usuarios, vectores_turnos, vectores_autos,vectores_usuarios;

         Procedure menu_principal;
         Procedure menu_abmc;
         Procedure menu_listado;
         Procedure menu_alta;
         Procedure menu_baja;
         Procedure menu_modificar;
         Procedure menu_consultar;
         procedure consulta_turno(var arch_t:t_turnos;var arch_u:t_usuarios; nom_turno:string; nom_usuario:string); 
         procedure consulta_usuario(var arch_t:t_turnos; var arch_u:t_usuarios; nom_usuario:string);
var
   nombre_turno:string;
   nombre_auto:string;
   nombre_usuario:string;
   arch_turno:t_turnos;
   arch_auto:t_autos;
   arch_usuario:t_usuarios;


Implementation


            Procedure menu_principal;
            var
               x,y,i:integer;
               control,control2:char;
            Begin
                 abrir_archivo_turno(arch_turno, nombre_turno);
                 close(arch_turno);
                 abrir_archivo_auto(arch_auto, nombre_auto);
                 close(arch_auto);
                 abrir_archivo_usuario(arch_usuario, nombre_usuario);
                 close(arch_usuario);
                 repeat
                 clrscr;
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (63,3);
                 Writeln ('MENU PRINCIPAL');
                 Gotoxy (48,6);
                 Writeln ('1: ABMC');
                 Gotoxy (48,10);
                 Writeln ('2: Listados');
                 Gotoxy (48,14);
                 Writeln ('3: Vaciar Archivos');
                 Gotoxy (48,18);
                 Writeln ('4: Cerrar Aplicacion');
                 control:=readkey;
                 case control of
                      '1':Begin
                               clrscr;
                               menu_abmc;
                          End;

                      '2':Begin
                               clrscr;
                               menu_listado;
                          End;

                      '3': Begin
                                clrscr;
                                textcolor (white);
                                clrscr;
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2;
                                  End;
                                  x:=97;
                                  y:=17;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       y:=y-1;
                                  End;
                                  x:=96;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x-2;
                                  End;
                                  textcolor (white);
                                  Gotoxy (54,4);
                                  Writeln (#191'Seguro que desea vaciar los archivos?');
                                  Gotoxy (54,7);
                                  writeln ('1:SI');
                                  Gotoxy (87,7);
                                  Writeln ('2:NO');
                                  control2:=readkey;
                                Repeat
                                      If control2 = '1' then
                                         begin
                                              eliminar_archivo_turno(arch_turno);
                                              eliminar_archivo_usuario(arch_usuario);
                                              eliminar_archivo_auto(arch_auto);
                                              clrscr;
                                              textcolor(green);
                                              writeln('Borrado correctamente!');
                                              textcolor(white);
                                              writeln('Presione cualquier tecla para volver a Menu principal');
                                              readkey;
                                              clrscr;
                                              menu_principal
                                         end;

                                      If control2 = '2' then
                                         Begin
                                              clrscr;
                                              menu_principal;
                                         End;
                                  until (control2='1') or (control2='2');
                           End;

                         '4':begin
                                  textcolor (white);
                                  clrscr;
                                  repeat
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2
                                  End;
                                  x:=96;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2
                                  End;
                                  textcolor (white);
                                  Gotoxy (58,4);
                                  Writeln (#191'Seguro que desea salir?');
                                  Gotoxy (58,7);
                                  writeln ('1:SI');
                                  Gotoxy (78,7);
                                  Writeln ('2:NO');
                                  Gotoxy (50,20);
                                  Textcolor (Blue);
                                  Writeln ('Alumnos: Sosa Mariano - Galarza Francisco');
                                  control2:=readkey;
                                  If control2 = '1' then
                                     halt;
                                  If control2 = '2' then
                                     Begin
                                          clrscr;
                                          menu_principal;
                                     End;
                                  until (control2='1') or (control2='2');
                             end;

                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3');
                 Readkey;
            End;


            Procedure menu_abmc;
            var
            x,y,i:integer;
            control:char;
            Begin
                 clrscr;
                 repeat
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (63,3);
                 Writeln(#191'Que desea hacer?');
                 Gotoxy (47,6);
                 Writeln ('1: Dar de alta');
                 Gotoxy (47,10);
                 Writeln ('2: Dar de baja');
                 Gotoxy (47,14);
                 Writeln ('3: Modificar');
                 Gotoxy (47,18);
                 Writeln ('4: Consultar');
                 Gotoxy (47,22);
                 Writeln ('5: Volver al menu principal');
                 control:=readkey;
                 case control of
                      '1':Begin
                               textcolor(white);
                               clrscr;
                               menu_alta;
                          End;
                      '2':Begin
                               textcolor(white);
                               clrscr;
                               menu_baja;
                          End;
                      '3':Begin
                               textcolor(white);
                               clrscr;
                               menu_modificar;
                          End;
                      '4':Begin
                               clrscr;
                               menu_consultar;
                          End;
                      '5':Begin
                               textcolor(white);
                               clrscr;
                               menu_principal
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4') or (control='5');
                 Readkey;
            End;


            Procedure menu_listado;
            var
               x,y,i:integer;
               control:char;
               vt:v_turnos;
               va:v_autos;
               vu:v_usuarios;
            Begin
                 inicializar_vector_turno(vt);
                 inicializar_vector_autos(va);
                 inicializar_vector_usuario(vu);
                 clrscr;
                 repeat
                 textcolor (white);
                 x:=41;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=42;
                 y:=1;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=101;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=42;
                 y:=25;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (60,3);
                 Writeln(#191'Que listado desea obtener?');
                 Gotoxy (42,6);
                 Writeln ('1: Usuarios ordenados alfabeticamente');
                 Gotoxy (42,10);
                 Writeln ('2: Turnos ordenadas alfabeticamente');
                 Gotoxy (42,14);
                 Writeln ('3: Autos ordenados alfabeticamente');
                 Gotoxy (42,18);
                 Writeln ('4: volver al menu principal');
                 control:=readkey;
                 case control of
                      '1':begin
                                textcolor(white);
                                clrscr;
                                listado_usuario(arch_usuario, nombre_usuario, vu);
                                menu_principal;
                           end;
                      '2': begin
                                textcolor(white);
                                clrscr;
                                listado_turnos(arch_turno, nombre_turno, vt);
                                menu_principal;
                           end;
                      '3': begin
                                textcolor(white);
                                clrscr;
                                listado_autos(arch_auto, nombre_auto, va);
                                menu_principal;
                           end;
                      '4':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='5'); 
                 Readkey;
            End;

            Procedure menu_alta;
            var
               x,y,i:integer;
               control:char;
               rt:r_turno;
               ra:r_auto;
               ru:registro_usuario;
            Begin
                 repeat
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (59,3);
                 Writeln(#191'Que desea dar de alta?');
                 Gotoxy (47,6);
                 Writeln ('1: Turno');
                 Gotoxy (47,10);
                 Writeln ('2: Auto');
                 Gotoxy (47,14);
                 Writeln ('3: Usuario');
                 Gotoxy (47,18);
                 Writeln ('4: Volver al menu principal');
                 control:=readkey;
                 case control of
                      '1':begin
                                textcolor(white);
                                clrscr;
                                alta_turno(arch_turno,arch_usuario,arch_auto,nombre_auto,nombre_usuario,nombre_turno, rt);
                                menu_principal;
                          end;
                      '2':begin
                                textcolor(white);
                                clrscr;
                                alta_auto(arch_auto, nombre_auto, ra);
                                menu_principal;
                          end;
                      '3':begin
                                textcolor(white);
                                clrscr;
                                alta_usuario(arch_usuario, nombre_usuario, ru);
                                menu_principal;
                          end;
                      '4':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='5');
                 Readkey;
            End;


            Procedure menu_baja;
            var
               x,y,i:integer;
               control:char;
               aux:integer;
               pos:integer;
               aux_patente:st20;
               aux_dni:longint;
               validacion:integer;
            Begin
                 repeat
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (59,3);
                 Writeln(#191'Que desea dar de baja?');
                 Gotoxy (47,6);
                 Writeln ('1: Turno');
                 Gotoxy (47,10);
                 Writeln ('2: Auto');
                 Gotoxy (47,14);
                 Writeln ('3: Usuario');
                 Gotoxy (47,18);
                 Writeln ('4: Volver al menu principal');
                 control:=readkey;
                 case control of
                      '1':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el codigo del turno que desea dar de baja: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                      until validacion=0;
                                     busqueda_turno(arch_turno, nombre_turno, aux, pos);
                                     if pos>-1 then
                                        begin
                                             baja_turno(arch_turno, nombre_turno, pos);
                                             textcolor(green);
                                             writeln('Turno dado de baja exitosamente!.');
                                             writeln('Presione cualquier tecla para continuar...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El turno no esta registrado.');
                                                 writeln('Presione cualquier tecla para continuar...');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '2':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese la patente del auto que desea dar de baja: ');
                                           {$I-}
                                                readln(aux_patente);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar un tipo de dato alfanumerico.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_patente(arch_auto, nombre_auto, aux_patente, pos);
                                     if pos>-1 then
                                        begin
                                             baja_auto(arch_auto, nombre_auto, pos);
                                             textcolor(green);
                                             writeln('Auto borrado exitosamente!.');
                                             writeln('Presione cualquier tecla para continuar...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El auto no esta registrado.');
                                                 writeln('Presione ESC. para salir o enter para volver a intentar..');
                                                 textcolor(white);
                                                 control:=readkey;
                                                   if control=#27 then
                                                     begin
                                                       menu_abmc;
                                                     end;
                                            end;
                                 until (pos>-1)
                          end;
                      '3':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el DNI del Usuario que desea dar de baja: ');
                                           {$I-}
                                                readln(aux_dni);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_dni_usuario(arch_usuario, nombre_usuario, aux_dni, pos);
                                     if pos>-1 then
                                        begin
                                             baja_usuario(arch_usuario, nombre_usuario, pos);
                                             textcolor(green);
                                             writeln('Usuario dado de caja exitosamente!.');
                                             writeln('Presione cualquier tecla para continuar...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El usuario no esta registrado.');
                                                 writeln('Presione cualquier tecla para continuar...');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '4':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar...');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='5');
                 Readkey;
            End;


            Procedure menu_modificar;
            var
               x,y,i:integer;
               control:char;
               aux:integer;
               aux_patente:st20;
               pos:integer;
               validacion:integer;
            Begin
                 repeat
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=17;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (55,3);
                 Writeln(#191'Que registro desea modificar?');
                 Gotoxy (47,6);
                 Writeln ('1: Turno');
                 Gotoxy (47,10);
                 Writeln ('2: Auto');
                 Gotoxy (47,14);
                 Writeln ('3: Volver al menu principal');
                 control:=readkey;
                 case control of 
                      '1': begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                           writeln('Ingrese el codigo del turno que desea modificar: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion=0 then
                                              begin
                                                   busqueda_turno(arch_turno, nombre_turno, aux, pos);
                                                   if pos>-1 then
                                                   begin
                                                        modificar_turno(arch_turno,arch_usuario,arch_auto,nombre_turno,nombre_usuario,nombre_auto,pos);
                                                        menu_principal;
                                                   end
                                                      else
                                                          begin
                                                               writeln('El turno no esta registrado.');
                                                               writeln('Presione cualquier tecla para continuar...');
                                                               readkey;
                                                               menu_abmc;
                                                          end;
                                              end
                                                 else
                                                     begin
                                                          writeln('Debe ingresar solo numeros');
                                                          readkey;
                                                     end;
                                 until (pos>-1) and (validacion=0);
                          end;
                         '2':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese la patente del auto que desea modificar: ');
                                           {$I-}
                                                readln(aux_patente);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar un tipo de dato alfanumerico.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_patente(arch_auto, nombre_auto, aux_patente, pos);
                                     if pos>-1 then
                                        begin
                                             modificar_auto(arch_auto, nombre_auto, pos);
                                             menu_principal;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El auto no esta registrado.');
                                                 writeln('Presione ESC. para salir o enter para volver a intentar..');
                                                 textcolor(white);
                                                 control:=readkey;
                                                   if control=#27 then
                                                     begin
                                                       menu_abmc;
                                                     end;
                                            end;
                                 until (pos>-1)
                          end;
                      '3':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='3');
                 Readkey;
            End;

            Procedure menu_consultar;
            var
               x,y,i:integer;
               control:char;
            Begin
                 clrscr;
                 repeat
                 textcolor (white);
                 x:=46;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=21;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (61,3);
                 Writeln(#191'Que desea consultar?');
                 Gotoxy (47,6);
                 Writeln ('1: Turno');
                 Gotoxy (47,10);
                 Writeln ('2: Usuario');
                 Gotoxy (47,14);
                 Writeln ('3: Volver al menu principal');
                 control:=readkey;
                 case control of
                      '1':begin
                               clrscr;
                               consulta_turno(arch_turno,arch_usuario,nombre_turno, nombre_usuario); 
                               gotoxy(51,10);
                               textcolor(yellow);
                               writeln('Presione enter para salir.');
                               textcolor(white);
                               readkey;
                               menu_principal;
                          end;
                      '2':begin
                               clrscr;
                               consulta_usuario(arch_turno, arch_usuario, nombre_usuario);
                               readkey;
                               menu_principal;
                          end;
                      '3':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3');
                 Readkey;
            End;




     //CONSULTA TURNO
     procedure consulta_turno(var arch_t:t_turnos;var arch_u:t_usuarios; nom_turno:string; nom_usuario:string);
               var
                    reg_turno:r_turno;
                    reg_usuario:registro_usuario;
                    aux:integer;
                    pos,x,y,i:integer;
               begin
                    textcolor(white);
                    writeln('Ingrese codigo de turno que desea consultar:');
                    Gotoxy (48,1);
                    readln(aux);
                    busqueda_turno(arch_turno, nom_turno, aux, pos);
                    if pos>-1 then
                         begin
                              clrscr;
                              textcolor (blue);
                              x:=49;
                              y:=2;
                              For i:=1 to 8 do
                                   Begin
                                        Gotoxy (x,y);
                                        Writeln('|');
                                        inc (y);
                                   End;
                              x:=50;
                              y:=9;
                              For i:=1 to 20 do
                                   Begin
                                        Gotoxy (x,y);
                                        Writeln ('_');
                                        x:=x+2
                                   End;
                              x:=89;
                              y:=2;
                              For i:=1 to 8 do
                                   Begin
                                        Gotoxy (x,y);
                                        Writeln('|');
                                        inc (y);
                                   End;
                              x:=50;
                              y:=1;
                              For i:=1 to 20 do
                              Begin
                                   Gotoxy (x,y);
                                   Writeln ('_');
                                   x:=x+2
                              End;
                              textcolor (white);
                              leer_turno(arch_turno, nombre_turno, pos, reg_turno);
                              if reg_turno.estado_turno then
                              begin
                                   gotoxy(60,2);
                                   writeln('Turno: ', aux);
                                   gotoxy(60,5);
                                   writeln('Fecha: ', reg_turno.dia_hora);
                                   gotoxy(60,6);
                                   writeln('Motivo: ', reg_turno.motivo);
                                   gotoxy(60,7);
                                   writeln('Patente: ', reg_turno.patente);
                                   gotoxy(51,3);
                                   writeln('-------------------------------------');
                                   busqueda_dni_usuario(arch_usuario, nom_usuario, reg_turno.dni_usuario, pos);
                                   if pos>-1 then
                                        begin
                                             leer_usuario(arch_usuario, nom_usuario, pos, reg_usuario);
                                             if reg_usuario.estado_usuario then
                                             begin
                                                  gotoxy(60,4);
                                                  writeln('usuario: ', reg_usuario.nombre_usuario);
                                             end
                                                  else
                                                       begin
                                                            textcolor(red);
                                                            gotoxy(60,9);
                                                            writeln('El Usuario esta dado de baja');
                                                            textcolor(white);
                                                       end;
                                        end;
                              end
                                   else
                                        begin
                                             gotoxy(60,10);
                                             textcolor(red);
                                             writeln('El turno esta dada de baja');
                                             textcolor(white);
                                             readkey;
                                             menu_consultar;
                                        end;
                              
                         end
                         else
                              begin
                                   textcolor(red);
                                   writeln('Este turno no esta registrado. Presione cualquier tecla...');
                                   textcolor(white);
                                   readkey;
                                   menu_consultar;
                              end;
               end;
     //CONSULTA TURNO END



     procedure consulta_usuario(var arch_t:t_turnos; var arch_u:t_usuarios ; nom_usuario:string);
     var
     reg_usua:registro_usuario;
     aux:longint;
     pos:integer;
     validacion:integer;
     begin
          textcolor(white);
          repeat
               writeln('Ingrese el DNI del usuario:');
               {$I-}
                    Gotoxy(46,1);
                    readln(aux);
               {$I+}
               clrscr;
               validacion:=ioresult();
               if validacion<>0 then
                    begin
                         Textcolor(red);
                         writeln('Debe ingresar solo numeros');
                         textcolor(white);
                    end;
          until validacion=0;
          busqueda_dni_usuario(arch_usuario, nom_usuario, aux, pos);
          if pos>-1 then
          begin
               leer_usuario(arch_usuario, nom_usuario, pos, reg_usua);
               if reg_usua.estado_usuario=false then
                    begin
                         gotoxy(61,1);
                         textcolor(red);
                         writeln('El usuario esta dado de baja');
                         textcolor(white);
                         textcolor(yellow);
                         writeln('Presione enter para salir.');
                         textcolor(white);
                         readkey;
                         menu_consultar;
                    end;
               pos:=-1;
               gotoxy(64,2);
               writeln('Usuario: ', reg_usua.nombre_usuario);
               gotoxy(60,3);
               writeln('------------------------------');
               busqueda_nombre_usuario(arch_usuario, nombre_usuario, reg_usua.nombre_usuario, pos);
               if pos=-1 then
                              Begin
                                   gotoxy(61,4);
                                   textcolor(red);
                                   writeln('No hay ningun turno registrado con este usuario.');
                                   textcolor(white);
                              End;
          end
               else
                    Begin
                         textcolor (red);
                         writeln('Este usuario no esta registrado.');
                         writeln('Presione cualquier tecla para continuar...');
                         Textcolor(white);
                         readkey;
                         menu_consultar;
                    End;
     end;


begin
     nombre_turno:='arch_turno.dat';
     nombre_auto:='arch_auto.dat';
     nombre_usuario:='arch_usuario.dat';
End.




