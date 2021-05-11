#!/usr/bin/env perl
use strict;

my(%hash, %filter, @line, @geno);
open SAM, "Glyma_10G246300.reserve.csv";
while(<SAM>){
  chomp;
  s/\r$//g if(/\r$/);
  if( /^X/ ){
    $_ = substr($_, 1);
  }
  $hash{$_}++;
}
close SAM;

open NAME, "../name.info";
while(<NAME>){
  chomp;
  s/\r$//g if(/\r$/);
  @line = split /\t/;
  for(my$i=11; $i<=$#line; $i++){
    if( exists $hash{$line[$i]}){
      $filter{($i-8)}++;
    }
  }
}
close NAME;

open OUT, ">Gma.dep_geno";
open GENO, "../Gma_geno";
while(<GENO>){
  chomp;
  @line = split /\t/;

  @geno = ();
  for(my$i=3; $i<=$#line; $i++){
    if( exists $filter{$i}){
      push(@geno, $line[$i]);
    }
  }
  print OUT $line[0]."\t".$line[1]."\t".$line[2]."\t".join("\t", @geno)."\n";
}
close GENO;
close OUT; 
