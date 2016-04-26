##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::UpstreamTrimOverlappingFeaturesProcessor;

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
  return new BioMinerva::DNALib::UpstreamTrimOverlappingFeaturesProcessor();
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
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "No feature_processor in $self" );
  }

  my $trim_sequence = $mask_feature->sequence();
  foreach my $feature( @{ $features || [] } ) {
    $trim_sequence =
      $trim_sequence->temp_upstream_trim_sequence( $feature );
    if( !ref( $trim_sequence ) ) { 
      last; 
    }
  }

  if( ref( $trim_sequence ) ) {
    my $target_feature = $mask_feature->clone_without_part_features();
    $target_feature->set_sequence( $trim_sequence );
    $feature_processor->process_feature( $target_feature );
  }
}

##########################################################################

1;
