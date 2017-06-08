#!/bin/ksh

#########################
# Name: ports_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Editing OBSD ports
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

rep "\${MACHINE-ARCH}-openbsd" "\${MACHINE-ARCH}-libertybsd" infrastructure/mk/perl.port.mk

# The ones that require build_alias
archiverslist="archivers/libzip archivers/gcab archivers/gcpio archivers/gshar+gunshar archivers/gtar archivers/libarchive archivers/libmspack archivers/libtar archivers/lzo"
archiverslist="$archiverslsit archivers/lzop archivers/par2cmdline"
audiolist="audio/freealut"
dabataseslist="databases/db/v3 databases/db/v4 databases/openldap"
devellist="devel/autoconf/2.13 devel/autoconf/2.52 devel/autoconf/2.54 devel/autoconf/2.56 devel/autoconf/2.57 devel/autoconf/2.58 devel/autoconf/2.59 devel/autoconf/2.60"
devellist="$devellist devel/autoconf/2.61 devel/autoconf/2.62 devel/autoconf/2.63 devel/autoconf/2.64 devel/autoconf/2.65 devel/autoconf/2.66 devel/autoconf/2.67 devel/autoconf/2.68"
devellist="$devllist devel/autoconf/2.69 devel/automake/1.4 devel/automake/1.8 devel/automake/1.9 devel/automake/1.10 devel/automake/1.11 devel/automake/1.12 devel/automake/1.13"
devellist="$devellist devel/automake/1.14 devel/automake/1.15 devel/libtool devel/libidn devel/gmake devel/llvm devel/sdl2-image devel/sdl2 devel/apr devel/apr-util devel/t1lib"
devellist="$devellist devel/bison"
editorslist="editors/nano"
gameslist="games/xscorch"
geolist="geo/spatialindex"
langlist="lang/ghc"
maillist="mail/mutt mail/alpine"
netlist="net/openvpn"
securitylist="security/cyrus-sasl2 security/libmcrypt"
sysutilslist="sysutils/e2fsprogs"
textproclist="textproc/groff"
wwwlist="www/lynx www/apache-httpd"

portlist="$archiverslist $audiolist $databaseslist $devellist $editorslist $gameslist $geolist $langlist $maillist $netlist $securitylist $sysutilslist $textproclist $wwwlist"

for port in $portlist
do
	rep ".include <bsd.port.mk>" "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" $port/Makefile
	lineadd  "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" ".include <bsd.port.mk>" $port/Makefile
done

rep ".include <bsd.port.mk>" "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd\"" lang/ghc/Makefile
lineadd  "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd\"" ".include <bsd.port.mk>" lang/ghc/Makefile


devellist="devel/cmake"
portlist="$audiolist"
for port in $portlist
do
	if grep "pre-configre:" $SRC_DIR/$port/Makefile
	then
		lineadd "pre-configure:" "        cp -r \${FILESDIR}/Platform/LibertyBSD.cmake \${WRKSRC}/Modules/Platform/LibertyBSD.cmake" $port/Makefile
	else
		rep ".include <bsd.port.mk>" "pre-configure:" $port/Makefile
		lineadd "pre-configure:" "        cp \${FILESDIR}/Platform/LibertyBSD.cmake \${WRKSRC}/Modules/Platform/LibertyBSD.cmake" $port/Makefile
		lineadd "        cp \${FILESDIR}/Platform/LibertyBSD.cmake \${WRKSRC}/Modules/Platform/LibertyBSD.cmake" ".include <bsd.port.mk>" $port/Makefile
	fi
	dircp files/ports/files/Platform $port/files/Platform
done

# Installing files
dircp files/ports/files/cmake/Platform devel/cmake/files/Platform
lineadd "pre-configure:" "        cp \${FILESDIR}/Platform/LibertyBSD.cmake \${WRKSRC}/Modules/Platform/LibertyBSD.cmake" devel/cmake/Makefile

apply
