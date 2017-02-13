#!/bin/ksh

#########################
# Name: src_deblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Delobbing OBSD base
#       sources for use in
#       LBSD.
#########################

# Usage: src_deblob.sh

. ./libdeblob.sh

PATCH_DIR=/tmp/src_deblob/

if [ -e $PATCH_DIR ]
then
        self_destruct_sequence $PATCH_DIR
else
        mkdir $PATCH_DIR
fi

if test -z $1
then
        SRC_DIR=/usr/src/
	mkdir $SRC_DIR
else
        SRC_DIR=$1
fi

echo $SRC_DIR

arch_list="amd64 i386"

for arch in $arch_list # not all archs have ramdisk_cd... fix!
do
	linedel "\${DESTDIR}/etc/firmware/kue.*" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/bnx-b06" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/bnx-b09"  distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/bnx-rv2p" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/bnx-xi-rv2p" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/bnx-xi90-rv2p" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2561" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2561s" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2661" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2860" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2573" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt2870" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/ral-rt3071" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/rum-rt2573" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/run-rt2870" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/run-rt3071" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/tigon1" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/tigon2" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/zd1211" distrib/${arch}/ramdisk_cd/list.local
	linedel "\${DESTDIR}/etc/firmware/zd1211b" distrib/${arch}/ramdisk_cd/list.local
done

linedel "pkg_add pkg_sign" usr.sbin/pkg_add/Makefile
rep "pkg_add fw_update" "pkg_add pkg_sign" usr.sbin/pkg_add/Makefile
strdel "fw_update" usr.sbin/pkg_add/Makefile
linedel "FwUpdate.pm" usr.sbin/pkg_add/Makefile

# Remove fw man pages and fw_update from base set, etc.
for arch in $arch_list
do
	linedel "./usr/libdata/perl5/OpenBSD/FwUpdate.pm" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/sbin/fw_update" "distrib/sets/lists/base/md.${arch}"

	linedel "./usr/share/man/man1/fw_update.1" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/acx.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/adw.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/adv.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/athn.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/bnx.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/bwi.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/drm.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/fxp.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/inteldrm.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/ips.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/ipw.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/iwi.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/iwm.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/iwn.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/kue.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/malo.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/myx.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/neo.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/otus.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/pgt.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/radeondrm.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/ral.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/rsu.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/rtwn.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/rum.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/siop.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/tht.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/thtc.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/ti.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/uath.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/udl.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/ulpt.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/upgt.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/urtwn.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/uvideo.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/wpi.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/yds.4" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/share/man/man4/zyd.4" "distrib/sets/lists/base/md.${arch}"
done
# Remove non-free fw man pages from their makefile
fw_list="acx adw adv athn bnx bwi drm fxp inteldrm ips ipw iwi iwm iwn kue malo myx neo otus pgt ral"
fw_list="$fw_list radeondrm rsu rtwn rum siop tht thtc ti uath udl ulpt upgt urtwn uvideo wpi yds zyd"
for man_blob in $fw_list
do
	strdel " ${man_blob}.4" share/man/man4/Makefile
	strdel "\^${man_blob}.4" share/man/man4/Makefile
done

linedel "MLINKS+=adv.4 adw.4" share/man/man4/Makefile
linedel "MLINKS+=drm.4 inteldrm.4 drm.4 radeondrm.4" share/man/man4/Makefile
linedel "MLINKS+=tht.4 thtc.4" share/man/man4/Makefile

# Add Free Software-related man pages
filecp files/fsdg.7 share/man/man7/fsdg.7
filecp files/free-software.7 share/man/man7/free-software.7
rep "environ.7 glob.7 hier.7 hostname.7 intro.7 kgdb.7 " "environ.7 free-software.7 fsdg.7 glob.7 hier.7 " share/man/man7/Makefile
rep "library-specs.7 mailaddr.7" "hostname.7 intro.7 kgdb.7 library-specs.7 mailaddr.7" share/man/man7/Makefile
lineadd "./usr/share/man/man7/free-software.7" "./usr/share/man/man7/packages.7" distrib/sets/lists/base/mi
lineadd "./usr/share/man/man7/fsdg.7" "./usr/share/man/man7/packages.7" distrib/sets/lists/base/mi
lineadd "man7/eqn.7" "./usr/share/man/man7/free-software.7" distrib/sets/lists/man/mi
lineadd "man7/free-software.7" "./usr/share/man/man7/fsdg.7" distrib/sets/lists/man/mi
linedel "./usr/share/man/man1/fw_update.1" distrib/sets/lists/man/mi

apply
