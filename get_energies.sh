#!/bin/bash
#===============================================================================
#
#          FILE:  get_energies.sh
# 
#         USAGE:  ./get_energies.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mariano Forti (MF), marianodforti@gmail.com
#       COMPANY:  Comisión Nacional de Energía Atómica
#       VERSION:  1.0
#       CREATED:  30/10/15 10:52:52 ART
#      REVISION:  ---
#===============================================================================


awk '/E0=/ { print $1"  "$5}' OSZICAR >> Energias.dat
