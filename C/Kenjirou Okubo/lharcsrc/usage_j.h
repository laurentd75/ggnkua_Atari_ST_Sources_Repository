/*************************************************
	LHarc version 1.13b (c) Yoshi 1988-89.
	usage & message module : 1989/ 5/14

HTAB = 4
*************************************************/

char title[] = "\nLHarc 1.13b (c)Yoshi, 1988-89.\n";

char use[] =
"LHarc  version 1.13b            Copyright(c) H.Yoshizaki�i�g��h�ׁj, 1988-89.\n"
"============================================================= 1989 - 5 - 14 ===\n"
"                     <<< �����k���ɊǗ��v���O���� >>>\n"
"===============================================================================\n"
"  �g�p�@�FLHarc [<����>] [{/|-}{<�X�C�b�`>[-|+|2|<�I�v�V����>]}...] <���ɖ�>\n"
"                  [<�h���C�u��>:|<��f�B���N�g����>\\] [<�p�X��> ...]\n"
"-------------------------------------------------------------------------------\n"
"  �s���߁t\n"
"     a: ���ɂɃt�@�C����ǉ�          u: ���ɂɃt�@�C����ǉ��i�����ƍ��t�j\n"
"     f: ���ɂ̃t�@�C�����X�V          m: ���ɂɃt�@�C�����ړ��i�����ƍ��t�j\n"
"     d: ���ɓ��̃t�@�C���̍폜      e,x: ���ɂ���t�@�C�������o��\n"
"     p: ���ɓ��̃t�@�C���̉{��      l,v: ���ɂ̈ꗗ�\��\n"
"     s: ���ȉ𓀏��ɂ̍쐬            t: ���ɓ��̃t�@�C���� CRC �`�F�b�N\n"
"  �s�X�C�b�`�t\n"
"     r: �ċA�I���W���s��              w: ���[�N�f�B���N�g���̎w��\n"
"     x: �f�B���N�g������L���ɂ���    m: �₢���킹���s��Ȃ�\n"
"     p: ���O�̔�r�������ɍs��        c: �����ƍ����s��Ȃ�\n"
"     a: �S�����𓀌��̑ΏۂƂ���      v: ���̃��[�e�B���e�B�Ńt�@�C�����{��\n"
"     n: �o�ߕ\�������Ȃ�              k: �������s�̃L�[���[�h�̐ݒ�\n"
"     t: ���ɂ̎������ŐV�̃t�@�C����\n"
"===============================================================================\n"
"  �]�ځE�Ĕz�z�Ȃǂ͎��R�ł��B                           Nifty-Serve  PFF00253\n"
"  �i�ڂ����͎g�p�̎�����������������B�j                 ASCII-pcs    pcs02846";

char M_UNKNOWNERR[]	=	"�����G���[�ł��D����󋵂����񍐂�������";
char M_INVCMDERR[]	=	"���̂悤�Ȗ��߂͂���܂���";
char M_MANYPATERR[]	=	"�R�}���h���C���̃t�@�C���������߂��܂�";
char M_NOARCNMERR[]	=	"���Ƀt�@�C�������w�肵�Ă�������";
char M_NOFNERR[]	=	"�t�@�C�������w�肵�Ă�������";
char M_NOARCERR[]	=	"���Ƀt�@�C����������܂���";
char M_RENAMEERR[]	=	"���Ƀt�@�C���̖��O��ύX�ł��܂���";
char M_MKTMPERR[]	=	"��ƃt�@�C�����쐬�ł��܂���";
char M_DUPFNERR[]	=	"�قȂ�p�X�ɓ����̃t�@�C��������܂�";
char M_TOOMANYERR[]	=	"�p�X���̎w�肪���߂��܂�";
char M_TOOLONGERR[]	=	"�p�X�������߂��܂�";
char M_NOFILEERR[]	=	"�t�@�C����������܂���";
char M_MKFILEERR[]	=	"�t�@�C�����쐬�ł��܂���";
char M_RDERR[]		=	"�t�@�C�����ǂ߂܂���";
char M_WTERR[]		=	"�t�@�C���������܂���";
char M_MEMOVRERR[]	=	"�������s���ł�";
char M_INVSWERR[]	=	"�����ȃX�C�b�`���w�肳��Ă��܂�";
char M_CTRLBRK[]	=	"�����I�����܂�";
char M_NOMATCHERR[]	=	"��v����t�@�C��������܂���";
char M_COPYERR[]	=	"��ƃt�@�C���̃R�s�[�Ɏ��s���܂���";
char M_NOTLZH[]		=	"���� '%s' �̊g���q�� '.LZH' �ƈقȂ�܂����A"
						"��Ƃ𑱂��܂��� [Y/N] ";
char M_OVERWT[]		=	"���������Ă������ł��� [Y/N] ";
char M_MKDIR[]		=	"�f�B���N�g�����쐬���Ă������ł��� [Y/N] ";
char M_MKDIRERR[]	=	"�f�B���N�g�����쐬�ł��܂���";
char M_CRCERR[]		=	"CRC Err\n";
char M_RDONLY[]		=	"�������݋֎~�ł�";

char *errmes[] = {
	M_UNKNOWNERR, M_INVCMDERR, M_MANYPATERR, M_NOARCNMERR,
	M_NOFNERR, M_NOARCERR, M_RENAMEERR, M_MKTMPERR,
	M_DUPFNERR, M_TOOMANYERR, M_TOOLONGERR, M_NOFILEERR,
	M_MKFILEERR, M_RDERR, M_WTERR, M_MEMOVRERR, M_INVSWERR,
	M_CTRLBRK, M_NOMATCHERR, M_COPYERR,
	M_NOTLZH, M_OVERWT, M_MKDIR, M_MKDIRERR, M_CRCERR,
	M_RDONLY
};
