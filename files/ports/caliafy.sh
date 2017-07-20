#!/bin/ksh

##########################################################
# caliafy.sh
# List of ports that require an OBSD CMAKE_SYSTEM_NAME
##########################################################

audiolist="chromaprint liblastfm musepack glyr lmms"
devellist="cmocka doxygen"
netlist="libmygpo-qt"
wwwlist="webkitgtk4"

audiolist="$(echo "$audiolist" | sed 's^ ^ audio/^g')"
devellist="$(echo "$devellist" | sed 's^ ^ devel/^g')"
netlist="$(echo "$netlist" | sed 's^ ^ net/^g')"
wwwlist="$(echo "$wwwlist" | sed 's^ ^ www/^g')"

portlist="$audiolist $devellist $netlist $wwwlist"
