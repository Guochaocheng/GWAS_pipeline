#!/bin/bash

for i in 2018Oil 2019Oil 2018Protein 2019Protein 2018Oilnew 2019Oilnew
do
  cd $i
  
  cp ../08.mkPvalue.pl ./
  for sample in `awk '{print $2}' taxa_${i}.txt`
  do
    perl 08.mkPvalue.pl $sample &
  done

  cd ..
done
