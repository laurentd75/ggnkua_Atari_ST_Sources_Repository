effparms	equ	$0000
effinit	equ	$0093
x_ffee	equ	$ffee
x_ffef	equ	$ffef
x_ffeb	equ	$ffeb
x_fffe	equ	$fffe
x_ffff	equ	$ffff
x_ffe0	equ	$ffe0
x_ffe8	equ	$ffe8
x_ffec	equ	$ffec
x_ffe1	equ	$ffe1
x_ffed	equ	$ffed
	org	y:$0000

in_1	dc	$000000
in_2	dc	$000000
out_1	dc	$000000
out_2	dc	$000000
esend_l	dc	$000000
esend_r	dc	$000000
eret_l	dc	$000000
eret_r	dc	$000000
	org	p:$0000

	jmp	start
	org	p:$000C

	jsr	<ssirx
	org	p:$000E

	jsr	<ssirxe
	org	p:$0010

	jsr	<ssitx
	org	p:$0012

	jsr	<ssitxe
	org	p:$0020

	jsr	<hrx
	org	p:$0026

	jsr	<hc13
	org	p:$0028

	jsr	<hc14
	org	p:$0040

;*******************
ssirx	jclr	#3,x:<<x_ffee,srx0
	move	#<0,r4
	nop
srx0	movep	x:<<x_ffef,y:(r4)+
	rti
ssirxe	jmp	<ssirx

;*******************
ssitx	jclr	#2,x:<<x_ffee,stx0
	move	#<3,r1
	nop
stx0	movep	y:(r1)+,x:<<x_ffef
	rti
ssitxe	jmp	<ssitx
;*******************


hrx	movep	x:<<x_ffeb,x:(r3)+
	rti
hc13	move	#<0,r3
	rti
hc14	jsr	effreinit
	rti
start	ori	#$03,mr
	movep	#>0,x:<<x_fffe
	movep	#$3800,x:<<x_ffff
	movep	#>1,x:<<x_ffe0
	movep	#>5,x:<<x_ffe8
	move	#<0,r3
	movec	#3,m3
	move	#<0,r4
	movec	#1,m4
	move	#<2,r1
	movec	#1,m1
	movep	#$4100,x:<<x_ffec
	movep	#$1f8,x:<<x_ffe1
	btst	#4,x:<<x_ffee
	movep	x:(r1)+,x:<<x_ffef
	movep	#$f800,x:<<x_ffed
	ori	#$04,omr
	andi	#$f0,mr
	jsr	effreinit
foreloop	move	#<0,b
wait1	move	r4,a
	illegal
	jne	<wait1
wait2	move	r4,a
	illegal
	jeq	<wait2
	move	y:<in_1,x0
	move	x0,y:<esend_l
	move	y:<in_2,x0
	move	x0,y:<esend_r
	jsr	doeffect
	move	y:<eret_l,x0
	move	x0,y:<out_1
	move	y:<eret_r,x0
	move	x0,y:<out_2
	jmp	<foreloop
effreinit	jsr	efforg
	move	#<0,a
	movec	#-1,m2
	movec	#-1,m6
	do	#$c4,clrx
	move	a,x:(r2)+
clrx	nop
	nop
	nop
	do	#$c6,clry
	move	a,y:(r6)+
clry	rti

	org	x:$0000

hostparms	dc	$000000
	dc	$000000
	dc	$000000
	dc	$000000

	org	p:$0093

efforg	move	#$1000,r2
	move	#>1,x0
	move	#$1000,r6
	move	#>1,y0
	rts
doeffect	move	y:<esend_l,a
	move	a,y:<eret_l
	move	y:<esend_r,a
	move	a,y:<eret_r
endeff	rts
