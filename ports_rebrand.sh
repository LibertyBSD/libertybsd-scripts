#!/bin/ksh

#########################
# Name: ports_rebrand.sh
# Main: jadedctrl
# Lisc: ISC # Desc: Editing OBSD ports
#       tree for use with
#       LBSD.
#########################

# Usage: ports_deblob.sh

. ./libdeblob.sh

PATCH_DIR=/tmp/ports_rebrand/

if [ -e $PATCH_DIR ]
then
	self_destruct_sequence $PATCH_DIR
	mkdir $PATCH_DIR
else
	mkdir $PATCH_DIR
fi

if test -z $1
then
	SRC_DIR=/usr/ports/
else
	SRC_DIR=$1
fi


. ./files/ports/aliafy.sh

# Add the build_alias env variable to listed ports
for port in $portlist
do
	rep ".include <bsd.port.mk>" "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" $port/Makefile
	lineadd  "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" ".include <bsd.port.mk>" $port/Makefile
done


. ./files/ports/caliafy.sh

# Add the -DCMAKE_SYSTEM_NAME argument to listed ports
for port in $portlist
do
	rep ".include <bsd.port.mk>" "CONFIGURE_ARGS +=        -DCMAKE_SYSTEM_NAME=OpenBSD" $port/Makefile
	lineadd  "CONFIGURE_ARGS +=        -DCMAKE_SYSTEM_NAME=OpenBSD" ".include <bsd.port.mk>" $port/Makefile
done


# Port-specific changes for build
rep ".include <bsd.port.mk>" "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd\"" lang/ghc/Makefile
lineadd  "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd\"" ".include <bsd.port.mk>" lang/ghc/Makefile
lineadd "pre-configure:" "        @cp \${FILESDIR}/Platform/LibertyBSD.cmake \${WRKSRC}/Modules/Platform/LibertyBSD.cmake" devel/cmake/Makefile
lineadd "\${WRKSRC}/config" "        @cp \${FILESDIR}/Makefile.openbsd ${WRKSRC}/config/Makefile.libertybsd" graphics/glew/Makefile
dircp files/ports/files/cmake/Platform devel/cmake/files/Platform
lineadd "pre-configure:" "        @cp \${FILESDIR}/platforms/LibertyBSD.cmake \${WRKSRC}/cmake/platforms/LibertyBSD.cmake" devel/llvm/Makefile
dircp files/ports/files/llvm/ devel/llvm/files/
rep "-no-ssse3 -no-sse3" "-no-ssse3 -no-sse3 -platform openbsd-g++" x11/qt5/qtbase/Makefile
rep "--enable-shared" "--enable-shared --target-os=openbsd" graphics/ffmpeg/Makefile

# *.mk edits
rep "\${MACHINE-ARCH}-openbsd" "\${MACHINE-ARCH}-libertybsd" infrastructure/mk/perl.port.mk

# Misc. infrastructure edits
lineadd "*:OpenBSD:*:*)" "*:LibertyBSD:*:*)" infrastructure/db/config.guess
lineadd "*:OpenBSD:*:*)" "        exit ;;" infrastructure/db/config.guess
lineadd "*:OpenBSD:*:*)" "        echo \${UNAME_MACHINE_ARCH}-unknown-openbsd\${UNAME_RELEASE}" infrastructure/db/config.guess
lineadd "*:OpenBSD:*:*)" "        UNAME_MACHINE_ARCH=\`arch | sed 's/^.*BSD\.//'\`" infrastructure/db/config.guess

# Go through ports with additional patches for LBSD
for category in files/ports/files/patches/*
do
	category_name="$(echo $category | sed 's^.*/^^')"
	for port in $category
	do
		port_name="$(echo $port | sed 's^.*/^^')"
		for patch in $port
		do
			patch_name="$(echo $patch | sed 's^.*/^^')"
			filecp "files/ports/file/patches/$category_name/$port_name/$patch_name" "$category_name/$port_name/patches/$patch_name"
		done
	done
done


# Port-specific changes for rebranding
rep "ftp.openbsd.org/pub/OpenBSD/snapshots/i386/cd52.iso" "ftp.libertybsd.net/pub/LibertyBSD/snapshots/i386/cd61.iso" emulators/qemu/pkg/README 
rep "ftp.openbsd.org/pub/OpenBSD/snapshots/amd64/cd52.iso" "ftp.libertybsd.net/pub/LibertyBSD/snapshots/amd64/cd61.iso" emulators/qemu/pkg/README
linedel "\$ ftp ftp://ftp.openbsd.org/pub/OpenBSD/snapshots/sparc/cd52.iso" emulators/qemu/pkg/README
rep "install52.fs" "install61.fs" emulators/qemu/pkg/README
rep "install52.iso" "install61.iso" emulators/qemu/pkg/README
rep "OpenBSD" "LibertyBSD" emulators/qemu/pkg/README
rep "ftp.openbsd.org" "ftp.libertybsd.net" sysutils/ruby-puppet/4/patches/patch-lib_puppet_provider_package-openbsd_rb
rep "on OpenBSD" "on LibertyBSD" sysutils/sysmon/pkg/README ; rep "openbsd.org" "libertybsd.net" sysutils/sysmon/pkg/README
rep "=\"OpenBSD " "=\"LibertyBSD " multimedia/gstreamer-0.10/Makefile.inc
rep "openbsd.org" "libertybsd.net" multimedia/gstreamer-0.10/Makefile.inc
# @jimmybot for this :) ^^
rep "www.openbsd.org" "libertybsd.net" www/lynx/patches/patch-lynx_cfg

apply
