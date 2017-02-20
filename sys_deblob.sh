#!/bin/sh

#########################
# Name: sys_deblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Delobbing OBSD kernel
#       sources for use in
#       LBSD.
#########################

# Usage: sys_deblob.sh $SRC_DIR

. ./libdeblob.sh

PATCH_DIR=/tmp/sys_deblob


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
	rep "kue\*  at uhub?" "#kue\*  at uhub?" arch/${arch}/conf/GENERIC
	rep "rum\*  at uhub?" "#rum\*  at uhub?" arch/${arch}/conf/GENERIC
	rep "zyd\*  at uhub?" "#rum\*  at uhub?" arch/${arch}/conf/GENERIC
	rep "uvideo\*       at uhub?" "#uvideo\*       at uhub?" arch/${arch}/conf/GENERIC
	rep "video\*        at uvideo?" "#video*        at uvideo?" arch/${arch}/conf/GENERIC
	rep "udl\*  at uhub?" "#udl\*  at uhub?" arch/${arch}/conf/GENERIC
	rep "wsdisplay\* at udl?" "#wsdisplay\* at udl?" arch/${arch}/conf/GENERIC
	rep "ips\*  at pci?" "#ips\*  at pci?" arch/${arch}/conf/GENERIC
	rep "siop\* at pci?" "#siop\* at pci?" arch/${arch}/conf/GENERIC
	rep "adw\*  at pci?" "#adw\*  at pci?" arch/${arch}/conf/GENERIC
	rep "fxp\*  at pci?" "#fxp\*  at pci?" arch/${arch}/conf/GENERIC
	rep "fxp\*  at cardbus?" "#fxp\*  at cardbus?" arch/${arch}/conf/GENERIC
	rep "myx\*  at pci?" "#myx\*  at pci?" arch/${arch}/conf/GENERIC
	rep "bnx\*  at pci?" "#bnx\*  at pci?" arch/${arch}/conf/GENERIC
	rep "thtc\* at pci?" "#thtc\* at pci?" arch/${arch}/conf/GENERIC
	rep "tht\*  at thtc?" "#tht\*  at thtc?" arch/${arch}/conf/GENERIC
	rep "ral\*  at pci?" "#ral\*  at pci?" arch/${arch}/conf/GENERIC
	rep "ral\*  at cardbus?" "#ral\*  at cardbus?" arch/${arch}/conf/GENERIC
	rep "yds\*  at pci?" "#yds*  at pci?" arch/${arch}/conf/GENERIC
	rep "audio\*        at yds?" "#audio\*        at yds?" arch/${arch}/conf/GENERIC
	
	rep "fxp\*          at pci?" "#fxp\*          at pci?" arch/${arch}/conf/RAMDISK

	rep "kue\*          at uhub?" "#kue\*          at uhub?" arch/${arch}/conf/RAMDISK_CD
	rep "rum\*          at uhub?" "#rum\*          at uhub?" arch/${arch}/conf/RAMDISK_CD
	rep "zyd\*          at uhub?" "#zyd\*          at uhub?" arch/${arch}/conf/RAMDISK_CD
	rep "ips\*          at pci?" "ips\*          at pci?" arch/${arch}/conf/RAMDISK_CD
	rep "siop\*         at pci?" "#siop\*         at pci?" arch/${arch}/conf/RAMDISK_CD
	rep "adw\*          at pci?" "#adw\*          at pci?" arch/${arch}/conf/RAMDISK_CD
	rep "fxp\*          at pci?" "#fxp\*          at pci?" arch/${arch}/conf/RAMDISK_CD
	rep "fxp\*          at cardbus?" "#fxp\*          at cardbus?" arch/${arch}/conf/RAMDISK_CD
	rep "bnx\*          at pci?" "#bnx\*          at pci?" arch/${arch}/conf/RAMDISK_CD
	rep "ral\*          at pci?" "#ral\*          at pci" arch/${arch}/conf/RAMDISK_CD
	rep "ral\*          at cardbus?" "#ral\*          at cardbus?" arch/${arch}/conf/RAMDISK_CD
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
linedel "attach        adv at pci with adv_pci" dev/pci/files.pci
linedel "file  dev/pci/adv_pci.c" dev/pci/files.pci
linedel "file  dev/ic/advlib.c" dev/pci/files.pci
linedel "dev/microcode/adw/advmcode.c" dev/pci/files.pci
linedel "# AdvanSys ULTRA WIDE SCSI controllers" dev/pci/files.pci
linedel "# device declaration in sys/conf/files" dev/pci/files.pci
linedel "attach        adw at pci with adw_pci" dev/pci/files.pci
linedel "file  dev/pci/adw_pci.c" dev/pci/files.pci
linedel "file  dev/ic/adwlib.c" dev/pci/files.pci
linedel "file  dev/microcode/adw/adwmcode.c" dev/pci/files.pci
linedel "# ESS Maestro3" dev/pci/files.pci
linedel "device        esa: audio, ac97" dev/pci/files.pci
linedel "attach        esa at pci" dev/pci/files.pci
linedel "file  dev/pci/esa.c" dev/pci/files.pci
linedel "# Yamaha YMF Audio" dev/pci/files.pci
linedel "device        yds {}: audio, ac97, firmload" dev/pci/files.pci
linedel "attach        yds at pci" dev/pci/files.pci
linedel "file  dev/pci/yds.c" dev/pci/files.pci
linedel "# NeoMagic 256AV and 256ZX" dev/pci/files.pci
linedel "device        neo: audio, ac97, firmload" dev/pci/files.pci
linedel "attach        neo at pci" dev/pci/files.pci
linedel "file  dev/pci/neo.c" dev/pci/files.pci
linedel "# Intel EtherExpress PRO 10/100B" dev/pci/files.pci
linedel "attach        fxp at pci with fxp_pci" dev/pci/files.pci
linedel "file  dev/pci/if_fxp_pci.c" dev/pci/files.pci
linedel "# Tehuti Networks 10Gb Ethernet" dev/pci/files.pci
linedel "device        thtc {}" dev/pci/files.pci
linedel "attach        thtc at pci" dev/pci/files.pci
linedel "device        tht: ether, ifnet, ifmedia, firmload" dev/pci/files.pci
linedel "attach        tht at thtc" dev/pci/files.pci
linedel "file  dev/pci/if_tht.c" dev/pci/files.pci
linedel "# Myricom Myri-10G Ethernet" dev/pci/files.pci
linedel "device        myx: ether, ifnet, ifmedia" dev/pci/files.pci
linedel "attach        myx at pci" dev/pci/files.pci
linedel "file  dev/pci/if_myx.c" dev/pci/files.pci
linedel "# Broadcom BCM570[68] gigabit ethernet" dev/pci/files.pci
linedel "device        bnx: ether, ifnet, mii, ifmedia, mii_phy, firmload" dev/pci/files.pci
linedel "attach        bnx at pci" dev/pci/files.pci
linedel "file  dev/pci/if_bnx.c" dev/pci/files.pci
linedel "# Ralink RT2500 PCI/Mini-PCI" dev/pci/files.pci
linedel "attach        ral at pci with ral_pci" dev/pci/files.pci
linedel "file  dev/pci/if_ral_pci.c" dev/pci/files.pci

apply
