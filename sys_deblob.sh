#!/bin/sh
########################################
# name: sys_deblob.sh
# main: jadedctrl
# lisc: isc
# desc: Delobbing obsd kernel sources
#       for use in lbsd.
########################################

. ./libdeblob.sh

if test -z "$1"; then
	echo "usage: sys_deblob.sh kernel_sources"
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/sys_deblob
mkdir "$PATCH_DIR" 2> /dev/null


# --------------------------------------

#arch_list="alpha amd64 armish armv7 hppa i386 landisk loongson luna88k macppc miniroot octeon sgi socppc sparc sparc64 vax zaurus"
arch_list="amd64 i386"

for arch in $arch_list 
do
	linedel "kue\*" arch/${arch}/conf/GENERIC
	linedel "rum\*" arch/${arch}/conf/GENERIC
	linedel "zyd\*" arch/${arch}/conf/GENERIC
	linedel "uvideo\?" arch/${arch}/conf/GENERIC
	linedel "udl\*" arch/${arch}/conf/GENERIC
	linedel "udl?" arch/${arch}/conf/GENERIC
	linedel "ips\*" arch/${arch}/conf/GENERIC
	linedel "siop\*" arch/${arch}/conf/GENERIC
	linedel "adw" arch/${arch}/conf/GENERIC
	linedel "fxp" arch/${arch}/conf/GENERIC
	linedel "myx" arch/${arch}/conf/GENERIC
	linedel "bnx" arch/${arch}/conf/GENERIC
	linedel "bnxt" arch/${arch}/conf/GENERIC
	linedel "thtc" arch/${arch}/conf/GENERIC
	linedel "ral\*" arch/${arch}/conf/GENERIC
	linedel "yds" arch/${arch}/conf/GENERIC
	
	linedel "fxp\*" arch/${arch}/conf/RAMDISK

	linedel "kue\*" arch/${arch}/conf/RAMDISK_CD
	linedel "rum\*" arch/${arch}/conf/RAMDISK_CD
	linedel "zyd\*" arch/${arch}/conf/RAMDISK_CD
	linedel "ips\*" arch/${arch}/conf/RAMDISK_CD
	linedel "siop\*" arch/${arch}/conf/RAMDISK_CD
	linedel "adw\*" arch/${arch}/conf/RAMDISK_CD
	linedel "fxp\*" arch/${arch}/conf/RAMDISK_CD
	linedel "bnx\*" arch/${arch}/conf/RAMDISK_CD
	linedel "bnxt\*" arch/${arch}/conf/RAMDISK_CD
	linedel "ral\*" arch/${arch}/conf/RAMDISK_CD
done

filedel "dev/microcode/adw"
filedel dev/microcode/afb
filedel dev/microcode/atmel
filedel dev/microcode/bnx
filedel dev/microcode/bwi
filedel dev/microcode/cirruslogic
filedel dev/microcode/cyclades
filedel dev/microcode/esa
filedel dev/microcode/fxp
filedel dev/microcode/ises
filedel dev/microcode/kue
filedel dev/microcode/myx
filedel dev/microcode/neomagic
filedel dev/microcode/ral
filedel dev/microcode/rum
filedel dev/microcode/siop
filedel dev/microcode/symbol
filedel dev/microcode/tht
filedel dev/microcode/tigon
filedel dev/microcode/tusb3410
filedel dev/microcode/typhoon
filedel dev/microcode/udl
filedel dev/microcode/yds
filedel dev/microcode/zydas

linedel "SUBDIR=" dev/microcode/Makefile
linedel "symbol tigon tht" dev/microcode/Makefile

filedel dev/pci/adv_pci.c
filedel dev/pci/adw_pci.c
filedel dev/pci/esa.c
filedel dev/pci/esareg.h
filedel dev/pci/esavar.h

linedel "# AdvanSys 1200A, 1200B, and ULTRA SCSI controllers" dev/pci/files.pci
linedel "# device declaration in sys/conf/files" dev/pci/files.pci
linedel "adv_pci" dev/pci/files.pci
linedel "adw_pci" dev/pci/files.pci
linedel "# AdvanSys ULTRA WIDE SCSI controllers" dev/pci/files.pci
linedel "# device declaration in sys/conf/files" dev/pci/files.pci
linedel "# ESS Maestro3" dev/pci/files.pci
linedel "esa" dev/pci/files.pci
linedel "# Yamaha YMF Audio" dev/pci/files.pci
linedel "yds" dev/pci/files.pci
linedel "# NeoMagic 256AV and 256ZX" dev/pci/files.pci
linedel "neo" dev/pci/files.pci
linedel "# Intel EtherExpress PRO 10/100B" dev/pci/files.pci
linedel "fxp_pci" dev/pci/files.pci
linedel "# Tehuti Networks 10Gb Ethernet" dev/pci/files.pci
linedel "thtc" dev/pci/files.pci
linedel "# Myricom Myri-10G Ethernet" dev/pci/files.pci
linedel "myx" dev/pci/files.pci
linedel "# Broadcom BCM570[68] gigabit ethernet" dev/pci/files.pci
linedel "bnx" dev/pci/files.pci
linedel "# Ralink RT2500 PCI/Mini-PCI" dev/pci/files.pci
linedel "ral_pci" dev/pci/files.pci

apply
