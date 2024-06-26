;
; Attendre plusieurs �v�nements simultan�ment
; Assembler           MULTI.ASM
;

gemdos         = 1
crawcin        = 7
cconws         = 9

               .INCLUDE 'GEM_INEX.ASM'

               .TEXT 

main:          jsr        gem_init

               pea        message       ;Afficher message
               move.w     #cconws,-(sp)
               trap       #gemdos
               addq.l     #6,sp

; Appeler evnt_multi

               move.w     #25,control   ;Opcode de fonction
               move.w     #16,control+2
               move.w     #7,control+4
               move.w     #1,control+6
               clr.w      control+8

               move.w     #33,int_in    ;Combinaison d'�v�nements (octets 0 et 5)
               move.w     #3000,int_in+28         ;Valeur low pour le timer
               clr.w      int_in+30     ;Valeur high (en millisecondes)

               jsr        aes

               cmpi.w     #1,int_out    ;Quel �v�nement s'est
               bne.s      time          ;r�ellement produit?
               pea        a_touche
               bra.s      l
time:          pea        a_time

l:             move.w     #cconws,-(sp)
               trap       #gemdos
               addq.l     #6,sp

               move.w     #crawcin,-(sp)          ;Attendre touche...
               trap       #gemdos
               addq.l     #2,sp

               jsr        gem_exit

               clr.w      -(sp)
               trap       #gemdos

               .DATA 

message:       .DC.b 27," Tapez n'importe quelle touche. Si vous ne tapez "
               .DC.b 'pas de touche dans les ',13,10,'3 secondes, le '
               .DC.b 'programme',13,10,'sera interrompu.',13,10,10,0

a_touche:      .DC.b 'Taper une touche pour quitter',13,10,0

a_time:        .DC.b 'Quitte dans 3 secondes',13,10,0

               .END 
