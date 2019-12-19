#!/bin/sh
########################################
# name: man_deblob.sh
# main: jadedctrl
# lisc: isc
# desc: delobbing obsd man pages for
#	use in lbsd.
########################################

. ./libdeblob.sh

if test -z $1; then
	echo "usage: man_deblob.sh src_dir"
	exit 2
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/man_deblob
mkdir "$PATCH_DIR" 2> /dev/null


# --------------------------------------

firmwares="acx adw adv athn bnx bwi drm fxp inteldrm ips ipw iwi iwm iwn kue"
firmwares="$firmwares malo myx neo otus pgt ral radeondrm rsu rtwn rum siop"
firmwares="$firmwares tht thtc ti uath udl ulpt upgt urtwn uvideo wpi yds zyd"

for firmware in $firmwares; do
	strdel "\<${firmware}.4\>" share/man/man4/Makefile
	linedel "\<${firmware}.4\>" distrib/sets/lists/man/mi
	filedel share/man/man4/${firmware}.4
done

# --------------------------------------

linedel "./usr/share/man/man1/fw_update.1" distrib/sets/lists/man/mi

echo
echo "Applying..."
apply
