##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::OverlappingSequencesAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::OverlappingSequencesAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="feature_factory" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureFactory">
###---   <auto:comment id="feature_factory" md5="ajfRK5nKeu8O1iAMQUh8Hg">

=head2 feature_factory

 Title   : feature_factory property
 
 Usage   : $object->feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_factory" md5="1X/+SXk6hoj/gvrPj2ir9w">

sub feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_factory' } = shift @_;
  }
  return $self->{ 'feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_factory" md5="KUEdoE5I+frNv9fsYx8oFA">

sub get_feature_factory {
  return shift->{ 'feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_factory" md5="jrjTav7/QBvc/b/fShcnBQ">

sub set_feature_factory {
  my $self = shift @_;
  $self->{ 'feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_factory" md5="Q/CRdOmwILlT6wXJxvYYNw">

sub link_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="mask_feature_factory" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureFactory">
###---   <auto:comment id="mask_feature_factory" md5="VVPGJxWITCqJVbMHxdSKmw">

=head2 mask_feature_factory

 Title   : mask_feature_factory property
 
 Usage   : $object->mask_feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="mask_feature_factory" md5="dqscNXKU+z5T7lMlUsWdDA">

sub mask_feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'mask_feature_factory' } = shift @_;
  }
  return $self->{ 'mask_feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_mask_feature_factory" md5="gaawQlQDubpQjJsNKCBXjw">

sub get_mask_feature_factory {
  return shift->{ 'mask_feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_mask_feature_factory" md5="+oKx2t/wy9zTOSsEdEwmDw">

sub set_mask_feature_factory {
  my $self = shift @_;
  $self->{ 'mask_feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_mask_feature_factory" md5="PmKs+G9g/06PfNWqFNte9g">

sub link_mask_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'mask_feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'mask_feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="overlapping_features_processor" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::OverlappingFeaturesProcessor">
###---   <auto:comment id="overlapping_features_processor" md5="kG6Lalmw0ddkiFjUMvac+A">

=head2 overlapping_features_processor

 Title   : overlapping_features_processor property
 
 Usage   : $object->overlapping_features_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="overlapping_features_processor" md5="m9PGOw9Gi1OMvhU8H6/SjA">

sub overlapping_features_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'overlapping_features_processor' } = shift @_;
  }
  return $self->{ 'overlapping_features_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_overlapping_features_processor" md5="FuYs9VujvCFRUpWnkLHWng">

sub get_overlapping_features_processor {
  return shift->{ 'overlapping_features_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_overlapping_features_processor" md5="RmceGBrxUXFPh/i5fawvXw">

sub set_overlapping_features_processor {
  my $self = shift @_;
  $self->{ 'overlapping_features_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_overlapping_features_processor" md5="snoGG/G7jhNHkWTOe1yfuQ">

sub link_overlapping_features_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'overlapping_features_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'overlapping_features_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::OverlappingFeaturesProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='skip_equal' get_id='' set_id=''>
###---   <auto:comment id="skip_equal" md5="QZOWDYbP4gx4za+YA38VHA">

=head2 skip_equal

 Title   : skip_equal property
 
 Usage   : $object->skip_equal(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="skip_equal" md5="98jE26D4cq6JW2J4KGYRuQ">

sub skip_equal {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'skip_equal' } = shift @_;
  }
  return $self->{ 'skip_equal' };
}

###---   </auto:code>
###---   <auto:code get_id="get_skip_equal" md5="opWTpdWtvFFdikRk2lpBhw">

sub get_skip_equal {
  return shift->{ 'skip_equal' };
}

###---   </auto:code>
###---   <auto:code set_id="set_skip_equal" md5="F/QxHNbZqORoXwHO5Xh3bA">

sub set_skip_equal {
  my $self = shift @_;
  $self->{ 'skip_equal' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='skip_not_contained' get_id='' set_id=''>
###---   <auto:comment id="skip_not_contained" md5="KmCT2SBvmqbEJY3oOP8qvQ">

=head2 skip_not_contained

 Title   : skip_not_contained property
 
 Usage   : $object->skip_not_contained(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="skip_not_contained" md5="TZlu0e/SSmG+ecIB6ezdAg">

sub skip_not_contained {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'skip_not_contained' } = shift @_;
  }
  return $self->{ 'skip_not_contained' };
}

###---   </auto:code>
###---   <auto:code get_id="get_skip_not_contained" md5="FXAvA26Y5Ha1nKd7cCIt7A">

sub get_skip_not_contained {
  return shift->{ 'skip_not_contained' };
}

###---   </auto:code>
###---   <auto:code set_id="set_skip_not_contained" md5="dr2zwK1UcCCsY2EBLbPlKw">

sub set_skip_not_contained {
  my $self = shift @_;
  $self->{ 'skip_not_contained' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='only_with_overlaps' get_id='' set_id=''>
###---   <auto:comment id="only_with_overlaps" md5="hgWijJ74zcwZB6PO3+bhEA">

=head2 only_with_overlaps

 Title   : only_with_overlaps property
 
 Usage   : $object->only_with_overlaps(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="only_with_overlaps" md5="xyA1CR/oN3s6XDR9xEfb9A">

sub only_with_overlaps {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'only_with_overlaps' } = shift @_;
  }
  return $self->{ 'only_with_overlaps' };
}

###---   </auto:code>
###---   <auto:code get_id="get_only_with_overlaps" md5="YOR59yXzLV+GBjoLxqQgGA">

sub get_only_with_overlaps {
  return shift->{ 'only_with_overlaps' };
}

###---   </auto:code>
###---   <auto:code set_id="set_only_with_overlaps" md5="WebKlq9Vmobfi1GKFMhOyg">

sub set_only_with_overlaps {
  my $self = shift @_;
  $self->{ 'only_with_overlaps' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'mask_feature_factory', $self->mask_feature_factory() );
  $target->property( 'overlapping_features_processor', $self->overlapping_features_processor() );
  $target->property( 'skip_equal', $self->skip_equal() );
  $target->property( 'skip_not_contained', $self->skip_not_contained() );
  $target->property( 'only_with_overlaps', $self->only_with_overlaps() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'mask_feature_factory' );
  $target->property( 'overlapping_features_processor' );
  $target->property( 'skip_equal' );
  $target->property( 'skip_not_contained' );
  $target->property( 'only_with_overlaps' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'mask_feature_factory' ) { $self->mask_feature_factory( @values ); }
  elsif( $property eq 'overlapping_features_processor' ) { $self->overlapping_features_processor( @values ); }
  elsif( $property eq 'skip_equal' ) { $self->skip_equal( @values ); }
  elsif( $property eq 'skip_not_contained' ) { $self->skip_not_contained( @values ); }
  elsif( $property eq 'only_with_overlaps' ) { $self->only_with_overlaps( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
  $self->link_mask_feature_factory( $registry );
  $self->link_overlapping_features_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;
  
  my $mask_feature_factory = $self->get_mask_feature_factory();
  if( !ref( $mask_feature_factory ) ) {
    croak( "No mask_feature_factory in $self" );
  }

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "No feature_factory in $self" );
  }
  
  my $overlapping_features_processor = $self->get_overlapping_features_processor();
  if( !ref( $overlapping_features_processor ) ) {
    croak( "No overlapping_features_processor in $self" );
  }

  my $skip_equal = $self->get_skip_equal();
  my $skip_not_contained = $self->get_skip_not_contained();
  my $only_with_overlaps = $self->get_only_with_overlaps();
  
  my @primary_sequence_ids = sort
    @{ $mask_feature_factory->primary_sequence_ids() || [] };

  foreach my $primary_sequence_id( @primary_sequence_ids ) {
    my $mask_primary_sequence_id_feature_factory = 
      $mask_feature_factory->primary_sequence_id_feature_factory( $primary_sequence_id );
    my $primary_sequence_id_feature_factory = 
      $feature_factory->primary_sequence_id_feature_factory( $primary_sequence_id );
      
    my $mask_index_iterator =
      $mask_primary_sequence_id_feature_factory->start_sorted_index_iterator();
    my $index_iterator =
      $primary_sequence_id_feature_factory->start_sorted_index_iterator();

    $mask_index_iterator->reset();
    $index_iterator->reset();

    while( $mask_index_iterator->valid() ) {
      my $mask_sequence =
        $mask_feature_factory->index2sequence( $mask_index_iterator->value() );

      # ----- skip whatever is already before -----
      while( $index_iterator->valid() ) {
        my $sequence =
          $feature_factory->index2sequence( $index_iterator->value() );
          
        if( !$sequence->located_before_start( $mask_sequence ) )
          { last; }
        $index_iterator->iterate();
      }

      # ----- iterate over overlapping elements -----
      my @local_features;
      
      my $local_index_iterator = $index_iterator->clone();
      while( $local_index_iterator->valid() ) {
        my $sequence =
          $feature_factory->index2sequence( $local_index_iterator->value() );

        if( $sequence->located_after_end( $mask_sequence ) )
          { last; }
        
        if( $sequence->overlaps( $mask_sequence ) ) {
          if( $skip_equal && $mask_sequence->equals( $sequence ) ) { 
          } elsif( $skip_not_contained && !$mask_sequence->contains( $sequence ) ) {
          } else {
            my $feature =
              $feature_factory->index2feature( $local_index_iterator->value() );
            push @local_features, $feature;
          }
        }

        $local_index_iterator->iterate();
      }

      if( !$only_with_overlaps || scalar( @local_features ) ) {
        my $mask_feature =
          $mask_feature_factory->index2feature( $mask_index_iterator->value() );
          
        $overlapping_features_processor->process_overlapping_features(
          $mask_feature,
          \@local_features
        );
      }
      
      $mask_index_iterator->iterate();
    }
  }
}

##########################################################################

1;
