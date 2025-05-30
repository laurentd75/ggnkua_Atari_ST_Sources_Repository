/*
 * @(#)errno.h, XdLibs, SozobonX
 *
 * system error codes
 * last change:
 *  -VS: 1995/08/28
 */

#ifndef _ERRNO_H
#define	_ERRNO_H

extern	int	errno;		/* system error number */
extern	int	sys_nerr;	/* largest (negative) error number */
extern	char	**sys_errlist;	/* system error message text */
extern	char	*strerror(int num);	/* error string retrieval function */

#define	is_syserr(n)	((n <= 0) && (n >= sys_nerr))


#define	E_OK		0		/* no error */

/* bios errors */
#ifndef ERROR
#define	ERROR		(-1)		/* general error */
#endif
#define	EDRVNR		(-2)		/* drive not ready */
#define	EUNCMD		(-3)		/* unknown command */
#define	E_CRC		(-4)		/* crc error */
#define	EBADRQ		(-5)		/* bad request */
#define	E_SEEK		(-6)		/* seek error */
#define	EMEDIA		(-7)		/* unknown media */
#define	ESECNF		(-8)		/* sector not found */
#define	EPAPER		(-9)		/* out of paper */
#define	EWRITF		(-10)		/* write failure */
#define	EREADF		(-11)		/* read failure */
#define	EWRPRO		(-13)		/* media write protected */
#define	E_CHNG		(-14)		/* media changed */
#define	EUNDEV		(-15)		/* unknown device */
#define	EBADSF		(-16)		/* bad sectors on format */
#define	EOTHER		(-17)		/* request disk swap */

/* gemdos errors */
#define	EINVFN		(-32)		/* invalid function number */
#define	EFILNF		(-33)		/* file not found */
#define	EPTHNF		(-34)		/* path not found */
#define	ENHNDL		(-35)		/* no more handles */
#define	EACCDN		(-36)		/* access denied */
#define	EIHNDL		(-37)		/* invalid handle */
#define	ENSMEM		(-39)		/* not enough memory */
#define	EIMBA		(-40)		/* invalid memory block */
#define	EDRIVE		(-46)		/* invalid drive id */
#define	ENSAME		(-48)		/* rename to different drive */
#define	ENMFIL		(-49)		/* no more files */
#define	ERANGE		(-64)		/* range error */
#define	EINTRN		(-65)		/* internal error */
#define	EPLFMT		(-66)		/* bad executable format */
#define ENOEXEC EPLFMT
#define	EGSBF		(-67)		/* memory block growth failure */

#define ENAMETOOLONG ERANGE	/* a filename component is too long */
#define ELOOP		(-80)		/* too many symbolic links */

#define	EDOM		(-100)		/* domain error */
#define	EEXIST		(-101)		/* file exists for (O_CREAT|O_EXCL) */
/* this isn't really an error at all, just an indication to the kernel
 * that a mount point may have been crossed
 */
#define EMOUNT	(-200)

#endif 	/* _ERRNO_H	*/
