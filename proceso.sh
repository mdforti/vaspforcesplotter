#!/bin/bash
shopt -s extglob

thiscase=FeO2term9L-FeBCC7L
if [ -f force001 ]
then
  echo "borrando resultados anteriores"
  rm force???
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
    bash Fuerzas_por_atomo.sh 
    bash get_energies.sh 
    wc -l < Energias.dat >> borders.dat
done

gnuplot plot_force_selective.gpi
gnuplot plot_rel_desplaza.gpi
gnuplot plot_energies.gpi
pdftk fuerzas.pdf update_info bookmarks.txt output b_fuerzas.pdf
pdftk Rel_Desplaza.pdf update_info bookmarks.txt output b_rel_desplaza.pdf

pdftoppm -png Energias.pdf Energias

PAGINAS="1 5 9 35 41 49"
for p in $PAGINAS ; do pdftoppm -f $p -singlefile -png b_fuerzas.pdf fuerzas$p ; done

mkdir atomos
mv force* atomos/
cd atomos
rm  !(*59|*67|*57|*65|*75|*69|*26|*126|*61)
for file in force*
do
  mv $file $file"_"$thiscase
done
cd ..

