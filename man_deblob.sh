#!/bin/sh

#########################
# Name: man_deblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Delobbing OBSD man
#       pages for use in
#       LBSD.
#########################

# Usage: man_deblob.sh $SRC_DIR

. ./libdeblob.sh

PATCH_DIR=/tmp/man_deblob


if [ -e $PATCH_DIR ]
then
	self_destruct_sequence $PATCH_DIR
	mkdir $PATCH_DIR
else
	mkdir $PATCH_DIR
fi

if test -z $1
then
	SRC_DIR=/usr/src
else
	SRC_DIR=$1
fi

# man4
set -A fw_list acx adw adv athn bnx bwi drm fxp inteldrm ips ipw iwi iwm \
       iwn kue malo myx neo otus pgt ral radeondrm rsu rtwn rum siop tht \
       thtc ti uath udl ulpt upgt urtwn uvideo wpi yds zyd
for man_blob in "${fw_list[@]}"
do
	strdel "\<${man_blob}.4\>" share/man/man4/Makefile
	linedel "${man_blob}.4" distrib/sets/lists/man/mi
done

linedel "./usr/share/man/man1/fw_update.1" distrib/sets/lists/man/mi
