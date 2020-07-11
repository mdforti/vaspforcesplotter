#!/bin/bash
#===============================================================================
#
#          FILE:  Fuerzas_por_atomo.sh
# 
#         USAGE:  ./Fuerzas_por_atomo.sh 
# 
#   DESCRIPTION:  Obtiene las fuerzas para cada átomo sobre cada ciclo ionico, reordenadas
#                 por átomo. 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mariano Forti (MF), marianodforti@gmail.com
#       COMPANY:  Comisión Nacional de Energía Atómica
#       VERSION:  1.0
#       CREATED:  23/10/15 14:56:19 ART
#      REVISION:  ---
#===============================================================================

NIONS=$(grep NIONS OUTCAR | awk '{print $NF}')

for atom in $(seq -w 1 $NIONS)
do
  outfile=force$atom

  awk -v ver=$atom '/TOTAL-FORCE/ {getline;for(i=1;i<=ver;i++)getline; print $0 }' OUTCAR >> $outfile 
done

