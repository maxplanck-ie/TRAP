##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioSimpleAlignFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess croak carp );

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

sub indexes
{
  my( $self ) = @_;

  confess( "Not overridden in $self" );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub index2bio_simple_align
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index_bio_seq_no2sequence
{
  my( $self, $index, $bio_seq_no ) = @_;
  confess( "Not overridden in $self" );
}

sub index_bio_seq_no2feature
{
  my( $self, $index, $bio_seq_no ) = @_;
  confess( "Not overridden in $self" );
}

sub index2sequences
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2features
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

##########################################################################

sub index_iterator
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

##########################################################################

1;
