*** BOOT2 ATROCITY / ATLANTIDE ***
***        BY ZANAK           ***
	
;	CLR.L	-(SP)
;	MOVE.W	#$20,-(SP)
;	TRAP	#1
;	ADDQ.L	#6,SP
	
;FALCON_2	MOVE.L	#$0F0F0F0F,$FFFF8240.W
;	LEA.L	$FFFF8240.W,A0
;	MOVE.W	#$F,D0
;FALCON_11	SUB.L	#$01010101,(A0)
;	DBF	D0,FALCON_11
;	MOVE.L	#$0F0F0F0F,$FFFF825E.W
	
	LEA	TEXTE_BOOT2(PC),A1	
	MOVE.L	A1,-(SP)
	MOVE.W	#9,-(SP)
	TRAP	#1
	ADDQ.L	#6,SP
	
;	CLR.L	-(SP)
;	TRAP	#1
	
	RTS
	
TEXTE_BOOT2	
	
	DC.B	27,"E"
	DC.B	"           - ATROCITY -         ",10,13
	DC.B	"     A L'AUBE DU MATIN DU SOIR 2",10,13,10,13,10,13,10,13
	DC.B	"      PLEASE WAIT - LOADING ... ",10,13,10,13,0
	
	EVEN
	
	