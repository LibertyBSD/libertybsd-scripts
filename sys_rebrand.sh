#!/bin/sh
########################################
# name: sys_rebrand.sh
# main: jadedctrl
# lisc: isc
# desc: rebranding obsd kernel sources
#	for use in lbsd.
########################################

. ./libdeblob.sh

if test -z "$1"; then
	echo "usage: sys_rebrand.sh kernel_sources"
	exit 2
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/sys_rebrand
mkdir "$PATCH_DIR" 2> /dev/null


# --------------------------------------

# arch_list="alpha amd64 armish armv7 hppa i386 landisk loongson luna88k macppc
# arch-list="$arch_list miniroot octeon sgi socppc sparc sparc64 vax zaurus"
arch_list="amd64 i386"

for arch in $arch_list 
do
	rep "no OpenBSD" "no LibertyBSD" "arch/${arch}/stand/libsa/biosdev.c"
done

rep ">> OpenBSD/\" MACHINE" ">> LibertyBSD/\" MACHINE" stand/boot/boot.c

apply
