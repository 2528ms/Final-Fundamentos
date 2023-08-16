unit archivos_autos;

interface
         uses crt;

         type
             st10=string[10];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_auto=record
                     marca:st30;
                     modelo:st30;
                     patente:st20;
                     tipo:integer;
                     combustible:st20;
                     estado_auto:boolean;
                     end;
         t_autos = file of r_auto;

         procedure abrir_archivo_auto(var arch:t_autos; nom_arch:string);
         procedure leer_auto(var arch:t_autos; nom_arch:string; var pos:integer; var dato_leido:r_auto);
         procedure guardar_auto(var arch:t_autos ; nom_arch:string ; var escribir_dato:r_auto);
         procedure modificar_auto(var arch:t_autos; nom_arch:string ;pos:integer);
         procedure busqueda_marca(var arch:t_autos; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_patente(var arch:t_autos; nom_arch:string; buscado:st20; var pos:integer);
         procedure alta_auto(var arch:t_autos; nom_arch:string; var reg:r_auto);
         procedure baja_auto(var arch:t_autos; nom_arch:string; var pos:integer);
         procedure alta_estado_auto(var arch:t_autos; nom_arch:string; var pos:integer);
         procedure eliminar_archivo_auto(var arch:t_autos);

implementation
              procedure abrir_archivo_auto(var arch:t_autos;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.
                   //close(arch);
              end;
              procedure leer_auto(var arch:t_autos; nom_arch:string; var pos:integer; var dato_leido:r_auto); //Lee archivo de tipo texto
              begin
                   abrir_archivo_auto(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_auto(var arch:t_autos; nom_arch:string ; var escribir_dato:r_auto); //Escribe en archivo de tipo texto
              begin
                   abrir_archivo_auto(arch, nom_arch);
                   seek(arch, filesize(arch));
                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                   close(arch);
              end;

              procedure modificar_auto(var arch:t_autos; nom_arch:string ;pos:integer);
              var
                 x,y,i:integer;
                 reg:r_auto;
                 control:char;
                 validacion:integer;
              begin
                   clrscr;
                   leer_auto(arch, nom_arch, pos, reg);
                   if reg.estado_auto then
                   begin
                    clrscr;
                 textcolor (blue);
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
                   gotoxy(55,1);
                   writeln('Modificar Auto');
                   gotoxy(21,4);
                   writeln('Marca: ', reg.marca);
                   gotoxy(21,5);
                   writeln('Modelo: ', reg.modelo);
                   gotoxy(21,6);
                   writeln('Tipo: ', reg.tipo);
                   gotoxy(21,7);
                   writeln('Combustible: ',reg.combustible);
                   gotoxy(61,3);
                   writeln(#168,'Que desea modificar?');
                   gotoxy(61,4);
                   writeln('1: Marca: ');
                   gotoxy(61,5);
                   writeln('2: Modelo: ');
                   gotoxy(61,6);
                   writeln('3: Tipo: ');
                   gotoxy(61,7);
                   writeln('4: Combustible: ');
                   gotoxy(61,8);
                   writeln('ESC: Salir ');
                   repeat
                         gotoxy(21,9);
                         control:=readkey;
                         keypressed;
                         case control of
                              '1':begin
                                       gotoxy(72,4);
                                       writeln('                           ');
                                       gotoxy(72,4);
                                       readln(reg.marca);
                                       gotoxy(29,4);
                                       writeln('              ');
                                       gotoxy(29,4);
                                       writeln(reg.marca);
                                       reg.estado_auto:=true;
                                       abrir_archivo_auto(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                               '2':begin
                                       gotoxy(75,5);
                                       writeln('                           ');
                                       gotoxy(75,5);
                                       readln(reg.modelo);
                                       gotoxy(32,5);
                                       writeln('              ');
                                       gotoxy(32,5);
                                       writeln(reg.modelo);
                                       reg.estado_auto:=true;
                                       abrir_archivo_auto(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                   end;
                                '3':begin
                                         repeat
                                               gotoxy(21,10);
                                               writeln('                           ');
                                               gotoxy(21,11);
                                               writeln('                                      ');
                                               gotoxy(74,6);
                                               writeln('                           ');
                                               gotoxy(74,6);
                                               {$I-}
                                                    readln(reg.tipo);
                                               {$I+}
                                               validacion:=ioresult();
                                               if validacion<>0 then
                                                  begin
                                                       textcolor(red);
                                                       gotoxy(21,10);
                                                       writeln('Debe ingresar solo numeros.');
                                                       gotoxy(21,11);
                                                       writeln('Presione enter para intentar de nuevo.');
                                                       textcolor(white);
                                                       readkey;
                                                  end;
                                         until validacion=0;
                                         gotoxy(21,10);
                                         writeln('                           ');
                                         gotoxy(21,11);
                                         writeln('                                      ');
                                         gotoxy(31,6);
                                         writeln('              ');
                                         gotoxy(31,6);
                                         writeln(reg.tipo);
                                         reg.estado_auto:=true;
                                         abrir_archivo_auto(arch, nom_arch);
                                         seek(arch, pos);
                                         write(arch, reg);
                                         close(arch);
                                    end;
                                '4':begin
                                         repeat
                                               gotoxy(21,10);
                                               writeln('                           ');
                                               gotoxy(21,11);
                                               writeln('                                      ');
                                               gotoxy(73,7);
                                               writeln('                           ');
                                               gotoxy(73,7);
                                               {$I-}
                                                    readln(reg.combustible);
                                               {$I+}
                                               validacion:=ioresult();
                                               if validacion<>0 then
                                                  begin
                                                       textcolor(red);
                                                       gotoxy(21,10);
                                                       writeln('Debe ingresar tipo de combustible.');
                                                       gotoxy(21,11);
                                                       writeln('Presione enter para intentar de nuevo.');
                                                       textcolor(white);
                                                       readkey;
                                                  end;
                                         until validacion=0;
                                         gotoxy(21,10);
                                         writeln('                           ');
                                         gotoxy(21,11);
                                         writeln('                                      ');
                                         gotoxy(30,7);
                                         writeln('              ');
                                         gotoxy(30,7);
                                         writeln(reg.combustible);
                                         reg.estado_auto:=true;
                                         abrir_archivo_auto(arch, nom_arch);
                                         seek(arch, pos);
                                         write(arch, reg);
                                         close(arch);
                                    end;
                         end;
                   until control=#27;
                   end
                      else
                          begin
                               writeln('El Auto esta dado de baja.');
                               readkey;
                          end;
              end;

              procedure busqueda_marca(var arch:t_autos; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_auto;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_auto(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.marca = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_patente(var arch:t_autos; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_auto;
                 i:integer;
              begin
                   i:=0;
                   pos:=-1;
                   abrir_archivo_auto(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.patente = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure baja_auto(var arch:t_autos; nom_arch:string; var pos:integer);
              var
                 reg:r_auto;
              begin
                   leer_auto(arch, nom_arch, pos, reg);
                   reg.estado_auto:=false;
                   abrir_archivo_auto(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_auto(var arch:t_autos; nom_arch:string; var pos:integer);
              var
                 reg:r_auto;
              begin
                   leer_auto(arch, nom_arch, pos, reg);
                   reg.estado_auto:=true;
                   abrir_archivo_auto(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_auto(var arch:t_autos; nom_arch:string; var reg:r_auto);
              var
                 posi,x,y,i:integer;
                 control:char;
                 asd:string;
                 validacion:integer;
              begin
                   clrscr;
                 textcolor (blue);
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
                 For i:=1 to 28 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=100;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=1;
                 For i:=1 to 28 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   posi:=-1;
                   gotoxy(63,2);
                   writeln('Alta de Auto');
                   gotoxy(45,4);
                   writeln('Marca del automovil: ');
                   gotoxy(45,5);
                   writeln('Modelo ');
                   gotoxy(45,6);
                   writeln('Patente: ');
                   gotoxy(45,7);
                   writeln('Tipo: ');
                   gotoxy(45,8);
                   writeln('Combustible: ');
                   gotoxy(64,4);
                   readln(asd);
                   busqueda_marca(arch, nom_arch, asd, posi);
                   if posi = -1 then
                      begin
                           reg.marca:=asd;
                           repeat
                                 gotoxy(50,5);
                                 writeln('                                             ');
                                 gotoxy(50,5);
                                 {$I-}
                                      readln(reg.patente);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion=0 then
                                    begin
                                         busqueda_patente(arch, nom_arch, reg.patente, posi);
                                         if posi>-1 then
                                            begin
                                                 gotoxy(45,10);
                                                 textcolor (red);
                                                 writeln('El DNI ya esta registrado. Debe ingresar otro.');
                                                 textcolor (white);
                                            end;
                                         end
                                            else
                                                begin
                                                     gotoxy(45,10);
                                                     textcolor (red);
                                                     writeln('Debe ingresar solo numeros');
                                                     textcolor (white);
                                                end;
                           until (posi=-1) and (validacion=0);
                           gotoxy(45,10);
                           writeln('                                              ');
                           gotoxy(56,6);
                           readln(reg.modelo);
                           repeat
                                        gotoxy(55,7);
                                        writeln('                                        ');
                                        gotoxy(55,7);
                                        {$I-}
                                             readln(reg.patente);
                                        {$I+}
                                        validacion:=ioresult();
                                        if validacion<>0 then
                                           begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('Debe ingresar solo numeros');
                                                textcolor (white);
                                           end;
                                   until validacion=0;
                                   gotoxy(45,10);
                                   writeln('                                              ');
                                   repeat
                                          gotoxy(62,8);
                                          writeln('                                  ');
                                          gotoxy(62,8);
                                         {$I-}
                                              readln(reg.tipo);
                                         {$I+}
                                         validacion:=ioresult();
                                         if validacion<>0 then
                                            begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('Debe ingresar solo numeros');
                                                textcolor (white);
                                            end;
                                   until validacion=0;
                                   gotoxy(45,10);
                                   writeln('                                              ');
                           reg.estado_auto:=true;
                           guardar_auto(arch, nom_arch, reg);
                           gotoxy(45,10);
                           textcolor (green);
                           writeln('Listo!');
                           textcolor (white);
                           readkey;
                      end
                         else
                             begin
                                  leer_auto(arch, nom_arch, posi, reg);
                                  if (reg.estado_auto) then
                                     begin
                                          repeat
                                                gotoxy(45,10);
                                                writeln('Este Auto ya esta registrado.', #168'Que desea hacer?');
                                                gotoxy(45,11);
                                                writeln('1: Modificar');
                                                gotoxy(45,12);
                                                writeln('2: Dar de baja');
                                                gotoxy(45,13);
                                                writeln('3: Cargar igual');
                                                gotoxy(45,14);
                                                writeln('ESC: Volver');
                                                control:=readkey;
                                                keypressed;
                                                if (control = '1') then
                                                   modificar_auto(arch, nom_arch, posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  baja_auto (arch,nom_arch, posi);
                                                                  gotoxy(45,10);
                                                                  writeln('                                                  ');
                                                                  gotoxy(45,11);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,12);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,13);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,14);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,10);
                                                                  textcolor (green);
                                                                  writeln('Listo!');
                                                                  textcolor (white);
                                                                  readkey;
                                                             end
                                                             else
                                                                 if (control='3') then
                                                                    begin
                                                                         gotoxy(45,10);
                                                                         writeln('                                                  ');
                                                                         gotoxy(45,11);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,12);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,13);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,14);
                                                                         writeln('                                              ');
                                                                         reg.marca:=asd;
                                                                         repeat
                                                                               gotoxy(50,5);
                                                                               writeln('                                     ');
                                                                               gotoxy(50,5);
                                                                               {$I-}
                                                                                    readln(reg.patente);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion=0 then
                                                                                  begin
                                                                                       busqueda_patente(arch, nom_arch, reg.patente, posi);
                                                                                       if posi>-1 then
                                                                                          begin
                                                                                               gotoxy(45,10);
                                                                                               textcolor(red);
                                                                                               writeln('La patente ya esta registrada. Debe ingresar otra');
                                                                                               textcolor(white);
                                                                                          end;
                                                                                  end
                                                                                     else
                                                                                         begin
                                                                                              gotoxy(45,10);
                                                                                              textcolor(red);
                                                                                              writeln('Debe ingresar solo numeros');
                                                                                              textcolor(white);
                                                                                         end;
                                                                         until (posi=-1) and (validacion=0);
                                                                         gotoxy(45,10);
                                                                         writeln('                                              ');
                                                                         gotoxy(56,6);
                                                                         readln(reg.modelo);
                                                                         repeat
                                                                                gotoxy(55,7);
                                                                                writeln('                                       ');
                                                                                gotoxy(55,7);
                                                                               {$I-}
                                                                                    readln(reg.patente);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion<>0 then
                                                                                  begin
                                                                                       gotoxy(45,10);
                                                                                       textcolor(red);
                                                                                       writeln('Debe ingresar solo numeros');
                                                                                       textcolor(white);
                                                                                  end;
                                                                         until validacion=0;
                                                                         gotoxy(45,10);
                                                                         writeln('                                         ');
                                                                         repeat
                                                                               gotoxy(62,8);
                                                                               writeln('                                  ');
                                                                               gotoxy(62,8);
                                                                               {$I-}
                                                                                    readln(reg.tipo);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion<>0 then
                                                                                  begin
                                                                                       gotoxy(45,10);
                                                                                       textcolor(red);
                                                                                       writeln('Debe ingresar solo numeros');
                                                                                       textcolor(white);
                                                                                  end;
                                                                         until validacion=0;
                                                                         gotoxy(45,10);
                                                                         writeln('                                      ');
                                                                         reg.estado_auto:=true;
                                                                         guardar_auto(arch, nom_arch, reg);
                                                                         gotoxy(45,10);
                                                                         textcolor(green);
                                                                         writeln('Listo!');
                                                                         readkey;
                                                                    end
                                                                       else
                                                                           if (control=#27) then
                                                                              clrscr
                                                                                 else
                                                                                     begin
                                                                                          gotoxy(45,10);
                                                                                          writeln('                                                  ');
                                                                                          gotoxy(45,11);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,12);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,13);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,14);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,10);
                                                                                          textcolor(red);
                                                                                          writeln('La tecla ingresada es erronea...');
                                                                                          textcolor(white);
                                                                                          readkey;
                                                                                     end;
                                          until (control = '1') or (control='2') or (control='3') or (control = #27);
                                     end
                                     else
                                     begin
                                         repeat
                                               gotoxy(45,10);
                                               writeln('Este Auto esta registrado pero esta dada de baja.');
                                               gotoxy(45,11);
                                               writeln('1: Dar de alta');
                                               gotoxy(45,12);
                                               writeln('ESC: Volver');
                                               control:=readkey;
                                               keypressed;
                                               gotoxy(45,10);
                                               writeln('                                                     ');
                                               gotoxy(45,11);
                                               writeln('                                              ');
                                               gotoxy(45,12);
                                               writeln('                                              ');
                                               if (control = '1') then
                                                  begin
                                                       alta_estado_auto(arch, nom_arch, posi);
                                                       gotoxy(45,10);
                                                       textcolor(green);
                                                       writeln('Listo!');
                                                       readkey;
                                                  end
                                                     else
                                                         if (control=#27) then
                                                            clrscr
                                                               else
                                                                   begin
                                                                        gotoxy(45,10);
                                                                        writeln('                                                     ');
                                                                        gotoxy(45,11);
                                                                        writeln('                                              ');
                                                                        gotoxy(45,12);
                                                                        writeln('                                              ');
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

              procedure eliminar_archivo_auto(var arch:t_autos);
              begin
                   erase(arch);
              end;
begin

end.
