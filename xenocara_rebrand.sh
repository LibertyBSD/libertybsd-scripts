#!/bin/sh

#########################
# Name: xenocara_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Rebranding xenocara
#       sources for use in
#       LBSD.
#########################

# Usage: src_deblob.sh $SRCE_DIR

if [ -k $1 ]
then
	echo "Usage: xenocara_rebrand.sh [source directory]"
else
	SRC_DIR="$1"
fi

rep "OpenBSD __osrelease__" "LibertyBSD __osrelease" app/fvwm/sample.fvwmrc/system.fvwmrc
rep "\*:OpenBSD:\*:)" "\*:LibertyBSD:\*:)" app/twm/config.guess

filecp files/LibertyBSD_15bpp.xpm app/xdm/config/LibertyBSD_15bpp.xpm
filecp files/LibertyBSD_1bpp.xpm app/xdm/config/LibertyBSD_1bpp.xpm
filecp files/LibertyBSD_4bpp.xpm app/xdm/config/LibertyBSD_4bpp.xpm
filecp files/LibertyBSD_8bpp.xpm app/xdm/config/LibertyBSD_8bpp.xpm

rep "BITMAPDIR/\*\*//OpenBSD" "BITMAPDIR/**//LibertyBSD" app/xdm/config/Xresources.cpp
rep "--with-color-pixmap=OpenBSD" "--with-color-pixmap=LibertyBSD" app/xdm/Makefile.bsd-wrapper
rep "--with-bw-pixmap=OpenBSD" "--with-bw-pixmap=LibertyBSD" app/xdm/Makefile.bsd-wrapper
rep "/config/OpenBSD_" "/config/LibertyBSD_" app/xdm/Makefile.bsd-wrapper

lineadd "CONFIG_SITE=$(CONFIG_SITE)" "build_alias=\${arch}-unknown-openbsd6.0" app/xlockmore/Makefile.bsd-wrapper
lineadd "\${CONFIGURE_ENV} PATH=\$(XENOCARA_PATH)" "build_alias=\${arch}-unknown-openbsd6.0" share/mk/bsd.xorg.mk
