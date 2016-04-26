##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SubtractionFeatureOfOverlappingFeaturesProcessor;

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
  return new BioMinerva::DNALib::SubtractionFeatureOfOverlappingFeaturesProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

##########################################################################
# FUNCTIONALITY
##########################################################################

#NOTE: so, it works as follows: $mask_feature - $features

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;

  my $subsequences = 
    $mask_feature->spacer_subsequences_surrounding_sequences( $features );

  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "No feature_processor in $self" );
  }

  foreach my $subsequence( @{ $subsequences || [] } ) {
    my $target_feature = $self->_create_feature( $mask_feature, $features );
    $target_feature->set_type( 'region' );
    $target_feature->set_sequence( $subsequence );

    $feature_processor->process_feature( $target_feature );
  }
}

##########################################################################

1;
