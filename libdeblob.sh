#!/bin/ksh

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
	echo $1 | sed 's|\^|/|g'
}

# Replace a string in a file
# Usage: rep $replacee $replacer $file
rep() {
	if [ -e "$PATCH_DIR/$(filetize "$3")" ]
	then
		sed 's^'"$1"'^'"$2"'^g' $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").tmp
		mv $PATCH_DIR/$(filetize "$3").tmp $PATCH_DIR/$(filetize "$3")
		diff $3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed 's^'"$1"'^'"$2"'^g' ${SRC_DIR}/${3} > $PATCH_DIR/$(filetize "$3")
		diff $3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	fi

}

# Delete a string in a file
# Usage: strdel $string $file
strdel() {
	rep "$1" "" $2
}

# Inserts a new line after another
# Usage: lineadd $string $newline $file
lineadd() {
	if [ -e "$PATCH_DIR/$(filetize "$3")" ]
	then
		sed 's^'"$1"'^'"$1"'\n'"$2"'^' $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").tmp
		mv $PATCH_DIR/$(filetize "$3").tmp $PATCH_DIR/$(filetize "$3")
		diff $3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed 's^'"$1"'^'"$1"'\n'"$2"'^' ${SRC_DIR}/${3} > $PATCH_DIR/$(filetize "$3")
		diff $3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	fi
}

# Removes a line.
# Usage linedel $string $file
linedel() {
	if [ -e "$PATCH_DIR/$(filetize "$2")" ]
	then
		grep -v "$1" $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").tmp
		mv $PATCH_DIR/$(filetize "$2").tmp $PATCH_DIR/$(filetize "$2")
		diff $2 $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	else
		grep -v "$1" ${SRC_DIR}/${2} > $PATCH_DIR/$(filetize "$2")
		diff $2 $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	fi
}

# "Copies" a file
# Usage: filedel $file $dest
filecp() {
	cp $1 $PATCH_DIR/ADD_$(filetize "$2")
}

# "Deletes" a file
# Usage: filedel $file
filedel() {
	touch $PATCH_DIR/RM_$(filetize "$1")
}

# Applies patches.
apply() {
	for file in $PATCH_DIR/*
	do
		realname=$(echo $file | sed 's^.*/^^' | sed 's/ADD_//' | sed 's/^/'"$SRC_DIR"'/')
		realname="$(unfiletize "$realname")"

		if echo "$file" | grep "RM_" > /dev/null
		then
			realname=$(echo "$realname" | sed 's/RM_//' | sed 's/^/'"$SRC_DIR"'/')
			echo "Deleting $realname in three seconds..."
			sleep 3
			rm -rf $realname
		elif echo "$file" | grep "ADD_" > /dev/null
		then
			realname=$(echo "$realname" | sed 's/ADD_//')
			echo "Copying $file to $realname..."
			cp $file $realname
		elif echo "$file" | grep ".patch$" > /dev/null
		then
			patch "$(echo $realname | sed 's/\.patch//' | sec 's/^/'"$SRC_DIR"'/')" < $file
		fi
	done
}

self_destruct_sequence() {
	echo "$1 will be deleted in ten seconds."
	echo "CTRL-C now to avoid this fate!"
	echo "10"; sleep 1
	echo "9"; sleep 1
	echo "8"; sleep 1
	echo "7"; sleep 1
	echo "6"; sleep 1
	echo "5"; sleep 1
	echo "4"; sleep 1
	echo "3"; sleep 1
	echo "2"; sleep 1
	echo "1"; sleep 1
	printf "0\nDestruction!"
	rm -rf "$1"
}
