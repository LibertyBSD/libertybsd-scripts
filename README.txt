===============================================================================
LIBERTYBSD-SCRIPTS                                       For deblobbing OpenBSD
===============================================================================

Scripts used to deblob and rebrand [OpenBSD](https://openbsd.org) sources for
the [LibertyBSD](https://libertybsd.net) project.

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

Cheers, good luck. :)

----------------------------------------
CREDITS
----------------------------------------
Ports contributions by [jmfgdev](https://notabug.org/jimmybot) (I.E. Jimmybot)
Some improvements and contributions by Einhard Leichtfuß

----------------------------------------
BORING STUFF
----------------------------------------
License is ISC (COPYING.txt)
Author is Jaidyn Levesque <jadedctrl@teknik.io>
Source is at https://git.eunichx.us/libertybsd-scripts.git
