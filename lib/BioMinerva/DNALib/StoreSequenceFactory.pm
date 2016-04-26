##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StoreSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FragmentedSequenceFactory;
@ISA = qw( BioMinerva::DNALib::FragmentedSequenceFactory );

use BioMinerva::DNALib::StoreSequence;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

sub sequences_digest
{
  my( $self ) = @_;

  confess( "Not overridden in $self" );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub add_store_sequence
{
  my( $self, $store_sequence ) = @_;

  $self->_add_sequence(
    $store_sequence,
    $store_sequence->get_primary_sequence_id(),
    $store_sequence->get_id() 
  );
}

sub add_sequence_seq
{
  my( $self, $sequence, $seq ) = @_;

  if( $sequence->length() != length( $seq ) ) {
    croak(
      "Incorrect length(\$seq)="
      . length( $seq )
      . " compared to $sequence"
    );
  }

  my $store_sequence = new BioMinerva::DNALib::StoreSequence();
  $store_sequence->set_sequence( $sequence );
  $store_sequence->set_seq( $seq );

  $self->_add_sequence(
    $store_sequence,
    $store_sequence->get_primary_sequence_id(),
    $store_sequence->get_id() 
  );
}

##########################################################################

sub _do_get_seq
{
  my( $self, $store_sequence, $f_offs, $copy_length ) = @_;

  return substr( 
    $store_sequence->get_seq(), 
    $f_offs, 
    $copy_length 
  );
}

##########################################################################

1;
