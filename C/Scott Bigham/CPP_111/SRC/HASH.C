
/*---------------------------------------------------------------------*\
|									|
| CPP -- a stand-alone C preprocessor					|
| Copyright (c) 1993 Hacker Ltd.		Author: Scott Bigham	|
|									|
| Permission is granted to anyone to use this software for any purpose	|
| on any computer system, and to redistribute it freely, with the	|
| following restrictions:						|
| - No charge may be made other than reasonable charges for repro-	|
|     duction.								|
| - Modified versions must be clearly marked as such.			|
| - The author is not responsible for any harmful consequences of	|
|     using this software, even if they result from defects therein.	|
|									|
| hash.c -- maintain hash table for macro lookup			|
\*---------------------------------------------------------------------*/

#include "global.h"
#include "ztype.h"

#define HASH_SIZE 1009

extern char *magic_words[];
extern int N_MWORDS;

/* a hash object */
typedef struct hash {
  char *id;
  Macro *data;
  struct hash *next;
} Hash;

static Hash *H[HASH_SIZE];

/*
   hash_id() -- compute a hash value for the identifier pointed to by |s|;
   place a pointer to the first character after the identifier in |*end|.

Credit where it's due -- this hash function was originally suggested by Chris
   Torek on comp.lang.c.  As an explanation of the implementation, he
   offered:  "What *does* that 33 do?  I have no idea."
*/
unsigned int hash_id(s, end)
  register char *s;
  char **end;
{
  register unsigned int h = 0;

  for (; is_ctok(*s); s++)
/*    h = h * 33 + *s; */
    h += (h << 5) + *s;
  if (end)
    *end = s;
  return h % HASH_SIZE;
}

/*
   hash_add() -- add to the hash table an entry for the identifier |s|, with
   hash value |hv| and macro value |M|
*/
void hash_add(s, hv, M)
  char *s;
  unsigned int hv;
  Macro *M;
{
  register Hash *h = mallok(sizeof (Hash));

  h->data = M;
  h->next = NULL;
  h->id = strdup(s);
  h->next = H[hv];
  H[hv] = h;
}

/*
   hash_unlink() -- destroy the hash object pointed to by |h|; return a
   pointer to the hash object following |h|.  Used in hash_remove().
*/
static Hash *hash_unlink(h)
  register Hash *h;
{
  register Hash *hh = h->next;

  free(h->id);
  if (h->data->m_text)
    free(h->data->m_text);
  free(h->data);
  free(h);
  return hh;
}

/*
   hash_remove() -- remove the hash object for identifier |s|, with hash
   value |hv|
*/
void hash_remove(s, hv)
  char *s;
  unsigned int hv;
{
  register Hash *h;

  if (!H[hv])
    return;
  if (streq(H[hv]->id, s)) {
    H[hv] = hash_unlink(H[hv]);
    return;
  }
  for (h = H[hv]; h->next; h = h->next)
    if (streq(h->next->id, s)) {
      h->next = hash_unlink(h->next);
      return;
    }
}

/*
   magic_check() -- determine if the conditionally-active magic preprocessor
   constant in hash object |h| is in fact active
*/
static int magic_check(h)
  register Hash *h;
{
  if (ansi && streq(h->id, "__STDC__"))
    return 1;
  if ((get_mode() & IF_EXPR) && streq(h->id, "defined"))
    return 1;
  return 0;
}

/*
   lookup() -- look for the identifier |s| with hash value |hv| in the hash
   table.  Return its associated macro value, or NULL if the identifier is
   not present
*/
Macro *lookup(s, hv)
  register char *s;
  unsigned int hv;
{
  register Hash *h;

  for (h = H[hv]; h; h = h->next)
    if (streq(h->id, s)) {
      if (!(h->data->flags & MAGIC2) || magic_check(h)) {
	return h->data;
      } else {
	return NULL;
      }
    }
  return NULL;
}

/*
   hash_setup() -- initialize the hash table and add the predefined tokens
*/
void hash_setup()
{
  register int i;
  register Macro *M;
  unsigned int hv;

#if 0
  for (i = 0; i < HASH_SIZE; i++)
    H[i] = NULL;
#endif
  for (i = 0; i < N_MWORDS; i++) {
    M = mallok(sizeof (Macro));

    M->nargs = 0;
    M->m_text = M->argnames = NULL;
    M->flags = MAGIC;
    if (i < 2)
      M->flags |= MAGIC2;
    hash_add(magic_words[i], hash_id(magic_words[i], NULL), M);
  }
}

/*
   hash_clean_undef() -- remove all identifiers that were #undef'ined via -U
   from the hash table
*/
void hash_clean_undef()
{
  register int i;
  register Hash *h;

  for (i = 0; i < HASH_SIZE; i++) {
    while (H[i] && H[i]->data->flags & UNDEF)
      H[i] = hash_unlink(H[i]);
    if (H[i]) {
      for (h = H[i]; h->next; h = h->next)
	if (h->next->data->flags & UNDEF)
	  h->next = hash_unlink(h->next);
    }
  }
}

/* hash_free() -- deallocate all hash objects */
void hash_free()
{
#if 0 /* experimental -- let OS clean up behind us, should save time */
  int i;
  Hash *h;

  for (i = 0; i < HASH_SIZE; i++)
    for (h = H[i]; h; h = hash_unlink(h)) ;
#endif
}
