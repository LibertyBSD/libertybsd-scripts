#!/bin/sh

#########################
# Name: xenocara_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Rebranding xenocara
#       sources for use in
#       LBSD.
#########################

PATCH_DIR=/tmp/xenocara_rebrand

if [ -e $PATCH_DIR ]
then
	self_destruct_sequence $PATCH_DIR
else
	mkdir $PATCH_DIR
fi

if test -z $1
then
	SRC_DIR=/usr/xenocara
else
	SRC_DIR=$1
fi

. ./libdeblob.sh


rep "OpenBSD __osrelease__" "LibertyBSD __osrelease__" app/fvwm/sample.fvwmrc/system.fvwmrc
rep "Geometry 80x60" "Geometry 90x65" app/fvwm/sample.fvwmrc/system.fvwmrc
lineadd "\*:OpenBSD:\*:)" "\*:LibertyBSD:\*:)" app/twm/config.guess
lineadd "\*:OpenBSD:\*:)" "exit;;" app/twm/config.guess
lineadd "\*:OpenBSD:\*:)" "echo \${UNAME_MACHINE_ARCH}-unknown-openbsd\${UNAME_RELEASE}" app/twm/config.guess
lineadd "\*:OpenBSD:\*:)" "UNAME_MACHINE_ARCH=\`arch | sed 's/OpenBSD.//'\`" app/twm/config.guess

filecp files/pixmaps/LibertyBSD_15bpp.xpm app/xdm/config/LibertyBSD_15bpp.xpm
filecp files/pixmaps/LibertyBSD_1bpp.xpm app/xdm/config/LibertyBSD_1bpp.xpm
filecp files/pixmaps/LibertyBSD_4bpp.xpm app/xdm/config/LibertyBSD_4bpp.xpm
filecp files/pixmaps/LibertyBSD_8bpp.xpm app/xdm/config/LibertyBSD_8bpp.xpm

filecp files/pixmaps/LibertyBSD_15bpp.xpm app/xenodm/config/LibertyBSD_15bpp.xpm
filecp files/pixmaps/LibertyBSD_1bpp.xpm app/xenodm/config/LibertyBSD_1bpp.xpm
filecp files/pixmaps/LibertyBSD_4bpp.xpm app/xenodm/config/LibertyBSD_4bpp.xpm
filecp files/pixmaps/LibertyBSD_8bpp.xpm app/xenodm/config/LibertyBSD_8bpp.xpm

rep "BITMAPDIR/\*\*//OpenBSD" "BITMAPDIR/**//LibertyBSD" app/xdm/config/Xresources.cpp
rep "--with-color-pixmap=OpenBSD" "--with-color-pixmap=LibertyBSD" app/xdm/Makefile.bsd-wrapper
rep "--with-bw-pixmap=OpenBSD" "--with-bw-pixmap=LibertyBSD" app/xdm/Makefile.bsd-wrapper
rep "/config/OpenBSD_" "/config/LibertyBSD_" app/xdm/Makefile.bsd-wrapper

rep "BITMAPDIR/\*\*//OpenBSD" "BITMAPDIR/**//LibertyBSD" app/xenodm/config/Xresources.cpp
rep "--with-color-pixmap=OpenBSD" "--with-color-pixmap=LibertyBSD" app/xenodm/Makefile.bsd-wrapper
rep "--with-bw-pixmap=OpenBSD" "--with-bw-pixmap=LibertyBSD" app/xenodm/Makefile.bsd-wrapper
rep "/config/OpenBSD_" "/config/LibertyBSD_" app/xenodm/Makefile.bsd-wrapper
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.am
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.in

rep "pixmaps/OpenBSD" "pixmaps/LibertyBSD" distrib/sets/lists/xshare/mi

lineadd "*:OpenBSD:*:*)" "*:LibertyBSD:*:*)" font/util/config.guess
lineadd "*:OpenBSD:*:*)" "        exit ;;" font/util/config.guess
lineadd "*:OpenBSD:*:*)" "        echo \${UNAME_MACHINE_ARCH}-unknown-openbsd\${UNAME_RELEASE}" font/util/config.guess
lineadd "*:OpenBSD:*:*)" "        UNAME_MACHINE_ARCH=\`arch | sed 's/OpenBSD.//'\`" font/util/config.guess
rep "sh " "build_alias=\${MACHINE_ARCH}-unknown-openbsd6.2  sh " app/xlockmore/Makefile.bsd-wrapper
rep "exec sh " "build_alias=\${MACHINE_ARCH}-unknown-openbsd6.2  exec sh " share/mk/bsd.xorg.mk

apply
