#!/bin/bash
shopt -s extglob
ROOT=~/CuadernoTrabajo/scripts/vaspforcesplotter

thiscase=Case
if [ -f force* ]
then
  echo "borrando resultados anteriores"
  rm force*
fi

if [ -f Energias.dat ] 
then
  echo "borrando *.dat anteriores"
  rm Energias.dat 
  rm borders.dat
fi

PARC=""

if [ -f parciales.tar.gz ]
then
  PARC="parciales.tar.gz"
fi

for tarf in  OUT-OSZ-CON*.tar.gz $PARC
do
    echo "procesando $tarf"   
    tar -xf $tarf 
    bash $ROOT/Fuerzas_por_atomo.sh 
    bash $ROOT/get_energies.sh 
    wc -l < Energias.dat >> borders.dat
done

gnuplot $ROOT/plot_force_selective.gpi
gnuplot $ROOT/plot_rel_desplaza.gpi
gnuplot $ROOT/plot_energies.gpi
pdftk fuerzas.pdf update_info bookmarks.txt output b_fuerzas.pdf
pdftk Rel_Desplaza.pdf update_info bookmarks.txt output b_rel_desplaza.pdf

mkdir atomos
mv force* atomos/
do
  mv $file $file"_"$thiscase
done
cd ..

