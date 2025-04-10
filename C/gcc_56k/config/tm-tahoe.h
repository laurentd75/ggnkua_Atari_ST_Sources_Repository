/* Definitions of target machine for GNU compiler.  Tahoe version.
   Copyright (C) 1989 Free Software Foundation, Inc.

This file is part of GNU CC.

GNU CC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 1, or (at your option)
any later version.

GNU CC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU CC; see the file COPYING.  If not, write to
the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  */

/*
 * File: tm-tahoe.h
 *
 * This port made at the University of Buffalo by Devon Bowen,
 * Dale Wiles and Kevin Zachmann.
 *
 * Mail bugs reports or fixes to:	gcc@cs.buffalo.edu
 */


/*
 * Run-time Target Specification
 */

/* we want "tahoe" and "unix" auto-defined for all future compilations */

#define CPP_PREDEFINES "-Dtahoe -Dunix"

/* have cc1 print that this is the tahoe version */

#define TARGET_VERSION printf (" (tahoe)");

/* this is required in all tm files to hold flags */

extern int target_flags;

/* Zero if it is safe to output .dfloat and .float pseudos.  */
#define TARGET_HEX_FLOAT (target_flags & 1)

#define TARGET_DEFAULT 1

#define TARGET_SWITCHES		\
  { {"hex-float", 1},		\
    {"no-hex-float", -1},	\
    { "", TARGET_DEFAULT} }


/*
 * Storage Layout
 */

/* tahoe uses a big endian byte order */

#define BYTES_BIG_ENDIAN

/* tahoe uses a big endian word order */

#define WORDS_BIG_ENDIAN

/* standard byte size is usable on tahoe */

#define BITS_PER_UNIT 8

/* longs on the tahoe are 4 byte groups */

#define BITS_PER_WORD 32

/* from the last two params we get 4 bytes per word */

#define UNITS_PER_WORD 4

/* addresses are 32 bits (one word) */

#define POINTER_SIZE 32

/* pointers should align every 32 bits */

#define POINTER_BOUNDARY 32

/* all parameters line up on 32 boundaries */

#define PARM_BOUNDARY 32

/* stack should line up on 32 boundaries */

#define STACK_BOUNDARY 32

/* line functions up on 32 bits */

#define FUNCTION_BOUNDARY 32

/* the biggest alignment the tahoe needs in 32 bits */

#define BIGGEST_ALIGNMENT 32

/* we have to align after an 'int : 0' in a structure */

#define EMPTY_FIELD_BOUNDARY 32

/* structures must be made of full bytes */

#define STRUCTURE_SIZE_BOUNDARY 8

/* tahoe is picky about data alignment */

#define STRICT_ALIGNMENT

/* keep things standard with pcc */

#define PCC_BITFIELD_TYPE_MATTERS

/* this section is borrowed from the vax version since the */
/* formats are the same in both of the architectures	   */

#define CHECK_FLOAT_VALUE(mode, d) \
  if ((mode) == SFmode) \
    { \
      if ((d) > 1.7014117331926443e+38) \
	{ error ("magnitude of constant too large for `float'"); \
	  (d) = 1.7014117331926443e+38; } \
      else if ((d) < -1.7014117331926443e+38) \
	{ error ("magnitude of constant too large for `float'"); \
	  (d) = -1.7014117331926443e+38; } \
      else if (((d) > 0) && ((d) < 2.9387358770557188e-39)) \
	{ warning ("`float' constant truncated to zero"); \
	  (d) = 0.0; } \
      else if (((d) < 0) && ((d) > -2.9387358770557188e-39)) \
	{ warning ("`float' constant truncated to zero"); \
	  (d) = 0.0; } \
    }


/*
 * Register Usage
 */

/* define 15 general regs plus one for the floating point reg (FPP) */

#define FIRST_PSEUDO_REGISTER 17

/* let the compiler know what the fp, sp and pc are */

#define FIXED_REGISTERS {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0}

/* lots of regs aren't guarenteed to return from a call. The FPP reg */
/* must be included in these since it can't be saved by the reg mask */

#define CALL_USED_REGISTERS {1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1}

/* The FPP can handle any type, but the others may require as many as */
/* two regs depending on the mode needed 			      */

#define HARD_REGNO_NREGS(REGNO, MODE) \
 (REGNO != 16 ? ((GET_MODE_SIZE(MODE)+UNITS_PER_WORD-1) / UNITS_PER_WORD) : 1)

/* any mode greater than 4 bytes (doubles) can only go in an even regs */
/* and the FPP can only hold SFmode and DFmode 			       */

#define HARD_REGNO_MODE_OK(REGNO, MODE) \
 (REGNO != 16 ? (GET_MODE_SIZE (MODE) <= 4 ? 1 : (REGNO % 2 - 1)) : \
	(MODE == SFmode || MODE == DFmode))

/* if mode1 or mode2, but not both, are doubles then modes cannot be tied */

#define MODES_TIEABLE_P(MODE1, MODE2) \
 ((MODE1 == DFmode) == (MODE2 == DFmode))

/* the program counter is reg 15 */

#define PC_REGNUM 15

/* the stack pointer is reg 14 */

#define STACK_POINTER_REGNUM 14

/* the frame pointer is reg 13 */

#define FRAME_POINTER_REGNUM 13

/* tahoe does require an fp */

#define FRAME_POINTER_REQUIRED 1

/* since tahoe doesn't have a argument pointer, make it the fp */

#define ARG_POINTER_REGNUM 13

/* this isn't currently used since C doesn't support this feature */

#define STATIC_CHAIN_REGNUM 0

/* we'll use reg 1 for structure passing cause the destination */
/* of the eventual movblk requires it to be there anyway.      */

#define STRUCT_VALUE_REGNUM 1


/*
 * Register Classes
 */

/* tahoe has two types of regs. GENERALY_REGS are all the regs up */
/* to number 15. FPP_REG is the special floating point processor  */
/* register class (only one reg).				  */

enum reg_class {NO_REGS,GENERAL_REGS,FPP_REG,ALL_REGS,LIM_REG_CLASSES};

/* defines the number of reg classes.				    */

#define N_REG_CLASSES (int) LIM_REG_CLASSES

/* this defines what the classes are officially named for debugging */

#define REG_CLASS_NAMES \
 {"NO_REGS","GENERAL_REGS","FPP_REG","ALL_REGS"}

/* set general regs to be the first 16 regs and the fpp reg to be 17th */

#define REG_CLASS_CONTENTS {0,0xffff,0x10000,0x1ffff}

/* register class for the fpp reg is FPP_REG, all others are GENERAL_REGS */

#define REGNO_REG_CLASS(REGNO) (REGNO == 16 ? FPP_REG : GENERAL_REGS)

/* only gereral registers can be used as a base reg */

#define BASE_REG_CLASS GENERAL_REGS

/* only gereral registers can be used to index */

#define INDEX_REG_CLASS GENERAL_REGS

/* 'a' as a contraint in the md file means the FFP_REG class */

#define REG_CLASS_FROM_LETTER(C) (C == 'a' ? FPP_REG : NO_REGS)

/* any general reg but the fpp can be a base reg */

#define REGNO_OK_FOR_BASE_P(regno) \
((regno) < FIRST_PSEUDO_REGISTER - 1 || reg_renumber[regno] >= 0)

/* any general reg except the pc and fpp can be an index reg */

#define REGNO_OK_FOR_INDEX_P(regno)  \
((regno) < FIRST_PSEUDO_REGISTER - 2 || reg_renumber[regno] >= 0)

/* if your loading a floating point constant, it can't be done */
/* through a register. Force it to be a memory constant.       */

#define PREFERRED_RELOAD_CLASS(X,CLASS) \
	((GET_CODE (X) == CONST_DOUBLE) ? NO_REGS : CLASS)

/* for the fpp reg, all modes fit; for any others, you need two for doubles */

#define CLASS_MAX_NREGS(CLASS, MODE)	\
 (CLASS != FPP_REG ? ((GET_MODE_SIZE (MODE) + UNITS_PER_WORD - 1) / UNITS_PER_WORD) : 1)

/* we don't define any special constant sizes so all should fail */

#define CONST_OK_FOR_LETTER_P(VALUE, C)  0

/* we don't define any special double sizes so all should fail */

#define CONST_DOUBLE_OK_FOR_LETTER_P(VALUE, C) 0


/*
 * Describing Stack Layout
 */

/* tahoe stack grows from high to low memory */

#define STACK_GROWS_DOWNWARD

/* Define this if longjmp restores from saved registers
   rather than from what setjmp saved.  */
#define LONGJMP_RESTORE_FROM_STACK

/* tahoe call frames grow from high to low memory on the stack */

#define FRAME_GROWS_DOWNWARD

/* the tahoe fp points to the *top* of the frame instead of the   */
/* bottom, so we have to make this offset a constant large enough */
/* to jump over the biggest frame possible.			  */

#define STARTING_FRAME_OFFSET -52

/* tahoe always pushes 4 bytes unless it's a double in which case */
/* it pushes a full 8 bytes.					  */

#define PUSH_ROUNDING(BYTES) (BYTES <= 4 ? 4 : 8)

/* the first parameter in a function is at the fp + 4 */

#define FIRST_PARM_OFFSET(FNDECL) 4

/* the tahoe return function takes care of everything on the stack */

#define RETURN_POPS_ARGS(FUNTYPE) 1

/* function values for all types are returned in register 0 */

#define FUNCTION_VALUE(VALTYPE, FUNC)  \
  gen_rtx (REG, TYPE_MODE (VALTYPE), 0)

/* libarary routines also return things in reg 0 */

#define LIBCALL_VALUE(MODE)  gen_rtx (REG, MODE, 0)

/* Tahoe doesn't return structures in a reentrant way */

#define PCC_STATIC_STRUCT_RETURN

/* we only return values from a function in reg 0 */

#define FUNCTION_VALUE_REGNO_P(N) ((N) == 0)

/* we never pass args through a register */

#define FUNCTION_ARG(CUM, MODE, TYPE, NAMED) 0

/* int is fine to hold the argument summary in FUNCTION_ARG */

#define CUMULATIVE_ARGS int

/* we just set CUM to 0 before the FUNCTION_ARG call. No matter what */
/* we make it, FUNCTION_ARG will return 0 anyway		     */

#define INIT_CUMULATIVE_ARGS(CUM,FNTYPE)	\
 ((CUM) = 0)

/* all modes push their size rounded to the nearest word boundary */
/* except block which is the size of the block rounded up	  */

#define FUNCTION_ARG_ADVANCE(CUM, MODE, TYPE, NAMED)	\
 ((CUM) += ((MODE) != BLKmode			\
	    ? (GET_MODE_SIZE (MODE) + 3) & ~3	\
	    : (int_size_in_bytes (TYPE) + 3) & ~3))

/* this is always false since we never pass params in regs */

#define FUNCTION_ARG_REGNO_P(N) 0

/* this code calculates the register entry mask and sets up    */
/* the stack pointer for the function. The stack is set down   */
/* far enough from the fp to jump over any push regs and local */
/* vars. This is a problem since the tahoe has the fp pointing */
/* to the top of the frame and the compiler must know the off- */
/* set off the fp to the local vars.			       */

#define FUNCTION_PROLOGUE(FILE, SIZE)     \
{ register int regno;						\
  register int mask = 0;					\
  extern char call_used_regs[];					\
  for (regno = 0; regno < FIRST_PSEUDO_REGISTER-1; regno++)	\
    if (regs_ever_live[regno] && !call_used_regs[regno])	\
       mask |= 1 << regno;					\
  fprintf (FILE, "\t.word 0x%x\n", mask);			\
  if (SIZE != 0) fprintf (FILE, "\tsubl3 $%d,fp,sp\n", (SIZE) - STARTING_FRAME_OFFSET); }

/* to call the profiler, push the variable value onto the stack */
/* and call mcount like a regular function.			*/

#define FUNCTION_PROFILER(FILE, LABELNO)  \
   fprintf (FILE, "\tpushl $LP%d\n\tcallf $8,mcount\n", (LABELNO));

/* all stack handling at the end of a function is handled by the */
/* return command.						 */

#define EXIT_IGNORE_STACK 1

/* this never gets executed since the system knows it always gets  */
/* an fp to work with. It just prints a friendly message since the */
/* person must be playing with the tm file defs 		   */

#define FIX_FRAME_POINTER_ADDRESS(ADDR,DEPTH) \
 { abort(); }


/*
 * Library Subroutine Names
 */

/* udiv is a valid C library routine in libc.a, so we call that */

#define UDIVSI3_LIBCALL "*udiv"

/* urem is a valid C library routine in libc.a, so we call that */

#define UMODSI3_LIBCALL "*urem"


/*
 * Addressing Modes
 */

/* constant addresses can be treated exactly the same as normal constants */

#define CONSTANT_ADDRESS_P(X) CONSTANT_P (X)

/* we can have as many as two regs in any given address */

#define MAX_REGS_PER_ADDRESS 2

/* The following is all the code for GO_IF_LEGITIMATE_ADDRESS */
/* most of this taken directly from the vax tm file since the */
/* tahoe and vax addressing modes are nearly identicle.	      */

/* Is x an indirectable address? */

#define INDIRECTABLE_ADDRESS_P(X)  \
  (CONSTANT_ADDRESS_P (X)						\
   || (GET_CODE (X) == REG && REG_OK_FOR_BASE_P (X))			\
   || (GET_CODE (X) == PLUS						\
       && GET_CODE (XEXP (X, 0)) == REG					\
       && REG_OK_FOR_BASE_P (XEXP (X, 0))				\
       && CONSTANT_ADDRESS_P (XEXP (X, 1))))

/* If x is a non-indexed-address, go to ADDR. */

#define GO_IF_NONINDEXED_ADDRESS(X, ADDR)  \
{ register rtx xfoob = (X);						\
  if (GET_CODE (xfoob) == REG) goto ADDR;				\
  if (INDIRECTABLE_ADDRESS_P (xfoob)) goto ADDR;			\
  xfoob = XEXP (X, 0);							\
  if (GET_CODE (X) == MEM && INDIRECTABLE_ADDRESS_P (xfoob))		\
    goto ADDR;								\
  if ((GET_CODE (X) == PRE_DEC || GET_CODE (X) == POST_INC)		\
      && GET_CODE (xfoob) == REG && REGNO (xfoob) == 14)		\
    goto ADDR; }

/* Is PROD an index term in mode MODE. */

#define INDEX_TERM_P(PROD, MODE)   \
(GET_MODE_SIZE (MODE) == 1						\
 ? (GET_CODE (PROD) == REG && REG_OK_FOR_BASE_P (PROD))			\
 : (GET_CODE (PROD) == MULT						\
    &&									\
    (xfoo0 = XEXP (PROD, 0), xfoo1 = XEXP (PROD, 1),			\
     ((GET_CODE (xfoo0) == CONST_INT					\
       && INTVAL (xfoo0) == GET_MODE_SIZE (MODE)			\
       && GET_CODE (xfoo1) == REG					\
       && REG_OK_FOR_INDEX_P (xfoo1))					\
      ||								\
      (GET_CODE (xfoo1) == CONST_INT					\
       && INTVAL (xfoo1) == GET_MODE_SIZE (MODE)			\
       && GET_CODE (xfoo0) == REG					\
       && REG_OK_FOR_INDEX_P (xfoo0))))))

/* Is the addition to the index a reg? */

#define GO_IF_REG_PLUS_INDEX(X, MODE, ADDR)	\
{ register rtx xfooa;							\
  if (GET_CODE (X) == PLUS)						\
    { if (GET_CODE (XEXP (X, 0)) == REG					\
	  && REG_OK_FOR_BASE_P (XEXP (X, 0))				\
	  && (xfooa = XEXP (X, 1),					\
	      INDEX_TERM_P (xfooa, MODE)))				\
	goto ADDR;							\
      if (GET_CODE (XEXP (X, 1)) == REG					\
	  && REG_OK_FOR_BASE_P (XEXP (X, 1))				\
	  && (xfooa = XEXP (X, 0),					\
	      INDEX_TERM_P (xfooa, MODE)))				\
	goto ADDR; } }

/* Is the rtx X a valid memoy address for operand of mode MODE? */
/* If it is, go to ADDR */

#define GO_IF_LEGITIMATE_ADDRESS(MODE, X, ADDR)  \
{ register rtx xfoo, xfoo0, xfoo1;					\
  GO_IF_NONINDEXED_ADDRESS (X, ADDR);					\
  if (GET_CODE (X) == PLUS)						\
    { xfoo = XEXP (X, 0);						\
      if (INDEX_TERM_P (xfoo, MODE))					\
	{ GO_IF_NONINDEXED_ADDRESS (XEXP (X, 1), ADDR); }		\
      xfoo = XEXP (X, 1);						\
      if (INDEX_TERM_P (xfoo, MODE))					\
	{ GO_IF_NONINDEXED_ADDRESS (XEXP (X, 0), ADDR); }		\
      if (CONSTANT_ADDRESS_P (XEXP (X, 0)))				\
	{ if (GET_CODE (XEXP (X, 1)) == REG				\
	      && REG_OK_FOR_BASE_P (XEXP (X, 1)))			\
	    goto ADDR;							\
	  GO_IF_REG_PLUS_INDEX (XEXP (X, 1), MODE, ADDR); }		\
      if (CONSTANT_ADDRESS_P (XEXP (X, 1)))				\
	{ if (GET_CODE (XEXP (X, 0)) == REG				\
	      && REG_OK_FOR_BASE_P (XEXP (X, 0)))			\
	    goto ADDR;							\
	  GO_IF_REG_PLUS_INDEX (XEXP (X, 0), MODE, ADDR); } } }

/* Register 16 can never be used for index or base */

#ifndef REG_OK_STRICT
#define REG_OK_FOR_INDEX_P(X) (REGNO(X) != 16)
#define REG_OK_FOR_BASE_P(X) (REGNO(X) != 16)
#else
#define REG_OK_FOR_INDEX_P(X) REGNO_OK_FOR_INDEX_P (REGNO (X))
#define REG_OK_FOR_BASE_P(X) REGNO_OK_FOR_BASE_P (REGNO (X))
#endif

/* Addressing is too simple to allow optimizing here */

#define LEGITIMIZE_ADDRESS(X,OLDX,MODE,WIN)  {}

/* Post_inc and pre_dec always adds 4 */

#define GO_IF_MODE_DEPENDENT_ADDRESS(ADDR,LABEL)	\
 { if (GET_CODE(ADDR) == POST_INC || GET_CODE(ADDR) == PRE_DEC)		\
       goto LABEL;							\
   if (GET_CODE (ADDR) == PLUS)						\
     { if (CONSTANT_ADDRESS_P (XEXP (ADDR, 0))				\
	   && GET_CODE (XEXP (ADDR, 1)) == REG);			\
       else if (CONSTANT_ADDRESS_P (XEXP (ADDR, 1))			\
		&& GET_CODE (XEXP (ADDR, 0)) == REG);			\
       else goto LABEL; }}

/* Double's are not legitimate as immediate operands */

#define LEGITIMATE_CONSTANT_P(X) \
  (GET_CODE (X) != CONST_DOUBLE)


/*
 * Miscellaneous Parameters
 */

/* the elements in the case jump table are all words */

#define CASE_VECTOR_MODE HImode

/* each of the table elements in a case are relative to the jump addess */

#define CASE_VECTOR_PC_RELATIVE

/* tahoe case instructions just fall through to the next instruction */
/* if not satisfied. It doesn't support a default action	     */

#define CASE_DROPS_THROUGH

/* the standard answer is given here and work ok */

#define IMPLICIT_FIX_EXPR FIX_ROUND_EXPR

/* in a general div case, it's easiest to use TRUNC_DIV_EXPR */

#define EASY_DIV_EXPR TRUNC_DIV_EXPR

/* the standard seems to be leaving char's as signed so we left it */
/* this way even though we think they should be unsigned!	   */

#define DEFAULT_SIGNED_CHAR 1

/* the most we can move without cutting down speed is 4 bytes */

#define MOVE_MAX 4

/* our int is 32 bits */

#define INT_TYPE_SIZE 32

/* byte access isn't really slower than anything else */

#define SLOW_BYTE_ACCESS 0

/* zero extension is more than one instruction so try to avoid it */

#define SLOW_ZERO_EXTEND

/* any bits higher than the low 4 are ignored in the shift count */
/* so don't bother zero extending or sign extending them         */

#define SHIFT_COUNT_TRUNCATED

/* we don't need to officially convert from one fixed type to another */
/* in order to use it as that type. We can just assume it's the same  */

#define TRULY_NOOP_TRUNCATION(OUTPREC, INPREC) 1

/* pass chars as ints */

#define PROMOTE_PROTOTYPES

/* pointers can be represented by an si mode expression */

#define Pmode SImode

/* function addresses are made by specifying a byte address */

#define FUNCTION_MODE QImode

/* all the costs here were borrowed from the vax version of the */
/* tm file. They're pretty much the same in the tahoe           */

#define CONST_COSTS(RTX,CODE) \
  case CONST_INT:						\
    if (RTX == const0_rtx) return 0;				\
    if ((unsigned) INTVAL (RTX) < 077) return 1;		\
  case CONST:							\
  case LABEL_REF:						\
  case SYMBOL_REF:						\
    return 3;							\
  case CONST_DOUBLE:						\
    return 5;


/*
 * Condition Code Information
 */

/* Condition codes still break in one case that we haven't tracked */
/* down yet, so we have to leave them like this for now.	   */

#define NOTICE_UPDATE_CC(EXP, INSN) \
{ if (GET_CODE(EXP) == SET && GET_CODE(SET_DEST(EXP)) == CC0) {		\
	cc_status.flags = 0;					\
	cc_status.value1 = SET_DEST(EXP);			\
	cc_status.value2 = SET_SRC(EXP);			\
  } else							\
	CC_STATUS_INIT; }


/*
 * Output of Assembler Code
 */

/* start the assembly by turning off APP */

#define ASM_FILE_START(FILE) fprintf (FILE, "#NO_APP\n\n");

/* the instruction that turns on the APP for the gnu assembler */

#define ASM_APP_ON "#APP\n"

/* the instruction that turns off the APP for the gnu assembler */

#define ASM_APP_OFF "#NO_APP\n"

/* what to output before read-only data.  */

#define TEXT_SECTION_ASM_OP ".text"

/* what to output before writable data.  */

#define DATA_SECTION_ASM_OP ".data"

/* this is what we call each of the regs. notice that the FPP reg is   */
/* called "ac". This should never get used due to the way we've set    */
/* up FPP instructions in the md file. But we call it "ac" here to     */
/* fill the list.						       */

#define REGISTER_NAMES \
{"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", \
 "r9", "r10", "r11", "r12", "fp", "sp", "pc", "ac"}

/* registers are called the same thing in dbx anything else */

#define DBX_REGISTER_NUMBER(REGNO) (REGNO)

/* allow generation of dbx info in the assembly */

#define DBX_DEBUGGING_INFO

/* our dbx doesn't support this */

#define DBX_NO_XREFS

/* we don't want symbols broken up */

#define DBX_CONTIN_LENGTH 0

/* this'll really never be used, but we'll leave it at this */

#define DBX_CONTIN_CHAR '?'

/* labels are the label followed by a colon and a newline */
/* must be a statement, so surround it in a null loop     */

#define ASM_OUTPUT_LABEL(FILE,NAME)	\
  do { assemble_name (FILE, NAME); fputs (":\n", FILE); } while (0)

/* use the .globl directive to make labels global for the linker */

#define ASM_GLOBALIZE_LABEL(FILE,NAME)	\
  do { fputs (".globl ", FILE); assemble_name (FILE, NAME); fputs ("\n", FILE);} while (0)

/* output a label by appending an underscore to it */

#define ASM_OUTPUT_LABELREF(FILE,NAME)	\
  fprintf (FILE, "_%s", NAME)

/* use the standard format for printing internal labels */

#define ASM_OUTPUT_INTERNAL_LABEL(FILE,PREFIX,NUM)	\
  fprintf (FILE, "%s%d:\n", PREFIX, NUM)

/* a * is used for label indirection in unix assembly */

#define ASM_GENERATE_INTERNAL_LABEL(LABEL,PREFIX,NUM)	\
  sprintf (LABEL, "*%s%d", PREFIX, NUM)

/* outputing a double is easy cause we only have one kind */

#define ASM_OUTPUT_DOUBLE(FILE,VALUE)  \
{							\
  union { int i[2]; double d;} temp;			\
  temp.d = (VALUE);					\
  if (TARGET_HEX_FLOAT)					\
    fprintf ((FILE), "\t.long 0x%x,0x%x  # %.20e\n",	\
	     temp.i[0], temp.i[1], temp.d);		\
  else							\
    fprintf (FILE, "\t.dfloat 0d%.20e\n", temp.d);	\
}

/* This is how to output an assembler line defining a `float' constant.  */

#define ASM_OUTPUT_FLOAT(FILE,VALUE)  \
{							\
  union { int i; float f;} temp;			\
  temp.f = (float) (VALUE);				\
  if (TARGET_HEX_FLOAT)					\
    fprintf ((FILE), "\t.long 0x%x  # %.20e\n",		\
	     temp.i, temp.f);				\
  else							\
    fprintf (FILE, "\t.float 0f%.20e\n", temp.f);	\
}

/* This is how to output an assembler line defining an `int' constant.  */

#define ASM_OUTPUT_INT(FILE,VALUE)  \
( fprintf (FILE, "\t.long "),			\
  output_addr_const (FILE, (VALUE)),		\
  fprintf (FILE, "\n"))

/* Likewise for `char' and `short' constants.  */

#define ASM_OUTPUT_SHORT(FILE,VALUE)  \
( fprintf (FILE, "\t.word "),			\
  output_addr_const (FILE, (VALUE)),		\
  fprintf (FILE, "\n"))

#define ASM_OUTPUT_CHAR(FILE,VALUE)  \
( fprintf (FILE, "\t.byte "),			\
  output_addr_const (FILE, (VALUE)),		\
  fprintf (FILE, "\n"))

/* This is how to output an assembler line for a numeric constant byte.  */

#define ASM_OUTPUT_BYTE(FILE,VALUE)  \
  fprintf (FILE, "\t.byte 0x%x\n", (VALUE))

/* this is the insn to push a register onto the stack */

#define ASM_OUTPUT_REG_PUSH(FILE,REGNO)	\
  fprintf (FILE, "\tpushl %s\n", reg_names[REGNO])

/* this is the insn to pop a register from the stack */

#define ASM_OUTPUT_REG_POP(FILE,REGNO)	\
  fprintf (FILE, "\tmovl (sp)+,%s\n", reg_names[REGNO])

/* this is required even thought tahoe doesn't support it */
/* cause the C code expects it to be defined		  */

#define ASM_OUTPUT_ADDR_VEC_ELT(FILE, VALUE)  \
  fprintf (FILE, "\t.long L%d\n", VALUE)

/* This is how to output an element of a case-vector that is relative.  */

#define ASM_OUTPUT_ADDR_DIFF_ELT(FILE, VALUE, REL)  \
  fprintf (FILE, "\t.word L%d-L%d\n", VALUE, REL)

/* This aligns the assembler output */

#define ASM_OUTPUT_ALIGN(FILE,LOG)  \
  LOG ? fprintf (FILE, "\t.align %d\n", (LOG)) : 0

/* This is how to skip over some space */

#define ASM_OUTPUT_SKIP(FILE,SIZE)  \
  fprintf (FILE, "\t.space %d\n", (SIZE))

/* This defines common variables across files */

#define ASM_OUTPUT_COMMON(FILE, NAME, SIZE, ROUNDED)  \
( fputs (".comm ", (FILE)),			\
  assemble_name ((FILE), (NAME)),		\
  fprintf ((FILE), ",%d\n", (ROUNDED)))

/* This defines a common varible in the local file */

#define ASM_OUTPUT_LOCAL(FILE, NAME, SIZE, ROUNDED)  \
( fputs (".lcomm ", (FILE)),			\
  assemble_name ((FILE), (NAME)),		\
  fprintf ((FILE), ",%d\n", (ROUNDED)))

/* code to generate a label */

#define ASM_FORMAT_PRIVATE_NAME(OUTPUT, NAME, LABELNO)	\
( (OUTPUT) = (char *) alloca (strlen ((NAME)) + 10),	\
  sprintf ((OUTPUT), "%s.%d", (NAME), (LABELNO)))

/* parenthesis for expressions in the assembly */

#define ASM_OPEN_PAREN "("
#define ASM_CLOSE_PAREN ")"

/* Define results of standard character escape sequences.  */

#define TARGET_BELL 007
#define TARGET_BS 010
#define TARGET_TAB 011
#define TARGET_NEWLINE 012
#define TARGET_VT 013
#define TARGET_FF 014
#define TARGET_CR 015

/* Print an operand.  Some difference from the vax code,
   since the tahoe can't support immediate floats and doubles.

   %@ means print the proper alignment operand for aligning after a casesi.
   This depends on the assembler syntax.
   This is 1 for our assembler, since .align is logarithmic.  */

#define PRINT_OPERAND_PUNCT_VALID_P(CODE)				\
  ((CODE) == '@')

#define PRINT_OPERAND(FILE, X, CODE)  \
{ if (CODE == '@')							\
    putc ('1', FILE);							\
  else if (GET_CODE (X) == REG)						\
    fprintf (FILE, "%s", reg_names[REGNO (X)]);				\
  else if (GET_CODE (X) == MEM)						\
    output_address (XEXP (X, 0));					\
  else { putc ('$', FILE); output_addr_const (FILE, X); }}

/* When the operand is an address, call print_operand_address to */
/* do the work from output-tahoe.c.				 */

#define PRINT_OPERAND_ADDRESS(FILE, ADDR)  \
 print_operand_address (FILE, ADDR)

