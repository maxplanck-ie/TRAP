##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureIndexIterator2FeatureIterator;

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
    $clone = new BioMinerva::DNALib::FeatureIndexIterator2FeatureIterator();
  }

  $self->SUPER::clone( $clone );

  confess( "Not completed yet" );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_index_iterator' get_id='' set_id=''>
###---   <auto:comment id="feature_index_iterator" md5="1xSxdmltfA1SRKJwz6orTg">

=head2 feature_index_iterator

 Title   : feature_index_iterator property
 
 Usage   : $object->feature_index_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_index_iterator" md5="8lYzXP2g4nyePkIMotzmVQ">

sub feature_index_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_index_iterator' } = shift @_;
  }
  return $self->{ 'feature_index_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_index_iterator" md5="GVM0T/cGNqXM4SrC7apLiw">

sub get_feature_index_iterator {
  return shift->{ 'feature_index_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_index_iterator" md5="4/yflHV2wDiZ+64FHLKtww">

sub set_feature_index_iterator {
  my $self = shift @_;
  $self->{ 'feature_index_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='feature_factory' get_id='' set_id=''>
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
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_index_iterator', $self->get_feature_index_iterator() );
  $target->property( 'feature_factory', $self->get_feature_factory() );
}

sub progress_hash
{
  my( $self ) = @_;

  my $size = $self->size();
  my $count = $self->count();
  my $progress = $self->progress();

  my $progress_hash = {};
  
  if( defined( $size ) ) {
    $progress_hash->{ 'features' } = "$count/$size";
  } else {
    $progress_hash->{ 'features' } = "$count";
  }
  
  if( defined( $progress ) ) {
    $progress_hash->{ 'progress' } = sprintf( "%4.1f", $progress * 100.0 ) . "%";
  }

  return $progress_hash;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
  
  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  $feature_index_iterator->reset();
}

sub valid
{
  my( $self ) = @_;
  
  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  return $feature_index_iterator->valid();
}

sub iterate
{
  my( $self ) = @_;
  
  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  $feature_index_iterator->iterate();
}

sub feature
{
  my( $self ) = @_;
  
  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }

  my $feature_index = $feature_index_iterator->feature_index();
  if( !defined( $feature_index ) ) {
    confess( "Internal inconsistency, undef feature_index obtained in $self" );
  }

  return $feature_factory->feature_index2feature( $feature_index );
}

#allowed to return undef, when slow/unable to determine
sub size
{
  my( $self ) = @_;

  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  return $feature_index_iterator->size();
}

sub count
{
  my( $self ) = @_;

  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  return $feature_index_iterator->count();
}

#allowed to return undef, when slow/unable to determine
sub progress
{
  my( $self ) = @_;

  my $feature_index_iterator = $self->get_feature_index_iterator();
  if( !ref( $feature_index_iterator ) ) {
    croak( "Undefined feature_index_iterator in $self" );
  }

  return $feature_index_iterator->progress();
}

##########################################################################

1;
