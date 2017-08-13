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

archiverslist="$(echo "$archiverslist" | sed -E 's`( |^)`\1archivers/^g')"
audiolist="$(echo "$audiolist" | sed -E 's`( |^)`\1audio/^g')"
cadlist="$(echo "$cadlist" | sed -E 's`( |^)`\1cad/^g')"
converterslist="$(echo "$converterslist" | sed -E 's`( |^)`\1converters/^g')"
databaseslist="$(echo "$databaseslist" | sed -E 's`( |^)`\1databases/^g')"
devellist="$(echo "$devellist" | sed -E 's`( |^)`\1devel/^g')"
mathlist="$(echo "$mathlist" | sed -E 's`( |^)`\1math/^g')"
netlist="$(echo "$netlist" | sed -E 's`( |^)`\1net/^g')"
wwwlist="$(echo "$wwwlist" | sed -E 's`( |^)`\1www/^g')"

portlist="$archiverslist $audiolist $cadlist $devellist $mathlist $netlist"
portlist="$portlist $wwwlist"
