#!/bin/ksh

##########################################################
# caliafy.sh
# List of ports that require an OBSD CMAKE_SYSTEM_NAME
##########################################################

archiverslist="quazip unshield"
audiolist="chromaprint liblastfm musepack glyr lmms mscore openal ympd"
cadlist="kicad kikac-library"
converterslist="wv2"
databaseslist="cmocka doxygen mydumper"
devellist="cmocka doxygen yaml-cpp"
netlist="libmygpo-qt"
mathlist="cgal"
wwwlist="webkitgtk4"

archiverslist="$(echo "$archiverslist" | sed 's^ ^ archivers/^g')"
audiolist="$(echo "$audiolist" | sed 's^ ^ audio/^g')"
cadlist="$(echo "$cadlist" | sed 's^ ^ cad/^g')"
converterslist="$(echo "$converterslist" | sed 's^ ^ converters/^g')"
databaseslist="$(echo "$databaseslist" | sed 's^ ^ databases/^g')"
devellist="$(echo "$devellist" | sed 's^ ^ devel/^g')"
mathlist="$(echo "$mathlist" | sed 's^ ^ math/^g')"
netlist="$(echo "$netlist" | sed 's^ ^ net/^g')"
wwwlist="$(echo "$wwwlist" | sed 's^ ^ www/^g')"

portlist="$archiverslist $audiolist $cadlist $devellist $mathlist $netlist $wwwlist"
