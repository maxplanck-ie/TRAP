##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::UnionFeatureOfOverlappingFeaturesProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureOfOverlappingFeaturesProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureOfOverlappingFeaturesProcessor );

use Carp qw( confess croak carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::UnionFeatureOfOverlappingFeaturesProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;

croak( "reimplement" );

  my $sequence = $mask_feature->sequence();
  foreach my $feature( @{ $features || [] } ) {
    $sequence->union( $feature );
  }
  if( $sequence->empty() ) {
    return;
  }
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "No feature_processor in $self" );
  }
  
  my $target_feature = $self->_create_feature( $mask_feature, $features );
  $target_feature->set_sequence( $sequence );

  $feature_processor->process_feature( $target_feature );
}

##########################################################################

1;
