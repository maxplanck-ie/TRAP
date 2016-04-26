##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::RangeFeatureComparator;

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
    $clone = new BioMinerva::DNALib::RangeFeatureComparator();
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

  confess( "Not implemented yet" );
}

sub is_located_before
{
  my( $self, $first_feature, $second_feature ) = @_;

  confess( "Not implemented yet" );
}

sub overlaps
{
  my( $self, $first_feature, $second_feature ) = @_;

  confess( "Not implemented yet" );
}

##########################################################################

1;

