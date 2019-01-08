#!/bin/sh

#########################
# Name: src_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Rebranding OBSD base
#       sources for use in
#       LBSD.
#########################

# Usage: src_rebrand.sh $SRC_DIR

. ./libdeblob.sh

PATCH_DIR=/tmp/src_rebrand


if [ -e $PATCH_DIR ]
then
	self_destruct_sequence $PATCH_DIR
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

rep "export OBSD=\"OpenBSD/\$ARCH \$VNAME\"" "export OBSD=\"LibertyBSD/\$ARCH \$VNAME\"" distrib/miniroot/dot.profile

#iso_list="alpha amd64 hppa i386 sgi sparc sparc64 vax"
iso_list="amd64 i386"
for arch in $(echo $iso_list)
do
	rep "OpenBSD \${OSREV} ${arch} Install CD" "LibertyBSD \${OSREV} ${arch} Install CD" distrib/$arch/iso/Makefile
	rep "Copyright (c) `date +%Y` Theo de Raadt, The OpenBSD project" "Copyright (c) `date +%Y` The *OpenBSD* and LibertyBSD projects" distrib/$arch/iso/Makefile
	rep "Theo de Raadt <deraadt@openbsd.org>" "Riley Baird <riley@openmailbox.org>" distrib/$arch/iso/Makefile
	rep "OpenBSD/\${MACHINE}   \${OSREV} Install CD" "LibertyBSD/\${MACHINE} \${OSREV} Install CD" distrib/$arch/iso/Makefile
done

#cdfs_list="alpha amd64 i386 loongson sgi sparc sparc64 vax"
cdfs_list="amd64 i386"
for arch in $(echo $cdfs_list)
do
	rep "OpenBSD \${OSREV} ${arch} bootonly CD" "LibertyBSD \${OSREV} ${arch} bootonly CD" distrib/$arch/cdfs/Makefile
	rep "Copyright (c) `date +%Y` Theo de Raadt, The OpenBSD project" "Copyright (c) `date +%Y` The *OpenBSD* and LibertyBSD projects" distrib/$arch/cdfs/Makefile
	rep "Theo de Raadt <deraadt@openbsd.org>" "Riley Baird <riley@openmailbox.org>" distrib/$arch/cdfs/Makefile
	rep "OpenBSD/${arch}   \${OSREV} boot-only CD" "LibertyBSD/${arch} \${OSREV} boot CD" distrib/$arch/cdfs/Makefile
done

# Distrib changes for all archs
for arch in $(echo $arch_list)
do
#	rep "${arch}-openbsd" "${arch}-libertybsd" distrib/sets/lists/base/md.$arch
	rep "You will not be able to boot OpenBSD from \${1}." "You will not be able to boot LibertyBSD from \${1}." distrib/$arch/common/install.md
done


rep "#define DMESG_START \"OpenBSD \"" "#define DMESG_START \"LibertyBSD \"" usr.bin/sendbug/sendbug.c
rep "bugs@openbsd.org" "bugs@libertybsd.net" usr.bin/sendbug/sendbug.c

rep	"sysctl -n kern.version | sed 1q >" \
	"sysctl -n kern.version | sed 1q | sed 's/OpenBSD/LibertyBSD/' >" \
	etc/rc

# Adding LBSD keys
filecp files/keys/libertybsd-61-base.pub etc/signify/libertybsd-61-base.pub
filecp files/keys/libertybsd-61-pkg.pub etc/signify/libertybsd-61-pkg.pub
filecp files/keys/libertybsd-61-syspatch.pub etc/signify/libertybsd-61-syspatch.pub
filecp files/keys/libertybsd-62-base.pub etc/signify/libertybsd-62-base.pub
filecp files/keys/libertybsd-62-pkg.pub etc/signify/libertybsd-62-pkg.pub
filecp files/keys/libertybsd-62-syspatch.pub etc/signify/libertybsd-62-syspatch.pub
filecp files/keys/libertybsd-63-base.pub etc/signify/libertybsd-63-base.pub
filecp files/keys/libertybsd-63-pkg.pub etc/signify/libertybsd-63-pkg.pub
filecp files/keys/libertybsd-63-syspatch.pub etc/signify/libertybsd-63-syspatch.pub
filecp files/keys/libertybsd-64-base.pub etc/signify/libertybsd-64-base.pub
filecp files/keys/libertybsd-64-pkg.pub etc/signify/libertybsd-64-pkg.pub
filecp files/keys/libertybsd-64-syspatch.pub etc/signify/libertybsd-64-syspatch.pub


filecp files/motd etc/motd
filecp files/root.mail etc/root/root.mail 
filecp files/install.sub distrib/miniroot/install.sub

rep "openbsd-" "libertybsd-" usr.sbin/syspatch/syspatch.sh
rep "OpenBSD" "LibertyBSD" usr.sbin/syspatch/syspatch.sh

apply
