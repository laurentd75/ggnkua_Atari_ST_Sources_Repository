/* Copyright (c) 1988 by Sozobon, Limited.  Author: Tony Andrews
 *
 * Permission is granted to anyone to use this software for any purpose
 * on any computer system, and to redistribute it freely, with the
 * following restrictions:
 * 1) No charge may be made other than reasonable charges for reproduction.
 * 2) Modified versions must be clearly marked as such.
 * 3) The authors are not responsible for any harmful consequences
 *    of using this software, even if they result from defects in it.
 */

static	char	Version[] =
"cc: version 1.01  Copyright (c) 1988 by Sozobon, Limited.";

/*
 * cc - C compiler driver program
 *
 * Parses command line for options and file names. Then calls the
 * various passes of the compiler as needed.
 */

#include <stdio.h>
#include <fcntl.h>
#include <osbind.h>

/*
 * This is the amount of space to grab from TOS at a time for
 * malloc(). The default is 64K which wastes space if you don't
 * need much. Since we spawn sub-programs from cc, it's important
 * to leave as much memory for them as possible.
 */
long	_BLKSIZ = 4096;

#ifndef	TRUE
#define	FALSE	(0)
#define	TRUE	!FALSE
#endif

#define	MAXOPT	16	/* max. number of options to any one pass */

/*
 * Standard filename extensions
 */
#define	EXSUF	".ttp,.tos,.prg"	/* suffixes for executables */
#define	LIBSUF	".a,.lib"		/* libraries */

/*
 * Compiler pass information
 */
#define	CC	"hcc"

char	*hccopt[MAXOPT];
int	hcc_cnt = 0;		/* number of options to hcc */

/*
 * Optimizer information
 */
#define	OPT	"top"
#define	OTMP	"top_tmp.s"

/*
 * Assembler information
 */
#define	ASM	"jas"			/* default assembler */
#define	ASMD	"as68symb.dat"		/* assembler data file (as68 only) */

/*
 * Loader information
 */
#define	LD	"ld"
#define	LTMP	"ldfile.tmp"		/* loader command file */

#define	CSU	"dstart.o"		/* C startup code */
#define	PCSU	"pdstart.o"		/* profiling startup code */

#define	LIBC	"dlibs"			/* C runtime library */
#define	PLIBC	"pdlibs"		/* profiled runtime library */

#define	LIBM	"libm"			/* math library */
#define	PLIBM	"plibm"			/* profiled math library */

/*
 * Path information
 */

char	*path;		/* where to find executables */
char	*lib;		/* where to find library stuff */
char	*tmp;		/* where to put temporary files */

/*
 * Default paths for executables and libraries
 *
 * Always check the root of the current drive first.
 */
#define	DEFPATH		"\\bin,\\sozobon\\bin"
#define	DEFLIB		"\\lib,\\sozobon\\lib"
#define	DEFTMP		""

/*
 * Boolean options
 */
int	mflag = 0;	/* generate a load map */
int	vflag = 0;	/* show what we're doing w/ version numbers */
int	nflag = 0;	/* ...but don't really do it */
int	Sflag = 0;	/* generate assembly files */
int	cflag = 0;	/* generate ".s" files only */
int	Oflag = 0;	/* run the optimizer */
int	tflag = 0;	/* generate a symbol table in executables */
int	pflag = 0;	/* enable execution profiling */
int	fflag = 0;	/* enable floating point */

/*
 * We build lists of the various file types we're given. Within each
 * type, MAXF says how many we can deal with.
 */
#define	MAXF	30

int	ncfiles = 0;	/* .c files */
char	*cfiles[MAXF];
int	nsfiles = 0;	/* .s files */
char	*sfiles[MAXF];
int	nofiles = 0;	/* .o files */
char	*ofiles[MAXF];
int	nlfiles = 0;	/* .a or .lib files (or files with no suffix) */
char	*lfiles[MAXF];

char	*output = NULL;	/* output file */

char	cmdln[512];

usage()
{
	fprintf(stderr,
		"Sozobon C Compiler Options:\n");
	fprintf(stderr,
		"-c		compile, but don't link\n");
	fprintf(stderr,
		"-O		run the assembly code optimizer\n");
	fprintf(stderr,
		"-S		don't assemble, leave .s files around\n");
	fprintf(stderr,
		"-v (or -V)	show the passes and versions as they run\n");
	fprintf(stderr,
		"-n		like -v, but don't really run anything\n");
	fprintf(stderr,
		"-m		tell the loader to generate a load map\n");
	fprintf(stderr,
		"-t		tell the loader to generate a symbol table\n");
	fprintf(stderr,
		"-f		link the floating point library\n");
	fprintf(stderr,
		"-p		enable execution profiling\n");
	fprintf(stderr,
		"-o f		use the file 'f' for the loader output\n");
	fprintf(stderr,
		"-Ilib		add dir. 'lib' to the header search list\n");
	fprintf(stderr,
		"-Dsym		define the pre-processor symbol 'sym' as 1\n");
	fprintf(stderr,
		"-Dsym=val	or as 'val'\n");
	fprintf(stderr,
		"-Usym		un-define the built-in symbol 'sym'\n");

	exit(1);
}

main(argc, argv)
int	argc;
char	*argv[];
{
	extern	char	*chsuf();
	register int	i;
	register char	*s;
	register int	endopt;
	int	domsg = FALSE;

	if (argc == 1)
		usage();

	for (i=1; i < argc ;i++) {
		if (argv[i][0] == '-') {	/* option */
			endopt = FALSE;
			for (s = &argv[i][1]; *s && !endopt ;s++) {
				switch (*s) {
				case 'c':
					cflag = TRUE; break;
				case 'O':
					Oflag = TRUE; break;
				case 'S':
					Sflag = TRUE; break;
				case 'v':
				case 'V':
					vflag = TRUE; break;
				case 'n':
					nflag = TRUE; break;
				case 'm':
					mflag = TRUE; break;
				case 't':
					tflag = TRUE; break;
				case 'f':
					fflag = TRUE; break;
				case 'p':
					pflag = TRUE; break;
				case 'o':
					output = argv[++i];
					endopt = TRUE;
					break;
				/*
				 * Options for other passes.
				 */
				case 'I':	/* compiler options */
				case 'D':
				case 'U':
					hccopt[hcc_cnt++] = argv[i];
					endopt = TRUE;
					break;
				default:
					usage();
				}
			}
		} else {		/* input file */
			if (output == NULL)
				output = chsuf(argv[i], ".ttp");

			keepfile(argv[i]);
		}
	}

	if ((ncfiles + nsfiles) > 1)
		domsg = TRUE;

	doinit();

	if (vflag)
		printf("%s\n", Version);

	for (i = 0; i < ncfiles ;i++) {
		if (domsg)
			printf("%s:\n", cfiles[i]);
		docomp(cfiles[i]);
		doopt(cfiles[i]);
		doasm(cfiles[i], TRUE);
	}

	for (i = 0; i < nsfiles ;i++) {
		if (domsg)
			printf("%s:\n", sfiles[i]);
		doasm(sfiles[i], FALSE);
	}

	dold();		/* run the loader */

	exit(0);
}

/*
 * doinit() - set up some variables before getting started
 */
doinit()
{
	char	*getenv();

	if ((path = getenv("PATH")) == NULL)
		path = DEFPATH;

	if ((lib = getenv("LIB")) == NULL)
		lib = DEFLIB;

	if ((tmp = getenv("TMP")) == NULL)
		tmp = DEFTMP;
}

/*
 * keepfile(f) - remember the filename 'f' in the appropriate place
 */
keepfile(f)
char	*f;
{
	char	*p, *strchr();

	if ((p = strchr(f, '.')) == NULL) {	/* no suffix */
		lfiles[nlfiles++] = f;
		return;
	}

	if (strcmp(p, ".c") == 0) {
		cfiles[ncfiles++] = f;
		return;
	}
	if (strcmp(p, ".s") == 0) {
		sfiles[nsfiles++] = f;
		return;
	}
	if (strcmp(p, ".o") == 0) {
		ofiles[nofiles++] = f;
		return;
	}
	if (strcmp(p, ".a") == 0) {
		lfiles[nlfiles++] = f;
		return;
	}
	if (strcmp(p, ".lib") == 0) {
		lfiles[nlfiles++] = f;
		return;
	}
	fprintf(stderr, "cc: unknown file suffix '%s'\n", f);
	exit(1);
}

/*
 * chsuf(f, suf) - change the suffix of file 'f' to 'suf'.
 *
 * Space for the new string is obtained using malloc().
 */
char *
chsuf(f, suf)
char	*f;
char	*suf;
{
	char	*malloc();
	char	*s, *p;

	p = s = malloc(strlen(f) + strlen(suf) + 1);

	strcpy(p, f);

	for (; *p ; p++) {
		if (*p == '.')
			break;
	}

	while (*suf)
		*p++ = *suf++;

	*suf = '\0';

	return s;
}

/*
 * isfile(f) - return true if the given file exists
 */
int
isfile(f)
char	*f;
{
	int	fd;

	if ((fd = open(f, O_RDONLY)) < 0)
		return FALSE;

	close(fd);
	return TRUE;
}

/*
 * findfile(e, b, s, chknul)
 *
 * Finds a file in one of the directories given in the environment
 * variable whose value is pointed to by 'e'. Looks for the file
 * given by 'b' with one of the suffixes listed in 's'. The suffix
 * string should contain suffixes delimited by commas.
 *
 * e.g.  findfile("env stuff", "hcc", ".tos,.ttp,.prg")
 *
 * Returns a pointer to a static area containing the pathname of the
 * file, if found, NULL otherwise.
 *
 * If 'chknul' is set, try the base name without any suffix as well.
 */
char *
findfile(e, b, s, chknul)
char	*e;
char	*b;
char	*s;
int	chknul;
{
	static	char	file[256];
	char	env[256];
	char	suf[128];
	char	*eptr, *sptr;
	char	*p;

	/*
	 * Make a copy of the value of the env. variable. Convert all
	 * delimiters to nulls.
	 */
	if (e != NULL) {
		strcpy(env, e);
		for (p = env; *p ;p++) {
			if (*p == ';' || *p == ',')
				*p = '\0';
		}
		p[1] = '\0';		/* double null terminator */
	} else
		env[1] = env[0] = '\0';

	strcpy(suf, s);
	for (p = suf; *p ;p++) {
		if (*p == ',')
			*p = '\0';
	}
	p[1] = '\0';		/* double null terminator */

	/*
	 * Always check the root of the current drive and the
	 * current directory first. If that doesn't work, then
	 * start looking in the usual places...
	 */
	for (sptr = suf; *sptr ;) {

		sprintf(file, "%s%s", b, sptr);

		if (isfile(file))
			return file;

		sprintf(file, "\\%s%s", b, sptr);

		if (isfile(file))
			return file;

		while (*sptr++ != '\0')
			;
	}

	for (eptr = env; *eptr ;) {
		if (chknul) {
			sprintf(file, "%s\\%s", eptr, b);
			if (isfile(file))
				return file;
		}

		for (sptr = suf; *sptr ;) {

			sprintf(file, "%s\\%s%s", eptr, b, sptr);

			if (isfile(file))
				return file;

			while (*sptr++ != '\0')
				;
		}
		while (*eptr++ != '\0')
			;
	}
	return NULL;		/* give up */
}

/*
 * docmd(path, cmdline) - run a command
 */
int
docmd(path, cmdline)
char	*path;
char	*cmdline;
{
	int	i;
	char	cmd[150];

	strcpy(&cmd[1], cmdline);
	cmd[0] = strlen(cmdline);

	i = Pexec(0, path, cmd, 0L);

	return i;
}

/*
 * docomp(f) - run the compiler on the given .c file
 */
docomp(f)
char	*f;
{
	int	i;
	char	*cpath, *sf;

	if ((cpath = findfile(path, CC, EXSUF, FALSE)) == NULL) {
		fprintf(stderr, "cc: can't find compiler program '%s'\n", CC);
		exit(1);
	}

	strcpy(cmdln, pflag ? "-P " : "");

	for (i=0; i < hcc_cnt ;i++) {
		strcat(cmdln, hccopt[i]);
		strcat(cmdln, " ");
	}
	strcat(cmdln, f);

	if (nflag || vflag)
		fprintf(stderr, "%s %s\n", cpath, cmdln);

	if (!nflag) {
		if (docmd(cpath, cmdln)) {
			sf = chsuf(f, ".s");
			unlink(sf);
			free(sf);
			fprintf(stderr, "cc: compiler failed\n");
			exit(1);
		}
	}
}

/*
 * doopt(f) - run the optimizer
 *
 * Only optimize files that were produced by the compiler.
 */
doopt(f)
char	*f;
{
	int	i;
	char	*opath;
	char	*sf;

	if (!Oflag)
		return;

	if ((opath = findfile(path, OPT, EXSUF, FALSE)) == NULL) {
		fprintf(stderr, "cc: can't find optimizer program '%s'\n", OPT);
		exit(1);
	}

	sf = chsuf(f, ".s");

	if (nflag || vflag)
		fprintf(stderr, "%s %s %s\n",
			opath, sf, OTMP);

	if (!nflag) {
		sprintf(cmdln, "%s %s", sf, OTMP);
		if (docmd(opath, cmdln)) {
			unlink(OTMP);
			fprintf(stderr, "cc: optimizer failed (continuing)\n");
			unlink(OTMP);
		} else {
			unlink(sf);
			rename(OTMP, sf);
		}
	}
	free(sf);
}

/*
 * doasm() - run the assembler
 *
 * If 'istmp' is TRUE, the file we were given is a temporary
 */
doasm(f, istmp)
char	*f;
int	istmp;
{
	char	*strrchr(), *getenv();
	int	i;
	char	apath[128], *dpath;
	char	*s;
	char	*aname;		/* assembler to use */
	char	*sf;

	if (Sflag)
		return;

	if ((aname = getenv("ASM")) == NULL)
		aname = ASM;

	if ((dpath = findfile(path, aname, EXSUF, FALSE)) == NULL) {
		fprintf(stderr, "cc: can't find assembler program '%s'\n", aname);
		exit(1);
	}
	strcpy(apath, dpath);

	if (strcmp(aname, "as68") == 0) {
		if ((dpath = findfile(lib, ASMD, "", TRUE)) == NULL) {
			fprintf(stderr, "cc: can't find assembler data file\n");
			exit(1);
		}
		if ((s = strrchr(dpath, '\\')) == NULL) {
			fprintf(stderr, "cc: can't find assembler data file\n");
			exit(1);
		}
		s[1] = '\0';
	} else
		dpath = NULL;

	sf = chsuf(f, ".s");

	if (nflag || vflag)
		fprintf(stderr, "%s -l -u%s%s %s\n",
			apath,
			(dpath != NULL) ? " -s " : "",
			(dpath != NULL) ? dpath : "",
			sf);

	if (!nflag) {
		sprintf(cmdln, "%s%s %s",
			(dpath != NULL) ? "-l -u -s " : "",
			(dpath != NULL) ? dpath : "",
			sf);

		if (docmd(apath, cmdln)) {
			fprintf(stderr, "cc: assembler failed '%s'\n",
				sf);
			if (istmp)
				unlink(sf);
			free(sf);
			exit(1);
		}
	}

	if (nflag) {
		free(sf);
		return;
	}

	if (istmp)
		unlink(sf);

	free(sf);
}

/*
 * dold() - run the loader
 */
dold()
{
	FILE	*fp, *fopen();
	int	i;
	char	tfile[128];
	char	*lpath;
	char	*s;
	char	*l;

	if (cflag || Sflag)
		return;

	/*
	 * Construct the name of the loader data file.
	 */
	if (*tmp != '\0') {
		strcpy(tfile, tmp);
		if (tfile[strlen(tfile)-1] != '\\')
			strcat(tfile, "\\");
	} else
		tfile[0] = '\0';

	strcat(tfile, LTMP);

	unlink(tfile);
	/*
	 * Construct loader command file
	 */
	if ((fp = fopen(tfile, "w")) == NULL) {
		fprintf(stderr, "cc: can't open loader temp file\n");
		exit(1);
	}

	l = pflag ? PCSU : CSU;
	if ((lpath = findfile(lib, l, "", TRUE)) == NULL) {
		fprintf(stderr, "cc: can't find C startup code '%s'\n", l);
		exit(1);
	}
	fprintf(fp, "%s\n", lpath);

	for (i = 0; i < ncfiles ;i++) {
		s = chsuf(cfiles[i], ".o");
		fprintf(fp, "%s\n", s);
		free(s);
	}
	for (i = 0; i < nsfiles ;i++) {
		s = chsuf(sfiles[i], ".o");
		fprintf(fp, "%s\n", s);
		free(s);
	}
	for (i = 0; i < nofiles ;i++)
		fprintf(fp, "%s\n", ofiles[i]);

	for (i = 0; i < nlfiles ;i++) {
		if (isfile(lfiles[i])) {
			fprintf(fp, "%s\n", lfiles[i]);
		} else {
			lpath = findfile(lib, lfiles[i], LIBSUF, TRUE);
			if (lpath == NULL) {
				fprintf(stderr, "cc: can't find library '%s'\n", lfiles[i]);
				exit(1);
			}
			fprintf(fp, "%s\n", lpath);
		}
	}

	if (fflag) {
		l = pflag ? PLIBM : LIBM;
		if ((lpath = findfile(lib, l, LIBSUF, TRUE)) == NULL) {
			fprintf(stderr, "cc: can't find floating point library '%s'\n",l);
			exit(1);
		}
		fprintf(fp, "%s\n", lpath);
	}

	l = pflag ? PLIBC : LIBC;
	if ((lpath = findfile(lib, l, LIBSUF, TRUE)) == NULL) {
		fprintf(stderr, "cc: can't find C runtime library '%s'\n", l);
		exit(1);
	}
	fprintf(fp, "%s\n", lpath);

	fclose(fp);

	if ((lpath = findfile(path, LD, EXSUF, FALSE)) == NULL) {
		fprintf(stderr, "cc: can't find loader program '%s'\n", LD);
		exit(1);
	}

	sprintf(cmdln, "%s%s-p -u _main %s -o %s -f %s",
		mflag ? "-m " : "",
		tflag ? "-t " : "",
		fflag ? "-u __printf -u __scanf " : "",
		output,
		tfile);

	if (nflag || vflag)
		fprintf(stderr, "%s %s\n", lpath, cmdln);

	if (!nflag) {
		if (docmd(lpath, cmdln)) {
			fprintf(stderr, "cc: loader failed\n");
			unlink(tfile);
			unlink(output);
			exit(1);
		}
	}

	if (nflag)
		return;

	for (i = 0; i < ncfiles ;i++) {
		s = chsuf(cfiles[i], ".o");
		unlink(s);
		free(s);
	}

	for (i = 0; i < nsfiles ;i++) {
		s = chsuf(sfiles[i], ".o");
		unlink(s);
		free(s);
	}

	unlink(tfile);
}
