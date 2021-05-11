#!/usr/bin/env perl
use strict;

my (@line, @pos1, @pos2, @phe, @posList, $i, $j, $k, $trait, $pos);
my @year = ("2018Oil", "2019Oil", "2018Protein", "2019Protein", "2018Oilnew", "2019Oilnew");
my $dis = 100*1000;
my $out= "cand.gwas.snp";
my $pvalue = "7.76e-8";

#file format: num pheName
#eg: 1 TSW
open PHE, "phe.list"; 
while(<PHE>){
	chomp;
	@line = split /\t/;
	push(@phe, $line[1]);
}
close PHE;

#file format:geneID chr1:1-100
open CAND, "candadiate.gene";
while(<CAND>){
	chomp;
	s/\r$//g if(/\r$/);
	@line = split /\t/;
	@pos1 = split /:/, $line[1];	# split postions
	@pos2 = split /-/, $pos1[1];
	# store the postion info 
	push(@posList, [$line[0], $line[1], $pos1[0], $pos2[0]-$dis, $pos2[1]+$dis]);
}
close CAND;

open OUT, ">".$out;
for($i=0; $i<=$#year; $i++){
	for($j=0; $j<=$#phe; $j++){
		$trait = $year[$i]."/output/".$phe[$j].".pvalue";

		print "[INFO] $trait begins.\n";	
		next if(! -e $trait );
		open IN, $trait;
		while(<IN>){
			chomp;
			@line = split /\t/;
			next if($line[0] eq "trait");
	
			# check the position of snp and candidate gene		
			for($k=0; $k<=$#posList; $k++){
				next if( $line[2] ne $posList[$k][2]);
				if( $posList[$k][3] <= $line[3] && $line[3] <= $posList[$k][4]){
					#next if( $line[4] > $pvalue);
					if( $posList[$k][3]<= $line[3] && $line[3] <= $posList[$k][3]+$dis){
						$pos = $line[3]- ($posList[$k][3]+$dis);
					}elsif( $posList[$k][3]+$dis <= $line[3] && $line[3] <= $posList[$k][4]-$dis ){
						$pos = "gene-".($line[3]-($posList[$k][3]+$dis));
					}elsif( $posList[$k][4]-$dis <= $line[3] && $line[3] <= $posList[$k][4]){
						$pos = $line[3] - ($posList[$k][4]-$dis);
					}

					#next if( $line[4] > $pvalue);
					print OUT $trait."\t".$year[$i]."\t".$phe[$j]."\t".join("\t", @{$posList[$k]})."\t".$pos."\t".join("\t", @line)."\n";
				}
			}
		}
		close IN;
	}
}
close OUT;	
