##########################################################################

package BioMinerva::DNALib::SurroundingRegionsOfPartsFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use strict;
use warnings;
use vars qw( @ISA );
use BioMinerva::DNALib::FeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureProcessor );

use Carp qw( confess carp croak );
use URI::Escape;
use BioMinerva::DNALib::Feature;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::SurroundingRegionsOfPartsFeatureProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_processor' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="feature_processor" md5="590kX77o/z11rFZiD4wW9A">

=head2 feature_processor

 Title   : feature_processor property
 
 Usage   : $object->feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_processor" md5="PCWVqoFW+WySJGnPwF5OLw">

sub feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_processor' } = shift @_;
  }
  return $self->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_processor" md5="Xk4YITFJR5x4zq3JMOIgnA">

sub get_feature_processor {
  return shift->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_processor" md5="ii7RU2XwXrU8nt4/NS64vw">

sub set_feature_processor {
  my $self = shift @_;
  $self->{ 'feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_processor" md5="7XvZLA/AZW8QrjIHZjyJag">

sub link_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_processor', $self->get_feature_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_processor' ) { $self->set_feature_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature
{
  my( $self, $feature ) = @_;

  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "No feature_processor in $self" );
  }

  my $target_feature = $feature->clone_without_part_features();
  
  my $part_features = $feature->part_features() || [];
  if( @{ $part_features } ) {
    my $surrounding_sequences = 
      $feature->contained_subsequences_surrounding_sequences(
        $part_features
      );
      
    my $surrounding_features = [];
    foreach my $surrounding_sequence( @{ $surrounding_sequences } ) {
      my $surrounding_feature = new BioMinerva::DNALib::Feature();
      $surrounding_feature->set_type( 'region' );
      $surrounding_feature->set_sequence( $surrounding_sequence );
      $target_feature->add_part_feature(  $surrounding_feature );
    }
  }

  $feature_processor->process_feature( $target_feature );
}

##########################################################################

1;
