
#include "..\\include\\lists.h"

/*
** File: sqr_root.c
**
** Obtain truncated integer square root
**
** Copyright (c) 1984 Island Graphics Corporation
*/

/*
** Sqr_root() - Return the integer square root the the long integer i
*/

int
sqr_root(i)
register long	i;
{
    register unsigned long	mask;
    register long t;
    register unsigned WORD	result;
    register long		lt;

    /*
    ** Approximate starting mask value
    */

    for (mask = 1, lt = i; mask < lt; mask <<= 1, lt >>= 1)
	;

    result = 0;

    while (mask)
    {
	t = result | mask;
	if ((t * t) <= i)
	    result = t;
	mask >>= (unsigned int)1;
    }

    return ((int)result);
}

calc_distance(x1,y1,x2,y2)
WORD x1,y1,x2,y2;
{
long delta_x, delta_y;

delta_x = x1 - x2;
delta_y = y1 - y2;

return(sqr_root( (long)(delta_x*delta_x) + (long)(delta_y*delta_y)));
}

