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
strdel "fw_update.1" usr.sbin/pkg_add/Makefile
strdel "fw_update" usr.sbin/pkg_add/Makefile
linedel "FwUpdate.pm" usr.sbin/pkg_add/Makefile

# Remove fw man pages and fw_update from base set, etc.
for arch in $arch_list
do
	linedel "./usr/libdata/perl5/OpenBSD/FwUpdate.pm" "distrib/sets/lists/base/md.${arch}"
	linedel "./usr/sbin/fw_update" "distrib/sets/lists/base/md.${arch}"

	linedel "./etc/firmware/4c9904" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/3c990-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at76c503-i3863-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at77c503-i3863-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at76c503-rfmd-acc-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at76c503-rfmd-acc-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at76c505-rfmd-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-at76c505-rfmd-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-intersil-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-intersil-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd2958-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd2958-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd2958smc-ext" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/atu-rfmd2958smc-int" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-b06" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-b09" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-rv2p" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-xi-rv2p" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/bnx-xi90-rv2p" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/cs4280" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/cs4280-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d101a" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d101b0" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d101ma" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d101s" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d102" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-d102c" "distrib/sets/lists/base/md.${arch}"
	linedel "./etc/firmware/fxp-d102e" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/fxp-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/kue" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/kue-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/myx-eth_z8e" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/myx-ethp_z8e" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/myx-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/ral-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/ral-rt2561" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/ral-rt2561s" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/ral-rt2661" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/ral-rt2860" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/rum-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/rum-rt2573" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/run-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/run-rt2870" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/run-rt3071" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/symbol-eprim" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/symbol-esec" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/symbol-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tht" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tht-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tigon-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tigon1" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tigon2" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tusb3410" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/tusb3410-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/udl_huffman" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/yds" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/yds-license" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/zd1211" "distrib/sets/lists/base/md.${arch}"
        linedel "./etc/firmware/zd1211-license" "distrib/sets/lists/base/md.${arch}"
	linedel "./etc/firmware/zd1211b" "distrib/sets/lists/base/md.${arch}"

done

linedel "./usr/libdata/perl5/OpenBSD/FwUpdate.pm" distrib/sets/lists/base/mi
linedel "./usr/sbin/fw_update" distrib/sets/lists/base/mi

# Add Free Software-related man pages
filecp files/fsdg.7 share/man/man7/fsdg.7
filecp files/free-software.7 share/man/man7/free-software.7
rep "environ.7 glob.7 hier.7 hostname.7 intro.7 kgdb.7 " "environ.7 free-software.7 fsdg.7 glob.7 hier.7 " share/man/man7/Makefile
rep "library-specs.7 mailaddr.7" "hostname.7 intro.7 kgdb.7 library-specs.7 mailaddr.7" share/man/man7/Makefile
lineadd "./usr/share/man/man7/free-software.7" "./usr/share/man/man7/packages.7" distrib/sets/lists/man/mi
lineadd "./usr/share/man/man7/fsdg.7" "./usr/share/man/man7/packages.7" distrib/sets/lists/man/mi
linedel "./usr/share/man/man1/fw_update.1" distrib/sets/lists/man/mi

apply
