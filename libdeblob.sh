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
	echo $1 | sed 's|/|\^|g'
}

# Vice-versa, clearly.
# Usage: defiletize $filetizedpath
unfiletize() {
	echo $1 | sed 's|\^|/|g'
}

# Prints $1 number of spaces.
# Usage: space $number
space() {
	i=0
	while [ $i != $1 ]
	do
		printf " "
		i=$((i+1))
	done
}

# Replace a string in a file
# Usage: rep $replacee $replacer $file
rep() {
	if [ -e "$PATCH_DIR/$(filetize "$3")" ]
	then
		sed 's^'"$1"'^'"$2"'^g' $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").tmp
		mv $PATCH_DIR/$(filetize "$3").tmp $PATCH_DIR/$(filetize "$3")
		diff ${SRC_DIR}/$3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed 's^'"$1"'^'"$2"'^g' ${SRC_DIR}/${3} > $PATCH_DIR/$(filetize "$3")
		diff ${SRC_DIR}/$3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
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
		sed 's^'"$1"'^'"$1"' \
'"$2"'^' $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").tmp
		mv $PATCH_DIR/$(filetize "$3").tmp $PATCH_DIR/$(filetize "$3")
		diff ${SRC_DIR}/$3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	else
		sed 's^'"$1"'^'"$1"' \
'"$2"'^' ${SRC_DIR}/${3} > $PATCH_DIR/$(filetize "$3")
		diff ${SRC_DIR}/$3 $PATCH_DIR/$(filetize "$3") > $PATCH_DIR/$(filetize "$3").patch
	fi
}

# Removes a line.
# Usage linedel $string $file
linedel() {
	if [ -e "$PATCH_DIR/$(filetize "$2")" ]
	then
		grep -v "$1" $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").tmp
		mv $PATCH_DIR/$(filetize "$2").tmp $PATCH_DIR/$(filetize "$2")
		diff ${SRC_DIR}/$2 $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
	else
		echo otherwise
		grep -v "$1" "${SRC_DIR}/$2" > $PATCH_DIR/$(filetize "$2")
		diff ${SRC_DIR}/$2 $PATCH_DIR/$(filetize "$2") > $PATCH_DIR/$(filetize "$2").patch
		echo otherhell
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
	echo $PATCH_DIR $1
	touch $PATCH_DIR/RM_$(filetize $1)
}

# Applies patches.
apply() {
	for file in $PATCH_DIR/*
	do
		realname=$(echo $file | sed 's^.*/^^' | sed 's/ADD_//' | sed 's/RM_//')
		realname="$(unfiletize "$realname")"

		if echo "$file" | grep "RM_" > /dev/null
		then
			realname=$(echo "$realname" | sed 's/RM_//')
			echo "Deleting $realname in three seconds..."
			echo "3"; sleep 1
			echo "2"; sleep 1
			echo "1"; sleep 1
			if rm -rf ${SRC_DIR}/$realname
			then
				echo "$realname deleted" >> apply.log
				echo "$realname deleted"
			else
				echo "!!! $realname NOT deleted" >> apply.log
				echo "!!! $realname NOT deleted"
			fi
		elif echo "$file" | grep "ADD_" > /dev/null
		then
			realname=$(echo "$realname" | sed 's/ADD_//')
			echo "Copying $file to $realname..."
			if cp $file ${SRC_DIR}/$realname
			then
				echo "$realname copied from $file" >> apply.log
			else
				echo "!!! $realname NOT copied from $file" >> apply.log
			fi
		elif echo "$file" | grep ".patch$" > /dev/null
		then
			if patch "${SRC_DIR}/$(echo $realname | sed 's/\.patch//')" < $file
			then
				echo "${SRC_DIR}/$(echo $realname | sed 's/\.patch//') patched from $file" >> apply.log
			else
				echo "!!! ${SRC_DIR}/$(echo $realname | sed 's/\.patch//') NOT patched from $file" >> apply.log
			fi
		fi
	done
}

self_destruct_sequence() {
	echo "$1 will be deleted in three seconds."
	echo "CTRL-C now to avoid this fate!"
	echo "3"; sleep 1
	echo "2"; sleep 1
	echo "1"; sleep 1
	printf "0\nDestruction!"
	rm -rf "$1"
}
