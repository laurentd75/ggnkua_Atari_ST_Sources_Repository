PROGRAM prim2;

CONST n = 1000;
VAR   i,k  : integer;  
      prim : boolean;  
BEGIN
  write(2:4);
  i:=1;
  REPEAT 
    i:=i+2;
    prim := true;
    k:=1;
    REPEAT
     k:=k+2;
     IF i MOD k = 0
       THEN prim := false;
    UNTIL (NOT prim) OR (k>=trunc(sqrt(i)));
    IF prim THEN write (i:4) 
  UNTIL i>=n;
END.

{ Problemstellung :

  Alle Primzahlen von 1 bis 997 sollen ausgegeben werden.
  Dieses Programm ist durch Profilierung optimiert bis zum gehtfastnichtmehr.
  
  Beispiel :
  
  �berpr�fen Sie die ausgegebenen Werte auf Primzahlen.
  
  Besonderheiten :
  
  Schleifenverhalten, Variablenbereiche 
}
  