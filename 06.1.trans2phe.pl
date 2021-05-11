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
      $filter{($i-11)}++;
    }
  }
}
close NAME;

my($id)=0;
open IN, $ARGV[0];
open OUT, ">".$ARGV[1];
while(<IN>){
  chomp;
  if( exists $filter{$id}){
    print OUT $_."\n";
  }
  $id++;
}
close IN;
close OUT; 
