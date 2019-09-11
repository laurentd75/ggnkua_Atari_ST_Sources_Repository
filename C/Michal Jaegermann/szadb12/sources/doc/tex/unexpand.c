#include <stdio.h>

#define MAXLIN 132
#define TABSTOP 8

int                tabs[MAXLIN];

main ()
{
    int            c, delay, col;
    void           settab ();

    settab (tabs);

    col = delay = 0;
    while (EOF != (c = getchar ())) {
        if (MAXLIN < col) {
            /* copy remaining characters on a line */
            do {
                putchar (c);
            } while ('\n' != c && 
                           EOF != (c = getchar ()));
            col = 0;
        }
        else {
            switch (c) {
            case '\t':
                while (!tabs[col])
                    col++;
            case ' ':           /* fallthrough */
                if (!tabs[col]) {
                    col += 1;
                    continue;   /* keep delay */
                }
                putchar ((delay == col) ? ' ' : '\t');
                col += 1;
                break;
            default:
                while (delay < col) {
                    putchar (' ');
                    delay += 1;
                }
                putchar (c);
                col = ('\n' == c ? 0 : col + 1);
                break;
            } /* switch */
        } /* if (MAXLIN < col) */
        delay = col;
    }
    exit (0);
}

void
settab (tab_pt)
short           *tab_pt;
{
    int             i;

    for (i = 0; i < MAXLIN; i++) {
        *tab_pt++ = (0 == (i % TABSTOP));
    }
}
