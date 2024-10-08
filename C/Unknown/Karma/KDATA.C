extern int box_wide,box_hi;

struct shape
{  int num_corners; int corners[12];
      int num_neighbors; int neighbors[4];
      int owner; int renters; int update;
}  karma[]=
   {  5, {1,1, 4,1, 3,3, 1,4, 1,1},          /*0*/
         2, {43,44},
         0, 0, 0,
      5, {10,1, 13,1, 13,4, 11,3, 10,1},
         2, {45,46},
         0, 0, 0,
      5, {11,11, 13,10, 13,13, 10,13, 11,11},
         2, {40,47},
         0, 0, 0,
      5, {1,10, 3,11, 4,13, 1,13, 1,10},
         2, {41,42},
         0, 0, 0,
      
      4, {6,2, 8,2, 7,4, 6,2},               /*4*/
         3, { 5,11,39},
         0, 0, 0,
      4, {8,2, 9,3, 7,4, 8,2},
         3, { 4, 6,45},
         0, 0, 0,
      4, {9,3, 9,5, 7,4, 9,3},
         3, { 5, 7,50},
         0, 0, 0,
      4, {9,5, 8,6, 7,4, 9,5},
         3, { 6, 8,19},
         0, 0, 0,
      4, {8,6, 6,6, 7,4, 8,6},
         3, { 7, 9,52},
         0, 0, 0,
      4, {6,6, 5,5, 7,4, 6,6},
         3, { 8,10,29},
         0, 0, 0,
      4, {5,5, 5,3, 7,4, 5,5},
         3, { 9,11,49},
         0, 0, 0,
      4, {5,3, 6,2, 7,4, 5,3},
         3, { 4,10,44},
         0, 0, 0,
      
      4, {9,5, 11,5, 10,7, 9,5},             /*12*/
         3, {13,19,50},
         0, 0, 0,
      4, {11,5, 12,6, 10,7, 11,5},
         3, {12,14,46},
         0, 0, 0,
      4, {12,6, 12,8, 10,7, 12,6},
         3, {13,15,36},
         0, 0, 0,
      4, {12,8, 11,9, 10,7, 12,8},
         3, {14,16,47},
         0, 0, 0,
      4, {11,9, 9,9, 10,7, 11,9},
         3, {15,17,51},
         0, 0, 0,
      4, {9,9, 8,8, 10,7, 9,9},
         3, {16,18,21},
         0, 0, 0,
      4, {8,8, 8,6, 10,7, 8,8},
         3, {17,19,52},
         0, 0, 0,
      4, {8,6, 9,5, 10,7, 8,6},
         3, { 7,12,18},
         0, 0, 0,
      
      4, {6,8, 8,8, 7,10, 6,8},              /*20*/
         3, {21,27,52},
         0, 0, 0,
      4, {8,8, 9,9, 7,10, 8,8},
         3, {17,20,22},
         0, 0, 0,
      4, {9,9, 9,11, 7,10, 9,9},
         3, {21,23,51},
         0, 0, 0,
      4, {9,11, 8,12, 7,10, 9,11},
         3, {22,24,40},
         0, 0, 0,
      4, {8,12, 6,12, 7,10, 8,12},
         3, {23,25,37},
         0, 0, 0,
      4, {6,12, 5,11, 7,10, 6,12},
         3, {24,26,41},
         0, 0, 0,
      4, {5,11, 5,9, 7,10, 5,11},
         3, {25,27,48},
         0, 0, 0,
      4, {5,9, 6,8, 7,10, 5,9},
         3, {20,26,31},
         0, 0, 0,
      
      4, {3,5, 5,5, 4,7, 3,5},               /*28*/
         3, {29,35,49},
         0, 0, 0,
      4, {5,5, 6,6, 4,7, 5,5},
         3, { 9,28,30},
         0, 0, 0,
      4, {6,6, 6,8, 4,7, 6,6},
         3, {29,31,52},
         0, 0, 0,
      4, {6,8, 5,9, 4,7, 6,8},
         3, {27,30,32},
         0, 0, 0,
      4, {5,9, 3,9, 4,7, 5,9},
         3, {31,33,48},
         0, 0, 0,
      4, {3,9, 2,8, 4,7, 3,9},
         3, {32,34,42},
         0, 0, 0,
      4, {2,8, 2,6, 4,7, 2,8},
         3, {33,35,38},
         0, 0, 0,
      4, {2,6, 3,5, 4,7, 2,6},
         3, {28,34,43},
         0, 0, 0,
      
      5, {12,6, 14,6, 14,8, 12,8, 12,6},     /*36*/
         4, {14,38,46,47},
         0, 0, 0,
      5, {6,12, 8,12, 8,14, 6,14, 6,12},
         4, {24,39,40,41},
         0, 0, 0,
      5, {0,6, 2,6, 2,8, 0,8, 0,6},
         4, {34,36,42,43},
         0, 0, 0,
      5, {6,0, 8,0, 8,2, 6,2, 6,0},
         4, { 4,37,44,45},
         0, 0, 0,
      
      6, {9,11, 11,11, 10,13, 8,14, 8,12, 9,11}, /*40*/
         4, { 2,23,37,51},
         0, 0, 0,
      6, {3,11, 5,11, 6,12, 6,14, 4,13, 3,11},
         4, { 3,25,37,48},
         0, 0, 0,
      6, {0,8, 2,8, 3,9, 3,11, 1,10, 0,8},
         4, { 3,33,38,48},
         0, 0, 0,
      6, {1,4, 3,3, 3,5, 2,6, 0,6, 1,4},
         4, { 0,35,38,49},
         0, 0, 0,
      6, {4,1, 6,0, 6,2, 5,3, 3,3, 4,1},
         4, { 0,11,39,49},
         0, 0, 0,
      6, {8,0, 10,1, 11,3, 9,3, 8,2, 8,0},
         4, { 1, 5,39,50},
         0, 0, 0,
      6, {11,3, 13,4, 14,6, 12,6, 11,5, 11,3},
         4, { 1,13,36,50},
         0, 0, 0,
      6, {12,8, 14,8, 13,10, 11,11, 11,9, 12,8},
         4, { 2,15,36,51},
         0, 0, 0,
      
      5, {3,9, 5,9, 5,11, 3,11, 3,9},        /*48*/
         4, {26,32,41,42},
         0, 0, 0,
      5, {3,3, 5,3, 5,5, 3,5, 3,3},
         4, {10,28,43,44},
         0, 0, 0,
      5, {9,3, 11,3, 11,5, 9,5, 9,3},
         4, { 6,12,45,46},
         0, 0, 0,
      5, {9,9, 11,9, 11,11, 9,11, 9,9},
         4, {16,22,40,47},
         0, 0, 0,
      
      5, {6,6, 6,8, 8,8, 8,6, 6,6},          /*52*/
         4, { 8,18,20,30},
         0, 0, 0
      
   };

int translate[14][14] =
{  { -1, -1, -1, -1,100,101, 39, 39,102,103, -1, -1, -1, -1},
   { -1,  0,  0,104, 44, 44, 39, 39, 45, 45,105,  1,  1, -1},
   { -1,  0,  0,106, 44,107,108,109,110, 45,111,  1,  1, -1},
   { -1,112,113, 49, 49,114,115,116,117, 50, 50,118,119, -1},
   {120, 43, 43, 49, 49,121,122,123,124, 50, 50, 46, 46,125},
   {126, 43,127,128,129,130,131,132,133,134,135,136, 46,137},
   { 38, 38,138,139,140,141, 52, 52,142,143,144,145, 36, 36},

   { 38, 38,146,147,148,149, 52, 52,150,151,152,153, 36, 36},
   {154, 42,155,156,157,158,159,160,161,162,163,164, 47,165},
   {166, 42, 42, 48, 48,167,168,169,170, 51, 51, 47, 47,171},
   { -1,172,173, 48, 48,174,175,176,177, 51, 51,178,179, -1},
   { -1,  3,  3,180, 41,181,182,183,184, 40,185,  2,  2, -1},
   { -1,  3,  3,186, 41, 41, 37, 37, 40, 40,187,  2,  2, -1},
   { -1, -1, -1, -1,188,189, 37, 37,190,191, -1, -1, -1, -1}
};

int diagonal[92][4] =
{
/*100*/
   { 3,-1,44, 0}, { 7,44,-1, 0}, { 2,45,-1, 0}, { 6,-1,45, 0},
/*104*/
   { 4, 0,44, 0}, { 5, 1,45, 0},
/*106*/
   { 0,44, 0, 0}, { 8,44,11, 0}, { 5, 4,11, 0},
   { 4, 4, 5, 0}, { 9, 5,45, 0}, { 1,45, 1, 0},
/*112*/
   { 3, 0,43, 0}, { 7,43, 0, 0}, { 2,10,11, 0}, {13,10,11, 4},
   {10, 4, 5, 6}, { 7, 6, 5, 0}, { 2,46, 1, 0}, { 6, 1,46, 0},
/*120*/
   { 4,-1,43, 0}, { 3,10, 9, 0}, {12, 8, 9,10},
   {11, 6, 7, 8}, { 6, 6, 7, 0}, { 5,-1,46, 0},
/*126*/
   { 0,43,-1, 0}, { 8,43,35, 0}, { 5,28,35, 0}, { 4,28,29, 0},
   { 9,29, 9, 0}, { 0, 8, 9, 0}, { 1, 8, 7, 0}, { 8, 7,19, 0},
   { 5,12,19, 0}, { 4,12,13, 0}, { 9,13,46, 0}, { 1,46,-1, 0},
/*138*/
   { 2,34,35, 0}, {13,34,35,28}, {10,28,29,30}, { 7,30,29, 0},
   { 2,18,19, 0}, {13,18,19,12}, {10,12,13,14}, { 7,14,13, 0},

/*146*/
   { 3,34,33, 0}, {12,32,33,34}, {11,30,31,32}, { 6,30,31, 0},
   { 3,18,17, 0}, {12,16,17,18}, {11,14,15,16}, { 6,14,15, 0},
/*154*/
   { 5,42,-1, 0}, { 9,42,33, 0}, { 0,32,33, 0}, { 1,32,31, 0},
   { 8,31,27, 0}, { 5,20,27, 0}, { 4,20,21, 0}, { 9,21,17, 0},
   { 0,16,17, 0}, { 1,16,15, 0}, { 8,15,47, 0}, { 4,47,-1, 0},
/*166*/
   { 1,-1,42, 0}, { 2,26,27, 0}, {13,26,27,20},
   {10,20,21,22}, { 7,22,21, 0}, { 0,-1,47, 0},
/*172*/
   { 2, 3,42, 0}, { 6,42, 3, 0}, { 3,26,25, 0}, {12,24,25,26},
   {11,22,23,24}, { 6,22,23, 0}, { 3,47, 2, 0}, { 7, 2,47, 0},
/*180*/
   { 5,41, 3, 0}, { 9,41,25, 0}, { 0,24,25, 0},
   { 1,24,23, 0}, { 8,23,40, 0}, { 4,40, 2, 0},
/*186*/
   { 1, 3,41, 0}, { 0, 2,40, 0},
/*188*/
   { 2,-1,41, 0}, { 6,41,-1, 0}, { 3,40,-1, 0}, { 7,-1,40, 0}
};

fix_it( whi, x, y )
int     whi, x, y;
{
int i,rx,ry,hx,hy,edge,answer;

   i = diagonal[whi][0];
   hx = rx = x % box_wide;
   hy = ry = y % box_hi;
   hx /= 2;
   hy /= 2;
   edge = box_wide/2;
   answer = diagonal[whi][1];  /* default answer */

   switch( i )
   {  case 0: if( rx+hy < edge ) answer = diagonal[whi][2];
         break;
      case 1: if( rx-hy >= edge ) answer = diagonal[whi][2];
         break;
      case 2: if( ry-hx < 1 ) answer = diagonal[whi][2];
         break;
      case 3: if( ry+hx > edge ) answer = diagonal[whi][2];
         break;
      case 4: if( rx+hy > edge ) answer = diagonal[whi][2];
         break;
      case 5: if( rx-hy <= 0 ) answer = diagonal[whi][2];
         break;
      case 6: if( ry-hx >= edge ) answer = diagonal[whi][2];
         break;
      case 7: if( ry+hx < edge ) answer = diagonal[whi][2];
         break;
      case 8: if( rx+ry > box_wide ) answer = diagonal[whi][2];
         break;
      case 9: if( rx-ry > 0 ) answer = diagonal[whi][2];
         break;
      case 10: if( rx+hy >= edge )
               {  answer = diagonal[whi][2];
                  if( ry+hx > edge )
                     answer = diagonal[whi][3];
               }
               break;
      case 11: if( ry-hx > 0 )
               {  answer = diagonal[whi][2];
                  if( rx-hy <= 0 )
                     answer = diagonal[whi][3];
               }
               break;
      case 12: if( rx+hy <= edge )
               {  answer = diagonal[whi][2];
                  if( ry+hx < edge )
                     answer = diagonal[whi][3];
               }
               break;
      case 13: if( ry-hx < edge )
               {  answer = diagonal[whi][2];
                  if( rx-hy >= edge )
                     answer = diagonal[whi][3];
               }
               break;
   }  /* end switch */
   return( answer );
}  /* end of fix_it() */


