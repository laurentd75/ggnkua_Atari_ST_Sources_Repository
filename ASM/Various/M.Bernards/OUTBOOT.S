section text

pea	msg1		; start mit meldung
	move.w	#9,-(a7)
	trap	#1
	addq.l	#6,a7
	move.w	#7,-(a7)
	trap	#1
	addq.l	#2,a7
	
	clr.w	-(a7)		; lese Bootsektor
	clr.w	-(a7)
	move.w	#1,-(a7)
	pea	buffer(pc)
	move.w	#2,-(a7)
	move.w	#4,-(a7)
	trap	#13
	lea	14(a7),a7
	
	lea	buffer(pc),a0	; eigener Code �bertragen
	move.w	#$6038,(a0)
	lea	$3a(a0),a0
	lea	mycode(pc),a1
	move.w	#endcod-mycode,d0
	lsr.w	#1,d0
loop:	move.w	(a1)+,(a0)+
	dbra	d0,loop
	
	move.w	#1,-(a7)	; Protobt : Bootsektor generieren
	move.w	#-1,-(a7)
	move.l	#-1,-(a7)
	pea	buffer(pc)
	move.w	#18,-(a7)
	trap	#14
	lea	14(a7),a7
	
	clr.w	-(a7)		; und schreiben
	clr.w	-(a7)
	move.w	#1,-(a7)
	pea	buffer(pc)
	move.w	#3,-(a7)
	move.w	#4,-(a7)
	trap	#13
	lea	14(a7),a7
	
	clr.w	-(a7)
	trap	#1
	
mycode: pea	msg(pc)
	move.w	#9,-(a7)
	trap	#1
	addq.l	#6,a7
	rts
msg:	dc.b	7,'>>Diskette ohne Virus<< ST-Magazin 1988',13,10,7,0
endcod:
	section data
msg1:	dc.b	'Bootsektor vor Viren sch�tzen! ',189,'`88 by M.Bernards',13,10
	dc.b	'Insert Disk in Drive A: and press any key ',0

	section bss
	even
buffer	ds.w	256

                   