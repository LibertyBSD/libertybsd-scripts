===============================================================================
LIBERTYBSD-SCRIPTS                                       For deblobbing OpenBSD
===============================================================================

Scripts used to deblob and rebrand OpenBSD source-code, made for the
LibertyBSD project.



----------------------------------------
SCRIPTS
----------------------------------------
There're five scripts here, so here's what they do:

	src_deblob.sh	Deblobs main OBSD source of NF FW, references, etc
	man_deblob.sh	Gets rid of pages with non-free (NF) references
	sys_deblob.sh	Deletes NF firmware and references thereof from kernel

	src_rebrand.sh	Basic system rebranding, etc
	sys_rebrand.sh	System/boot rebranding
	man_rebrand.sh	Rebrand man-pages, and add some of our new ones
	xenocara_rebrand.sh
			Rebrands X sources-- not much to this one

	ports_deblob.sh
			Deblob ports tree of all NF listings
	ports_rebrand.sh
			Rebrand ports in ports-tree, etc



----------------------------------------
USAGE
----------------------------------------
Usage of these scripts is pretty simple-- to make freshly deblobbed OBSD
sources, just run them each with $1 being the directory of the corresponding
source-code, like so:

	sh src_deblob.sh /usr/src
	sh man_deblob.sh /usr/src
	sh sys_deblob.sh /usr/src/sys
	sh xenocara_rebrand.sh /usr/xenocara
	sh ports_deblob.sh /usr/ports

If you want liberated OpenBSD sources, but without the LibertyBSD rebranding,
just skip the *_rebrand.sh scripts and everything should go fine.



----------------------------------------
NOTES
----------------------------------------
All of the scripts make use of "./libdeblob.sh", and all file-editing/etc
operations are abstracted to its functions.

This is because, instead of actually applying changes directly to the source
code of the given directory, the deblob scripts create a set of patches for
the given directory, and, after every patch is created, the patches are
finally applied to the given directory.

The making of patches, etc, are abstacted to the functions "ifile" and "ofile".
"ifile" outputs to stdout the file-- be it the patch-file, the original,
whatever is appropriate. "ofile" writes to the patch-file what is piped to it,
and handles the bullocks.

Hence why "ifile | operation | ofile" is so common in libdeblob.sh

Each script uses a very clearly-named /tmp/ directory...
	script-name.*/

... where * is a random string of numbers.

This *is* more indirect and cumbersome, but it has some nice advantages:
	o Forced Abstraction:
	  When operations *need* to be abstracted, they tend to become more
	  standardized. This leads to easily grokable function-names (rather
	  than potentially obscure command calls)
	o Easy Debugging:
	  Since all patches and their effects are stored in /tmp/ before
	  being applied, one can easily SIGUP and investigate for any
	  problems before the given directory is tainted. Or even if it
	  already has been, it's still easy enough to compare patches, etc.
	o Patch Generation:
	  I mean, yeah, it makes patches. We know that. So for sure, if we
	  want to distribute patches, that's nice. And they'll be distributed,
	  not that it's clear they'll be useful to anyone. Hey, if it's easy
	  to provide for some weird, obscure, barely-hypothetical use-case,
	  why not?

... in order of importance.



----------------------------------------
BORING STUFF
----------------------------------------
Send patches/issues to:
	o <jadedctrl@teknik.io>
	o <#libertybsd> (Freenode)
	o </f/libertybsd> (raddle.me)

License is ISC (COPYING.txt)
Author is Jaidyn Levesque <jadedctrl@teknik.io>
Some ports contributions by jmfgdef (Jimmybot),
some improvements by Einhard Leichtfuß.
Source is at https://git.eunichx.us/libertybsd-scripts.git
