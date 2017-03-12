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

PATCH_DIR=/tmp/man_deblob


if [ -e $PATCH_DIR ]
then
        self_destruct_sequence $PATCH_DIR
	mkdir $PATCH_DIR
else
        mkdir $PATCH_DIR
fi

if test -z $1
then
        SRC_DIR=/usr/src/share/man
else
        SRC_DIR=$1
fi


# man1
rep "administrators with" "administrators with LibertyBSD" share/man/man1/help.1
linedel "^Other$" "man1/help.1"
linedel "references include the FAQ" share/man/man1/help.1
linedel "https://openbsd.org/faq"
linedel "which is mostly intended for administrators" share/man/man1/help.1
linedel "a working knowledge of" share/man/man1/help.1
linedel "\.Ux \." "man1/help.1"
linedel "There are also mailing lists in place" share/man/man1/help.1
rep "\.Ox ," "LibertyBSD," share/man/man1/help.1
rep "available;" "available; LibertyBSD" share/man/man1/help.1
linedel "\.Ox" share/man/man1/help.1

rep "\.Ox" "LibertyBSD" share/man/man1/gcc-local.1
rep "\.Ox" "LibertyBSD" share/man/man1/clang-local.1


# man3
rep "\.Ox" "LibertyBSD" share/man/man3/makedev.3
rep "\.Ox" "LibertyBSD" share/man/man3/sysexits.3


# man4
