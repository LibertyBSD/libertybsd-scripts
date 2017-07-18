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


# List of ports that require an OBSD build_alias env var
astrolist="astro/gcal astro/wcslib"
archiverslist="archivers/libzip archivers/gcab archivers/gcpio archivers/gshar+gunshar archivers/gtar archivers/libarchive archivers/libmspack archivers/libtar archivers/lzo archivers/xz archivers/zziplib archivers/gcab"
archiverslist="$archiverslsit archivers/lzop archivers/par2cmdline"
audiolist="audio/freealut audio/akode audio/twolame audio/audacious audio/pulseaudio audio/jack audio/libcue audio/audacious-plugins audio/ardour audio/soundtouch multimedia/gstreamer1/mm"
converterslist="converters/libiconv"
dabataseslist="databases/db/v3 databases/db/v4 databases/openldap databases/sqlite3 databases/gdbm databases/yasm databases/iodbc databases/mariadb"
devellist="devel/autoconf/2.13 devel/autoconf/2.52 devel/autoconf/2.54 devel/autoconf/2.56 devel/autoconf/2.57 devel/autoconf/2.58 devel/autoconf/2.59 devel/autoconf/2.60"
devellist="$devellist devel/autoconf/2.61 devel/autoconf/2.62 devel/autoconf/2.63 devel/autoconf/2.64 devel/autoconf/2.65 devel/autoconf/2.66 devel/autoconf/2.67 devel/autoconf/2.68"
devellist="$devllist devel/autoconf/2.69 devel/automake/1.4 devel/automake/1.8 devel/automake/1.9 devel/automake/1.10 devel/automake/1.11 devel/automake/1.12 devel/automake/1.13"
devellist="$devellist devel/automake/1.14 devel/automake/1.15 devel/libtool devel/libidn devel/gmake devel/llvm devel/sdl2-image devel/sdl2 devel/apr devel/apr-util devel/t1lib"
devellist="$devellist devel/bison devel/gettext devel/gettext-tools devel/libsigsegv devel/ffcall devel/gobject-introspection devel/yasm devel/sdl devel/cppunit devel/json-glib"
devellist="$devellist devel/libsoup devel/libsigc++-2 devel/glib2mm devel/atk2mm devel/libnotify devel/npth devel/check devel/pangomm devel/scons"
editorslist="editors/nano"
gameslist="games/xscorch"
graphicslist="graphics/cairo graphics/gd"
geolist="geo/spatialindex"
langlist="lang/ghc lang/clisp lang/gawk lang/guile lang/ghc"
maillist="mail/mutt mail/alpine"
mathlist="math/graphviz"
multimedialist="multimedia/xvidcore"
netlist="net/openvpn net/librest"
printlist="print/libpaper print/texlive/base print/texlive/texmf print/psutils"
securitylist="security/cyrus-sasl2 security/libmcrypt security/libtasn1 security/p11-kit security/pinentry"
shellslist="shells/bash"
sysutilslist="sysutils/e2fsprogs sysutils/polkit sysutils/consolekit"
textproclist="textproc/groff textproc/jq textproc/rapto textproc/raptorr"
wwwlist="www/lynx www/apache-httpd"
x11list="x11/gnome/at-spi2-core x11/gnome/at-spi2-atk x11/gnome/py-atspi x11/gnome/libsecret x11/gnome/gcr x11/xkbcommon x11/gtk2mm x11/gnome/libgnomecanvasmm x11/gtk3mm"

portlist="$archiverslist $audiolist $databaseslist $devellist $editorslist $gameslist $geolist $langlist $maillist $multimedia $netlist $securitylist $sysutilslist $textproclist $wwwlist"

# Add the build_alias env variable to listed ports
for port in $portlist
do
	rep ".include <bsd.port.mk>" "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" $port/Makefile
	lineadd  "CONFIGURE_ENV +=        build_alias=\"\${ARCH}-unknown-openbsd6.1\"" ".include <bsd.port.mk>" $port/Makefile
done


# List of ports that require an OpenBSD CMAKE_SYSTEM_NAME
audiolist="audio/chromaprint"
devellist="devel/cmocka devel/doxygen"

portlist="$devellist"

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

# Problem childs:
# * lang/python 	"configure: error: cannot run C compiled programs."	It configures just fine (using same args as used when configuring in ports) manually, but not using port.
# * lang/tcl
# * x11/tk
# * devel/llvm
# * security/gnutls
# * lang/ruby   	"configure: error: cannot run C compiled programs."	It configures just fine (using same args as used when configuring in ports) manually, but not using port.
# * gobject-introspection
# * lang/mono   	"configure: error: cannot run C compiled programs."	It configures just fine (using same args as used when configuring in ports) manually, but not using port.
# * mozjs17	Need to figure out how to create a build_alias... the env var and config arg used in other ports doesn't work.
# * multimedia/libvpx	"Toolchain unable to link executables"
# * p5-Curses
# * libproxy	ld issue
# * x11/gtk\+3
# * graphics/openjp2	ninja; ld issue
# * devel/jdk/1.7
# * audio/libsoxr	ninja; ...
# * databases/mariadb
# * multimedia/libv4l
# * multimedia/x26[45] --host=${ARCH}-unknown-openbsd6.1
# * graphics/ffmpeg	Unable to test cc.
# * x11/qt4
# * x11/qt5/qtbase
# * x11/qt5/qtdeclarative
# * x11/qt5/qttools
# * gstreamer/plugins-base
# * p5-Module-Build
# * libmusicbrainz
# * libmusicbrainz5
# * bioperl
# * lang/g77
# * qtmultimedia
# * qtdeclarative
# * qtsvg
# * audio/cantata

# The recurring theme I'm noticing here is the 'cannot run C compiled programs' issue. If that's solved, everything else should be smooth
# sailing....
# Unfortunately some of the more important packages encounter this issue.

# Note to self: gc*

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

apply
