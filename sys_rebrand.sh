#!/bin/sh

#########################
# Name: sys_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Rebranding OBSD kernel
#       sources for use in
#       LBSD.
#########################

# Usage: sys_deblob.sh $SRC_DIR

if [ -k $1 ]
then
	echo "Usage: sys_deblob.sh [source directory]"
else
	SRC_DIR="$1"
fi

arch_list="alpha amd64 armish armv7 hppa i386 landisk loongson luna88k macppc miniroot octeon sgi socppc sparc sparc64 vax zaurus"

for arch in $arch_list 
do
	rep "no OpenBSD" "no LibertyBSD" arch/${arch}/stand/libsa/biosdev.c
done

rep "ost=\"OpenBSD\"" "ost=\"LibertyBSD\"" conf/newvers.sh
rep ">> OpenBSD/\" MACHINE" ">> LibertyBSD/\" MACHINE" stand/boot/boot.c
