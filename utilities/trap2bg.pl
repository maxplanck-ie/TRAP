#! /usr/bin/perl -w

# this script convert TRAP output (gff-file with affinities) into a bedgraph file
# optionally different normalizations can be performed
# input:
#       1. trap output (gff-file)
#       2. external file with parameters
#       3. normalisation scheme
#
# output:
#       1. bedgraph file with (affinities, normalized TRAP scores, p values)

use strict;   
use Getopt::Long;

my %opt = (
           'external'   => undef,    # external file to define distribution parameters (e.g mean and std)
           'norm'       => "none",   # choices: "none" (default), "log", "GEV_lin"
           'help'       => undef,
          );

GetOptions(
           "external=s"    => \$opt{external},
           "norm=s"        => \$opt{norm},
           "help"          => \$opt{help},
           );



my $usage= "usage: $0 
           [-norm <normalisation method/distribution>; choices: none (default), log, GEV_lin] 
           [-external <external file with distribution parameters>; required for norm=GEV_lin] 
           \n";


if ( $opt{help}) {
    print $usage;
    exit;
}


if ($opt{norm} eq "GEV_lin" && !$opt{external}) { print $usage; exit; }

my %stat=();
if ($opt{external} && -e $opt{external} ) { %stat = ReadStat($opt{external}); }

while(<> ) {

    if ($_ =~ /^\#/) { next; }  # skip command lines
    chomp;
    my @word  = split('\s+');

    my $chr   = $word[0];
    my $start = $word[3]-1;  # half-open convention of bed-file
    my $end   = $word[4];
    my $score = $word[5];  
    my $length = $end - $start + 1;
    my $id    = $word[8];

    # use defined length for normalization, but be cautious if this length is very small (e.g. NNNNNNNNATNNNNNN ==> def_L=2)
    if ($id =~ /def_L=(\d+)/) { if ($1>0) {$length=$1;} }


    # default: keep original score (= affinity)
    my $new_score=$word[5];    

    # simple: normalize with respect to (effective) length and take logarithm ==> TRAP-score
    if ($opt{norm} eq "log") { $new_score = log($score / $length); }

    # GEV_lin: convert affinity into p-value as determined from GEV distribution
    if ($opt{norm} eq "GEV_lin") {
	# 3 parameters of GEV distribution are determined through linear regression against log($length)
	my @parm = id2parm($id,\%stat);        # regression parameter
	my $logL     = log($length);    # _natural_ logarithm !
	my $shape    = $parm[0] + $parm[1]*$logL;
	my $scale    = $parm[2] + $parm[3]*$logL;
	my $location = $parm[4] + $parm[5]*$logL;
	my $x        = log($score);     # _natural_ logarithm !
	$new_score = GEVp($x,$shape,$scale,$location);
    }

    print join "\t", ($chr, $start, $end, $new_score); print "\n"; 
}

#print STDERR "$0: Finished \n";

exit(0);


###################################################################################
sub ReadStat {
    # read mean and standard deviation from file
    my ($file) = @_;
    
    my %stat = ();
    open(STAT, "<$file")   || die "ReadStat: Can't open STAT file $file : $! \n";
    while(<STAT>) {
	chomp;
	if ($_ =~ /\#/) {next;}
	my @word = split('\s+');
	my $name = shift @word;
	if (exists $stat{$name}) {
	    my @prev = @{$stat{$name}};
	    print "$name has already been assigned parameters @prev\n";
	    print "will not overwrite with @word\n";
	    print "UNIFY file $file !\n";
	    exit(1);
	}
	#print "name = $name word = @word\n"; exit(1);
	push(@{$stat{$name}}, @word);
    }
    close(STAT);

    return %stat;
}

#################################################################################################
sub GEV {
    # returns -log Pr(X>x|a,b,c)
    # checked against R (evd::pgev), which returns Pr(X<=x|a,b,c)
    
    my ($x,$a,$b,$c) = @_;

    if ($b <= 0 ) { print "GEV: ERROR b = $b\n"; exit(1); }
    #if ($b <= 0 ) { print "GEV: ERROR b = $b\n"; return 0; }
    
    $x = ($x - $c) / $b;
    
    my $p;
    if ($a==0) {
	# convert to Gumbel a->0
	$p = 1.0 - exp(-exp(-$x));
    } else {
	$p = 1 + $a*$x;
	if ($p<0) {$p=0;}
	$p = $p**-(1/$a);
	$p = 1.0 - exp(-$p);
    }
    #print "GEV $x $a $b $c $p\n";

    my $Z=1000;
    if ($p>0) {
	$Z = -log($p)/log(10);  # return -log p
    }
    return $Z;
}

#################################################################################################
sub GEVp {
    # returns Pr(X>x|a,b,c)
    
    my ($x,$a,$b,$c) = @_;

    #if ($b <= 0 ) { print "GEV: ERROR b = $b\n"; exit(1); }
    if ($b <= 0 ) { print "GEV: ERROR b = $b\n"; return 1; }
    
    $x = ($x - $c) / $b;
    
    my $p;
    if ($a==0) {
	# convert to Gumbel a->0
	$p = 1.0 - exp(-exp(-$x));
    } else {
	$p = 1 + $a*$x;
	if ($p<0) {$p=0;}
	$p = $p**-(1/$a);
	$p = 1.0 - exp(-$p);
    }
    #print "GEV $x $a $b $c $p\n";

    return $p;
}


#########################################################################

sub id2parm {
    my $id = shift;
    my $stat = shift;
    
    # the interpretation of $id is specific to the output from ANNOTATION tool  
    my $matrix_id   = "NA";
    my $matrix_name = "NA";
    my $seq_id      = "NA";

    my @fields = split('\;',$id);
    foreach my $f (@fields) {
	if ($f =~ /matrix_id=(\S+)/)   { $matrix_id   = $1; $matrix_id   =~ s/['\s;]//g;}
	if ($f =~ /matrix_name=(\S+)/) { $matrix_name = $1; $matrix_name =~ s/['\s;]//g;}
	if ($f =~ /seq_id=(\S+)/)      { $seq_id      = $1; $seq_id      =~ s/['\s;]//g;}
    }

    #### obtain parameters for this matrix ($matrix_id or $matrix_name)
    my @parm = ();
    if (exists $stat->{$matrix_id}) { 
	@parm = @{$stat->{$matrix_id}};
    } else {
	# try if the parameters are stored under $name
	if (!exists $stat->{$matrix_name}) { 
	    print STDERR "NormalizeGff: ERROR! have no information on matrix_name=$matrix_name matrix_id=$matrix_id id=$id\n"; next; #exit; 
	} else {
	    @parm = @{$stat->{$matrix_name}};
	}
    }
    return @parm;
}
