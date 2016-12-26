#!/bin/sh

#########################
# Name: src_deblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Delobbing OBSD base
#       sources for use in
#       LBSD.
#########################

# Usage: src_deblob.sh $SRCE_DIR

if [ -k $1 ]
then
	echo "Usage: src_deblob.sh [source directory]"
else
	SRC_DIR="$1"
fi

del "./usr/libdata/perl5/OpenBSD/FwUpdate.pm"
del "./usr/sbin/fw_update"
del "./usr/share/man/man1/fw_update.1"
del "./usr/share/man/man4/acx.4"
del "./usr/share/man/man4/adw.4"
del "./usr/share/man/man4/adv.4"
del "./usr/share/man/man4/athn.4"
del "./usr/share/man/man4/bnx.4"
del "./usr/share/man/man4/bwi.4"
del "./usr/share/man/man4/drm.4"
del "./usr/share/man/man4/fxp.4"
del "./usr/share/man/man4/inteldrm.4"
del "./usr/share/man/man4/ips.4"
del "./usr/share/man/man4/ipw.4"
del "./usr/share/man/man4/iwi.4"
del "./usr/share/man/man4/iwm.4"
del "./usr/share/man/man4/iwn.4"
del "./usr/share/man/man4/kue.4"
del "./usr/share/man/man4/malo.4"
del "./usr/share/man/man4/myx.4"
del "./usr/share/man/man4/neo.4"
del "./usr/share/man/man4/otus.4"
del "./usr/share/man/man4/pgt.4"
del "./usr/share/man/man4/radeondrm.4"
del "./usr/share/man/man4/ral.4"
del "./usr/share/man/man4/rsu.4"
del "./usr/share/man/man4/rtwn.4"
del "./usr/share/man/man4/rum.4"
del "./usr/share/man/man4/siop.4"
del "./usr/share/man/man4/tht.4"
del "./usr/share/man/man4/thtc.4"
del "./usr/share/man/man4/ti.4"
del "./usr/share/man/man4/uath.4"
del "./usr/share/man/man4/udl.4"
del "./usr/share/man/man4/ulpt.4"
del "./usr/share/man/man4/upgt.4"
del "./usr/share/man/man4/urtwn.4"
del "./usr/share/man/man4/uvideo.4"
del "./usr/share/man/man4/wpi.4"
del "./usr/share/man/man4/yds.4"
del "./usr/share/man/man4/zyd.4"

linedel "\${DESTDIR}/etc/firmware/kue.*"
linedel "\${DESTDIR}/etc/firmware/bnx-b06"
linedel "\${DESTDIR}/etc/firmware/bnx-b09"
linedel "\${DESTDIR}/etc/firmware/bnx-rv2p"
linedel "\${DESTDIR}/etc/firmware/bnx-xi-rv2p"
linedel "\${DESTDIR}/etc/firmware/bnx-xi90-rv2p"
linedel "\${DESTDIR}/etc/firmware/ral-rt2561"
linedel "\${DESTDIR}/etc/firmware/ral-rt2561s"
linedel "\${DESTDIR}/etc/firmware/ral-rt2661"
linedel "\${DESTDIR}/etc/firmware/ral-rt2860"
linedel "\${DESTDIR}/etc/firmware/ral-rt2573"
linedel "\${DESTDIR}/etc/firmware/ral-rt2870"
linedel "\${DESTDIR}/etc/firmware/ral-rt3071"
linedel "\${DESTDIR}/etc/firmware/zd1211"
linedel "\${DESTDIR}/etc/firmware/zd1211b"

rdel "fw_update" usr.sbin/pkg_add/Makefile


