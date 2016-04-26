##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ConditionalFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIterator;
@ISA = qw( BioMinerva::DNALib::FeatureIterator );

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
    $clone = new BioMinerva::DNALib::ConditionalFeatureIterator();
  }

  $self->SUPER::clone( $clone );
  
  $clone->set_feature_iterator(
    $self->get_feature_iterator()
  );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_iterator' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureIterator'>
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
###---   <auto:code link_id="link_feature_iterator" md5="Zu5ER5D0wydnjzzdVgsvuw">

sub link_feature_iterator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_iterator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_iterator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureIterator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='feature_condition' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureCondition'>
###---   <auto:comment id="feature_condition" md5="Gnv6WPbXK9bQ/U2pr6vuHQ">

=head2 feature_condition

 Title   : feature_condition property
 
 Usage   : $object->feature_condition(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_condition" md5="JKwCdAa8WuiVk4THLYM/8w">

sub feature_condition {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_condition' } = shift @_;
  }
  return $self->{ 'feature_condition' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_condition" md5="L733R2xh2B0dytAq2jyl2Q">

sub get_feature_condition {
  return shift->{ 'feature_condition' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_condition" md5="y7TOiMY9kT1G2UUxrz1kow">

sub set_feature_condition {
  my $self = shift @_;
  $self->{ 'feature_condition' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_condition" md5="yjP2ixWIBLLAgPFZzCgX+A">

sub link_feature_condition {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_condition' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_condition' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureCondition', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_count' get_id='' set_id=''>
###---   <auto:comment id="_count" md5="8Ek1Y1MCL9LjJzcxlFhdnQ">

=head2 _count

 Title   : _count property
 
 Usage   : $object->_count(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_count" md5="cXLnZFaOJ4MNFukSrAcDLw">

sub _count {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_count' } = shift @_;
  }
  return $self->{ '_count' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_count" md5="qdq6YcR8YmYUv6LInWFi2w">

sub _get_count {
  return shift->{ '_count' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_count" md5="zOM0ORr5SXGcQO4LcokDaw">

sub _set_count {
  my $self = shift @_;
  $self->{ '_count' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_iterator', $self->get_feature_iterator() );
  $target->property( 'feature_condition', $self->get_feature_condition() );
}

sub progress_hash
{
  my( $self ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    croak( "Undefined feature_iterator in $self" )
  }
  
  my $progress_hash = $feature_iterator->progress_hash();
  
  my $count = $self->count();
  $progress_hash->{ 'filtered_features' } = "$count";

  return $progress_hash;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
  
  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    croak( "Undefined feature_iterator in $self" )
  }
  
  $feature_iterator->reset();
  $self->_set_count( 0 );
  $self->_test_iterate();
}

sub valid
{
  my( $self ) = @_;
  return $self->get_feature_iterator()->valid();
}

sub iterate
{
  my( $self ) = @_;
  $self->get_feature_iterator()->iterate();
  $self->_test_iterate();
  $self->_set_count( $self->_get_count() + 1 );
}

sub feature
{
  my( $self ) = @_;
  return $self->get_feature_iterator()->feature();
}

sub size
{
  my( $self ) = @_;

  return undef;
}

sub count
{
  my( $self ) = @_;

  return $self->_get_count() || 0;
}

sub progress
{
  my( $self ) = @_;

  return $self->get_feature_iterator()->progress();
}

##########################################################################

sub _test_iterate
{
  my( $self ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    croak( "Undefined feature_iterator in $self" )
  }
  
  my $feature_condition = $self->get_feature_condition();
  if( !ref( $feature_condition ) ) {
    croak( "Undefined feature_condition in $self" )
  }
  
  while( 1 ) {
    if( !$feature_iterator->valid() ) { 
      last; 
    }
    if( $feature_condition->test( $feature_iterator->feature() ) ) {
      last;
    }
    $feature_iterator->iterate();
  }
}

##########################################################################

1;
