DEFINITION MODULE FixFiles;

(*                             Von Michael H.                               *)
(*  portiert nach M-2 August '91 von Christian Felsch und Peter Oleski.     *)       
(*  Diese ISAM ist Public Domain und darf von jedem f�r zivile Aufgaben     *)
(*  benutzt werden. Eine Nutzung f�r milit�rische Zwecke ist untersagt !    *)
(*                         Diese ISAM ist Peace-Ware !                      *)
(*                         ---------------------------                      *)
(*  Diese ISAM darf ver�ndert und erweitert werden. Bei guten Erweiterungen *)
(*  und Fehlern benachrichtigung bitte an uns senden.                       *)
(*  Die ISAM hat unsere Platte NICHT zerst�rt aber wir �bernehmen keine     *)
(*  Verantwortung f�r nichts.                                               *)
(*  Wir bitten aber, falls diese ISAM einmal eine Verwendung findet, uns    *)
(*  mit dem Satz ' ISAM by Jau-Team ' zu erw�hnen.                          *)
(*  Wird mit dieser Bibliothek ein kommerzielles Programm erstellt, so ist  *)
(*  uns ein kostenloses Exemplar zuzusenden                                 *)
(*  Zu erreichen unter:                                                     *)
(*                                                                          *)
(*      E-Mail: Peter Oleski        oder   Christian Felsch @ HH (MausNet)  *)
(*  gelbe Post: Ei�endorfergrenzweg 83a     Bevenser Weg 18                 *)
(*                             2100 Hamburg 90                              *)


 (* Modul zur Verwaltung der Datendateien  *)
  
 (* Erl�uterungen zu den zu �bergebenden Variablen:       *)
  
 (*  I  : Eingabewerte vom Benutzer                       *)
 (*  o  : nur interne Statusinformationen werden ge�ndert *)
 (*  O  : relevante Informationen werden zur�ckgeliefert  *)
  
  
 FROM SYSTEM      IMPORT LOC;
 FROM IsamGlobals IMPORT FixFile;


 PROCEDURE FixMake(VAR Datei      : FixFile;               (* O *)
                       FName      : ARRAY OF CHAR;         (* I *)
                       RecLen     : CARDINAL;              (* I *)
                       ZaehlStart : CARDINAL);             (* I *)
                       
  (* Kreiert neue Datendatei, max. Anzahl der Zugriffe in <ZaehlStand< *)
                                                   
                                                      
 PROCEDURE FixOpen(VAR Datei   : FixFile;                  (* O *)
                       FName   : ARRAY OF CHAR;            (* I *)
                       RecLen  : CARDINAL;                 (* I *)
                       MaxCount: CARDINAL);                (* I *)
                       
  (* �ffnet eine Datendatei *)
  

 PROCEDURE FixFlush(VAR Datei : FixFile);                  (* I/o *)
 
  (* F�hrt ein Flush auf Datendatei aus *)
  
 
 PROCEDURE FixClose(VAR Datei : FixFile);                  (* I/o *)
 
  (* Schlie�t eine Datendatei *)
  
 
 PROCEDURE FixErase(VAR Datei : FixFile);                  (* I/o *)
 
  (* L�scht eine Datendatei *)
  

 PROCEDURE FixRename(VAR Datei : FixFile;                  (* I/O *)
                         fNeu  : ARRAY OF CHAR);           (* I *)
                         
  (* Benennt eine Datendatei um *)
  

 PROCEDURE FixNew(VAR Datei  : FixFile;                    (* I/o *)
                  VAR SatzNr : LONGINT);                   (* O *)
                  
  (* Legt einen neuen leeren Datensatz an *)
  

 PROCEDURE FixAdd(VAR Datei  : FixFile;                    (* I/o *)
                  VAR SatzNr : LONGINT;                    (* O *)
                  VAR Buffer : ARRAY OF LOC);              (* I *)
                  
  (* F�gt einen neuen Datensatz in eine Datendatei ein *)


 PROCEDURE FixDel(VAR Datei  : FixFile;                    (* I/o *)
                      SatzNr : LONGINT);                   (* I *)
                      
  (* L�scht einen Datensatz aus einer Datendatei *)


 PROCEDURE FixGet(VAR Datei  : FixFile;                    (* I/o *)
                      SatzNr : LONGINT;                    (* I *)
                  VAR Buffer : ARRAY OF LOC;               (* O *)
                      Anz    : CARDINAL);                  (* I *)
                      
  (* Liest <Anz>  Datens�tze aus einer Datendatei *)


 PROCEDURE FixPut(VAR Datei  : FixFile;                    (* I/o *)
                      SatzNr : LONGINT;                    (* I *)
                  VAR Buffer : ARRAY OF LOC);              (* I *)
                  
  (* Schreibt einen Datensatz in eine Datendatei *)


 PROCEDURE FixSize(VAR Datei : FixFile): LONGINT;          (* I *)
 
  (* Liefert gesamte Gr��e einer Datendatei in Bytes *)


 PROCEDURE FixTotal(VAR Datei : FixFile) : LONGINT;        (* I *)
 
  (* Liefert Anzahl aller Datens�tze (benutzt und unbenutz), inkl. Status *)


 PROCEDURE FixUsed(VAR Datei : FixFile) : LONGINT;         (* I *)
 
  (* Liefert Anzahl der benutzten Datens�tze *)


 PROCEDURE FixCounter(VAR Datei : FixFile) : CARDINAL;     (* I *)
 
  (* Liefert den Z�hlerstand f�r Demo-Version *)


 PROCEDURE FixRecSize(DateiName : ARRAY OF CHAR) : LONGINT; (* I *)
 
  (* Liefert die Gr��e eines Datensatzes in Bytes *)


 PROCEDURE FixflushAll;


END FixFiles.