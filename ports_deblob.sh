#!/bin/sh
########################################
# name: ports_deblob.sh
# main: jadedctrl
# lisc: isc
# desc: delobbing obsd ports tree for
#	use with lbsd.
########################################

. ./libdeblob.sh

if test -z "$1"; then
	echo "usage: ports_deblob.sh ports_dir"
	exit 2
else
	SRC_DIR="$1"
fi

PATCH_DIR=/tmp/ports_deblob/
mkdir "$PATCH_DIR" 2>/dev/null


# --------------------------------------

portdirs="archivers astro audio biology books cad chinese comms converters"
portdirs="$portdirs databases devel editors education emulators fonts games"
portdirs="$portdirs geo graphics inputmethods japanese java korean lang mail"
portdirs="$portdirs math meta misc multimedia net news plan9 print productivity"
portdirs="$portdirs productivity security shells sysutils telephony textproc"
portdirs="$portdirs www x11"

# --------------------------------------

for portdir in $portdirs; do
	echo "========"
	echo "$portdir"
	echo "========"

	for portpath in $SRC_DIR/$portdir/*; do
		local port=$(echo $portpath | sed 's^.*/^^g')
		printf "."

		case "$(libre_status "$portdir/$port")" in
			"nonfree")
				echo
				echo "Non-free $port, flagged for deletion."

				dirdel "$portdir/$port"
				;;
			"libre")
				;;
			*)
				port_lisc_preview $portdir/$port
				yn_prompt "Is $port (f)ree or (n)on-free?" \
					'f' 'n'
				local status="$?"
				if test "$status" -eq 1; then
					add_nonfree_port "$portdir/$port"

					echo
					echo "$port flagged for deletion."

					dirdel "$portdir/$port"
				elif test "$status" -eq 0; then
					add_libre_port "$portdir/$port"
				fi
				;;
		esac
	done
	echo
done

# --------------------------------------
# INDEX mucking

# you'll notice that this is the only part of these scripts
# (other than libdeblob, obviously) that actually directly
# modifies both a file in SRC_DIR and PATCH_DIR.
# that's just because INDEX is way too big to be parseable
# through libdeblob functions.
# this isn't cool...

cp "$SRC_DIR/INDEX" "$PATCH_DIR/ADD_INDEX"
rm "$SRC_DIR/INDEX"

for port in $(cat files/ports/blacklist); do
	grep -v "$port" "$PATCH_DIR/ADD_INDEX" > "$PATCH_DIR/ADD_INDEX.temp"
	mv "$PATCH_DIR/ADD_INDEX.temp" "$PATCH_DIR/ADD_INDEX"
done

rm "$PATCH_DIR/ADD_INDEX.temp"

# --------------------------------------

apply
