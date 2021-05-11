#!/usr/bin/env perl
use strict;

my(%filter);
open IN, "Gma.dep_geno";
open OUT, ">Gma.dep.maf_geno";
open OUT1, ">maf.summary.txt";
while(<IN>){
  chomp;
  my@line = split /\t/;

  my$a = 0;
  my$b = 0;
  my$total = 0;
  for(my$i=3; $i<=$#line; $i++){
    if($line[$i] eq "2"){
      $a+=0.5;
      $b+=0.5;
    }elsif($line[$i] eq "0"){
      $a+=1;
    }elsif($line[$i] eq "1"){
      $b+=1;
    }
    $total+=1;
  }
  my $min=&min($a, $b);
  my $maf=$min/$total;

  print OUT1 $line[0]."\t".$maf."\n";
  if( $maf>0.05){
    print OUT join("\t", @line)."\n";
    $filter{$line[0]}++;
  }
}
close IN;
close OUT;
close OUT1;

open LOC, "../Gma_loc";
open LOC1, ">Gma.dep.maf_loc";
while(<LOC>){
  chomp;
  my@line = split /\t/;
  if( exists $filter{$line[0]}){
    print LOC1 join("\t", @line)."\n";
  }
}
close LOC;
close LOC1;


sub min{
  my($a, $b) = @_;
  if($a>$b){
    return $b;
  }else{
    return $a;
  }
}
