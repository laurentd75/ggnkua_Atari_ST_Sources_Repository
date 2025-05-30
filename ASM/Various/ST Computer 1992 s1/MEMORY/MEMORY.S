;******************************
; Initialisierungsteil f�rs ACC
;******************************
               lea   STACK(pc),sp      ; der Stapel f�rs ACC

               bsr.s FILA6             ; a6 und a5 =CONTRL, d7=1
               move.w #10,(a5)+        ; 10 Opcode Appl_Init
               move.l d7,(a5)+         ; 0*Intin 1*Intout(d7=1)
               clr.w (a5)+             ; 0*Addrin
               bsr.s AES               ; AES-Aufruf, Register setzen
               move.w INTOUT(pc),APPID-CONTRL(a6) ; Appl.-Nummer merken

               move.w #35,(a5)+        ; 35 Menu_Register
               move.w d7,(a5)+         ; 1*Intin(d7=1)
               move.w d7,(a5)+         ; 1*Intout
               move.w d7,(a5)+         ; 1*Addrin
               move.w APPID(pc),INTIN-CONTRL(a6) ; Applikationsnummer
               move.l #ACCNAME,ADDRIN-CONTRL(a6) ; der ACC-Name
               bsr.s AES               ; AES aufrufen
               move.w INTOUT(pc),ACCID-CONTRL(a6) ; die ACC-Nummer

LOOP:          bsr.s MEVENT            ; auf Ereignis warten
               cmpi.w #40,MSGBUFF-CONTRL(a6) ; ACC Open ?
               bne.s LOOP              ; nein, weiter warten
               move.w MSGBUFF+8(pc),d0 ; die ACC-Nummer
               cmp.w ACCID(pc),d0      ; bin ich gemeint ?
               bne.s LOOP              ; nein, weiter warten
               bsr.s MAIN              ; ja, Hauptroutine abarbeiten
               bra.s LOOP              ; und danach wieder warten

MEVENT:        move.w #23,(a5)+        ; 23 Evnt_Mesag
               move.l d7,(a5)+         ; 0*Intin 1*Intout(d7=1)
               move.w d7,(a5)+         ; 1*Addrin
               move.l #MSGBUFF,ADDRIN-CONTRL(a6) ; Message-Puffer

;*********************
; AES aufrufen
;*********************
AES:           move.l #AESPB,d1        ; Zeiger auf Adressliste
               clr.w (a5)+             ; 0*Addrout
               move.w #$c8,d0          ; Wert f�r AES
               trap #2                 ; aufrufen
FILA6:         lea   CONTRL(pc),a6     ; Zeiger f�r A6
               movea.l a6,a5           ; und A5
               moveq.l #1,d7           ; d7 auf 1 setzen
               rts                     ; fertig mit AES
;****************************
; Der eigentliche Aktionsteil
;****************************
MAIN:          moveq.l #-1,d0          ; Restspeicher erfragen
               move.l d0,-(sp)         ; -1.L auf Stack
               move.w #$48,-(sp)       ; MALLOC
               trap #1                 ; Gemdos
               addq.l #6,sp            ; in D0 Restspeicher
               lea   NUMMER(pc),a4     ; Stringadresse in Alert

PRLONG:        bsr.s LONGNUM           ; in Dezimal wandeln
               move.l #ALTEXT,ADDRIN-CONTRL(a6) ; Text f�r Alarmbox

ALERT:         move.w #52,(a5)+        ; 52 Form Alert
               move.w d7,(a5)+         ; 1*Intin(d7=1)
               move.w d7,(a5)+         ; 1*Intout
               move.w d7,(a5)+         ; 1*Addrin
               move.w d7,INTIN-CONTRL(a6) ; Default Button = 1
               bra.s AES
;**************************************
; Die Dezimal-Umwandlungsroutine
;**************************************
LONGNUM:       moveq.l #7,d4           ; insgesamt 7 Stellen
               move.l #1000,d1         ; zuerst 4-stellig
               moveq.l #(' '-'0'),d2   ; Space erlaubt
               divu.w d1,d0            ; durch 1000
               bsr.s D4TODEZ           ; umwandeln
               swap.w d0               ; Rest in d0.w
               moveq.l #100,d1         ; dann 3-stellig

D4TODEZ:       move.w d0,d3            ; Zahl retten
W1:            ext.l d3                ; auf Lang erweitern
               subq.w #1,d4            ; schon letzte Ziffer ?
               bne.s W2                ; nein
               clr.w d2                ; sonst kein Space erlaubt
W2:            divu.w d1,d3            ; Rest durch Teiler
               beq.s DEZPR1            ; ergab schon 0
               clr.w d2                ; kein Space erlaubt
DEZPR1:        add.b d2,d3             ; Offset zu Space addieren
               addi.b #'0',d3          ; Offset f�r Ascii
               move.b d3,(a4)+         ; ablegen in String
               swap.w d3               ; Rest der Division
               divu.w #10,d1           ; n�chster Teiler
               bne.s W1                ; wenn ungleich 0
               rts                     ; sonst fertig

               .DATA 
ACCNAME:       .DC.b '  Memory',0      ; 2 Spaces vor 'Me...'
ALTEXT:        .DC.b '[0][Memory:'
NUMMER:        .DC.b '        Bytes '  ; 8 Spaces vor 'By...'
               .DC.b '][Ok]',0
               .EVEN 
AESPB:         .DC.l CONTRL,GLOBAL,INTIN,INTOUT,ADDRIN,ADDROUT

               .BSS 
APPID:         .DS.w 1                 ; die Applikationsnummer
ACCID:         .DS.w 1                 ; die ACC-Nummer
MSGBUFF:       .DS.b 16                ; der Nachrichtenpuffer

CONTRL:        .DS.w 1                 ; Opcode der AES-Funktion
               .DS.w 1                 ; Anzahl der Intin-Eintr�ge
               .DS.w 1                 ; Anzahl der Intout-Ausgaben
               .DS.w 1                 ; Anzahl der Addrin-Eintr�ge
               .DS.w 1                 ; Anzahl der Addrout-Ausgaben
GLOBAL:        .DS.w 15
INTIN:         .DS.w 2                 ; Wort-Eingaben
INTOUT:        .DS.w 2                 ; Wort-Ausgaben
ADDRIN:        .DS.l 2                 ; Adre�-Eingaben
ADDROUT:       .DS.l 2                 ; Adre�-Ausgaben
               .DS.b 100               ; Platz f�r Stapel
STACK:         
               .END 

