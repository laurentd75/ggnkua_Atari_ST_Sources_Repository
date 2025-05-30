/*
 * Listing 3.4, Datei : crypt.c
 * Modul              : CRYPT - Verschl�sselung
 *                      nach dem DES
 * Modifikationsdatum : 12-Dez-1990
 * Abh�ngigkeiten     : -
 */

/*
 * Datentypen   : BLOCK, ORDERING
 * Variable     : key
 *
 * Aufgabe      :
 *
 * Darstellung von Schl�ssel- und Datenobjekten
 * (<BLOCK>) sowie Permutationsdaten (<ORDERING>).
 */

typedef struct {
    unsigned char b_data[64];
} BLOCK;

typedef struct {
    unsigned char o_data[64];
} ORDERING;

BLOCK key;

/*
 * Variablen    : ip, pi, swap, pc1, pc2, etr
 *                ptr, s_boxes, rots
 *
 * Aufgabe      :
 *
 * Einige Permutationsdaten.
 */

ORDERING ip = {
    58, 50, 42, 34, 26, 18, 10,  2,
    60, 52, 44, 36, 28, 20, 12,  4,
    62, 54, 46, 38, 30, 22, 14,  6,
    64, 56, 48, 40, 32, 24, 16,  8,
    57, 49, 41, 33, 25, 17,  9,  1,
    59, 51, 43, 35, 27, 19, 11,  3,
    61, 53, 45, 37, 29, 21, 13,  5,
    63, 55, 47, 39, 31, 23, 15,  7
};

ORDERING pi = {
    40,  8, 48, 16, 56, 24, 64, 32,
    39,  7, 47, 15, 55, 23, 63, 31,
    38,  6, 46, 14, 54, 22, 62, 30,
    37,  5, 45, 13, 53, 21, 61, 29,
    36,  4, 44, 12, 52, 20, 60, 28,
    35,  3, 43, 11, 51, 19, 59, 27,
    34,  2, 42, 10, 50, 18, 58, 26,
    33,  1, 41,  9, 49, 17, 57, 25
};

ORDERING swap = {
    33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48,
    49, 50, 51, 52, 53, 54, 55, 56,
    57, 58, 59, 60, 61, 62, 63, 64,
     1,  2,  3,  4,  5,  6,  7,  8,
     9, 10, 11, 12, 13, 14, 15, 16,
    17, 18, 19, 20, 21, 22, 23, 24,
    25, 26, 27, 28, 29, 30, 31, 32
};

ORDERING pc1 = {
    57, 49, 41, 33, 25, 17,  9,
     1, 58, 50, 42, 34, 26, 18,
    10,  2, 59, 51, 43, 35, 27,
    19, 11,  3, 60, 52, 44, 36,
    63, 55, 47, 39, 31, 23, 15,
     7, 62, 54, 46, 38, 30, 22,
    14,  6, 61, 53, 45, 37, 29, 
    21, 13,  5, 28, 20, 12,  4
};

ORDERING pc2 = {
    14, 17, 11, 24,  1,  5,
     3, 28, 15,  6, 21, 10,
    23, 19, 12,  4, 26,  8,
    16,  7, 27, 20, 13,  2,
    41, 52, 31, 37, 47, 55,
    30, 40, 51, 45, 33, 48,
    44, 49, 39, 56, 34, 53, 
    46, 42, 50, 36, 29, 32
};

ORDERING etr = {
    32,  1,  2,  3,  4,  5,
     4,  5,  6,  7,  8,  9,
     8,  9, 10, 11, 12, 13,
    12, 13, 14, 15, 16, 17,
    16, 17, 18, 19, 20, 21,
    20, 21, 22, 23, 24, 25,
    24, 25, 26, 27, 28, 29,
    28, 29, 30, 31, 32,  1
};

ORDERING ptr = {
    16,  7, 20, 21, 29, 12, 28, 17, 
     1, 15, 23, 26,  5, 18, 31, 10,
     2,  8, 24, 14, 32, 27,  3,  9, 
    19, 13, 30,  6, 22, 11,  4, 25
};

unsigned char s_boxes[8][64] = {
    {   14,  4, 13,  1,  2, 15, 11,  8,
         3, 10,  6, 12,  5,  9,  0,  7,
         0, 15,  7,  4, 14,  2, 13,  1,
        10,  6, 12, 11,  9,  5,  3,  8,
         4,  1, 14,  8, 13,  6,  2, 11,
        15, 12,  9,  7,  3, 10,  5,  0,
        15, 12,  8,  2,  4,  9,  1,  7,
         5, 11,  3, 14, 10,  0,  6, 13
    },

    {   15,  1,  8, 14,  6, 11,  3,  4,
         9,  7,  2, 13, 12,  0,  5, 10,
         3, 13,  4,  7, 15,  2,  8, 14,
        12,  0,  1, 10,  6,  9, 11,  5,
         0, 14,  7, 11, 10,  4, 13,  1,
         5,  8, 12,  6,  9,  3,  2, 15,
        13,  8, 10,  1,  3, 15,  4,  2,
        11,  6,  7, 12,  0,  5, 14,  9
    },

    {   10,  0,  9, 14,  6,  3, 15,  5,
         1, 13, 12,  7, 11,  4,  2,  8,
        13,  7,  0,  9,  3,  4,  6, 10,
         2,  8,  5, 14, 12, 11, 15,  1,
        13,  6,  4,  9,  8, 15,  3,  0,
        11,  1,  2, 12,  5, 10, 14,  7,
         1, 10, 13,  0,  6,  9,  8,  7,
         4, 15, 14,  3, 11,  5,  2, 12
    },

    {    7, 13, 14,  3,  0,  6,  9, 10,
         1,  2,  8,  5, 11, 12,  4, 15,
        13,  8, 11,  5,  6, 15,  0,  3,
         4,  7,  2, 12,  1, 10, 14,  9,
        10,  6,  9,  0, 12, 11,  7, 13,
        15,  1,  3, 14,  5,  2,  8,  4,
         3, 15,  0,  6, 10,  1, 13,  8,
         9,  4,  5, 11, 12,  7,  2, 14
    },

    {    2, 12,  4,  1,  7, 10, 11,  6,
         8,  5,  3, 15, 13,  0, 14,  9,
        14, 11,  2, 12,  4,  7, 13,  1,
         5,  0, 15, 10,  3,  9,  8,  6,
         4,  2,  1, 11, 10, 13,  7,  8, 
        15,  9, 12,  5,  6,  3,  0, 14,
        11,  8, 12,  7,  1, 14,  2, 13,
         6, 15,  0,  9, 10,  4,  5,  3
    },

    {   12,  1, 10, 15,  9,  2,  6,  8,
         0, 13,  3,  4, 14,  7,  5, 11,
        10, 15,  4,  2,  7, 12,  9,  5,
         6,  1, 13, 14,  0, 11,  3,  8,
         9, 14, 15,  5,  2,  8, 12,  3,
         7,  0,  4, 10,  1, 13, 11,  6,
         4,  3,  2, 12,  9,  5, 15, 10,
        11, 14,  1,  7,  6,  0,  8, 13
    },

    {    4, 11,  2, 14, 15,  0,  8, 13,
         3, 12,  9,  7,  5, 10,  6,  1,
        13,  0, 11,  7,  4,  9,  1, 10,
        14,  3,  5, 12,  2, 15,  8,  6,
         1,  4, 11, 13, 12,  3,  7, 14,
        10, 15,  6,  8,  0,  5,  9,  2,
         6, 11, 13,  8,  1,  4, 10,  7,
         9,  5,  0, 15, 14,  2,  3, 12
    },

    {   13,  2,  8,  4,  6, 15, 11,  1,
        10,  9,  3, 14,  5,  0, 12,  7,
         1, 15, 13,  8, 10,  3,  7,  4,
        12,  5,  6, 11,  0, 14,  9,  2,
         7, 11,  4,  1,  9, 12, 14,  2,
         0,  6, 10, 13, 15,  3,  5,  8,
         2,  1, 14,  7,  4, 10,  8, 13,
        15, 12,  9,  0,  3,  5,  6, 11
    }
};

int rots[] = {
    1,  1,  2,  2,  2,  2,  2,  2,
    1,  2,  2,  2,  2,  2,  2,  1
};

/*
 * Funktionen   : transpose
 *
 * Parameter    : transpose(data, t, n);
 *                BLOCK    *data;
 *                ORDERING *t;
 *                int      n;
 *
 * Aufgabe      :
 *
 * Permutation des durch <data> referenzierten
 * Datenblocks der L�nge <n> mit den durch <t>
 * referenzierten Permutationsdaten.
 */

void transpose(data, t, n)
BLOCK    *data;
ORDERING *t;
int      n;
{   BLOCK x;

    x = *data;
    while (n > 0) {
        n--;
        data->b_data[n] = x.b_data
                                [t->o_data[n] - 1];
    }
}

/*
 * Funktionen   : rotate
 *
 * Parameter    : rotate(key);
 *                BLOCK *key;
 *
 * Aufgabe      :
 *
 * Rotation des Schl�ssels <key>.
 */

void rotate(key)
BLOCK *key;
{   unsigned char *p;
    unsigned char *ep;
    int           data0,
                  data28;

    p = key->b_data;
    ep = &(key->b_data[55]);
    data0 = key->b_data[0];
    data28 = key->b_data[28];
    while (p < ep) {
        p++;
        *(p-1) = *p;
    }
    key->b_data[27] = data0;
    key->b_data[55] = data28;
}

/*
 * Funktionen   : f
 *
 * Parameter    : f(i, key, a, x);
 *                int      i;
 *                BLOCK    *key,
 *                         *a,
 *                         *x;
 *
 * Aufgabe      :
 *
 * Durchf�hrung der f-Funktion.
 */

ORDERING *EP = &etr;

void f(i, key, a, x)
int   i;
BLOCK *key,
      *a,
      *x;
{   BLOCK         e,
                  ikey,
                  y;
    int           k,
                  xb,
                  ri;
    unsigned char *p,
                  *q,
                  *r;

    e = *a;
    transpose(&e, EP, 48);
    for (k = rots[i]; k > 0; k--)
        rotate(key);
    ikey = *key;
    transpose(&ikey, &pc2, 48);
    p = &(y.b_data[48]);
    q = &(e.b_data[48]);
    r = &(ikey.b_data[48]);
    while (p > y.b_data)
        *--p = *--q ^ *--r;
    q = x->b_data;
    for (k = 0; k < 8; k++) {
        ri = *p++ << 5;
        ri += *p++ << 3;
        ri += *p++ << 2;
        ri += *p++ << 1;
        ri += *p++;
        ri += *p++ << 4;

        xb = s_boxes[k][ri];

        *q++ = (xb >> 3) & 1;
        *q++ = (xb >> 2) & 1;
        *q++ = (xb >> 1) & 1;
        *q++ = (xb & 1);
    }
    transpose(x, &ptr, 32);
}

/*
 * Funktionen   : encrypt
 *
 * Parameter    : encrypt(blck);
 *                BLOCK *blck;
 *
 * Aufgabe      :
 *
 * Zentrale Verschl�sselungsroutine.
 */

static void setkey(k)
char *k;
{   key = *((BLOCK *) k);
    transpose(&key, &pc1, 56);
}

void encrypt(blck)
char *blck;
{   BLOCK *p = (BLOCK *) blck,
          b,
          x;
    int   i,
          j,
          k;

    transpose(p, &ip, 64);
    for (i = 15; i>= 0; i--) {
        j = 15 - i;
        b = *p;
        for (k = 31; k >= 0; k--)
            p->b_data[k] = b.b_data[k + 32];
        f(j, &key, p, &x);
        for (k = 31; k >= 0; k--)
            p->b_data[k+32] = b.b_data[k] ^
                              x.b_data[k];
    }
    transpose(p, &swap, 64);
    transpose(p, &pi, 64);
}

/*
 * Funktionen   : crypt
 *
 * Parameter    : erg = crypt(passwd, salt);
 *                char *erg,
 *                     *passwd,
 *                     *salt;
 *
 * Aufgabe      :
 *
 * Die Verschl�sselung von Pa�w�rtern mit dem
 * DES. Als erster Parameter wird das Pa�wort
 * �bergeben. Als zweiter Parameter ein mindestens
 * zwei Zeichen umfassender Zufallsstring.
 * Als Ergebnis erh�lt man das verschl�sselte 
 * Pa�wort, dem die ersten beiden Zeichen des
 * Zufallsstrings vorangestellt sind.
 */

char *crypt(pw, salt)
char *pw,
     *salt;
{   char     pwb[66],
             result[16],
             *p = pwb,
             c;
    ORDERING new_etr;
    int      i,
             j,
             t,
             temp;

    while (*pw && p < &pwb[64]) {
        j = 7;
        while (j--)
            *p++ = (*pw >> j) & 01;
        pw++;
        *p++ = 0;
    }

    while (p < &pwb[64])
        *p++ = 0;

    setkey(p = pwb);

    while (p < &pwb[66])
        *p++ = 0;

    new_etr = etr;
    EP = &new_etr;
    for (i = 0; i < 2; i++) {
        c = *salt++;
        result[i] = c;
        if ( c > 'Z')
            c -= 6 + 7 + '.';
        else if ( c > '9')
            c -= 7 + '.';
        else
            c -= '.';
        for (j = 0; j < 6; j++) {
            if ((c >> j) & 01) {
                t = 6 * i + j;
                temp = new_etr.o_data[t];
                new_etr.o_data[t] =
                           new_etr.o_data[t + 24];
                new_etr.o_data[t + 24] = temp;
            }
        }
    }

    if (result[1] == 0)
        result[1] = result[0];

    for (i = 0; i < 25; i++)
        encrypt(pwb);
    EP = &etr;

    p = pwb;
    pw = result + 2;
    while (p < &pwb[66]) {
        c = 0;
        j = 6;
        while (j--) {
            c <<= 1;
            c |= *p++;
        }
        c += '.';
        if (c > '9')
            c += 7;
        if (c > 'Z')
            c += 6;
        *pw++ = c;
    }
    *pw = 0;
    return(result);
}

