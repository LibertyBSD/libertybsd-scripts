#!/bin/ksh

#########################
# Name: ports_deblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Delobbing OBSD ports
#       tree for use with
#       LBSD.
#########################

# Usage: ports_deblob.sh

. ./libdeblob.sh

PATCH_DIR=/tmp/ports_deblob/

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

portdirs="archivers astro audio biology books cad chinese comms converters databases devel"
portdirs="$portdirs editors education emulators fonts games geo graphics inputmethods" 
portdirs="$portdirs japanese java korean lang mail math meta misc multimedia net news plan9"
portdirs="$portdirs print productivity security shells sysutils telephony textproc www x11"

for portdir in $portdirs
do
	for portpath in $SRC_DIR/$portdir/*
	do
		port=$(echo $portpath | sed 's^.*/^^g')
		echo $port
		if grep "^$port$" files/ports/blacklist > /dev/null
		then
			echo "Non-free $port to be deleted!"
			filedel "$portdir/$port"
		elif grep "^$port$" files/ports/whitelist > /dev/null
		then
			echo "OK" > /dev/null
		else
			inputdone=0
			nfinput=''
			while [ $inputdone -eq 0 ]
			do
				grep -B1 "PERMIT_PACKAGE_CDROM" $SRC_DIR/$portdir/$port/Makefile
				echo "Is $port free or nonfree? (f/n)"
				read nfinput
				case $nfinput in
					f)
						echo "$port" >> files/ports/whitelist
						inputdone=1
						;;
					n)
						echo "$port" >> files/ports/blacklist
						inputdone=1
						;;
				esac
			done
		fi
	done
done

for port in $(cat files/ports/blacklist)
do
	linedel "/$port " INDEX
done

#for port in $(cat files/ports/whitelist)
#do
#	if grep "^$port-" $PATCH_DIR/INDEX || grep "/$port||" $PATCH_DIR/INDEX
#	then
#		echo "OK" > /dev/null
#	else
#		echo "$port" >> files/ports/blacklist
#		linedel "/$port " INDEX
#		echo "$port has a non-free depedency-- it has been added to the blacklist."
#		echo "You'll have to re-run this script in order to apply this change."
#		sleep 2
#	fi
#done

apply
