/*
 * Dieses Modul stellt einfach verkettete Listen
 * und dazugeh�rige Funktionen zur Verf�gung.
 * Entwickelt mit Pure C von K. Rindfrey.
 * (c) MAXON Computer 1993
 */
#include <stdlib.h>
#include <stdio.h>
#include "list.h"

#define N_ALLOC() malloc( sizeof( TNode))
/*
 * N_ALLOC reserviert Speicher f�r ein
 * Element vom Typ TNode.
 */


TList *ls_Create()
/*
 * Legt eine neue Liste an.
 * R�ckgabe: Zeiger auf eine leere Liste
 */
{
    register TNode *a, /* Anker.         */
                   *e; /* Ende der Liste */

    if( ( a = N_ALLOC()) == NULL ||
        ( e = N_ALLOC()) == NULL)  return( NULL);
    a->pval = a->next = e;
    e->pval = e->next = NULL;
    return( ( TList *) a);
}

TNode *ls_Insert( TNode *n, void *e) 
/*
 * F�gt e als Nachfolger von n ein.
 * R�ckgabe : Zeiger auf Nachfolgerknoten von n.
 */
{
    register TNode *neu;

    if( ( neu = N_ALLOC()) == NULL)
        return( NULL);
    neu->pval = e;
    neu->next = n->next;
    n->next = neu;
    return( neu);
}

TNode *ls_SInsert( TList *a, void *e, TCmpF cmp)
/*
 * F�gt e in die Liste a ein. Das Einf�gen
 * erfolgt sortiert mit cmp als
 * Vergleichsfunktion.
 */
{
    TNode *n, *nold, *end;

    n = a->next;
    nold = a;
    end = ( TNode *)a->pval;
    end->pval = e;     /* W�chter setzen */
    while( ( *cmp)( e, n->pval) > 0){
        nold = n;
        n = n->next;
    }
    end->pval = NULL;  /* W�chter entfernen */
    return( ls_Insert( nold, e));
}

TNode *ls_RmNext( TNode *n) 
/*
 * Entferne Nachfolgerknoten von n.
 * R�ckgabe: Zeiger auf den entfernten Knoten.
 */
{
    register TNode *d;

    d = n->next;
    if( d->next == NULL) return( NULL);
    n->next = d->next;
    return( d);
}

TNode *ls_Search( void *p, TList *a, TCmpF cmp)
/*
 * Suche Eintrag p in Liste a mit der
 * Vergleichsfunktion cmp.
 * R�ckgabe : Zeiger auf den Knoten mit
 * Eintrag p; NULL falls p nicht gefunden
 */
{
    TNode *n, *end;

    end = ( TNode *)a->pval;
    end->pval = p;   /* W�chter setzen */
    n = a->next;
    while( ( *cmp)(p, n->pval) != 0)
        n = n->next;
    end->pval = NULL; /* W�chter entfernen */
    return( n == end ? NULL : n);
}

void ls_ForAll( TList *a, Tv_pv func)
/*
 * Wendet die Funktion func auf
 * alle Eintr�ge der Liste a an.
 */
{
    TNode *n;

    n = a->next;
    while( n->next != NULL){
        ( *func)( n->pval);
        n = n->next;
    }
}

void ls_Free( TList *a)
/*
 * Gibt die Knoten der Liste frei
 */
{
    TNode *n, *nold;

    nold = a;
    n = a->next;
    while( n->next != NULL){
        free( nold);
        nold = n;
        n = n->next;
    }
    free( nold);
}

void ls_VFree( TList *a, Tv_pv ff)
/*
 * Gibt die Knoten der Liste und den
 * Inhalt frei.
 * ff ist eine Funktion zur Freigabe der Daten
 * unter pval.
 */
{
    TNode *n, *nold;

    nold = n = a->next;
    free( a);
    while( n->next != NULL){
        ( *ff)( nold->pval);
        free( nold);
        nold = n;
        n = n->next;
    }
    free( nold);
}

