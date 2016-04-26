##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::OverlappingSequencesFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::TryIterateFeatureIterator;
@ISA = qw( BioMinerva::DNALib::TryIterateFeatureIterator );

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
    $clone = new BioMinerva::DNALib::OverlappingSequencesFeatureIterator();
  }

  $self->SUPER::clone( $clone );

  $clone->set_feature_iterator( $self->get_feature_iterator()->clone() );
  $clone->set_mask_feature_iterator( $self->get_mask_feature_iterator()->clone() );
  $clone->set_range_feature_comparator( $self->get_range_feature_comparator() );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_iterator' get_id='' set_id=''>
###---   <auto:comment id="feature_iterator" md5="s1l2kfG0cJcoF8Occz+big">

=head2 feature_iterator

 Title   : feature_iterator property
 
 Usage   : $object->feature_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_iterator" md5="VePVqqYpUaDG7ssbpCnRVQ">

sub feature_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_iterator' } = shift @_;
  }
  return $self->{ 'feature_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_iterator" md5="50r/sbpD6+Uo2q0hHiCbPQ">

sub get_feature_iterator {
  return shift->{ 'feature_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_iterator" md5="J2fkrnbD1aMko3u3RKmYDA">

sub set_feature_iterator {
  my $self = shift @_;
  $self->{ 'feature_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='mask_feature_iterator' get_id='' set_id=''>
###---   <auto:comment id="mask_feature_iterator" md5="l+aV5tVUIAyDgXNAAeuXqg">

=head2 mask_feature_iterator

 Title   : mask_feature_iterator property
 
 Usage   : $object->mask_feature_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="mask_feature_iterator" md5="m1d3iJsZ3on5NBrKbRT6Yw">

sub mask_feature_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'mask_feature_iterator' } = shift @_;
  }
  return $self->{ 'mask_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_mask_feature_iterator" md5="AahzuV8GPVNTCdmZKO4phg">

sub get_mask_feature_iterator {
  return shift->{ 'mask_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_mask_feature_iterator" md5="4DvQ1ZLr7NNoqwWJtxAngg">

sub set_mask_feature_iterator {
  my $self = shift @_;
  $self->{ 'mask_feature_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='range_feature_comparator' get_id='' set_id=''>
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
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;

  my $mask_feature_iterator = $self->get_mask_feature_iterator();
  if( !ref( $mask_feature_iterator ) ) {
    croak( "Undefined mask_feature_iterator in $self" );
  }

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    croak( "Undefined feature_iterator in $self" );
  }

  my $range_feature_comparator = $self->get_range_feature_comparator();
  if( !ref( $range_feature_comparator ) ) {
    croak( "Undefined range_feature_comparator in $self" );
  }

  $mask_feature_iterator->reset();
  $feature_iterator->reset();

  $self->SUPER::reset();
}

sub feature
{
  my( $self ) = @_;

  return $self->get_feature_iterator()->feature();
}

##########################################################################

sub _try_iterate
{
  my( $self, $reset ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  my $mask_feature_iterator = $self->get_mask_feature_iterator();
  my $range_feature_comparator = $self->get_range_feature_comparator();

  if( !$reset && $feature_iterator->valid() ) {
    $feature_iterator->iterate();
  }

  while( $feature_iterator->valid() ) {
    my $feature = $feature_iterator->feature();

    for( ; $mask_feature_iterator->valid(); $mask_feature_iterator->iterate() ) {
      if( !$range_feature_comparator->is_located_before( 
        $mask_feature_iterator->feature(), $feature 
      ) ) {
        last;
      }
    }

    if( !$mask_feature_iterator->valid() ) {
      return 0;
    }

    if( $range_feature_comparator->overlaps( 
      $mask_feature_iterator->feature(), $feature 
    ) ) {
      return 1;
    }

    $feature_iterator->iterate();
  }

  return 0;
}

##########################################################################

1;

