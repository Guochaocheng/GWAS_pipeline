#!/bin/bash

phe=$1
col=$2
name=$3

gemma=${HOME}/software/bin/gemma
#geno=${HOME}/workshop/20210304_Glymax_GWAS/Gma.map
#loc=${HOME}/workshop/20210304_Glymax_GWAS/Gma.loc
#kin=${HOME}/workshop/20210304_Glymax_GWAS/Gma_kin
geno=/lustre/home/acct-argwx/argwx-gcc/workshop/20210304_Glymax_GWAS/20210510_split_sample/Glyma_10G246300/Gma.dep.maf_geno
loc=/lustre/home/acct-argwx/argwx-gcc/workshop/20210304_Glymax_GWAS/20210510_split_sample/Glyma_10G246300//Gma.dep.maf_loc
kin=/lustre/home/acct-argwx/argwx-gcc/workshop/20210304_Glymax_GWAS/20210510_split_sample/Glyma_10G246300/Gma_kin

$gemma -g $geno -a $loc -k $kin -p $phe -n $col -lmm -o $name
#perl ./07.tranPvalue.pl $name
perl ./08.mkPvalue.pl $name
