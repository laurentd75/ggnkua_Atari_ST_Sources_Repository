; Glory Lorry's "Word Up"
;
; Wordwrap ST V.1.3 / Begleitlisting zu "Wrapper's delight" / ST_Magazin
; Laurenz Pr��ner
;
; Ersetzt die Print-Funktion des GFA-BASICs und bricht Worte automatisch
; um. Er erkennt au�erdem falsche Wrap-Werte und gibt Fehlerstati zur�ck.
;
;        Sprache: Assembler
;       Compiler: GFA-Assembler
; Letztes Update: 15.2.89
;
; Aufruf: Variable%=C: <Adresse>(L:<Stringadresse>,<L�nge>, <Wrap>)
;
; R�ckgaben (in Variable%):
;  0 = Alles Ok, String wurde ordnungsgem�� ausgegeben
; -1 = Fehler, keine Ausgabe
;  1 = Wrap unm�glich, da die L�nge des 1. Wort einer Zeile>Wrap ist.
;      Es wurde deshalb nicht umgebrochen und die Worttrennung dem Gemdos
;      �berlassen. Die Ausgabe erfolgt also genau wie "PRINT".

Init:     
          movea.l   (sp)+,a6       ;Return auf a6 schieben.
          move.l    (sp)+,d1       ;d1=String
          move.w    (sp)+,d2       ;d2=L�nge
          move.w    (sp)+,d3       ;d3=Wrap
          movea.l   d1,a5          ;a5 auch String

Null:     move.b    #0,0(a5,d2.w)  ;Da GFA-Basic 2 die 0 nicht richtig setzt!

Vergl:    cmpi.w    #2,d3          ;Wrap<2? Wenn ja, dann mit Fehler
          blt.s     Endfeh         ;abbrechen.
          cmp.w     d2,d3          ;Wenn Wrap-Grenze nicht erreicht,
          bge.s     Auskl          ;String ausgeben & Return.
          bra.s     Wrap           ;Nun mu� ge'wrapped' werden!

Ende:     jmp       (a6)

Endfeh:   move.l    #-1,d0         ;Abbrechen. R�ckgabe "Fehler"
          bra.s     Ende

Auskl:    bsr.s     Ausg           ;String drucken
          lea.l     Ret,a0         ;Daten f�r <<Return>> in a0 laden
          move.l    a0,d1          ;die daten in d1 Kopieren
          bsr.s     Ausg           ;<<Return>>drucken
          move.l    #0,d0          ;R�ckgabe "alles Klar!"
          bra.s     Ende

Ausg:     move.l    d1,-(sp)       ;Stringadresse auf den Stack
          move.w    #9,-(sp)       ;Gemdos 9 vorbereiten
          trap      #1             ;Ab ins TOS
          addq.l    #6,sp          ;Stackpointer wieder auf Ursprung
          rts       

Wrap:     move.l    #0,d4
          move.w    d3,d4          ;Wrap in d4 kopieren
          sub.w     d4,d2          ;Neue L�nge = Alte L�nge-Wrap
          subq.w    #1,d2          ;-1. Neue L�nge in d2 eintragen
Rout:     cmpi.b    #32,0(a5,d4.w) ;ist das Zeichen <<Space>>?
          beq.s     Wrnow          ;Ja=>drucken
          cmpi.w    #0,d4          ;etwa schon am Zeilenanfang?
          beq       Gemum          ;Wenn ja das Wrappen abblasen
          subq.w    #1,d4          ;Wrap um 1 verringern
          addq.w    #1,d2          ;daf�r L�nge um 1 vergr��ern
          bra.s     Rout           ;Nun wieder vergleichen

Wrnow:    move.b    #0,0(a5,d4.w)  ;Adresse+Wrap
          bsr.s     Ausg           ;Raus damit
          lea.l     Ret,a0         ;<<Return>>
          move.l    a0,d1          ;ausdrucken
          bsr.s     Ausg           ;jetzt
          adda.l    d4,a5          ;Adresse+Wrap errechnen und in a5
          addq.l    #1,a5          ;Noch 1 dazu um die 0 zu skippen
          move.l    a5,d1          ;Neue Anfangsadresse eintragen
          bra.s     Vergl          ;Neu vom Anfang an

Gemum:    move.l    a5,d1          ;Wordwrap geht bei diesen Angaben nicht
          bsr.s     Ausg           ;darum schaltet es sich aus,
          lea.l     Ret,a0         ;l��t den String ganz normal vom Gemdos
          move.l    a0,d1          ;ausgeben und alles Wrap-m��ige
          bsr.s     Ausg           ;bleiben lassen.
          move.l    #1,d0          ;Damit das Basic solche F�lle mitkriegt und
          bra.s     Ende           ;darauf reagieren kann,  Status "1" ausgeben.

; Datensegment mit unver�nderlichen Daten

          .EVEN 
Ret:      .DC.b 13,10,0            ;<<Return>> mu� ja auch mal gesetzt werden!

          .END 

