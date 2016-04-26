##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::CmpFeatureComparator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureComparator;
@ISA = qw( BioMinerva::DNALib::FeatureComparator );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::CmpFeatureComparator();
  }

  $self->SUPER::clone( $clone );
  
  return $clone;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub compare
{
  my( $self, $first_feature, $second_feature ) = @_;

  my $cmp = $first_feature->get_primary_sequence_id()
    cmp $second_feature->get_primary_sequence_id();
  if( $cmp ) { return $cmp; }
  return $first_feature->get_start()
    <=> $second_feature->get_start();
}

##########################################################################

1;
