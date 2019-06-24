#!/bin/sh
########################################
# name: xenocara_rebrand.sh
# main: jadedctrl
# lisc: isc
# desc: rebranding xenocara sources for
#	use in lbsd.
########################################

. ./libdeblob.sh

if test -z $1; then
	echo "usage: xenocara_rebrand.sh xenocara_sources"
	exit 2
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/xenocara_rebrand
mkdir "$PATCH_DIR" 2> /dev/null


# --------------------------------------

rep "OpenBSD __osrelease__" "LibertyBSD __osrelease__" \
	app/fvwm/sample.fvwmrc/system.fvwmrc
rep "Geometry 80x60" "Geometry 90x65" app/fvwm/sample.fvwmrc/system.fvwmrc

filecp files/pixmaps/LibertyBSD_15bpp.xpm \
	app/xenodm/config/LibertyBSD_15bpp.xpm
filecp files/pixmaps/LibertyBSD_1bpp.xpm app/xenodm/config/LibertyBSD_1bpp.xpm
filecp files/pixmaps/LibertyBSD_4bpp.xpm app/xenodm/config/LibertyBSD_4bpp.xpm
filecp files/pixmaps/LibertyBSD_8bpp.xpm app/xenodm/config/LibertyBSD_8bpp.xpm

rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Xresources.in
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.in
rep "OpenBSD_" "LibertyBSD_" app/xenodm/config/Makefile.am
rep "OpenBSD_" "LibertyBSD_" app/xenodm/Makefile.bsd-wrapper

rep "pixmaps/OpenBSD" "pixmaps/LibertyBSD" distrib/sets/lists/xshare/mi

apply
