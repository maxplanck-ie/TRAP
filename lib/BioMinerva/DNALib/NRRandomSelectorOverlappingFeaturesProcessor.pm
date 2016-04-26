##########################################################################

package BioMinerva::DNALib::NRRandomSelectorOverlappingFeaturesProcessor;

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
  return new BioMinerva::DNALib::NRRandomSelectorOverlappingFeaturesProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='digest2seen' get_id='' set_id=''>
###---   <auto:comment id="digest2seen" md5="OIWecPBiXheB3THQquO/QA">

=head2 digest2seen

 Title   : digest2seen property
 
 Usage   : $object->digest2seen(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="digest2seen" md5="B2YCdEAyH9Ylb8J6OZ4fKQ">

sub digest2seen {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'digest2seen' } = shift @_;
  }
  return $self->{ 'digest2seen' };
}

###---   </auto:code>
###---   <auto:code get_id="get_digest2seen" md5="e563wYBQJNwO+kC9zEV7VQ">

sub get_digest2seen {
  return shift->{ 'digest2seen' };
}

###---   </auto:code>
###---   <auto:code set_id="set_digest2seen" md5="ZJTjZ5GmKL62e4XgJB7seA">

sub set_digest2seen {
  my $self = shift @_;
  $self->{ 'digest2seen' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

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

  my $digest2seen = $self->get_digest2seen();
  $digest2seen ||= {};

  my @all_features = ( $mask_feature, @{ $features } );
  my @all_features_digest =
    map { $_->digest()->digest() } @all_features;

  my $none_seen = 1;
  foreach my $digest( @all_features_digest ) {
    if( $digest2seen->{ $digest } ) {
      $none_seen = 0;
    }
  }

  if( $none_seen ) {
    $feature_processor->process_feature( $mask_feature );
  }
  
  foreach my $digest( @all_features_digest ) {
    $digest2seen->{ $digest } = 1;
  }

  $self->set_digest2seen( $digest2seen );
}

##########################################################################

1;
