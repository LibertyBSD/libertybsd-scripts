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

filecp files/pixmaps/LibertyBSD_15bpp.xpm app/xenodm/config/LibertyBSD_15bpp.xpm
filecp files/pixmaps/LibertyBSD_1bpp.xpm app/xenodm/config/LibertyBSD_1bpp.xpm
filecp files/pixmaps/LibertyBSD_4bpp.xpm app/xenodm/config/LibertyBSD_4bpp.xpm
filecp files/pixmaps/LibertyBSD_8bpp.xpm app/xenodm/config/LibertyBSD_8bpp.xpm

rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Xresources.in
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.in
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.am
rep "OpenBSD_" "LibertyBSD_" app/xenodm/Makefile.bsd-wrapper

rep "pixmaps/OpenBSD" "pixmaps/LibertyBSD" distrib/sets/lists/xshare/mi

apply
