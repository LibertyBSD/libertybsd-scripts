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

arch_list="amd64 i386"

for arch in $arg_list
do
	linedel "./usr/share/man/man1/fw_update.1" "distrib/sets/lists/base/md.${arch}"
done


# man4
fw_list="acx adw adv athn bnx bwi drm fxp inteldrm ips ipw iwi iwm iwn kue malo myx neo otus pgt ral"
fw_list="$fw_list radeondrm rsu rtwn rum siop tht thtc ti uath udl ulpt upgt urtwn uvideo wpi yds zyd"
for man_blob in $fw_list
do
        strdel " ${man_blob}.4" share/man/man4/Makefile
        strdel "\^${man_blob}.4" share/man/man4/Makefile
        linedel "${man_blob}.4" distrib/sets/lists/man/mi
done

strdel "acx.4" share/man/man4/Makefile
strdel "upgt.4" share/man/man4/Makefile
strdel "yds.4" share/man/man4/Makefile
rep "ural.4" "TEMP.4" share/man/man4/Makefile   # The above loop doesn't catch these-- but strdel "ral.4"
strdel "ral.4" share/man/man4/Makefile          # catches ural. So ural is switched out with TEMP beforehand.
rep "TEMP.4" "ural.4" share/man/man4/Makefile

#linedel "MLINKS+=adv.4 adw.4" share/man/man4/Makefile
#linedel "MLINKS+=drm.4 inteldrm.4 drm.4 radeondrm.4" share/man/man4/Makefile
#linedel "MLINKS+=tht.4 thtc.4" share/man/man4/Makefile
