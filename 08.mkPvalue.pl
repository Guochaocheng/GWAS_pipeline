#!/usr/bin/env perl
use strict;

my(@line);
my $trait=$ARGV[0];
open IN, "output/".$trait.".assoc.txt";
open OUT, ">output/".$trait.".pvalue";
while(<IN>){
  chomp;
  @line = split /\t/;
  if($line[0] eq "chr"){
    print OUT "trait\tsnp\tchr\tpos\tp\n";
  }else{
    #$line[0] = &chrGet($line[0]);
    print OUT $trait."\t".$line[1]."\t".$line[0]."\t".$line[2]."\t".$line[11]."\n";
  }
}
close IN;
close OUT;

sub chrGet{
  my($var) = @_;
  my(@var) = split //, $var;
  if($var[0] eq "A"){
    if($var[1] eq "1"){
      return 10;
    }else{
      return $var[2];
    }
  }elsif($var[0] eq "C"){
    return (10+$var[2]);
  }
}
