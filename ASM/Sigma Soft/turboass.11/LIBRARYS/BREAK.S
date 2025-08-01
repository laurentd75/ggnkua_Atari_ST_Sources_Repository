;************************************************************************
;* Falls sich ein Programm nicht debuggen l��t (IRQs, etc.), kann man	*
;* an einer kritischen Stelle dieses Modul einbinden. Nach RESET ist es *
;* dann mittels GETREGISTER mgl. die Stelle wiederzufinden (wenn der es *
;* der Debugger �berlebt hat).						*
;* �1989 by �-soft, written by Markus Fritze	       25.06.1988 01:57 *
;************************************************************************
save_base	equ $300	     ;Die Basisadresse ($300.w) ist (fast) will-
;				      k�rlich gew�hlt, aber GETREGISTER nimmt
;				      $300 als Default. Zudem liegt $300
;				      im Reset-festem Speicherbereich, d.h.
;				      falls ein RESET ohne Debugger aus-
;				      gel�st wird, bleiben die Daten er-
;				      halten (Reset-fest ist der Bereich
;				      kleiner $400, allerdings werden Teile
;				      durch Vektoren �berschrieben)

	trap	#3		     ;Trap #3 wird vom Debugger gesetzt. Es zeigt
;				      auf einen RTR, d.h. Es wird in den Super-
;				      visormodus geschaltet. Sonst wird nichts
;				      ge�ndert. Falls man bereits im Supervisor-
;				      modus ist, kann man sich diesen Befehl
;				      sparen.
 
	movem.l d0-d7/a0-a7,save_base ;alle Register retten
	lea	save_base+$40,a0     ;Platz f�r die restlichen Register
	move	sr,12(a0)	     ;SR retten (MOVEM & LEA beeinflussen
;				      das SR nicht!)
	bsr.s	*+2		     ;PC auf den Stack bringen
	nop			     ;2 Byte Mindestdistanz f�r BSR.S
	move.l	(sp)+,(a0)+	     ;PC retten
	move	usp,a1
	move.l	a1,(a0)+	     ;USP und
	move.l	sp,(a0) 	     ;SSP nochmals einzeln retten

;Falls es hier zuende sein soll, folgender Code:
	addq.w	#1,$ffff8240.w	     ;Ab hier flackert der Bildschirm
	bra.s	*-6		     ;nun nur noch RESET dr�cken

;Sonst bitte diesen Code:
	movem.l 32(a0),a0/a1	     ;A0 und A1 wieder zur�ck
	move	save_base+$4C,sr     ;SR auch wieder zur�ck

;Das war's, wenn nun RESET gedr�ckt wird, kann man sich schnell alle Werte
;zur�ckholen (siehe GETREGISTER)
