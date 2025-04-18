/************************************************************************
*									*
* The SB-Prolog System							*
* Copyright SUNY at Stony Brook, 1986; University of Arizona, 1987	*
*									*
************************************************************************/

/*-----------------------------------------------------------------
SB-Prolog is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY.  No author or distributor
accepts responsibility to anyone for the consequences of using it
or for whether it serves any particular purpose or works at all,
unless he says so in writing.  Refer to the SB-Prolog General Public
License for full details.

Everyone is granted permission to copy, modify and redistribute
SB-Prolog, but only under the conditions described in the
SB-Prolog General Public License.   A copy of this license is
supposed to have been given to you along with SB-Prolog so you
can know your rights and responsibilities.  It should be in a
file named COPYING.  Among other things, the copyright notice
and this notice must be preserved on all copies. 
------------------------------------------------------------------ */
/* tio.c */

#include "builtin.h"

b_0()
{
   printterm(reg[2], CAR); 
}


b_1()    /* ?? I don't understand this?? */
{
   register LONG     op2;
   register LONG_PTR top;

   op2 = reg[2];
bdr: 
   switch (TAG(op2)) {
      case FREE: NDEREF(op2, bdr);
      case CS  :
      case LIST: ERROR(3);
                 break;
      case NUM : printf("%c", INTVAL(op2));
                 break;
   }
}
