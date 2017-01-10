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
	if [ -e "/tmp/$(filetize "$3")" ]
	then
		sed --posix 's^'$1'^'$2'^g' /tmp/$(filetize "$3") > /tmp/$(filetize "$3").tmp
		mv /tmp/$(filetize "$3").tmp /tmp/$(filetize "$3")
		diff $3 /tmp/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed --posix 's^'$1'^'$2'^g' $3 > /tmp/$(filetize "$3")
		diff $3 /tmp/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	fi

}

# Delete a string in a file
# Usage: strdel $string $file
strdel() {
	if [ -e "/tmp/$(filetize "$2")" ]
	then
		sed 's^'$1'^^' /tmp/$(filetize "$2") > /tmp/$(filetize "$2").tmp
		mv /tmp/$(filetize "$2").tmp /tmp/$(filetize "$2")
		diff $2 /tmp/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	else
		sed 's^'$1'^^' $2 > /tmp/$(filetize "$2")
		diff $2 /tmp/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	fi
}

# Inserts a new line after another
# Usage: lineadd $string $newline $file
lineadd() {
	if [ -e "/tmp/$(filetize "$3")" ]
	then
		sed 's^'$1'^'$1'\n'$2'^' /tmp/$(filetize "$3") > /tmp/$(filetize "$3").tmp
		mv /tmp/$(filetize "$3").tmp /tmp/$(filetize "$3")
		diff $3 /tmp/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed 's^'$1'^'$1'\n'$2'^' $3 > /tmp/$(filetize "$3")
		diff $3 /tmp/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	fi
}

# Removes a line.
# Usage linedel $string $file
linedel() {
	if [ -e "/tmp/$(filetize "$3")" ]
	then
		grep -v "$1" /tmp/$(filetize "$2") > /tmp/$(filetize "$2").tmp
		mv /tmp/$(filetize "$2").tmp /tmp/$(filetize "$2")
		diff $2 /tmp/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	else
		grep -v "$1" $2 > /tmp/$(filetize "$2").tmp
		diff $2 /tmp/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	fi
}

# "Copies" a file
# Usage: filedel $file
filecp() {
	cp $1 /tmp/ADD_$(filetize "$2")
}

# "Deletes" a file
# Usage: filedel $file
filedel() {
	touch /tmp/RM_$(filetize "$1")
}

# Applies patches.
apply() {
	for file in $PATCH_DIR/*
	do
		realname=$(echo $file | sed 's^.*/^^')	# Still need unfiletizing?

		if echo "$file" | grep "^RM_" > /dev/null
		then
			rm $realname
		elif echo "$file" | grep "^ADD_" > /dev/null
		then
			cp $file $realname
		else
			patch $realname < $file
		fi
	done
}
