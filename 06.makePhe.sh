#!/bin/bash

for trait in 2018Oil 2019Oil 2018Oilnew 2019Oilnew 2018Protein 2019Protein
do
  mkdir $trait
  #cp ../../20210409_Chr20_add/${trait}/Gma_${trait} ${trait}/
  perl 06.1.trans2phe.pl ../../20210409_Chr20_add/${trait}/Gma_${trait} ${trait}/Gma_${trait}
  cp ../../20210409_Chr20_add/${trait}/taxa_${trait}.txt ${trait}/
  cp ../../20210409_Chr20_add/${trait}/06.ParaGemma.pl ${trait}/
  cp ../../20210409_Chr20_add/${trait}/example.slurm ${trait}/
done
