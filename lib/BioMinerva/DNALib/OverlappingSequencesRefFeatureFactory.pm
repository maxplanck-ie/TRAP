##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::OverlappingSequencesRefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefFeatureFactory;
@ISA = qw( BioMinerva::DNALib::RefFeatureFactory );

use BioMinerva::DNALib::SortedRefFeatureFactory;
use BioMinerva::DNALib::OverlappingSequencesFeatureIterator;
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

###--- <scalar_property id="range_feature_comparator" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureComparator">
###---   <auto:comment id="range_feature_comparator" md5="iaiVbTLUB0hS1+V5R119Qg">

=head2 range_feature_comparator

 Title   : range_feature_comparator property
 
 Usage   : $object->range_feature_comparator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="range_feature_comparator" md5="0fHr/A1QElNNiimhEOwabg">

sub range_feature_comparator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'range_feature_comparator' } = shift @_;
  }
  return $self->{ 'range_feature_comparator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_range_feature_comparator" md5="I63RmAIP61az187d40vF1A">

sub get_range_feature_comparator {
  return shift->{ 'range_feature_comparator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_range_feature_comparator" md5="1B7lmRZojIupT/J0RM2g+A">

sub set_range_feature_comparator {
  my $self = shift @_;
  $self->{ 'range_feature_comparator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_range_feature_comparator" md5="QeuWhjciArpAqH1p10zNdw">

sub link_range_feature_comparator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'range_feature_comparator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'range_feature_comparator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureComparator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

#--##--- <scalar_property id='skip_equal' get_id='' set_id=''/>

#--##--- <scalar_property id='skip_not_contained' get_id='' set_id=''/>

#--##--- <scalar_property id='only_with_overlaps' get_id='' set_id=''/>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'mask_feature_factory', $self->get_mask_feature_factory() );
  $target->property( 'range_feature_comparator', $self->get_range_feature_comparator() );
#  $target->property( 'skip_equal', $self->skip_equal() );
#  $target->property( 'skip_not_contained', $self->skip_not_contained() );
#  $target->property( 'only_with_overlaps', $self->only_with_overlaps() );
}

sub operator_display_id
{
  my( $self ) = @_;

  my $range_feature_comparator = $self->get_range_feature_comparator();

  return 'ovl_seq['
    . ( ref( $range_feature_comparator )
      ? $range_feature_comparator->display_id()
      : "<undef range_feature_comparator>"
    )
    . ']';
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  my $mask_feature_factory = $self->get_mask_feature_factory();
  $digest->add( ref( $mask_feature_factory ) ? $mask_feature_factory->digest_id() : '' );

  my $range_feature_comparator = $self->get_range_feature_comparator();
  $digest->add( ref( $range_feature_comparator ) ? $range_feature_comparator->digest_id() : '' );
  
  return $digest;
}

sub features_digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::features_digest();
  
  my $feature_factory = $self->get_feature_factory();
  $digest->add( ref( $feature_factory ) ? $feature_factory->digest_id() : '' );

  my $mask_feature_factory = $self->get_mask_feature_factory();
  $digest->add( ref( $mask_feature_factory ) ? $mask_feature_factory->digest_id() : '' );

  my $range_feature_comparator = $self->get_range_feature_comparator();
  $digest->add( ref( $range_feature_comparator ) ? $range_feature_comparator->digest_id() : '' );
  
  return $digest;
}

sub feature_comparator
{
  my( $self ) = @_;

  return $self->get_range_feature_comparator();
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub feature_iterator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "No feature_factory in $self" );
  }

  my $mask_feature_factory = $self->get_mask_feature_factory();
  if( !ref( $mask_feature_factory ) ) {
    croak( "No mask_feature_factory in $self" );
  }

  my $range_feature_comparator = $self->get_range_feature_comparator();
  if( !ref( $range_feature_comparator ) ) {
    croak( "No range_feature_comparator in $self" );
  }

  my $sorted_feature_factory = new BioMinerva::DNALib::SortedRefFeatureFactory();
  $sorted_feature_factory->set_feature_factory( $feature_factory );
  $sorted_feature_factory->set_feature_comparator( $range_feature_comparator );

  my $sorted_mask_feature_factory = new BioMinerva::DNALib::SortedRefFeatureFactory();
  $sorted_mask_feature_factory->set_feature_factory( $mask_feature_factory );
  $sorted_mask_feature_factory->set_feature_comparator( $range_feature_comparator );

  $sorted_feature_factory = $sorted_feature_factory->cached_feature_factory();
  $sorted_mask_feature_factory = $sorted_mask_feature_factory->cached_feature_factory();

  my $feature_iterator = new BioMinerva::DNALib::OverlappingSequencesFeatureIterator();
  $feature_iterator->set_feature_iterator( $sorted_feature_factory->feature_iterator() );
  $feature_iterator->set_mask_feature_iterator( $sorted_mask_feature_factory->feature_iterator() );
  $feature_iterator->set_range_feature_comparator( $range_feature_comparator );

  return $feature_iterator;
}

sub features
{
  my( $self ) = @_;

  return $self->_feature_iterator2features(
    $self->feature_iterator()
  );
}

sub num_of_features
{
  my( $self ) = @_;
  
  return $self->_feature_iterator2num_of_features(
    $self->feature_iterator()
  );
}

##########################################################################

1;
