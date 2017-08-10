#!/bin/ksh

########################################################
# aliafy.sh
# List of ports that require an OBSD build_alias env var
########################################################

astrolist="gcal wcslib"

archiverslist="libzip gcab gcpio gshar+gunshar gtar libarchive libmspack libtar lzo xz zziplib gcab lzop par2cmdline"
archiverslist="libtar"

audiolist="freealut akode twolame audacious pulseaudio jack libcue audacious-plugins ardour soundtouch gstreamer1/mm"
audiolist="$audiolist easytag freealut gmpc-plugins gsound libbs2b libcannberra mikmod mpdscribble umurmur"

cadlist="qucs"

chineselist="libchewing"

commslist="fldigi gnokii"

converterslist="libiconv p5-Convert-Color"

databaseslist="db/v3 db/v4 openldap sqlite3 gdbm yasm iodbc mariadb apache-couchdb libzdb mdbtools libpqxx pgadmin3"

devellist="autoconf/2.13 autoconf/2.52 autoconf/2.54 autoconf/2.56 autoconf/2.57 autoconf/2.58 autoconf/2.59 autoconf/2.60"
devellist="$devellist autoconf/2.61 autoconf/2.62 autoconf/2.63 autoconf/2.64 autoconf/2.65 autoconf/2.66 autoconf/2.67"
devellist="$devllist autoconf/2.68 autoconf/2.69 automake/1.4 automake/1.8 automake/1.9 automake/1.10 automake/1.11 automake/1.12"
devellist="$devellist automake/1.13 automake/1.14 automake/1.15 libtool libidn gmake llvm sdl2-image sdl2 apr apr-util t1lib"
devellist="$devellist bison gettext gettext-tools libsigsegv ffcall gobject-introspection yasm sdl cppunit json-glib libsoup"
devellist="$devellist libsigc++-2 glib2mm atk2mm libnotify npth check pangomm scons readline sdl-mixer libconfuse libconfig"
devellist="$devellist libgdata autogen boehm-gc commoncpp ccrtp cflow cgdb cil"

editorslist="nano"

gameslist="xscorch"

graphicslist="cairo gd ImageMagick djvulibre"

geolist="spatialindex geoclue2"

langlist="ghc clisp gawk guile ghc errlang/16 ocaml"

maillist="mutt alpine"

mathlist="graphviz"

misclist="findutils"

multimedialist="xvidcore libmp4v2"

netlist="openvpn librest quvi/scripts quvi/libquvi quvi uhttpmock telepathy/telepathy-glib"

printlist="libpaper texlive/base texlive/texmf psutils lilypond"

securitylist="cyrus-sasl2 libmcrypt libtasn1 p11-kit pinentry gpgme"

shellslist="bash"

sysutilslist="e2fsprogs polkit consolekit freeipmi coreutils"

textproclist="groff jq rapto raptorr"

wwwlist="lynx apache-httpd webkit"

x11list="gnome/at-spi2-core gnome/at-spi2-atk gnome/py-atspi gnome/libsecret gnome/gcr xkbcommon gtk2mm gnome/libgnomecanvasmm"

x11list="$x11list gtk3mm dbus-python gnome/yelp gnome/libgnome gnome/libgnomeui kde/art3 gnome/libgweather"

astrolist="$(echo "$astrolist" | sed 's^ ^ astro/^g')"
archiverslist="$(echo "$archiverslist" | sed 's^ ^ archivers/^g')"
audiolist="$(echo "$audiolist" | sed 's^ ^ audio/^g')"
cadlist="$(echo "$cadlist" | sed 's^ ^ cad/^g')"
chineselist="$(echo "$chineselist" | sed 's^ ^ chinese/^g')"
commslist="$(echo "$commslist" | sed 's^ ^ comms/^g')"
converterslist="$(echo "$converterslist" | sed 's^ ^ converters/^g')"
databaseslist="$(echo "$databaseslist" | sed 's^ ^ databases/^g')"
devellist="$(echo "$devellist" | sed 's^ ^ devel/^g')"
editorslist="$(echo "$editorslist" | sed 's^ ^ editors/^g')"
gameslist="$(echo "$gameslist" | sed 's^ ^ games/^g')"
graphicslist="$(echo "$graphicslist" | sed 's^ ^ graphics/^g')"
geolist="$(echo "$geolist" | sed 's^ ^ geo/^g')"
langlist="$(echo "$langlist" | sed 's^ ^ lang/^g')"
maillist="$(echo "$maillist" | sed 's^ ^ mail/^g')"
mathllist="$(echo "$mathlist" | sed 's^ ^ math/^g')"
misclist="$(echo "$misclist" | sed 's^ ^ misc/^g')"
multimedialist="$(echo "$multimedialist" | sed 's^ ^ multimedia/^g')"
netlist="$(echo "$netlist" | sed 's^ ^ net/^g')"
printlist="$(echo "$printlist" | sed 's^ ^ print/^g')"
securitylist="$(echo "$securitylist" | sed 's^ ^ security/^g')"
shellslist="$(echo "$shellslist" | sed 's^ ^ shells/^g')"
sysutils="$(echo "$sysutilslist" | sed 's^ ^ sysutils/^g')"
textproclist="$(echo "$textproclist" | sed 's^ ^ textproc/^g')"
wwwlist="$(echo "$wwwlist" | sed 's^ ^ www/^g')"
x11list="$(echo "$x11list" | sed 's^ ^ x11/^g')"

portlist="$archiverslist $audiolist $converterslist $databaseslist $devellist $editorslist $gameslist $graphicslist $geolist"
portlist="$portlist $langlist $maillist $mathlist $multimedialist $netlist $printlist $securitylist $shellslist $sysutilslist"
portlist="$portlist $textproclist $wwwlist $x11list"
