#!/usr/bin/env perl
use strict;

my$sample="Glyma_10G246300.reserve.csv";
my(%filter);
my(@line, %hash, @geno, $i);
open OUT, ">Gma.kinship.hmp";
open IN, "../name.info";
my $f1 = <IN>;
@line = split /\t/, $f1;
@geno = ();
open DE, $sample;
while(<DE>){
  chomp;
  s/\r$//g if(/\r$/);
  if( /^X/ ){
    $_ = substr($_, 1);
  }
  $filter{$_}++;
}
close DE;

for($i=11; $i<=$#line; $i++){
  #print $i."\n";
  if( exists $filter{$line[$i]}){
    push(@geno, $line[$i]);
  }
}
print OUT $line[0]."\t".$line[1]."\t".$line[2]."\t".$line[3]."\t".$line[4]."\t".$line[5]."\t".$line[6]."\t".$line[7]."\t".$line[8]."\t".$line[9]."\t".$line[10]."\t";
print OUT join("\t", @geno)."\n";


open LOC, "Gma.dep.maf_loc";
#open LOC, "../beagle/Gma.beagle.filterMAF_loc";
while(<LOC>){
  chomp;
  @line = split /\t/;
  $hash{$line[0]} = $line[2]."\t".$line[1];
}
close LOC;

open GENO, "Gma.dep.maf_geno";
#open GENO, "../beagle/Gma.beagle.filterMAF_geno";
while(<GENO>){
  chomp;
  @line = split /\t/;
 
  @geno=(); 
  for($i=3; $i<=$#line; $i++){
    if($line[$i] eq "0"){
      push(@geno, $line[1].$line[1]);
    }elsif($line[$i] eq "1"){
      push(@geno, $line[2].$line[2]);
    }elsif($line[$i] eq "2"){
      push(@geno, $line[1].$line[2]);
    }else{
      push(@geno, "NN");
    }
  }
  print OUT $line[0]."\t".$line[1]."/".$line[2]."\t".$hash{$line[0]}."\t+\tNA\tNA\tNA\tNA\tNA\tNA\t".join("\t", @geno)."\n";
}
close GENO;
close OUT;
