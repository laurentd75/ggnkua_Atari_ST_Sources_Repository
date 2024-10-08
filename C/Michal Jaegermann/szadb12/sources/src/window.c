/* Copyright (c) 1990 by Sozobon, Limited.  Authors: Johann Ruegg, Don Dugger
 *
 * Permission is granted to anyone to use this software for any purpose
 * on any computer system, and to redistribute it freely, with the
 * following restrictions:
 * 1) No charge may be made other than reasonable charges for reproduction.
 * 2) Modified versions must be clearly marked as such.
 * 3) The authors are not responsible for any harmful consequences
 *    of using this software, even if they result from defects in it.
 *
 *	window.c
 */
/*
 * Modifications:
 *  - w_nl rewritten to allow recording of display lines in a transcript
 *    file
 *  - small mods to speedup scrolling
 *     Michal Jaegermann, May 1990
 */
#include "adb.h"
#include "lang.h"

char            scrbuf[0x80ff];
char           *screen;
long            oscreen;
int             mywindow;
int             ucolor0, ucolor1;
int             opcode_pos = ALIGN_A;
char            linbuf[84];	/* length has to be divisible by 4 and has to
				 * agree with assembler coded function
				 * cleanlb() */

extern int      trid;
extern char    *trname;
extern w_buf   *trbuf;
extern void     cleanlb ();
extern int      l_restart, w_restart, lb_fill;
extern char    *lbuf;

winopen ()
{
    long            xbios ();


    screen = scrbuf;
    screen += 0xff;
    screen = (char *) ((long) screen & ~0xffL);

    oscreen = xbios (2);
    xbios (5, -1L, screen, -1);
    ucolor0 = xbios (7, 0, 0);
    ucolor1 = xbios (7, 1, 0x777);
    w_init ();
    mywindow = 1;
}

winswtch ()
{
    long            xbios ();

    if (mywindow) {
	xbios (5, -1L, oscreen, -1);
	xbios (7, 0, ucolor0);
	xbios (7, 1, ucolor1);
    }
    else {
	oscreen = xbios (2);
	xbios (5, -1L, screen, -1);
	ucolor0 = xbios (7, 0, 0);
	ucolor1 = xbios (7, 1, 0x777);
    }
    mywindow = !mywindow;
}

winclose ()
{
    if (mywindow)
	winswtch ();
}


putchr (c)
    char            c;
{
    w_curs (0);
    /* c &= 0x7f;  */
    switch (c) {
    case '\b':
	w_bs ();
	break;
    case '\t':
	w_tab ();
	break;
    case '\n':
	w_nl ();
	break;
    default:
	w_put (c);
	break;
    }
    w_curs (1);
}

struct window {
    short           cols, lines;
    short           curc, curl;
    short           res;
    short           fontsz;
    short           csz, lsz, fsz;
    char           *font;
}               w;

char           *bw_font;
char           *c_font;

w_init ()
{
    int             w_res;
    long            fontsp, getfonts ();
    long            t;

    fontsp = getfonts ();

    t = fontsp + 4;
    t = *(long *) t;
    t += 0x4c;
    c_font = *(char **) t;

    t = fontsp + 8;
    t = *(long *) t;
    t += 0x4c;
    bw_font = *(char **) t;

    w.curc = w.curl = 0;

    w.res = xbios (4);
    switch (w.res) {
    case 0:
	w.cols = 40;
	w.lines = 25;
	w.csz = 8;
	w.lsz = 4 * 40 * 8;
	w.fsz = 4 * 40;
	w.fontsz = 8;
	w.font = c_font;
	opcode_pos = 4;		/* print in the next line with an indent */
	break;
    case 1:
	w.cols = 80;
	w.lines = 25;
	w.csz = 4;
	w.lsz = 2 * 80 * 8;
	w.fsz = 2 * 80;
	w.fontsz = 8;
	w.font = c_font;
	break;
    case 2:
	w.cols = 80;
	w.lines = 25;
	w.csz = 2;
	w.lsz = 1 * 80 * 16;
	w.fsz = 1 * 80;
	w.fontsz = 16;
	w.font = bw_font;
	break;
    }
    w_curs (1);
}

w_put (c)
    char            c;
{
    register int    i;
    register char  *fp;
    register char  *tp;
    int             woff, horl;

    linbuf[w.curc] = c;
    tp = screen;
    horl = w.curc & 1;
    woff = w.curc >> 1;
    tp += woff * w.csz + horl;
    tp += w.curl * w.lsz;

    fp = &w.font[c];
    for (i = 0; i < w.fontsz; i++) {
	*tp = *fp;
	tp += w.fsz;
	fp += 256;
    }
    w.curc++;
    if (w.curc >= w.cols)
	force_nl ();
}

w_curs (flg)
{
    int             i;
    char           *tp;
    int             woff, horl;
    char            val;

    tp = screen;
    horl = w.curc & 1;
    woff = w.curc >> 1;
    tp += woff * w.csz + horl;
    tp += w.curl * w.lsz;

    val = flg ? 0xff : 0;

    for (i = 0; i < w.fontsz; i++) {
	*tp = val;
	tp += w.fsz;
    }
}

w_bs ()
{
    if (w.curc > w_restart) {
	--w.curc;
	w_put (' ');
    }
    w.curc = w_restart;
    prt (&lbuf[l_restart]);
}

optnl ()
{
    if (w.curc) {
	w_curs (0);
	w_nl ();
	w_curs (1);
    }
}

align (n)
{
    w_curs (0);
    if (n >= w.cols) {
	n = (n % w.cols);
	force_nl ();
    }
    else if (w.curc > n) {
	force_nl ();
    }
    w.curc = n;
    w_curs (1);
}

tab (n)
{
    w_curs (0);
    w.curc += n;
    w.curc -= (w.curc % n);
    if (w.curc >= w.cols)
	force_nl ();
    w_curs (1);
}

w_tab ()
{
    w.curc += 10;
    w.curc -= (w.curc % 10);
    if (w.curc >= w.cols)
	force_nl ();
}

w_nl ()
{
    extern void     trclose ();
    extern int      (*trout) ();

    if (trid != NO_TRANS) {	/* send a current screen line to transcript */
	linbuf[w.curc] = '\r';
	linbuf[w.curc + 1] = '\n';
	if (0 > (*trout) (trid, linbuf, (w.curc + 2))) {
	    if ((w_buf *) 0 == trbuf)
		/* prtf("\nerror on write to %s\n", trname); */
		prtf (MW, trname);
	    trclose ();
	}
    }
    w.curc = 0;
    w.curl++;
    if (w.curl >= w.lines) {
	w_scrup ();
	w.curl = w.lines - 1;
    }
    cleanlb ();
}

force_nl ()
{
    w_restart = 0;
    l_restart = lb_fill;
    w_nl ();
}

w_scrup ()
{
    register char  *fr, *to, *clr;
    register        cnt;

    clr = fr = to = screen;
    fr += w.lsz;
    cnt = w.lsz * (w.lines - 1);
    clr += cnt;
    lcopy (fr, to, cnt / 16);
    cnt = w.lsz;
    while (cnt--)
	*clr++ = 0;
}

#ifdef HELP

char            linesv[80 * 16];

w_help (flag)
{
    static int      svcol;
    char           *tp;

    if (flag == 0) {
	w_curs (0);
	tp = screen;
	tp += w.curl * w.lsz;
	lcopy (tp, linesv, w.lsz / 16);
	svcol = w.curc;
	w.curc = w.cols - 40;
    }
    else {
	w.curl = w.lines - 1;
	tp = screen;
	tp += w.curl * w.lsz;
	lcopy (linesv, tp, w.lsz / 16);
	w.curc = svcol;
	w_curs (1);
    }
}

w_hline (n)
{
    w.curl = n;
    w.curc = w.cols - 40;
}

w_hchr (c)
    char            c;
{
    w_put (c);
}
#endif HELP
