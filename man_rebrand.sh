#!/bin/sh

#########################
# Name: man_rebrand.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Rebranding OBSD man
#       pages for use in
#       LBSD.
#########################

# Usage: man_rebrand.sh $SRC_DIR
# Often: man_rebrand.sh /usr/src/share/man

. ./libdeblob.sh

PATCH_DIR=/tmp/man_rebrand


if [ -e "$PATCH_DIR" ]
then
	self_destruct_sequence "$PATCH_DIR"
	mkdir "$PATCH_DIR"
else
	mkdir "$PATCH_DIR"
fi

if test -z "$1"
then
	SRC_DIR=/usr/src
else
	SRC_DIR="$1"
fi



ox_replace() {
	local file rfile

	for file in "$SRC_DIR/$1"/*
	do
		if echo "$file" | grep -q "\.[1-9]$"
		then
			rfile="${file#$SRC_DIR/}"
			if grep -q ".Ox \." "$file"
			then
				rep ".Ox \." "LibertyBSD\." "$rfile"
			fi
			if grep -q ".Ox \," "$file"
			then
				rep ".Ox \," "LibertyBSD\," "$rfile"
			fi
			if grep -q ".Ox \:" "$file"
			then
				rep ".Ox \:" "LibertyBSD\:" "$rfile"
			fi
			if grep -q ".Ox$" "$file"
			then
				rep ".Ox$" "LibertyBSD" "$rfile"
			fi
			if grep -q "ftp.openbsd.org" "$file"
			then
				rep "ftp.openbsd.org" "ftp.libertybsd.net" "$rfile"
			fi
			if grep -q "http://openbsd.org" "$file"
			then
				rep "http://libertybsd.net" "$rfile"
			fi
			if grep -q "https://openbsd.org" "$file"
			then
				rep "https://libertybsd.net" "$rfile"
			fi
		fi
	done
}

mandirectories="man0 man1 man3 man4 man5 man6 man7 man8 man9"
for mandir in $mandirectories
do
	ox_replace "share/man/$mandir"
done

bindirectories="bin sbin usr.bin usr.sbin"
for bindir in $bindirectories
do
	for dir in "$SRC_DIR/$bindir"/*
	do
		if [ -d "$dir" ]
		then
			fixdir="${dir#$SRC_DIR/}"
			ox_replace "$fixdir"
		fi
	done
done

filecp files/man/release.8 share/man/man8/release.8
filecp files/man/help.1 share/man/man1/help.1

# Add Free Software-related man pages
filecp files/man/fsdg.7 share/man/man7/fsdg.7
filecp files/man/free-software.7 share/man/man7/free-software.7
rep "environ.7 glob.7 hier.7 hostname.7 intro.7 kgdb.7 " \
	"environ.7 free-software.7 fsdg.7 glob.7 hier.7 " share/man/man7/Makefile
rep "library-specs.7 mailaddr.7" \
	"hostname.7 intro.7 kgdb.7 library-specs.7 mailaddr.7" \
	share/man/man7/Makefile
lineadd "./usr/share/man/man7/eqn.7" "./usr/share/man/man7/fsdg.7" \
	distrib/sets/lists/man/mi
lineadd "./usr/share/man/man7/eqn.7" "./usr/share/man/man7/free-software.7" \
	distrib/sets/lists/man/mi
rep "eqn.7 " "eqn.7" distrib/sets/lists/man/mi
rep "free-software.7 " "free-software.7" distrib/sets/lists/man/mi

apply
