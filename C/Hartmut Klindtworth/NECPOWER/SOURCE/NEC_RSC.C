#define T0OBJ 0
#define T1OBJ 27
#define T2OBJ 63
#define FREEBB 1
#define FREEIMG 3
#define FREESTR 157

char *rs_strings[] = {
"",
"ALLES",
"",
"",
"SELEKTIERTES",
"",
"",
"KONFIGURATION",
"",
"",
" 1. Titel 12345678",
"",
"",
"1. BUTO",
"",
"",
"123456789112345678",
"",
"",
"2. BUTO",
"",
"",
"123456789012345678",
"",
"",
"3. BUTO",
"",
"",
"123456789012345678",
"",
"",
"4. BUTO",
"",
"",
"OK",
" Abbruch ",
"",
"",
"Sichern",
"",
"",
"Anzeigenkonfiguration",
"",
"",
"TYPEST.+PITCH SEL.",
"",
"",
"PRINT STYLE",
"",
"",
"12 CPI DRAFT SPEED",
"",
"",
"LANGUAGE CHAR SET",
"",
"",
"DEFAULT CHAR SET",
"",
"",
"SHAPE OF ZERO",
"",
"",
"GRAPHIS PRINT DIR.",
"",
"",
"QUIET MODE",
"",
"",
"FF LENGTH",
"",
"",
"SKIP OVER EMU.",
"",
"",
"LINES PER INCH",
"",
"",
"0 MARGIN EMU.",
"",
"",
"AUTO TEAR OFF",
"",
"",
"CUTTER POSITION",
"",
"",
"CR FUNCTION",
"",
"",
"LF FUNCTION",
"",
"",
"BUFFER FULL LF",
"",
"",
"PULL TRACTOR",
"",
"",
"SHEET FEEDER LM",
"",
"",
"DOWNLOAD CAPACITY",
"",
"",
"BAUD RATE",
"",
"",
"WORD LENGTH",
"",
"",
"PARITY CHECK",
"",
"",
"DCD SIGNALS",
"",
"",
"COMMUNIC. PROT.",
"",
"",
"DRAFT HORIZ. ALL.",
"",
"",
"LQ HORIZ. ALIGNEMT",
"",
"",
"OK",
" Abbruch ",
"",
"",
"Information",
"",
"",
"d. h. es darf f�r nicht-kommerzielle",
"",
"",
"NEC Power\xbf" " ist Freeware,",
"",
"",
"Zwecke frei benutzt und kopiert",
"",
"",
"Bei Fragen wenden Sie sich bitte an:",
"",
"",
"werden. [Zu finden in der MAXON-PD]",
"",
"",
"Hartmut Klindtworth",
"",
"",
"Winterbeker Weg 26b",
"",
"",
"D-w2300 Kiel 1 (Germany)",
"",
"",
"OK"};

int  IMAG0[] = {
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0xFE, 
0x1FB, 0xFFF8, 0x1FC, 0xF, 
0xFE00, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x1F, 
0x60, 0xF078, 0x706, 0x4003, 
0xC380, 0x0, 0x0, 0x0, 
0xF91, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x3F, 
0x61, 0xE018, 0x1E03, 0xC003, 
0xC3C0, 0x0, 0x0, 0x0, 
0xA9B, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x3F, 
0x41, 0xE018, 0x3C01, 0xC007, 
0x81E0, 0x0, 0x0, 0x0, 
0x215, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x3F, 
0x80C1, 0xE018, 0x7801, 0xC007, 
0x81E0, 0x0, 0x0, 0x0, 
0x211, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x67, 
0x80C1, 0xE018, 0xF801, 0x8007, 
0x81E0, 0x0, 0x0, 0x0, 
0x211, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x67, 
0x80C3, 0xC000, 0xF001, 0x8007, 
0x83E0, 0x0, 0x0, 0x0, 
0x73B, 0x8000, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x67, 
0xC183, 0xC601, 0xF001, 0x800F, 
0x3E0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x43, 
0xC183, 0xC601, 0xE001, 0x800F, 
0x3C0, 0x0, 0x0, 0x8, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0xC3, 
0xC187, 0xCC03, 0xE000, 0xF, 
0x78F, 0xC1F0, 0xF3C0, 0xF8FB, 
0xC000, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0xC1, 
0xE107, 0xFC03, 0xE000, 0x1F, 
0xF38, 0x60F0, 0xF3C3, 0x9C7F, 
0xC000, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0xC1, 
0xE307, 0x8C03, 0xC000, 0x1F, 
0xFC78, 0x70E0, 0xE1C7, 0x1C79, 
0xC000, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x81, 
0xE307, 0x8C03, 0xC000, 0x1E, 
0xF0, 0x70E0, 0xE0C7, 0x1CF8, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x180, 
0xF30F, 0xC03, 0xC000, 0x1E, 
0xE0, 0x71E1, 0xE0CE, 0x3CF0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x180, 
0xF20F, 0x803, 0xC000, 0x3C, 
0x1E0, 0x71E1, 0xE0CE, 0x38F0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x100, 
0xFE0F, 0x63, 0xC000, 0x3C, 
0x1E0, 0xF1C1, 0xC09F, 0xC0E0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x300, 
0x7E1F, 0x63, 0xC000, 0x3C, 
0x1C0, 0xF3C3, 0xC19E, 0x1E0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x300, 
0x7E1E, 0x43, 0xC006, 0x3C, 
0x1C0, 0xF3C3, 0xC31C, 0x1E0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x300, 
0x7C1E, 0xC1, 0xC00C, 0x78, 
0x1C1, 0xE387, 0x821C, 0x1C0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x200, 
0x3C1E, 0x1C1, 0xC018, 0x78, 
0x1C1, 0xC38F, 0x861C, 0x19C0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x600, 
0x3C3C, 0x380, 0xE030, 0x78, 
0xC3, 0x838B, 0x8C0C, 0x33C0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x3FC0, 
0x1EFF, 0xFF80, 0x38E0, 0x3FE, 
0xE7, 0x3B3, 0xB006, 0x63C0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x700, 0x0, 
0x3C, 0xC0, 0xC001, 0x8000, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0, 
0x0, 0x0, 0x0, 0x0};

int  IMAG1[] = {
0x1FC0, 0x1FC0, 0x1FC0, 0x1FC0, 
0x1FC0, 0x1FC0, 0x1FC0, 0x1FC0, 
0x1FC0, 0x1FC0, 0x1FC0, 0x1FC0, 
0x1FC0, 0xFFF8, 0xFFF8, 0xBFF8, 
0xFFC8, 0xFFF8};

int  IMAG2[] = {
0x0, 0xF80, 0x880, 0xF80, 
0x80, 0xE00, 0xB80, 0x880, 
0x880, 0x880, 0x880, 0x880, 
0x880, 0x880, 0x78F0, 0x4010, 
0x7FF0, 0x0};

long rs_frstr[] = {
0};

BITBLK rs_bitblk[] = {
(int *)0L, 32, 33, 0, 0, 1};

long rs_frimg[] = {
0};

ICONBLK rs_iconblk[] = {
(int *)1L, (int *)2L, (char *)0L, 4096,0,0, 0,0,16,18, 0,0,0,8};

TEDINFO rs_tedinfo[] = {
(char *)1L, (char *)2L, (char *)3L, 5, 6, 2, 0x1180, 0x0, -1, 6,1,
(char *)4L, (char *)5L, (char *)6L, 5, 6, 2, 0x1180, 0x0, -1, 13,1,
(char *)7L, (char *)8L, (char *)9L, 5, 6, 2, 0x1180, 0x0, -2, 14,1,
(char *)10L, (char *)11L, (char *)12L, 3, 6, 0, 0x1180, 0x0, -1, 19,1,
(char *)13L, (char *)14L, (char *)15L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
(char *)16L, (char *)17L, (char *)18L, 3, 6, 0, 0x1180, 0x0, -1, 19,1,
(char *)19L, (char *)20L, (char *)21L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
(char *)22L, (char *)23L, (char *)24L, 3, 6, 0, 0x1180, 0x0, -1, 19,1,
(char *)25L, (char *)26L, (char *)27L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
(char *)28L, (char *)29L, (char *)30L, 3, 6, 0, 0x1180, 0x0, -1, 19,1,
(char *)31L, (char *)32L, (char *)33L, 3, 6, 2, 0x1180, 0x0, -1, 8,1,
(char *)35L, (char *)36L, (char *)37L, 3, 6, 2, 0x1180, 0x0, -2, 10,1,
(char *)38L, (char *)39L, (char *)40L, 3, 6, 2, 0x1180, 0x0, -2, 8,1,
(char *)41L, (char *)42L, (char *)43L, 3, 6, 2, 0x1180, 0x0, 0, 22,1,
(char *)44L, (char *)45L, (char *)46L, 5, 6, 2, 0x1180, 0x0, 0, 19,1,
(char *)47L, (char *)48L, (char *)49L, 5, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)50L, (char *)51L, (char *)52L, 5, 6, 2, 0x1180, 0x0, 0, 19,1,
(char *)53L, (char *)54L, (char *)55L, 5, 6, 2, 0x1180, 0x0, 0, 18,1,
(char *)56L, (char *)57L, (char *)58L, 5, 6, 2, 0x1180, 0x0, 0, 17,1,
(char *)59L, (char *)60L, (char *)61L, 5, 6, 2, 0x1180, 0x0, 0, 14,1,
(char *)62L, (char *)63L, (char *)64L, 5, 6, 2, 0x1180, 0x0, 0, 19,1,
(char *)65L, (char *)66L, (char *)67L, 5, 6, 2, 0x1180, 0x0, 0, 11,1,
(char *)68L, (char *)69L, (char *)70L, 5, 6, 2, 0x1180, 0x0, 0, 10,1,
(char *)71L, (char *)72L, (char *)73L, 5, 6, 2, 0x1180, 0x0, 0, 15,1,
(char *)74L, (char *)75L, (char *)76L, 5, 6, 2, 0x1180, 0x0, 0, 15,1,
(char *)77L, (char *)78L, (char *)79L, 5, 6, 2, 0x1180, 0x0, 0, 14,1,
(char *)80L, (char *)81L, (char *)82L, 5, 6, 2, 0x1180, 0x0, 0, 14,1,
(char *)83L, (char *)84L, (char *)85L, 5, 6, 2, 0x1180, 0x0, 0, 16,1,
(char *)86L, (char *)87L, (char *)88L, 5, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)89L, (char *)90L, (char *)91L, 5, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)92L, (char *)93L, (char *)94L, 5, 6, 2, 0x1180, 0x0, 0, 15,1,
(char *)95L, (char *)96L, (char *)97L, 5, 6, 2, 0x1180, 0x0, 0, 13,1,
(char *)98L, (char *)99L, (char *)100L, 5, 6, 2, 0x1180, 0x0, 0, 16,1,
(char *)101L, (char *)102L, (char *)103L, 5, 6, 2, 0x1180, 0x0, 0, 18,1,
(char *)104L, (char *)105L, (char *)106L, 5, 6, 2, 0x1180, 0x0, 0, 10,1,
(char *)107L, (char *)108L, (char *)109L, 5, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)110L, (char *)111L, (char *)112L, 5, 6, 2, 0x1180, 0x0, 0, 13,1,
(char *)113L, (char *)114L, (char *)115L, 5, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)116L, (char *)117L, (char *)118L, 5, 6, 2, 0x1180, 0x0, 0, 16,1,
(char *)119L, (char *)120L, (char *)121L, 5, 6, 2, 0x1180, 0x0, 0, 18,1,
(char *)122L, (char *)123L, (char *)124L, 5, 6, 2, 0x1180, 0x0, 0, 19,1,
(char *)126L, (char *)127L, (char *)128L, 3, 6, 2, 0x1180, 0x0, -2, 10,1,
(char *)129L, (char *)130L, (char *)131L, 3, 6, 2, 0x1180, 0x0, 0, 12,1,
(char *)132L, (char *)133L, (char *)134L, 5, 6, 0, 0x1180, 0x0, -1, 37,1,
(char *)135L, (char *)136L, (char *)137L, 3, 6, 0, 0x1180, 0x0, -1, 25,1,
(char *)138L, (char *)139L, (char *)140L, 5, 6, 0, 0x1180, 0x0, -1, 32,1,
(char *)141L, (char *)142L, (char *)143L, 5, 6, 0, 0x1180, 0x0, -1, 37,1,
(char *)144L, (char *)145L, (char *)146L, 5, 6, 0, 0x1180, 0x0, -1, 36,1,
(char *)147L, (char *)148L, (char *)149L, 5, 6, 2, 0x1180, 0x0, -1, 20,1,
(char *)150L, (char *)151L, (char *)152L, 5, 6, 2, 0x1180, 0x0, -1, 20,1,
(char *)153L, (char *)154L, (char *)155L, 5, 6, 2, 0x1180, 0x0, -1, 25,1};

OBJECT rs_object[] = {
-1, 1, 25, G_BOX, NONE, NORMAL, 0x1181L, 0,0, 32,11,
3, 2, 2, G_IMAGE, 0x5, NORMAL, 0x0L, 0,0, 32,258,
1, -1, -1, G_ICON, TOUCHEXIT, NORMAL, 0x0L, 796,2048, 4096,4608,
8, 4, 7, G_BOX, NONE, NORMAL, 0xFF1141L, 0,514, 32,257,
7, 5, 6, G_IBOX, NONE, NORMAL, 0x1100L, 1803,256, 276,513,
6, -1, -1, G_BOXTEXT, 0x15, SELECTED, 0x0L, 257,768, 8,2560,
4, -1, -1, G_BOXTEXT, 0x15, NORMAL, 0x1L, 1545,768, 10,2560,
3, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0x2L, 512,1024, 10,2560,
22, 9, 21, G_BOX, NONE, NORMAL, 0x1141L, 0,771, 32,262,
10, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x1011101L, 541,512, 514,513,
19, 11, 17, G_BOX, NONE, NORMAL, 0xFF1101L, 1280,768, 1819,2821,
13, 12, 12, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x3L, 0,0, 1819,1537,
11, -1, -1, G_BOXTEXT, TOUCHEXIT, SHADOWED, 0x4L, 1554,512, 1544,1,
15, 14, 14, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x5L, 0,1793, 1819,1537,
13, -1, -1, G_BOXTEXT, TOUCHEXIT, SHADOWED, 0x6L, 1554,512, 1544,1,
17, 16, 16, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x7L, 0,3586, 1819,1537,
15, -1, -1, G_BOXTEXT, TOUCHEXIT, SHADOWED, 0x8L, 1554,512, 1544,1,
10, 18, 18, G_BOXTEXT, TOUCHEXIT, NORMAL, 0x9L, 0,1284, 1819,1537,
17, -1, -1, G_BOXTEXT, TOUCHEXIT, SHADOWED, 0xAL, 1810,512, 1544,1,
21, 20, 20, G_BOX, TOUCHEXIT, NORMAL, 0xFF1111L, 797,1025, 2,2307,
19, -1, -1, G_BOX, TOUCHEXIT, NORMAL, 0xFF1101L, 0,0, 2,1,
8, -1, -1, G_BOXCHAR, TOUCHEXIT, NORMAL, 0x2011101L, 541,3332, 514,513,
25, 23, 24, G_IBOX, NONE, NORMAL, 0x11100L, 1290,1033, 1045,3329,
24, -1, -1, G_BUTTON, 0x7, NORMAL, 0x22L, 1025,1536, 8,1,
22, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0xBL, 523,1536, 9,1,
0, 26, 26, G_BOX, NONE, NORMAL, 0xFF1101L, 0,1289, 1290,2817,
25, -1, -1, G_BOXTEXT, 0x25, NORMAL, 0xCL, 769,1280, 8,1,
-1, 1, 35, G_BOX, NONE, NORMAL, 0x1181L, 0,0, 32,267,
2, -1, -1, G_BOXTEXT, NONE, NORMAL, 0xDL, 0,0, 32,2049,
32, 3, 18, G_BOX, NONE, NORMAL, 0x1141L, 0,1793, 32,3335,
18, 4, 17, G_BOX, NONE, NORMAL, 0xFF1101L, 1025,1792, 1037,7,
5, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0xEL, 0,0, 1037,2048,
6, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0xFL, 0,2048, 1037,2048,
7, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x10L, 0,1, 1037,2048,
8, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x11L, 0,2049, 1037,2048,
9, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x12L, 0,2, 1037,2048,
10, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x13L, 0,2050, 1037,2048,
11, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x14L, 0,3, 1037,2048,
12, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x15L, 0,2051, 1037,2048,
13, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x16L, 0,4, 1037,2048,
14, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x17L, 0,2052, 1037,2048,
15, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x18L, 0,5, 1037,2048,
16, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x19L, 0,2053, 1037,2048,
17, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1AL, 0,6, 1037,2048,
3, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1BL, 0,2054, 1037,2048,
2, 19, 31, G_BOX, NONE, NORMAL, 0xFF1101L, 1808,1792, 1037,2054,
20, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1CL, 0,0, 1037,2048,
21, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1DL, 0,2048, 1037,2048,
22, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1EL, 0,1, 1037,2048,
23, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x1FL, 0,2049, 1037,2048,
24, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x20L, 0,2, 1037,2048,
25, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x21L, 0,2050, 1037,2048,
26, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x22L, 0,3, 1037,2048,
27, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x23L, 0,2051, 1037,2048,
28, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x24L, 0,4, 1037,2048,
29, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x25L, 0,2052, 1037,2048,
30, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x26L, 0,5, 1037,2048,
31, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x27L, 0,2053, 1037,2048,
18, -1, -1, G_BOXTEXT, SELECTABLE, SELECTED, 0x28L, 0,6, 1037,2048,
35, 33, 34, G_IBOX, NONE, NORMAL, 0x11100L, 1290,1033, 1045,3329,
34, -1, -1, G_BUTTON, 0x7, NORMAL, 0x7DL, 1025,1536, 8,1,
32, -1, -1, G_BOXTEXT, 0x5, NORMAL, 0x29L, 523,1536, 9,1,
0, -1, -1, G_BOX, LASTOB, NORMAL, 0xFF1101L, 0,1289, 1290,2817,
-1, 1, 14, G_BOX, NONE, NORMAL, 0x1181L, 0,0, 32,11,
2, -1, -1, G_BOXTEXT, NONE, NORMAL, 0x2AL, 0,0, 32,2049,
12, 3, 3, G_BOX, NONE, NORMAL, 0x1141L, 0,1793, 32,3335,
2, 4, 11, G_BOX, NONE, NORMAL, 0xFF1101L, 1537,3584, 1052,6,
5, -1, -1, G_TEXT, NONE, NORMAL, 0x2BL, 1024,2049, 1563,2048,
6, -1, -1, G_TEXT, NONE, NORMAL, 0x2CL, 1024,1024, 25,1,
7, -1, -1, G_TEXT, NONE, NORMAL, 0x2DL, 1024,2, 1051,2048,
8, -1, -1, G_TEXT, NONE, NORMAL, 0x2EL, 1024,1027, 1051,2048,
9, -1, -1, G_TEXT, NONE, NORMAL, 0x2FL, 1024,2050, 1051,2048,
10, -1, -1, G_TEXT, NONE, NORMAL, 0x30L, 1024,4, 1051,2048,
11, -1, -1, G_TEXT, NONE, NORMAL, 0x31L, 1024,2052, 1051,2048,
3, -1, -1, G_TEXT, NONE, NORMAL, 0x32L, 1024,5, 1051,2048,
14, 13, 13, G_IBOX, NONE, NORMAL, 0x11100L, 1290,1033, 1045,3329,
12, -1, -1, G_BUTTON, 0x7, NORMAL, 0x9CL, 1025,1536, 8,1,
0, -1, -1, G_BOX, LASTOB, NORMAL, 0xFF1101L, 0,1289, 1290,2817};

long rs_trindex[] = {
0L,
27L,
63L};

struct foobar {
	int 	dummy;
	int 	*image;
	} rs_imdope[] = {
0, &IMAG0[0],
0, &IMAG1[0],
0, &IMAG2[0]};

#define NUM_STRINGS 157
#define NUM_FRSTR 0
#define NUM_IMAGES 3
#define NUM_BB 1
#define NUM_FRIMG 0
#define NUM_IB 1
#define NUM_TI 51
#define NUM_OBS 78
#define NUM_TREE 3

char pname[] = "NEC_RSC.RSC";
