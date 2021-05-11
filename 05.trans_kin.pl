#!/usr/bin/perl -w
use strict;

my(  $name, @line );

open IN, $ARGV[0];
open OUT, ">".$ARGV[1];
$name = <IN>;
$name = <IN>;
$name = <IN>;
while(<IN>){
        chomp;
        @line = split /\t/;
        splice( @line, 0, 1);
        print OUT join("\t", @line)."\n";
}
close IN;
close OUT;
