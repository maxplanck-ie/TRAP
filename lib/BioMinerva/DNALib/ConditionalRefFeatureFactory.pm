##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ConditionalRefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefFeatureFactory;
@ISA = qw( BioMinerva::DNALib::RefFeatureFactory );

use Carp qw( confess carp croak );
use BioMinerva::DNALib::ConditionalFeatureIterator;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone {
  my( $self, $clone ) = @_;

  if( !ref( $clone ) ) {
    $clone = new BioMinerva::ConditionalRefFeatureFactory();
  }
  $self->SUPER::clone( $clone );

  $clone->set_feature_condition( $self->get_feature_condition() );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_condition', $self->get_feature_condition() );
}

sub operator_display_id
{
  my( $self ) = @_;

  my $feature_condition = $self->feature_condition();

  return 'cond['
    . ( ref( $feature_condition )
      ? $feature_condition->display_id()
      : "<undef feature_condition>"
    )
    . ']';
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  my $feature_condition = $self->get_feature_condition();
  $digest->add( ref( $feature_condition ) ? $feature_condition->digest_id() : '' );
  
  return $digest;
}

# the output depends on the input factory and condition; order is not changed
sub features_digest
{
  my( $self ) = @_;

  my $feature_condition = $self->get_feature_condition();
  my $feature_factory = $self->get_feature_factory();
  
  my $digest = ref( $feature_factory )
    ? $feature_factory->features_digest()
    : $self->SUPER::features_digest();
  $digest->add( ref( $feature_condition ) ? $feature_condition->digest_id() : '' );

  return $digest;
}

# always keeps the original order
sub feature_comparator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  return ref( $feature_factory )
    ? $feature_factory->feature_comparator()
    : $self->SUPER::feature_comparator();
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index_iterator
{
  my( $self ) = @_;
  
  return $self->_feature_iterator2feature_index_iterator(
    $self->feature_iterator()
  );
}

sub feature_iterator
{
  my( $self ) = @_;

  my $feature_condition = $self->get_feature_condition();
  if( !ref( $feature_condition ) ) {
    croak( "Undefined feature_condition in $self" )
  }

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  my $feature_iterator = new BioMinerva::DNALib::ConditionalFeatureIterator();
  $feature_iterator->set_feature_factory( $self );
  $feature_iterator->set_feature_iterator( $feature_factory->feature_iterator() );
  $feature_iterator->set_feature_condition( $feature_condition );

  return $feature_iterator;
}

sub feature_indexes
{
  my( $self ) = @_;

  return $self->_feature_iterator2feature_indexes(
    $self->feature_iterator()
  );
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
  
  return $self->feature_iterator()->size();
}

##########################################################################

1;
