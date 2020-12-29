/*
 *
 * Modifications by Ken Hollis (khollis@chatlink.com)
 * 12/04/94: Modifications to make sure objects are complient to their
 *			 original object type, and verbose error message if the
 *			 copy didn't work.  Formatted source to look better.
#include "treecopy.h"
 * CAUTION: The object-tree *must* have the LASTOB-flag (0x20) set in
 * BUG: Up to now tree_copy won't copy the color-icon-structure,
	if (what & C_ICONBLKPOINTER)
	if (what & C_BITBLKPOINTER)
/* Calculate the number of bytes we need for the new tree */
/* Size of the OBJECT-structure itself */
		switch (tree[i].ob_type & 0xff)	{
/* Size of a TEDINFO-structure */
				if (what & C_TEDINFOPOINTER) {
					to_malloc += (size_t)tree[i].ob_spec.tedinfo->te_txtlen;
			case G_IMAGE:
/* Size of the BITBLK-structure */
				if (what & C_BITBLKPOINTER) {
					to_malloc += (size_t)((LONG)tree[i].ob_spec.bitblk->bi_wb *
										  (LONG)tree[i].ob_spec.bitblk->bi_hl);
/* Size of the USERBLK-structure */
			case G_BUTTON:
/* Size of the string (with one null character at the end) */
			case G_ICON:
/* Size of the ICONBLK-structure */
				if (what & C_ICONBLKPOINTER) {
/* Sizes of icon-data, icon-mask and icon-text */
										  (LONG)tree[i].ob_spec.iconblk->ib_hicon /
												4L + 1L + (LONG)strlen(tree[i].ob_spec.iconblk->ib_ptext));
/* If the size is odd, make it even */
/* Exit if we've reached the last object in the tree */
		i++;
	objects = i + 1;
/* If there's not enough memory left for the new tree, return NULL */
		form_alert(1, "[3][Sorry, there is no available|memory for this copy!][ OK ]");
	}
/*
	for (i = 0; i < objects; i++) {
/* Copy the contents of the OBJECT-structure */

/* This was added to assure true copies of the object type */
		new_tree[i].ob_type = tree[i].ob_type;

/* Copy the contents of the TEDINFO-structure */
				if (what & C_TEDINFOPOINTER) {
/* Copy the strings in the TEDINFO-structure */
			case G_IMAGE:
/* Copy the contents of the BITBLK-structure */
				if (what & C_BITBLKPOINTER) {
/* Copy the image-data */
									 (LONG)tree[i].ob_spec.bitblk->bi_hl);
			case G_USERDEF:
				if (what & C_USERBLK) {
/* Copy the contents of the USERBLK-structure */
			case G_BUTTON:
/* Copy the string */
			case G_ICON:
/* Copy the contents of the ICONBLK-structure */

									(LONG)tree[i].ob_spec.iconblk->ib_hicon /
									8L);
/* Copy the icon-data */
/* Copy the icon-string */
/* Assure that area contains an even address */
	return(new_tree);