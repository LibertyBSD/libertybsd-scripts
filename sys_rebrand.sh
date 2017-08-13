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

. ./libdeblob.sh

PATCH_DIR=/tmp/sys_rebrand

if [ -e $PATCH_DIR ]
then
	self_destruct_sequence $PATCH_DIR
else
	mkdir $PATCH_DIR
fi

if test -z $1
then
	SRC_DIR=/usr/src/sys
else
	SRC_DIR=$1
fi


#arch_list="alpha amd64 armish armv7 hppa i386 landisk loongson luna88k macppc miniroot octeon sgi socppc sparc sparc64 vax zaurus"
arch_list="amd64 i386"

for arch in $arch_list 
do
	rep "no OpenBSD" "no LibertyBSD" arch/${arch}/stand/libsa/biosdev.c
done

rep "ost=\"OpenBSD\"" "ost=\"LibertyBSD\"" conf/newvers.sh
rep ">> OpenBSD/\" MACHINE" ">> LibertyBSD/\" MACHINE" stand/boot/boot.c

apply
