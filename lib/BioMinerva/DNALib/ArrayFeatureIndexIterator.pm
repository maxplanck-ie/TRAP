##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ArrayFeatureIndexIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIndexIterator;
@ISA = qw( BioMinerva::DNALib::FeatureIndexIterator );

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
    $clone = new BioMinerva::DNALib::ArrayFeatureIndexIterator();
  }

  $self->SUPER::clone( $clone );

  $clone->set_feature_indexes( $self->get_feature_indexes() );
  $clone->set_index( $self->get_index() );
  
  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_indexes' get_id='' set_id=''>
###---   <auto:comment id="feature_indexes" md5="ve0//UmjAjMbi5Fzuq8P0Q">

=head2 feature_indexes

 Title   : feature_indexes property
 
 Usage   : $object->feature_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_indexes" md5="0PBNhxFSBafDyvnlMlcv7g">

sub feature_indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_indexes' } = shift @_;
  }
  return $self->{ 'feature_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_indexes" md5="c8Axwi5pqsE0jzPxDStBMg">

sub get_feature_indexes {
  return shift->{ 'feature_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_indexes" md5="9NC+/J3z7cuTw1P4qSmgng">

sub set_feature_indexes {
  my $self = shift @_;
  $self->{ 'feature_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='index' get_id='' set_id=''>
###---   <auto:comment id="index" md5="aMJMKGFZg4HDWb8/1cfHiA">

=head2 index

 Title   : index property
 
 Usage   : $object->index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index" md5="7BAnGPK4NgFDGMFKVWXqTg">

sub index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index' } = shift @_;
  }
  return $self->{ 'index' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index" md5="7Lq+jJug+kSPckjiQV6D2A">

sub get_index {
  return shift->{ 'index' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index" md5="uBZWh3Xod+gC3juCQuhrzg">

sub set_index {
  my $self = shift @_;
  $self->{ 'index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_indexes', $self->get_feature_indexes() );
  $target->property( 'index', $self->get_index() );
}

sub reset
{
  my( $self ) = @_;
  $self->set_index( 0 );
}

sub valid
{
  my( $self ) = @_;
  return $self->get_index() < scalar( @{ $self->get_feature_indexes() || [] } );
}

sub iterate
{
  my( $self ) = @_;
  $self->set_index( $self->get_index() + 1 );
}

sub feature_index
{
  my( $self ) = @_;
  my $feature_indexes = $self->get_feature_indexes();
  return $feature_indexes->[ $self->get_index() ];
#  my $feature_index = $feature_indexes->[ $self->get_index() ];
#  if( !defined( $feature_index ) ) {
#    confess( "Internal inconsistency, undef feature_index in $self" );
#  }
#  return $feature_index;
}

sub size
{
  my( $self ) = @_;
  my $feature_indexes = $self->get_feature_indexes();
  if( !defined( $feature_indexes ) ) { return undef; }
  return scalar( @{ $feature_indexes } );
}

sub count
{
  my( $self ) = @_;

  return $self->get_index() || 0;
}

sub progress
{
  my( $self ) = @_;

  my $size = $self->size();
  if( !$size ) { return undef; }
  return $self->count() / $size;
}

##########################################################################

1;
