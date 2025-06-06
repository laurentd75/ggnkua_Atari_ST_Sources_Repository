# : Makefile.SH,v 9820Revision: 4.0.1.2 9820Date: 91/06/07 10:14:43 $
#
# $Log:	Makefile.SH,v $
# Revision 4.0.1.2  91/06/07  10:14:43  lwall
# patch4: cflags now emits entire cc command except for the filename
# patch4: alternate make programs are now semi-supported
# patch4: uperl.o no longer tries to link in libraries prematurely
# patch4: installperl now installs x2p stuff too
# 
# Revision 4.0.1.1  91/04/11  17:30:39  lwall
# patch1: C flags are now settable on a per-file basis
# 
# Revision 4.0  91/03/20  00:58:54  lwall
# 4.0 baseline.
# 
# 

CC = cgcc
YACC = bison -y
LDFLAGS = 
CLDFLAGS = 
SMALL = 
LARGE =  
mallocsrc = malloc.c
mallocobj = malloc.o
SLN = ln -s

libs = -lgdbm -lpml 

public = perl.ttp

# To use an alternate make, set  in config.sh.
MAKE = make


CCCMD = $(CC) -O -fomit-frame-pointer -fcombine-regs -c

private = 

scripts = 

manpages = perl.man h2ph.man

util = echo.ttp perlglob.ttp

sh = Makefile.SH makedepend.SH h2ph.SH

h1 = EXTERN.h INTERN.h arg.h array.h cmd.h config.h form.h handy.h
h2 = hash.h perl.h regcomp.h regexp.h spat.h stab.h str.h util.h

h = $(h1) $(h2)

c1 = array.c cmd.c cons.c consarg.c doarg.c doio.c dolist.c dump.c
c2 = eval.c form.c hash.c $(mallocsrc) perl.c regcomp.c regexec.c
c3 = stab.c str.c toke.c util.c atarist.c

c = $(c1) $(c2) $(c3)

obj1 = array.o cmd.o cons.o consarg.o doarg.o doio.o dolist.o dump.o
obj2 = eval.o form.o hash.o $(mallocobj) perl.o regcomp.o regexec.o
obj3 = stab.o str.o toke.o util.o atarist.o

obj = $(obj1) $(obj2) $(obj3)

lintflags = -hbvxac

# grrr
SHELL = /bin/sh

.c.o:
	$(CCCMD) $*.c

all: $(public)  $(util)

# This is the standard version that contains no "taint" checks and is
# used for all scripts that aren't set-id or running under something set-id.
# The $& notation is tells Sequent machines that it can do a parallel make,
# and is harmless otherwise.

perl.ttp: perly.o $(obj)
	$(CC) $(LARGE) $(CLDFLAGS) $(obj) perly.o $(libs) -o perl.ttp -v -s

echo.ttp: wildmat.o echo.c
	$(CC) -O -mshort -fomit-frame-pointer -fcombine-regs -o echo.ttp \
	echo.c wildmat.o -liio16 -s

perlglob.ttp: wildmat.o perlglob.c
	$(CC) -O -mshort -fomit-frame-pointer -fcombine-regs -o perlglob.ttp \
	perlglob.c wildmat.o -liio16 -s

wildmat.o: wildmat.c
	$(CC) -O -mshort -fomit-frame-pointer -fcombine-regs -c wildmat.c

perly.h: perly.c
	@ echo Dummy dependency for dumb parallel make
	touch perly.h

perly.c: perly.y perly.fixer
	@ echo 'Expect either' 29 shift/reduce and 59 reduce/reduce conflicts...
	@ echo '           or' 27 shift/reduce and 61 reduce/reduce conflicts...
	$(YACC) -d perly.y
	sh ./perly.fixer y.tab.c perly.c
	mv y.tab.h perly.h
	echo 'extern YYSTYPE yylval;' >>perly.h

perly.o: perly.c perly.h $(h)
	$(CCCMD) perly.c


clean:
	rm -f *.o all perl taintperl suidperl

realclean: clean
	rm -f *.orig */*.orig *~ */*~ core $(addedbyconf) h2ph h2ph.man
	rm -f perly.c perly.h 

# The following lint has practically everything turned on.  Unfortunately,
# you have to wade through a lot of mumbo jumbo that can't be suppressed.
# If the source file has a /*NOSTRICT*/ somewhere, ignore the lint message
# for that spot.

lint: perly.c $(c)
	lint $(lintflags) $(defs) perly.c $(c) > perl.fuzz

depend: makedepend
	- test -f perly.h || cp /dev/null perly.h
	./makedepend
	- test -s perly.h || /bin/rm -f perly.h

test: perl
	- cd t && chmod +x TEST */*.t
	- cd t && (rm -f perl; $(SLN) ../perl .) && ./perl TEST </dev/tty

clist:
	echo $(c) | tr ' ' '\012' >.clist

hlist:
	echo $(h) | tr ' ' '\012' >.hlist

shlist:
	echo $(sh) | tr ' ' '\012' >.shlist

# AUTOMATICALLY GENERATED MAKE DEPENDENCIES--PUT NOTHING BELOW THIS LINE
# If this runs make out of memory, delete /usr/include lines.
array.o: EXTERN.h
array.o: arg.h
array.o: array.c
array.o: array.h
array.o: cmd.h
array.o: config.h
array.o: form.h
array.o: handy.h
array.o: hash.h
array.o: perl.h
array.o: regexp.h
array.o: spat.h
array.o: stab.h
array.o: str.h
array.o: util.h
cmd.o: EXTERN.h
cmd.o: arg.h
cmd.o: array.h
cmd.o: cmd.c
cmd.o: cmd.h
cmd.o: config.h
cmd.o: form.h
cmd.o: handy.h
cmd.o: hash.h
cmd.o: perl.h
cmd.o: regexp.h
cmd.o: spat.h
cmd.o: stab.h
cmd.o: str.h
cmd.o: util.h
cons.o: EXTERN.h
cons.o: arg.h
cons.o: array.h
cons.o: cmd.h
cons.o: config.h
cons.o: cons.c
cons.o: form.h
cons.o: handy.h
cons.o: hash.h
cons.o: perl.h
cons.o: perly.h
cons.o: regexp.h
cons.o: spat.h
cons.o: stab.h
cons.o: str.h
cons.o: util.h
consarg.o: EXTERN.h
consarg.o: arg.h
consarg.o: array.h
consarg.o: cmd.h
consarg.o: config.h
consarg.o: consarg.c
consarg.o: form.h
consarg.o: handy.h
consarg.o: hash.h
consarg.o: perl.h
consarg.o: regexp.h
consarg.o: spat.h
consarg.o: stab.h
consarg.o: str.h
consarg.o: util.h
doarg.o: EXTERN.h
doarg.o: arg.h
doarg.o: array.h
doarg.o: cmd.h
doarg.o: config.h
doarg.o: doarg.c
doarg.o: form.h
doarg.o: handy.h
doarg.o: hash.h
doarg.o: perl.h
doarg.o: regexp.h
doarg.o: spat.h
doarg.o: stab.h
doarg.o: str.h
doarg.o: util.h
doio.o: EXTERN.h
doio.o: arg.h
doio.o: array.h
doio.o: cmd.h
doio.o: config.h
doio.o: doio.c
doio.o: form.h
doio.o: handy.h
doio.o: hash.h
doio.o: perl.h
doio.o: regexp.h
doio.o: spat.h
doio.o: stab.h
doio.o: str.h
doio.o: util.h
dolist.o: EXTERN.h
dolist.o: arg.h
dolist.o: array.h
dolist.o: cmd.h
dolist.o: config.h
dolist.o: dolist.c
dolist.o: form.h
dolist.o: handy.h
dolist.o: hash.h
dolist.o: perl.h
dolist.o: regexp.h
dolist.o: spat.h
dolist.o: stab.h
dolist.o: str.h
dolist.o: util.h
dump.o: EXTERN.h
dump.o: arg.h
dump.o: array.h
dump.o: cmd.h
dump.o: config.h
dump.o: dump.c
dump.o: form.h
dump.o: handy.h
dump.o: hash.h
dump.o: perl.h
dump.o: regexp.h
dump.o: spat.h
dump.o: stab.h
dump.o: str.h
dump.o: util.h
eval.o: EXTERN.h
eval.o: arg.h
eval.o: array.h
eval.o: cmd.h
eval.o: config.h
eval.o: eval.c
eval.o: form.h
eval.o: handy.h
eval.o: hash.h
eval.o: perl.h
eval.o: regexp.h
eval.o: spat.h
eval.o: stab.h
eval.o: str.h
eval.o: util.h
form.o: EXTERN.h
form.o: arg.h
form.o: array.h
form.o: cmd.h
form.o: config.h
form.o: form.c
form.o: form.h
form.o: handy.h
form.o: hash.h
form.o: perl.h
form.o: regexp.h
form.o: spat.h
form.o: stab.h
form.o: str.h
form.o: util.h
hash.o: EXTERN.h
hash.o: arg.h
hash.o: array.h
hash.o: cmd.h
hash.o: config.h
hash.o: form.h
hash.o: handy.h
hash.o: hash.c
hash.o: hash.h
hash.o: perl.h
hash.o: regexp.h
hash.o: spat.h
hash.o: stab.h
hash.o: str.h
hash.o: util.h
perl.o: EXTERN.h
perl.o: arg.h
perl.o: array.h
perl.o: cmd.h
perl.o: config.h
perl.o: form.h
perl.o: handy.h
perl.o: hash.h
perl.o: patchlevel.h
perl.o: perl.c
perl.o: perl.h
perl.o: perly.h
perl.o: regexp.h
perl.o: spat.h
perl.o: stab.h
perl.o: str.h
perl.o: util.h
regcomp.o: EXTERN.h
regcomp.o: INTERN.h
regcomp.o: arg.h
regcomp.o: array.h
regcomp.o: cmd.h
regcomp.o: config.h
regcomp.o: form.h
regcomp.o: handy.h
regcomp.o: hash.h
regcomp.o: perl.h
regcomp.o: regcomp.c
regcomp.o: regcomp.h
regcomp.o: regexp.h
regcomp.o: spat.h
regcomp.o: stab.h
regcomp.o: str.h
regcomp.o: util.h
regexec.o: EXTERN.h
regexec.o: arg.h
regexec.o: array.h
regexec.o: cmd.h
regexec.o: config.h
regexec.o: form.h
regexec.o: handy.h
regexec.o: hash.h
regexec.o: perl.h
regexec.o: regcomp.h
regexec.o: regexec.c
regexec.o: regexp.h
regexec.o: spat.h
regexec.o: stab.h
regexec.o: str.h
regexec.o: util.h
stab.o: EXTERN.h
stab.o: arg.h
stab.o: array.h
stab.o: cmd.h
stab.o: config.h
stab.o: form.h
stab.o: handy.h
stab.o: hash.h
stab.o: perl.h
stab.o: regexp.h
stab.o: spat.h
stab.o: stab.c
stab.o: stab.h
stab.o: str.h
stab.o: util.h
str.o: EXTERN.h
str.o: arg.h
str.o: array.h
str.o: cmd.h
str.o: config.h
str.o: form.h
str.o: handy.h
str.o: hash.h
str.o: perl.h
str.o: perly.h
str.o: regexp.h
str.o: spat.h
str.o: stab.h
str.o: str.c
str.o: str.h
str.o: util.h
toke.o: EXTERN.h
toke.o: arg.h
toke.o: array.h
toke.o: cmd.h
toke.o: config.h
toke.o: form.h
toke.o: handy.h
toke.o: hash.h
toke.o: perl.h
toke.o: perly.h
toke.o: regexp.h
toke.o: spat.h
toke.o: stab.h
toke.o: str.h
toke.o: toke.c
toke.o: util.h
util.o: EXTERN.h
util.o: arg.h
util.o: array.h
util.o: cmd.h
util.o: config.h
util.o: form.h
util.o: handy.h
util.o: hash.h
util.o: perl.h
util.o: regexp.h
util.o: spat.h
util.o: stab.h
util.o: str.h
util.o: util.c
util.o: util.h
atarist.o: EXTERN.h
atarist.o: arg.h
atarist.o: array.h
atarist.o: cmd.h
atarist.o: config.h
atarist.o: form.h
atarist.o: handy.h
atarist.o: hash.h
atarist.o: perl.h
atarist.o: regexp.h
atarist.o: spat.h
atarist.o: stab.h
atarist.o: str.h
atarist.o: atarist.c
atarist.o: util.h

malloc.o: EXTERN.h
malloc.o: arg.h
malloc.o: array.h
malloc.o: cmd.h
malloc.o: config.h
malloc.o: form.h
malloc.o: handy.h
malloc.o: hash.h
malloc.o: perl.h
malloc.o: regexp.h
malloc.o: spat.h
malloc.o: stab.h
malloc.o: str.h
malloc.o: malloc.c
malloc.o: util.h

