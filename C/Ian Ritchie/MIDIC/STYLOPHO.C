/*-----------------------------------------------------------------------*/
/*--------------------- ATARI STYLOPHONE SIMULATION ---------------------*/
/*-----------------------------------------------------------------------*/
 
 
#include <stdio.h>
#include <osbind.h>
 
#define BELL printf("\7") 
#define MIDI 3
                
int ftune[97] = {
 
0xFF, 
0x5D, 0x9C, 0xE7, 0x3C, 0x9B, 0x2, 0x73, 0xEB, 0x6B, 0xF2, 
0x80, 0x14, 0xAE, 0x4E, 0xF4, 0x9E, 0x4D, 0x1, 0xB9, 0x75, 
0x35, 0xF9, 0xC0, 0x8A, 0x57, 0x27, 0xFA, 0xCF, 0xA7, 0x81, 
0x5D, 0x36, 0x1B, 0xFC, 0xE0, 0xC5, 0xAC, 0x94, 0x7D, 0x68, 
0x53, 0x40, 0x2E, 0x1D, 0xD, 0xFE, 0xF0, 0xE2, 0xD8, 0xCA, 
0xBE, 0xB4, 0xAA, 0xA0, 0x97, 0x8F, 0x87, 0x7F, 0x78, 0x71, 
0x6B, 0x65, 0x5F, 0x5A, 0x55, 0x50, 0x4C, 0x47, 0x43, 0x40, 
0x3C, 0x39, 0x35, 0x32, 0x30, 0x2D, 0x2A, 0x28, 0x26, 0x24, 
0x22, 0x20, 0x1E, 0x1C, 0x1B, 0x19, 0x18, 0x16, 0x15, 0x14, 
0x13, 0x12, 0x11, 0x10, 0xF, 0xE};
 
int ctune[97] = {
 
0xFF, 
0xD, 0xC, 0xB, 0xB, 0xA, 0xA, 0x9, 0x8, 0x8, 0x7, 
0x7, 0x7, 0x6, 0x6, 0x5, 0x5, 0x5, 0x5, 0x4, 0x4, 
0x4, 0x3, 0x3, 0x3, 0x3, 0x3, 0x2, 0x2, 0x2, 0x2, 
0x2, 0x2, 0x2, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 
0x1, 0x1, 0x1, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 0x0, 0x0};
 
 
sound(frq, vme)                        /* play internal soundchip */
unsigned char frq, vme;
{
        frq = frq - 25;
        vme = vme / 9;                   /* compress volume data */
        Giaccess(vme, 0x88);
        Giaccess(ftune[frq], 0x80);
        Giaccess(ctune[frq], 0x81);
}
 
      
main()
{
unsigned char m, note, velocity;
BELL;
m=0;
     while (m != 192)                   /* exit on program change */
     {
          m = Bconin(MIDI);
          if (m > 143 && m < 159)   /* is a note on ( any midi channel)*/
          {
               note = Bconin(MIDI);
               velocity = Bconin(MIDI);
               if (!velocity)sound(note, 0);       /* Note Off */
               else sound(note, velocity);         /* Note On  */
          }
     }
}
 
 
 
 
 
