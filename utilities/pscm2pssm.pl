#!/usr/bin/perl

use strict;
use warnings;

use BioMinerva::DNALib::FastaFilePscmFactory;
use BioMinerva::DNALib::TransfacFilePscmFactory;
use BioMinerva::DNALib::FastaWriterPsmProcessor;
use BioMinerva::DNALib::PscmFactory2EntropyCutoffPscmFactory;
use BioMinerva::DNALib::PscmFactory2PssmFactory;
use BioMinerva::DNALib::PssmScoreDistFactory;
use Getopt::Long;
use Carp qw( confess carp croak );

my $transfac_matrix_file;
my $fasta_matrix_file;
my @matrices;
my @cutoff_names;
my $gc_content = 0.5;

my $result = GetOptions(
  "transfac_matrix_file|transfac_matrix|tm=s" => \$transfac_matrix_file,
  "fasta_matrix_file|fasta_matrix|fm=s" => \$fasta_matrix_file,
  "matrix=s" => \@matrices,
  "gc_content|gc=s" => \$gc_content,
  "cutoff_name=s" => \@cutoff_names,
);

if( !$result ) {
  croak( "Incorrect command line options, exiting" );
}

my $pscm_factory;
if( $transfac_matrix_file ) {
  $pscm_factory = new BioMinerva::DNALib::TransfacFilePscmFactory();
  $pscm_factory->file( $transfac_matrix_file );
} elsif( $fasta_matrix_file ) {
  $pscm_factory = new BioMinerva::DNALib::FastaFilePscmFactory();
  $pscm_factory->file( $fasta_matrix_file );
} else {
  croak( "No pssm/matrix factory defined" );
}

if( @matrices ) {
  my $filtered_pscm_factory = new BioMinerva::DNALib::IdFilteredRefPscmFactory();
  $filtered_pscm_factory->set_pscm_factory( $pscm_factory );
  $filtered_pscm_factory->pscm_ids( \@matrices );

  $pscm_factory = $filtered_pscm_factory;
}

my $pssm_factory;
{
  $pssm_factory = new BioMinerva::DNALib::PscmFactory2PssmFactory();
  $pssm_factory->set_pscm_factory( $pscm_factory );
  $pssm_factory->set_gc( $gc_content );
} 

my $pssm_score_dist_factory = new BioMinerva::DNALib::PssmScoreDistFactory();
#$pssm_score_dist_factory->set_cutoff_name( $cutoff_name );

my $psm_processor = new BioMinerva::DNALib::FastaWriterPsmProcessor();

foreach my $pssm( @{ $pssm_factory->pssms() || [] } ) {
  foreach my $cutoff_name( @cutoff_names ) {
    $pssm_score_dist_factory->set_cutoff_name( $cutoff_name );
    my $cutoff = $pssm_score_dist_factory->cutoff( $pssm, $pssm->pspm() );
    $pssm->add_attr( $cutoff_name . "_cutoff", $cutoff );
  }
  $psm_processor->process_psm( $pssm );
}

exit( 0 );
