- download polarssl 1.3.3 library from https://polarssl.org
- unzip it and copy to your a work folder.
- replace the Makefiles by the ones of this archive.
- replace the include\polarssl\config.h by the one of this archive.
- configured to use the zlib, and SSL/TLS client only.

- read the Makefiles, usage is to build libpolarssl.a for m68000, m68020-60
and mcpu=5475 (comment/uncomment some lines) with cross-compilation
(gcc, MaxOSX and Xcode).