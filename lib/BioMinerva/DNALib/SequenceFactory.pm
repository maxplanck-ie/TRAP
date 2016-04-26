##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

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

# Identifies the sequences and their seqs. Does not take the order into
# account.
sub sequences_digest
{
  my( $self ) = @_;
  
  my $digest = new Digest::MD5();
  
  $digest->add( ref( $self ) );

  return $digest;
}

sub sequences_digest_id
{
  my( $self ) = @_;

  return $self->sequences_digest()->b64digest();
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub sequence_ids
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

sub sequences
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

sub sequence_id2sequence
{
  my( $self, $sequence_id ) = @_;
  confess( "Not overridden in $self" );
}

sub primary_sequence_ids
{
  my( $self ) = @_;
  confess( "Future: Not overridden in $self" );
}

sub primary_sequences
{
  my( $self ) = @_;
  confess( "Future: Not overridden in $self" );
}

sub sequence2seq
{
  my( $self, $sequence ) = @_;

  return '?' x $sequence->length();
}

sub sequence_offs_length2seq
{
  my( $self, $sequence, $offs, $length ) = @_;

  my $sub_sequence = $sequence->relative_sequence(
    $offs, $offs + $length - 1, 0
  );

  return $self->sequence2seq( $sub_sequence );
}

sub sequence_id_start_end2sequence
{
  my( $self, $sequence_id, $seq_start, $seq_end ) = @_;

  my $whole_sequence = $self->sequence_id2sequence( $sequence_id );
  if( !ref( $whole_sequence ) ) {
    return undef;
  }

  if( $seq_start <= $seq_end ) {
    return $whole_sequence->relative_sequence( $seq_start, $seq_end, 0 );
  } else {
    return $whole_sequence->relative_sequence( $seq_end, $seq_start, 1 );
  }
}

##########################################################################

sub index2start
{
  my( $self, $index ) = @_;
  confess( "Future: Not overridden in $self" );
}

sub index2sequence
{
  my( $self, $index, $sequence ) = @_;
  confess( "Future: Not overridden in $self" );
}

##########################################################################

1;
