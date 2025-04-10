/*
 * TT44TT.RSH
 * Konvertierte Resourcedatei f�r TT44TT
 * Copyright (c) 1991 by MAXON Computer
 * Autoren: Oliver Scholz & Uwe Hax
 */

WORD IMAG0[] = {
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF, 
  0xFFFF, 0xFFFF, 0xFFFF, 0xFFFF
};

WORD IMAG1[] = {
  0x0000, 0x03E0, 0x0000, 0x0C7C, 
  0x0000, 0x1186, 0x0000, 0x6203, 
  0x0000, 0x8401, 0x0001, 0x0841, 
  0x0002, 0x10A1, 0x0004, 0x1152, 
  0x0008, 0xF0A2, 0x0011, 0xD844, 
  0x0023, 0xCC08, 0x0046, 0xA610, 
  0x008F, 0x73E0, 0x011A, 0xAB00, 
  0x013D, 0xDC00, 0x022A, 0xA800, 
  0x0477, 0x7000, 0x04AA, 0xA000, 
  0x091D, 0xC000, 0x110A, 0x8000, 
  0x1207, 0x0000, 0x23E2, 0x0000, 
  0x2412, 0x0000, 0x490C, 0x0000, 
  0x5284, 0x0000, 0x6544, 0x0000, 
  0x4AA4, 0x0000, 0x4548, 0x0000, 
  0x2290, 0x0000, 0x2120, 0x0000, 
  0x1040, 0x0000, 0x0F80, 0x0000
};

ICONBLK rs_iconblk[] = {
  IMAG0, IMAG1, "", 4096,6,23,
  0,0,32,32,16,32,0,7,
  IMAG0, IMAG1, "SERIAL 1", 4096,6,23,
  12,0,32,32, 0,32,57,7,
  IMAG0, IMAG1, "SERIAL 2", 4096,6,23,
  12,0,32,32, 0,32,57,7,
  IMAG0, IMAG1, "MODEM 2", 4096,6,23,
  12,0,32,32,0,32,58,7,
  IMAG0, IMAG1, "MODEM 1", 4096,6,23,
  12,0,32,32,0,32,58,7
};

TEDINFO rs_tedinfo[] = {
  "Protokoll", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 10,1,
  "Parit�t", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 8,1,
  "Port konfigurieren", "", "", 3, 6, 2, 0x1071,
  0x0, -1, 19,1,
  "19200", "", "", 3, 6, 2, 0x1180,
  0x0, -1, 6,1,
  "Baudrate", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 9,1,
  "Datenbits", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 10,1,
  "TEXT", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 5,1,
  "2 Bits", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 7,1,
  "1 Bit", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 6,1,
  "Stopbits", "", "", 3, 6, 0, 0x1180,
  0x0, -1, 9,1,
  "TT44TT", "", "", 3, 6, 2, 0x1071,
  0x0, 255, 7,1,
  "Terminal Times Four For TT's", "", "",
  5, 6, 2, 0x1180, 0x0, 255, 29,1,
  "(C) 1991 by Oliver Scholz & Uwe Hax", "", "",
  5, 6, 2, 0x1180, 0x0, 255, 36,1
};

OBJECT rs_object[] = {
  -1, 1, 37, G_BOX, NONE, OUTLINED,
  0x21100L, 0,0, 1325,2064,
  8, 2, 7, G_BOX, NONE, NORMAL,
  0xFF1100L, 2,2563, 1549,773,
  3, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"keines", 1028,3840, 6,1,
  4, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"RTS/CTS", 1028,1538, 7,1,
  5, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"XON/XOFF", 772,3075, 8,1,
  6, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,2306, 257,2304,
  7, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,769, 257,2304,
  1, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,3843, 257,2304,
  15, 9, 14, G_BOX, NONE, NORMAL,
  0xFF1100L, 2,3849, 1549,773,
  10, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"keine", 1284,257, 6,1,
  11, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"ungerade", 772,2819, 8,1,
  12, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,4, 257,2304,
  13, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,1025, 257,2304,
  14, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1537,2562, 257,2304,
  8, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"gerade", 772,1538, 6,1,
  16, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[0], 1027,259, 9,1,
  17, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[1], 1027,1545, 7,1,
  18, -1, -1, G_BOXTEXT, NONE, OUTLINED,
  (LONG)&rs_tedinfo[2], 773,1, 34,1,
  22, 19, 21, G_BOX, NONE, NORMAL,
  0xFF1100L, 785,3849, 1817,2562,
  20, -1, -1, G_BOXTEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[3], 520,3840, 8,1,
  21, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL,
  0x3FF1100L, 1552,3840, 1026,1,
  18, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL,
  0x4FF1100L, 517,3840, 1026,1,
  27, 23, 26, G_BOX, NONE, CROSSED,
  0xFF1101L, 1041,2563, 1548,3075,
  24, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"8 Bits", 1028,1538, 6,1,
  25, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1793,2306, 257,2304,
  26, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"7 Bits", 1028,3840, 6,1,
  22, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1793,513, 257,2304,
  28, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[4], 19,1801, 8,1,
  29, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[5], 275,3, 9,1,
  30, -1, -1, G_BUTTON, 0x5, NORMAL,
  (LONG)"Abbruch", 1558,270, 9,1,
  31, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[6], 1303,1540, 512,512,
  36, 32, 35, G_BOX, NONE, NORMAL,
  0xFF1100L, 1567,2563, 1291,3075,
  33, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[7], 260,1282, 6,1,
  34, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1281,2306, 257,2304,
  35, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[8], 260,3840, 5,1,
  31, -1, -1, G_BOX, 0x51, OUTLINED,
  0xFF1170L, 1281,513, 257,2304,
  37, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[9], 801,259, 8,1,
  0, -1, -1, G_BUTTON, 0x27, NORMAL,
  (LONG)"Ok", 1569,526, 265,3840,
  -1, 1, 9, G_BOX, NONE, OUTLINED,
  0x21100L, 0,0, 1827,3340,
  2, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"Das erste Terminalprogramm", 
  1284,2052, 26,1,
  3, -1, -1, G_BOXTEXT, NONE, OUTLINED,
  (LONG)&rs_tedinfo[10], 1290,3584, 526,1,
  4, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[11], 1542,1538, 791,3584,
  5, -1, -1, G_ICON, SELECTABLE, NORMAL,
  (LONG)&rs_iconblk[0], 1026,3328, 4,1794,
  6, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"f�r den Atari TT und Mega STE",
  515,2309, 29,1,
  7, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"mit bis zu 4 Schnittstellen ", 
  260,2566, 28,1,
  8, -1, -1, G_IBOX, NONE, OUTLINED,
  0x11100L, 2,3587, 288,2564,
  9, -1, -1, G_TEXT, NONE, NORMAL,
  (LONG)&rs_tedinfo[12], 1284,1289, 283,3072,
  0, -1, -1, G_BUTTON, 0x27, NORMAL,
  (LONG)"OK", 1292,3594, 1289,257,
  -1, 1, 4, G_BOX, NONE, NORMAL,
  0x1141L, 0,0, 45,20,
  2, -1, -1, G_ICON, SELECTABLE, NORMAL,
  (LONG)&rs_iconblk[1], 2,10, 263,1794,
  3, -1, -1, G_ICON, SELECTABLE, NORMAL,
  (LONG)&rs_iconblk[2], 2,13, 263,1794,
  4, -1, -1, G_ICON, SELECTABLE, NORMAL,
  (LONG)&rs_iconblk[3], 2,7, 519,1794,
  0, -1, -1, G_ICON, 0x21, NORMAL,
  (LONG)&rs_iconblk[4], 2,4, 519,1794,
  -1, 1, 6, G_IBOX, NONE, NORMAL,
  0x0L, 0,0, 90,25,
  6, 2, 2, G_BOX, NONE, NORMAL,
  0x1100L, 0,0, 90,513,
  1, 3, 5, G_IBOX, NONE, NORMAL,
  0x0L, 2,0, 25,769,
  4, -1, -1, G_TITLE, NONE, NORMAL,
  (LONG)" TT44TT ", 0,0, 8,769,
  5, -1, -1, G_TITLE, NONE, NORMAL,
  (LONG)" Datei ", 8,0, 7,769,
  2, -1, -1, G_TITLE, NONE, NORMAL,
  (LONG)" Optionen ", 15,0, 10,769,
  0, 7, 21, G_IBOX, NONE, NORMAL,
  0x0L, 0,769, 340,19,
  16, 8, 15, G_BOX, NONE, NORMAL,
  0xFF1100L, 2,0, 20,8,
  9, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  Zum Programm...   ", 0,0, 20,1,
  10, -1, -1, G_STRING, NONE, DISABLED,
  (LONG)"--------------------", 0,1, 20,1,
  11, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"1", 0,2, 20,1,
  12, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"2", 0,3, 20,1,
  13, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"3", 0,4, 20,1,
  14, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"4", 0,5, 20,1,
  15, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"5", 0,6, 20,1,
  7, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"6", 0,7, 20,1,
  21, 17, 20, G_BOX, NONE, NORMAL,
  0xFF1100L, 10,0, 18,4,
  18, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  �ffnen", 0,0, 18,1,
  19, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  Schlie�en", 0,1, 18,1,
  20, -1, -1, G_STRING, NONE, DISABLED,
  (LONG)"------------------", 0,2, 18,1,
  16, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  Ende", 0,3, 18,1,
  6, 22, 27, G_BOX, NONE, NORMAL,
  0xFF1100L, 17,0, 23,6,
  23, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  Parameter...", 0,0, 23,1,
  24, -1, -1, G_STRING, NONE, DISABLED,
  (LONG)"-----------------------",0,1,23,1,
  25, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  Zoomboxen", 0,2, 23,1,
  26, -1, -1, G_STRING, NONE, DISABLED,
  (LONG)"-----------------------",0,3,23,1,
  27, -1, -1, G_STRING, NONE, NORMAL,
  (LONG)"  INF-Datei laden...", 0,4, 23,1,
  21, -1, -1, G_STRING, LASTOB, NORMAL,
  (LONG)"  INF-Datei sichern...",0,5,23,1
};
  
#define NUM_OBS 81
#define NUM_TREE 4
