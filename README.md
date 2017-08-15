Scripts used to deblob and rebrand [OpenBSD](https://openbsd.org) sources for
the [LibertyBSD](https://libertybsd.net) project.

Usage of these scripts is pretty simple-- to make freshly deblobbed OBSD
sources, just run them each with $1 being the directory of the corresponding
source-code, like so:

* sh src_deblob.sh /usr/src
* sh man_deblob.sh /usr/src
* sh sys_deblob.sh /usr/src/sys
* sh xenocara_rebrand.sh /usr/xenocara
* sh ports_deblob.sh /usr/ports

If you want liberated OpenBSD sources, but without the LibertyBSD rebranding,
just skip the *_rebrand.sh scripts and everything should go fine.

Cheers, good luck! :)
