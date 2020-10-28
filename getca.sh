#!/bin/bash - 
#===============================================================================
#
#          FILE: getca.sh
# 
#         USAGE: ./getca.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Mariano Forti (MDF), mforti@cnea.gov.ar
#  ORGANIZATION: Comisión Nacional de Energía Atómica
#       CREATED: 28/10/20 10:46:34
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
for dir in RLX*dir 
do
  file=$dir/OUT-OSZ-CON.tar.gz
  if [ -f $1/$file ]
  then
    tar -xf $1/$file OUTCAR -O | grep "lattice vectors" -A 4 | awk 'BEGIN { RS="--" } { print $21/$7 }'
  elif [ -f $1/OUTCAR ] 
  then
    grep "lattice vectors" -A 4 $1/OUTCAR | awk 'BEGIN { RS="--" } { print $21/$7 }'
  fi
done

