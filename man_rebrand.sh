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


if [ -e $PATCH_DIR ]
then
        self_destruct_sequence $PATCH_DIR
	mkdir $PATCH_DIR
else
        mkdir $PATCH_DIR
fi

if test -z $1
then
        SRC_DIR=/usr/src
else
        SRC_DIR=$1
fi


# man1
rep "administrators with" "administrators with LibertyBSD" share/man/man1/help.1
linedel "^Other$" "man1/help.1" share/man/man1/help.1
linedel "references include the FAQ" share/man/man1/help.1
linedel "https://openbsd.org/faq" share/man/man1/help.1
linedel "which is mostly intended for administrators" share/man/man1/help.1
linedel "a working knowledge of" share/man/man1/help.1
linedel "\.Ux \." "man1/help.1" share/man/man1/help.1
linedel "There are also mailing lists in place" share/man/man1/help.1
#rep "\.Ox ," "LibertyBSD," share/man/man1/help.1
#rep "available;" "available; LibertyBSD" share/man/man1/help.1
#linedel "\.Ox" share/man/man1/help.1

#rep "\.Ox" "LibertyBSD" share/man/man1/gcc-local.1
#rep "\.Ox" "LibertyBSD" share/man/man1/clang-local.1


# man3
#rep "\.Ox" "LibertyBSD" share/man/man3/makedev.3
#rep "\.Ox" "LibertyBSD" share/man/man3/sysexits.3


# man5
#rep "OpenBSD


ox_replace() {
	for file in ${SRC_DIR}/$1/*
	do
		echo $file
		rfile=$(echo $file | sed 's^'"$SRC_DIR"'^^' | sed 's^/^^')
		echo $rfile
		if grep ".Ox \." $file
		then
			rep ".Ox \." "LibertyBSD\." "$rfile"
		fi
		if grep ".Ox \," $file
		then
			rep ".Ox \," "LibertyBSD\," "$rfile"
		fi
		if grep ".Ox \:" $file
		then
			rep ".Ox \:" "LibertyBSD\:" "$rfile"
		fi
		if grep ".Ox$" $file
		then
			rep ".Ox$" "LibertyBSD" "$rfile"
		fi
	done
}

mandirectories="man0 man1 man3 man4 man5 man6 man7 man8 man9"
for mandir in $mandirectories
do
	ox_replace "share/man/$mandir"
done

filecp files/man/release.8 share/man/man8/release.8

# Add Free Software-related man pages
filecp files/man/fsdg.7 share/man/man7/fsdg.7
filecp files/man/free-software.7 share/man/man7/free-software.7
rep "environ.7 glob.7 hier.7 hostname.7 intro.7 kgdb.7 " "environ.7 free-software.7 fsdg.7 glob.7 hier.7 " share/man/man7/Makefile
rep "library-specs.7 mailaddr.7" "hostname.7 intro.7 kgdb.7 library-specs.7 mailaddr.7" share/man/man7/Makefile
lineadd "./usr/share/man/man7/eqn.7" "./usr/share/man/man7/fsdg.7" distrib/sets/lists/man/mi
lineadd "./usr/share/man/man7/eqn.7" "./usr/share/man/man7/free-software.7" distrib/sets/lists/man/mi
rep "eqn.7 " "eqn.7" distrib/sets/lists/man/mi
rep "free-software.7 " "free-software.7" distrib/sets/lists/man/mi

apply
