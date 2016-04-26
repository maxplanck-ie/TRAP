##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::CopyRefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefFeatureFactory;
@ISA = qw( BioMinerva::DNALib::RefFeatureFactory );

use Carp qw( confess carp croak );

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
  confess( "Not overridden in $self" );
}

##########################################################################
# PROPERTIES
##########################################################################

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
#  $target->property( 'feature_comparator', $self->feature_comparator() );
}

sub operator_display_id
{
  my( $self ) = @_;

  return 'copy';
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();

  my $feature_factory = $self->get_feature_factory();
  $digest->add( 
    ref( $feature_factory ) 
      ? $feature_factory->digest_id()
      : ''
  );

  return $digest;
}

sub features_digest
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }
 
  return $feature_factory->features_digest();
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_index2feature( $feature_index );
}

sub feature_index_iterator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_index_iterator();
}

sub feature_iterator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_iterator();
}

sub feature_indexes
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_indexes();
}

sub features
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->features();
}

sub num_of_features
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->num_of_features();
}

##########################################################################

1;
