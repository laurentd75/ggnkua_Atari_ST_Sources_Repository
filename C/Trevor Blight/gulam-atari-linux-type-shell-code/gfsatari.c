/*
 * $Header: f:/src/gulam\RCS\gfsatari.c,v 1.1 1991/09/10 01:02:04 apratt Exp $ $Locker:  $
 * ======================================================================
 * $Log: gfsatari.c,v $
 * Revision 1.1  1991/09/10  01:02:04  apratt
 * First CI of AKP
 *
 * Revision: 1.7 90.10.24.12.13.46 apratt 
 * Added a feature to tch() which is called by touch() and other
 * places: if negopts['f'] and the file doesn't exist, it's created
 * and then touched.   -- this is non standard:
 * touch always creates a file, unless -c option, when it is not created.
 *
 * 
 * Revision: 1.6 89.06.16.17.23.44 apratt 
 * Header style change.
 * 
 * Revision: 1.5 89.03.09.16.38.44 Author: apratt
 * Fixed setdsk again so it leaves valu nonzero if it started that way.
 * 
 * Revision: 1.4 89.03.09.16.14.34 Author: apratt
 * Fixed setdsk so it doesn't put the drive bits in valu; puts zero
 * there unless Dsetdrv returns and error.
 * 
 * Revision: 1.3 89.02.13.11.18.20 Author: apratt
 * Removed still more string processing from gfgetcwd when mastercwd set.
 * 
 * Revision: 1.2 89.02.13.11.04.10 Author: apratt
 * Added mastercwd: null to begin with, set in gfgetcwd, cleared in cd.
 * If it's not null on entry to gfgetcwd, it's returned as the current dir.
 * 
 * Revision: 1.1 88.06.03.15.38.28 Author: apratt
 * Initial Revision
 * 
 */

/*
	gfsatari.c of Gulam -- OS interface dealing with Disk Files

	copyright (c) 1987 pm@cwru.edu

	The decls in #ifdef .. #else are included (by manually editing)
	in sysdpend.h; they are shown here for doc purposes.
*/

#include "gu.h"

#ifdef STANC
# define P_(s) s
#else
# define P_(s) ()
#endif
local magicclose P_((int i));
#undef P_

#if	!TOS
/* %%	gfsatari.c AtariST version */
#endif

extern	int	fda[];
extern	int	outappend;
extern	uchar *	rednm[];

uchar	DFLNSEP[] = "\r\n";

/* Return the char (ascii) code that denotes the file type given by
the attribute a */

	int
filetp(p, a)
register uchar	*p;
register int	a;
{	register int	c, i;
	register uchar	*q;
	extern   uchar 	ext[];

	c = ' ';
	if (a & 0x06) c = '!';		/* hidden	*/
	if (a & 0x08) c = '#';		/* volume	*/
	if (a & 0x10) c = DSC;		/* dir		*/

	if (q = rindex(p, '.'))
		for (q++, i=0; i < SZext-1; i += 4) 
			if (strcmp(q, ext+i) == 0) return '*';
	return c;
}

/* Convert file atribute a into a readable string and place it at
p[0..13], with p[13] == '\000'.  */

attrstr(a, p)
register int	a;
register uchar *	p;
{
	register uchar	c;

	c = '-';
	if (a & 0x20) c = 'm';
	if (a & 0x10) c = 'd';
	if (a & 0x08) c = 'v';
	if (a & 0x06) c = 'h';
	p[0] = c; 
	p[1] = 'r';
	p[2] = ((a & 0x01)? '-' : 'w');
	strcpy(p+3, "------- 1 "); /* p[3..12] */
}


setdsk(c)		/* set current disk drive to c	*/
register int c;
{
	long vtemp;

	if (('A' <= c) && (c <= 'Z')) c -= 'A';	else
	if (('a' <= c) && (c <= 'z')) c -= 'a';
	vtemp = Dsetdrv(c);
        /* >=0 is no error AKP */
	if (valu == 0) valu = (vtemp >= 0 ? 0 : vtemp);
}

mkdir(p)
register uchar *	p;
{	
	/* Dcreate() succeeds even if there is a regular file with that name */
	valu = (Fsfirst(p, 0xFF)? Dcreate(p) : -1);
}

rmdir(p)
register uchar *p;
{
	valu = Ddelete(p);
	if (valu == -36) emsg = "dir non empty";
}

static uchar *mastercwd = NULL;		/* AKP */

/* Return a ptr to the full path to current directory; includes
current drive. ([ Unless we are at the root of a device, there will be no
trailing \ But if we are, the returned string is of the form a:\ ]) */

	uchar *
gfgetcwd()	
{
	register uchar * cwd, *q;

	/* AKP */
	if (mastercwd != NULL) {
		q = strdup(mastercwd);
		return q;
	}

	if ((cwd = gmalloc(1024)) == NULL) return NULL;

	cwd[0] = Dgetdrv() + 'a'; cwd[1] = ':';
	Dgetpath(&cwd[2], 0);
/**	if (cwd[2] == '\000') {cwd[2] = '\\'; cwd[3] = '\000';} **/
	if (strlen(cwd) >= 1024) panic("gfgetcwd");
	q = lowercase(strdup(cwd)); gfree(cwd);
	mastercwd = strdup(q);		/* AKP */
	return q;
}

cd(p)
register uchar *p;
{
	register uchar	*q, *path;

	if (p == NULL) return;
	q = gfgetcwd(); path = p;
	if (mastercwd != NULL)	/* AKP */
	{   gfree(mastercwd);	/* AKP */
	    mastercwd = NULL;	/* AKP */
	}			/* AKP */
	if ((p[0] != '\000') && (p[1] == ':'))
	{	setdsk(*p);
		if (p[2]) p += 2;
		else p = "\\";
	}
	if (valu >= 0)
	if ((valu = Dsetpath(p)) < 0)
	{	if (q) setdsk(*q); /* back to orig drive */
		emsg = sprintp("could not cd to %s", path);
	}
	if (q) gfree(q);
}

chmod(p)
uchar	*p;
{	register int	attr, ic, i, mask;
	register uchar	*q, *r, *s;
	static uchar	opts[] = "whsvdm";

	attr = 	Fattrib(p, 0, 0);
	q = posopts; r = negopts; s = opts;
	{	ic = (int) 'w';
		if (q[ic]) attr &=  ~ 1;
		if (r[ic]) attr |=    1;
	}
	for (i = 1, mask = 2; i < 6; i++, mask <<= 1)
	{	ic = (int) s[i];
		if (q[ic]) attr |=    mask;
		if (r[ic]) attr &=  ~ mask;
	}
	Fattrib(p, 1, attr);
}

tch(p, td)
register uchar	*p;
register int	*td;
{	register int	fd;

   fd = Fopen(p, 0);
   if (fd < 0) {
       /* option -c means don't create a file */
      if( negopts['c'] ) return;
      fd = Fcreate(p,0);
      if (fd < 0) return;	/* fail completely */
   }
   else {
       Fdatime(td, fd, 1);
   } /* if */
   Fclose(fd);
}

touch(p)
register uchar *p;
{	int		td[2];

	td[0] = Tgettime();	td[1] = Tgetdate();
	tch(p, td);
}

outisredir()	{return (fda[1] > MINFH);}

/* Ouput the string p.  Called via: outstr(p) => streachline(.,
doout).  We do gputs() only because Fwrite() eats type-ahead chars
up.  If fda[1] > MINFH, we must do Fwrite beacuse of output
redirection.  */

doout(dummy, p)
register uchar	*p, *dummy;
{
	if (fda[1] >= MINFH)
	{	Fwrite(1, (long) strlen(p), p);
		Fwrite(1, 2L, CRLF);
	} else
	{	gputs(p); gputs(CRLF);
}	}

/* NB: File/Device handles values are -1, -2, -3 for x = con:, aux:,
prn: and positive numbers for other x when Fopen/Fcreate succeeds.  */

doredirections()
{	register uchar	*p;
	register int	h;
	extern	 uchar	*rednm[];
	extern	 int	fda[];

	fda[0] = fda[1] = MINFH - 1;
	if (p=rednm[0])
	{	fda[0] = Fdup(0);
		fda[2] = Fopen  (p,0); gfree(p); rednm[0] = NULL;
		if (fda[2] >= MINFH) Fforce(0,fda[2]);
	}
	if (p=rednm[1])
	{	fda[1] = Fdup(1); h = -1;
		if (outappend)
		{	h = fda[3] = Fopen(p, 1);
			if (h > 0) Fseek(0L, h, 2);	/* seek to end */
		}
		if (h < 0) fda[3] = Fcreate(p,0);
		gfree(p); rednm[1] = NULL; outappend = 0;
		if (fda[3] >= MINFH) Fforce(1, fda[3]);
}	}


	local
magicclose(i)		/* thanks to Beckmeyer; but, why does this work? */
register int	i;
{	if (fda[i] >= MINFH)
	{	Fclose(i);
		Fforce(i,fda[i]);
		Fclose(fda[i]);
		Fclose(fda[2+i]);
}	}

undoredirections()	/* called from processcmd() of main.c */
{
	magicclose(0); magicclose(1);
}

/* -eof- */
