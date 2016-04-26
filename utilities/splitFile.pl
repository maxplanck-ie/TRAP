#! /usr/bin/perl -w

# this script splits a file into "n" (almost) equal chunks
# while still respecting some regular expression to denot the chunk boundaries
# this script was written because "csplit" was not flexible enough to allow splitting a single file into
# multiple more complex chunks, compare
# csplit -f "$mdir/matrix_" -n 5 -s -z $mat "/^>/" {*}

use strict;   
use Getopt::Long;

my %opt = (
           'e'        => undef,     # regular expression: 
           'm'        => 1,         # number of chunks
           'prefix'   => "prefix",  # prefix=string for filename
           'help'     => undef,
          );


GetOptions(
           "m=i"    => \$opt{m},
           "e=s"    => \$opt{e},
           "p=s"    => \$opt{prefix},
           "help"   => \$opt{help},
           );



my $usage= "usage: $0 
           [-m <int>; number of regexp occurrences before chunking, default: $opt{m} ] 
           [-e <regexp>; regular expression to denote chunk boundaries] 
           <file> \n";


if ( $opt{help} || !$opt{e}) {
    print $usage;
    exit;
}



my $idx = 0;
my $count=0;

my $out = sprintf("%s%04d", $opt{prefix}, $idx);
open(OUT, ">$out");
while(<> ) {

    if ($_ =~ /$opt{e}/) { 

	if ( $count >= $opt{m} ) {
		close OUT;

		$count=0;
		$idx++;	
		$out = sprintf("%s%04d", $opt{prefix}, $idx);
		open(OUT, ">$out"); 


	}
	
	$count++; 
    }

    print OUT;	

}  

close(OUT);

exit(0);

