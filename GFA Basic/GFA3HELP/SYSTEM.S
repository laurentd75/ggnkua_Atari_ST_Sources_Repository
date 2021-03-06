 ;-----------------------------------------------------------.
 ; AUTO-FONTLOADER (SEKA-Sourcecode)                         |
 ; von Marcus Bode, 3200 Hildesheim                          |
 ;-----------------------------------------------------------|
 begin:               ; ** Programm initialisieren **        |
   move.l     a7,a5   ; Stackpointer in A5 puffern           |
   move.l   4(a5),a5  ; Basepage-Anfang holen                |
   move.l   $c(a5),d0 ; Programm-L�nge holen                 |
   add.l    $14(a5),d0 ;DATA-Bereich addieren                |
   add.l    $1c(a5),d0 ;BSS-Bereich addieren                 |
   add.l    #$100,d0  ; $100 Bytes f�r Basepage addieren     |
   move.l   d0,laenge ; Gesamtl�nge puffern                  |
 ;-----------------------------------------------------------|
 super:               ; ** Supervisor Mode einschalten **    |
   clr.l    -(sp)     ; User Stack wird Supervisor Stack     |
   move.w   #$20,-(sp) ;SUPER-Opcode �bergeben               |
   trap     #1        ; GEMDOS aufrufen                      |
   add.l    #6,sp     ; Stack aufr�umen                      |
   move.l   d0,oldssp ; alten Supervisor-Stack puffern       |
   move.l   $42e,a0   ; RAM-Endadresse holen, ...            |
   sub.l    #4,a0     ; ...Minus-Offset (4 Byte) und...      |
   move.l   #buf,(a0) ; ...Puffer-Adresse dorthin schreiben  |
 ;-----------------------------------------------------------|
 open:                ; ** Font-Datei �ffnen **              |
   move.w   #2,-(sp)  ; Dateiattribut �bergeben              |
   pea      filename  ; Filenamen-Adresse �bergeben          |
   move.w   #$3d,-(sp) ;OPEN-Opcode �bergeben                |
   trap     #1        ; GEMDOS aufrufen                      |
   addq.l   #8,sp     ; Stack aufr�umen                      |
   tst.l    d0        ; Fehler aufgetreten ?                 |
   bmi      break     ; Ja, dann alles abbrechen !           |
 ;-----------------------------------------------------------|
 read:                ; ** Font-Datei einlesen **            |
   move.w   d0,handle ; File-Handle zwischenspeichern        |
   pea      buf       ; Fontpuffer-Adresse �bergeben         |
   move.l   #4698,-(sp) ; Systemfont-L�nge �bergeben         |
   move.w   handle,-(sp) ;File-Handle �bergeben              |
   move.w   #$3f,-(sp) ; READ-Opcode �bergeben               |
   trap     #1        ; GEMDOS aufrufen                      |
   add.l    #12,sp    ; Stack aufr�umen                      |
   tst.l    d0        ; Fehler aufgetreten ?                 |
   bmi      break     ; Ja, dann alles abbrechen !           |
 ;-----------------------------------------------------------|
 close:               ; ** Font-Datei wieder schlie�en **    |
   move.w   handle,-(sp) ; File-Handle �bergeben             |
   move.w   #$3e,-(sp) ; CLOSE-Opcode �bergeben              |
   trap     #1        ; GEMDOS aufrufen                      |
   addq.l   #4,sp     ; Stack aufr�umen                      |
   tst.l    d0        ; Fehler aufgetreten ?                 |
   bmi      break     ; Ja, dann alles abbrechen !           |
 ;-----------------------------------------------------------|
 change:              ; ** Vektoren �ndern **                |
   move.l   #buf+$25a,$607e ; neue Font-Adresse in Header    |
   move.w   #32,d0    ; 8 m�gliche VBL-Routinen mal 4 Bytes  |
   move.l   #$4ce,a0  ; Startadresse der VBL-Routinen holen  |
   move.w   #4,d1     ; erste VBL-Routine �berspringen       |
 ;-----------------------------------------------------------|
 loop:                ; ** freien VBL-Vektor suchen **       |
   tst.l    (a0,d1)   ; testen, ob Routine benutzt wird      |
   beq      free      ; Nein, dann Suche abbrechen           |
   addq     #4,d1     ; sonst n�chste VBL-Routine            |
   cmp      d0,d1     ; schon alle Routinen getestet ?       |
   bne      loop      ; Nein, dann weitersuchen              |
 ;-----------------------------------------------------------|
 error:               ; ** Error-Exit der Suchroutine **     |
   move.l   #0,laenge ; Gesamtl�nge auf Null setzen          |
   bra      fertig    ; Alle Routinen getestet!              |
 ;-----------------------------------------------------------|
 break:               ; ** Error-Exit der Diskroutinen **    |
   move.l   #0,d0     ; Gesamtl�nge auf Null setzen          |
   bra      fertig    ; Programm beenden                     |
 ;-----------------------------------------------------------|
 free:                ; ** freie Routine gefunden **         |
   lea      (a0,d1),a2 ;Adresse der freien VBL-Routine holen |
   move.l   a2,vbl    ; Adresse zwischenspeichern            |
   move.l   #instal,(a2) ; VBL-Vektor auf User-Routine setzen|
 ;-----------------------------------------------------------|
 fertig:              ; ** zur�ck in User Mode **            |
   move.l   oldssp,-(sp) ; alten Supervisor Stack holen      |
   move.w   #$20,-(sp)   ; SUPER-Opcode �bergeben            |
   trap     #1        ; GEMDOS aufrufen                      |
   add.l    #6,sp     ; Stack aufr�umen                      |
   move.l   laenge,d0 ; Gesamtl�nge zur�ckholen              |
 ;-----------------------------------------------------------|
 ende:                ; ** Programm beenden **               |
   move.w   #0,-(sp)  ; Fehlercode 0 �bergeben               |
   move.l   d0,-(sp)  ; Gesamtl�nge �bergeben                |
   move.w   #$31,-(sp) ;KEEP PROCESS-Opcode �bergeben        |
   trap     #1        ; GEMDOS aufrufen (zur�ck zum Desktop) |
 ;-----------------------------------------------------------|
 instal:              ; ** VBL-Interrupt-Routine **          |
   cmpi.l   #buf+$25a,$607e ; Fontdaten-Zeiger ver�ndert ?   |
   beq      weiter    ; Nein, dann weiter pr�fen             |
   move.l   #buf+$25a,$607e;sonst neue Fontdaten-Adresse in..|
   move.l   #buf+$25a,$2924;..TOS-/GEM-Fontvektoren eintragen|
   move.l   vbl,a0    ; Adresse der User-VBL-Routine holen   |
   clr.l    (a0)      ; User-VBL-Routine l�schen             |
 ;-----------------------------------------------------------|
 weiter:              ; ** VBL-Routine beenden **            |
   rts                ; R�cksprung                           |
 ;-----------------------------------------------------------|
 filename:  dc.b 'system*.fnt',0 ; Filename des neuen Fonts  |
 handle:    blk.w 1   ; Speicher f�r File-Handle             |
 laenge:    blk.l 1   ; Speicher f�r Gesamtl�nge             |
 vbl:       blk.l 1   ; Speicher f�r VBL-Adresse             |
 oldssp:    blk.l 1   ; Speicher f�r Supervisor Stack        |
 buf:       blk.b 5000 ;Speicher f�r neuen Systemfont        |
 ;-----------------------------------------------------------'
