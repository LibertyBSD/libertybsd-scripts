#!/bin/sh
########################################
# name: libdeblob.sh
# main: jadedctrl
# lisc: isc
# desc: important functions for the
#	libertybsd-scripts project, for
#	rebranding and deblobbing obsd
#	sources.
########################################

# --------------------------------------
# generic

# STRING --> NIL
# A more reliable & portable 'echo'.
# GNU echo will print '\n' verbatim; but BSD might
# print a newline. That's literally program-breaking...
# This gets around that-- '\n' is always verbatim.
function necho {
	echo "\$string = \$ENV{'string'}; print \"\$string\\\n\";" \
	| string="$1" perl
}



# NIL --> STRING
# read from stdin until eof hit; return all input
# good for writing functions that take piped info
function reade {
	while IFS= read -r line; do
		necho "$line";
	done
}

# STRING NUMBER --> NIL
# Run a command a given amount of times.
function dotimes {
	local iteration="$1"
	local command="$(echo "$@" | awk '{$1=""; print}')"

	eval "$command"
	iteration="$(echo "$iteration - 1" | bc)"

	if test 0 -lt "$iteration"; then
		dotimes "$iteration" "$command"
	fi
}

# STRING STRING STRING --> BOOLEAN
# Return 0 or 1 from a yes-no input prompt.
function yn_prompt {
	prompt="$1"
	y="$2"
	n="$3"

	printf '%s ' "$prompt"
	read response

	case $response in
		"$y")	return 0
			;;
		"$n")	return 1
			;;
		*)	yn_prompt "$prompt" "$y" "$n"
			;;
	esac
}

# NUMBER --> STRING
# Print the given amount of spaces
function space {
	local spaces="$1"

	dotimes $spaces printf "\"  \""
}


# --------------------------------------
# core

# |STRING PATH NUMBER --> NIL
# Send string to a patch-file, and make a patch for the change.
# Pass the (source-dir) file path, and 1 or 2.
# "1" as second argument means "append" to file, "2" to "overwrite"
# Pipe text to this function, and it'll go to the old patch-file,
# or a new one will be created automatically.
function ofile {
	local text="$(reade)"
	local file="$1"
	local overwrite="$2"

	local filetized="$(filetize "$file")"
	local source_path="${SRC_DIR}/${file}"
	local patch_path="${PATCH_DIR}/${filetized}"
	local add_path="${PATCH_DIR}/ADD_${filetized}"
	local patch_orig="${PATCH_DIR}/${filetized}.orig"
	local patch_temp="${PATCH_DIR}/${filetized}.temp"
	local patch_diff="${PATCH_DIR}/${filetized}.patch"
	local target="$patch_path"

	if test -e "$add_path"; then
		local target="$add_path"
	elif test ! -e "$patch_path"; then
		cp "$source_path" "$patch_path"
		cp "$source_path" "$patch_orig"
	fi

	case "$overwrite" in
		"1")	necho "$text" >> "$target" ;;
		"2")	necho "$text" > "$target" ;;
	esac

	# we can't have patches for ADD_'ed files
	if test ! -e "$add_path"; then
		diff "$patch_orig" "$patch_path" > "$patch_diff"
	fi
}

# PATH --> STRING
# Get string from patch-file (or source-file) from it's
# source-path. Decides automatically which to choose.
function ifile {
	local file="$1"

	local filetized="$(filetize "$file")"
	local source_path="${SRC_DIR}/${file}"
	local patch_path="${PATCH_DIR}/${filetized}"
	local add_path="${PATCH_DIR}/ADD_${filetized}"

	if test -e "$add_path"; then
		cat "$add_path"
	elif test -e "$patch_path"; then
		cat "$patch_path"
	else
		cat "$source_path"
	fi
}



# --------------------------------------
	
# STRING --> STRING
# Turn file-path into a friendly filename
function filetize {
	local file="$1"

	echo "$file" \
	| sed 's|/|\^|g'
}

# STRING --> STRING
# Vice-versa, you can probably see. reverse `filetize`.
function unfiletize {
	local filetized_path="$1"

	echo "$filetized_path" \
	| sed 's|\^|/|g'
}



# --------------------------------------
# file manipulation

# STRING STRING PATH --> NIL
# Replace all instances of a string within a file.
function rep {
	local replaced="$1"
	local replacement="$2"
	local file="$3"

	printf "."

	ifile "$file" \
	| sed 's^'"$1"'^'"$2"'^g' \
	| ofile "$file" 2
}

# STRING PATH --> NIL
# Delete all instances of a string from a file.
function strdel {
	local string="$1"
	local file="$2"

	printf "."

	rep "$1" "" $2
}

# STRING STRING PATH --> NIL
# Add a line following the first old line with "identifier" in it.
function lineadd {
	local identifier="$1"
	local newline="$2"
	local file="$3"

	local oldline="$(ifile "$file" | grep "$identifier" | head -1)"

	printf "."

	# ideally we could use `rep`, but that can't take newlines
	ifile "$file" \
	| sed 's^'"$oldline"'^'"${oldline}"'\
'"${newline}"'^' \
	| ofile "$file" 2
}

# STRING PATH --> NIL
# Remove all lines that contain a given "identifier".
function linedel {
	local identifier="$1"
	local file="$2"

	printf "."

	ifile "$file" \
	| grep -v "$identifier" \
	| ofile "$file" 2
}



# --------------------------------------
# file operations

# PATH PATH --> NIL
# Copy a given directory (from "files/" CWD or form "$SRC_DIR/")--
# recursively.
function dircp {
	local dir="$1"
	local dest="$2"

	echo "Copying directory $dir"

	if echo "$dir" | grep -q "^files"; then
		local abs_path="$dir"
	else
		local abs_path="$SRC_DIR/$dir"
	fi

	for file in $(ls $abs_path); do
		local abs_file="$abs_path/$file"
		if test -d "$abs_file"; then
			dircp "$dir/$file" "$dest/$file"
		else
			filecp "$dir/$file" "$dest/$file"
		fi
	done
}

# PATH --> NIL
# Delete a given file.
function dirdel {
	local file="$1"

	touch "$PATCH_DIR/RMD_$(filetize "$1")"
}

# PATH PATH --> NIL
# Copy a given file (from "files/" CWD or form "$SRC_DIR/")
function filecp {
	local file="$1"
	local dest="$2"

	local patch_dest="$PATCH_DIR/ADD_$(filetize "$dest")"

	if echo "$file" | grep -q "^files/"; then
		cp "$file" "$patch_dest"
	else
		cp "$SRC_DIR/$1" "$patch_dest"
	fi
}

# PATH --> NIL
# Delete a given file.
function filedel {
	local file="$1"

	touch "$PATCH_DIR/RM_$(filetize "$1")"
}



# --------------------------------------

# PATH --> NIL
# Apply a file deletion (filetized, in PATCH_DIR).
function apply_rm {
	local file="$1"
	local unfiletized="$(unfiletize "$(echo "$file" | sed 's/RM_//')")"

	echo "Deleting $unfiletized (from $file)!" 

	rm "$SRC_DIR/$unfiletized"
}

# PATH --> NIL
# Apply a file deletion (filetized, in PATCH_DIR).
function apply_rmd {
	local file="$1"
	local unfiletized="$(unfiletize "$(echo "$file" | sed 's/RMD_//')")"

	echo "Deleting -rf $unfiletized (from $file)!" 

	rm -rf "$SRC_DIR/$unfiletized"
}

# PATH --> NIL
# Apply a file addition (filetized, in PATCH_DIR).
function apply_add {
	local file="$1"
	local unfiletized="$(unfiletize "$(echo "$file" | sed 's/ADD_//')")"

	echo "Copying $file to $unfiletized!"

	cp "$PATCH_DIR/$file" "$SRC_DIR/$unfiletized"
}

# PATH --> NIL
# Apply a given patch (filetized, in PATCH_DIR).
function apply_patch {
	local file="$1"
	local unfiletized="$(unfiletize "$(echo "$file" | sed 's/\.patch//')")"

	echo "Applying $file to $unfiletized!"

	patch "$SRC_DIR/$unfiletized" < "$PATCH_DIR/$file"
}

# --------------------------------------

# NIL --> NIL
# Apply all patches.
function apply {

	for file in $(ls "$PATCH_DIR")
	do
		if echo "$file" | grep -q "^RMD_"; then
			apply_rmd "$file"
		elif echo "$file" | grep -q "^RM_"; then
			apply_rm "$file"
		elif echo "$file" | grep -q "^ADD_"; then
			apply_add "$file"
		elif echo "$file" | grep -q "\.patch$"; then
			apply_patch "$file"
		fi
	done
}


# --------------------------------------
# ports tree

# PATH --> STRING
# Print a string that may show a port's license.
function port_lisc_preview {
	local port="$1"

	grep -B1 "PERMIT_PACKAGE_CDROM" \
		"$SRC_DIR/$port/Makefile" 2>/dev/null
	grep -B1 "PERMIT_PACKAGE_CDROM" \
		"$SRC_DIR/$port/Makefile.inc" 2>/dev/null
}

# PATH --> NIL
# Add a given port to the blacklist.
function add_nonfree_port {
	local port="$1"

	echo "$port_name" \
	>> files/ports/blacklist
}

# PATH --> NIL
# Add a given port to the whitelist.
function add_libre_port {
	local port="$1"

	echo "$port_name" \
	>> files/ports/whitelist
}

# PATH --> STRING
# Return how a port is flagged, if at all.
function libre_status {
	local port="$1"

	if grep -q "^$port$" files/ports/whitelist; then
		echo "libre"
	elif grep -q "^$port$" files/ports/blacklist; then
		echo "nonfree"
	else
		echo "undetermined"
	fi
}
