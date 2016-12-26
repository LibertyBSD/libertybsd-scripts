#!/bin/bash

#########################
# Name: libdeblob.sh
# Main: jadedctrl
# Lisc: ISC
# Desc: Functions to be
#       used for deblobbing
#       and rebranding OBSD
#       sources for the LBSD
#       project.
#########################

# Turns a file and it's path into a friendly filename
# Usage: filetize $filepath
filetize() {
	echo $1 | sed 's|/|^|g'
}

# Vice-versa, clearly.
# Usage: defiletize $filetizedpath
unfiletize() {
	echo $1 | sed 's|^|/|g'
}

# Replace a string in a file
# Usage: rep $replacee $replacer $file
rep() {
	sed --posix 's^'$1'^'$2'^g' $3 > /tmp/$(filetize "$3")
	diff $3 /tmp/$(filetize "$3") >> $PATCH_DIR/$(filetize "$3").patch
}

# Inserts a new line after another
# Usage: addline $string $newline $file
addline() {
	sed 's^'$1'^'$1'\n'$2'^' $3 > /tmp/$(filetize "$3")
	diff $3 /tmp/$(filetize "$3") >> $PATCH_DIR/$(filetize "$3").patch
}

apply() {
	for file in $PATCH_DIR/*
	do
		realname=$(echo $file | sed 's^.*/^^')
		patch $realname < $file
	done
}
