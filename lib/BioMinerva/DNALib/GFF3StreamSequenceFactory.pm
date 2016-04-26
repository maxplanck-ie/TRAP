##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3StreamSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FastaStreamSequenceFactory;
@ISA = qw( BioMinerva::DNALib::FastaStreamSequenceFactory );

use BioMinerva::DNALib::FastaStreamSequence;
use BioMinerva::Base::Cache;
use Carp qw( confess carp );
use POSIX qw( floor );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::GFF3StreamSequenceFactory();
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _do_process_other_format_headers
{
  my( $self, $stream ) = @_;

  while( my $line = <$stream> ) {
    if( $line =~ /^##FASTA$/ ) {
      return;
    }
  }

  croak( "Empty sequence factory (no ##FASTA line) in $self" );
}

##########################################################################

1;

