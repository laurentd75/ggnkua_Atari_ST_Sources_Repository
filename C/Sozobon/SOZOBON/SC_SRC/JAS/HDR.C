
/*
 * Copyright (c) 1988 by Sozobon, Limited.  Author: Joseph M Treat
 *
 * Permission is granted to anyone to use this software for any purpose
 * on any computer system, and to redistribute it freely, with the
 * following restrictions:
 * 1) No charge may be made other than reasonable charges for reproduction.
 * 2) Modified versions must be clearly marked as such.
 * 3) The authors are not responsible for any harmful consequences
 *    of using this software, even if they result from defects in it.
 */

#include "jas.h"

/* for megamax */
#define entry _entry

typedef struct {
	int magic;
	long tsize;
	long dsize;
	long bsize;
	long ssize;
	long stksize;
	long entry;
	int rlbflg;
} HEADER;

#define MAGIC	0x601a
#define SYMSIZE	14

headers()
{
	HEADER header;
	extern long txtsize, datsize, bsssize, nsyms;

	header.magic = MAGIC;
	header.tsize = txtsize;
	header.dsize = datsize;
	header.bsize = bsssize;
	header.ssize = nsyms * SYMSIZE;
	header.stksize = 0L;
	header.entry = 0L;
	header.rlbflg = 0;

	output( (char *) &header, sizeof header, 1 );
}
