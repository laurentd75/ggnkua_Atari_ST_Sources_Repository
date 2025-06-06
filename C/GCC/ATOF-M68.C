/* atof_m68k.c - */

/* Copyright (C) 1987 Free Software Foundation, Inc.

This file is part of Gas, the GNU Assembler.

The GNU assembler is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY.  No author or distributor
accepts responsibility to anyone for the consequences of using it
or for whether it serves any particular purpose or works at all,
unless he says so in writing.  Refer to the GNU Assembler General
Public License for full details.

Everyone is granted permission to copy, modify and redistribute
the GNU Assembler, but only under the conditions described in the
GNU Assembler General Public License.  A copy of this license is
supposed to have been given to you along with the GNU Assembler
so you can know your rights and responsibilities.  It should be
in a file named COPYING.  Among other things, the copyright
notice and this notice must be preserved on all copies.  */

#include "flonum.h"

extern FLONUM_TYPE generic_floating_point_number; /* Flonums returned here. */
#define NULL (0)

extern char EXP_CHARS[];
				/* Precision in LittleNums. */
#define MAX_PRECISION (6)
#define F_PRECISION (2)
#define D_PRECISION (4)
#define X_PRECISION (6)
#define P_PRECISION (6)

				/* Length in LittleNums of guard bits. */
#define GUARD (2)

int				/* Number of chars in flonum type 'letter'. */
atof_sizeof (letter)
     char letter;
{
  int	return_value;

  /*
   * Permitting uppercase letters is probably a bad idea.
   * Please use only lower-cased letters in case the upper-cased
   * ones become unsupported!
   */
  switch (letter)
    {
    case 'f':
    case 'F':
    case 's':
    case 'S':
      return_value = F_PRECISION;
      break;

    case 'd':
    case 'D':
    case 'r':
    case 'R':
      return_value = D_PRECISION;
      break;

    case 'x':
    case 'X':
      return_value = X_PRECISION;
      break;

    case 'p':
    case 'P':
      return_value = P_PRECISION;
      break;

    default:
      return_value = 0;
      break;
    }
  return (return_value);
}

static unsigned long int mask [] = {
  0x00000000,
  0x00000001,
  0x00000003,
  0x00000007,
  0x0000000f,
  0x0000001f,
  0x0000003f,
  0x0000007f,
  0x000000ff,
  0x000001ff,
  0x000003ff,
  0x000007ff,
  0x00000fff,
  0x00001fff,
  0x00003fff,
  0x00007fff,
  0x0000ffff,
  0x0001ffff,
  0x0003ffff,
  0x0007ffff,
  0x000fffff,
  0x001fffff,
  0x003fffff,
  0x007fffff,
  0x00ffffff,
  0x01ffffff,
  0x03ffffff,
  0x07ffffff,
  0x0fffffff,
  0x1fffffff,
  0x3fffffff,
  0x7fffffff,
  0xffffffff
  };

static int
next_bits (number_of_bits, address_of_bits_left_in_littlenum, address_of_littlenum_pointer)
     int		number_of_bits;
     int *		address_of_bits_left_in_littlenum;
     LITTLENUM_TYPE **	address_of_littlenum_pointer;
{
  int			return_value;

  if (number_of_bits >= (* address_of_bits_left_in_littlenum))
    {
      return_value  = mask [(* address_of_bits_left_in_littlenum)] & * (* address_of_littlenum_pointer);
      number_of_bits -= (* address_of_bits_left_in_littlenum);
      return_value <<= number_of_bits;
      (* address_of_bits_left_in_littlenum) = LITTLENUM_NUMBER_OF_BITS - number_of_bits;
      (* address_of_littlenum_pointer) --;	/* JF was --, how could it
						   possibly work! */
      return_value |= ( (* (* address_of_littlenum_pointer)) >>
                      ((* address_of_bits_left_in_littlenum)) ) & mask [number_of_bits];
    }
  else
    {
      (* address_of_bits_left_in_littlenum) -= number_of_bits;
      return_value = mask [number_of_bits] & ( (* (* address_of_littlenum_pointer)) >> (* address_of_bits_left_in_littlenum));
    }
  return (return_value);
}

static void
make_invalid_floating_point_number (words)
     LITTLENUM_TYPE *	words;
{
	words[0]= ((unsigned)-1)>>1;	/* Zero the leftmost bit */
	words[1]= -1;
	words[2]= -1;
	words[3]= -1;
	words[4]= -1;
	words[5]= -1;
}
f,>ff,a ffff,_PREer_umbe}
           