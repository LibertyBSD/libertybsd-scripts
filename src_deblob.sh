#!/bin/sh
########################################
# name: src_deblob.sh
# main: jadedctrl
# lisc: isc
# desc: delobbing obsd base sources for
#	use in lbsd.
########################################

. ./libdeblob.sh

if test -z "$1"; then
	echo "usage: src_deblob.sh source_dir"; 
	exit 2
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/src_deblob/
mkdir "$PATCH_DIR" 2> /dev/null


# --------------------------------------

arch_list="amd64 i386"

blobs="4c9904 3c990 3c990-license atu-at76c503-i3863-ext"
blobs="$blobs atu-at76c503-i3863-int atu-at76c503-rfmd-acc-ext"
blobs="$blobs atu-at76c503-rfmd-acc-int atu-at76c505-rfmd-ext"
blobs="$blobs atu-at76c505-rfmd-int atu-intersil-ext atu-intersil-int"
blobs="$blobs atu-license atu-rfmd-ext atu-rfmd-int atu-rfmd2958-ext"
blobs="$blobs atu-rfmd2958-int atu-rfmd2958smc-ext atu-rfmd2958smc-int bnx-b06"
blobs="$blobs bnx-b09 bnx-license bnx-rv2p bnx-xi-rv2p bnx-xi90-rv2p cs4280"
blobs="$blobs cs4280-license fxp-d101a fxp-d101b0 fxp-d101ma fxp-d101s fxp-d102"
blobs="$blobs fxp-d102c fxp-d102e fxp-license kue kue-license myx-eth_z8e"
blobs="$blobs myx-ethp_z8e myx-license ral-license ral-rt2561 ral-rt2561s"
blobs="$blobs ral-rt2661 ral-rt2860 ral-rt3290 rum-license rum-rt2573"
blobs="$blobs run-license run-rt2870 run-rt3071 symbol-eprim symbol-esec"
blobs="$blobs symbol-license tht tht-license tigon-license tigon1 tigon2"
blobs="$blobs tusb3410 tusb3410-license udl_huffman yds yds-license zd1211"
blobs="$blobs zd1211-license zd1211b"

for arch in $arch_list; do
	for blob in $blobs; do
		linedel "/etc/firmware/${firmware}" \
			"distrib/${arch}/ramdisk_cd/list"
		linedel "./etc/firmware/$blob" \
			"distrib/sets/lists/base/md.${arch}"
	done
	echo
done

# --------------------------------------

for arch in $arch_list
do
	linedel "./usr/libdata/perl5/OpenBSD/FwUpdate.pm" \
		"distrib/sets/lists/base/md.${arch}"
	linedel "./usr/sbin/fw_update" "distrib/sets/lists/base/md.${arch}"
	echo
done



# --------------------------------------

rep "\^OpenBSD " "\^LibertyBSD " usr.sbin/syspatch/syspatch.sh
rep "openbsd-" "libertybsd-" usr.sbin/syspatch/syspatch.sh
rep "MIRROR=https://cdn.openbsd.org/pub/OpenBSD" \
	"MIRROR=https://ftp.libertybsd.net/pub/LibertyBSD" \
	usr.sbin/syspatch/syspatch.sh

rep "\^OpenBSD " "\^LibertyBSD " usr.sbin/sysupgrade/sysupgrade.sh
rep "openbsd-" "libertybsd-" usr.sbin/sysupgrade/sysupgrade.sh
rep "MIRROR=https://cdn.openbsd.org/pub/OpenBSD" \
	"MIRROR=https://ftp.libertybsd.net/pub/LibertyBSD" \
	usr.sbin/sysupgrade/sysupgrade.sh


# --------------------------------------

linedel "./usr/libdata/perl5/OpenBSD/FwUpdate.pm" distrib/sets/lists/base/mi
linedel "./usr/sbin/fw_update" distrib/sets/lists/base/mi

linedel "pkg_add pkg_sign" usr.sbin/pkg_add/Makefile
rep "pkg_add fw_update" "pkg_add pkg_sign" usr.sbin/pkg_add/Makefile
strdel "fw_update.1" usr.sbin/pkg_add/Makefile
strdel "fw_update" usr.sbin/pkg_add/Makefile
linedel "FwUpdate.pm" usr.sbin/pkg_add/Makefile
echo



# --------------------------------------

echo "Applying..."
apply
