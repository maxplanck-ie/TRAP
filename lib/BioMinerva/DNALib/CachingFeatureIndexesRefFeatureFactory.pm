##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory;

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

  if( !ref( $clone ) ) {
    $clone = new BioMinerva::CachingFeatureIndexesRefFeatureFactory();
  }
  $self->SUPER::clone( $clone );

  $clone->set_cache( $self->get_cache() );
}

##########################################################################
# PROPERTIES
##########################################################################

sub display_id
{
  my( $self ) = @_;
  
  return
    "cached("
    . $self->SUPER::display_id()
    . ")";
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  return $digest;
}

sub features_digest
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  return ref( $feature_factory )
    ? $feature_factory->features_digest()
    : $self->SUPER::features_digest();
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

sub cached_feature_factory
{
  my( $self ) = @_;
  return $self;
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index_iterator
{
  my( $self ) = @_;

  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return $self->_feature_indexes2feature_index_iterator(
      $feature_indexes
    );
  } else {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
  
    return $feature_factory->feature_index_iterator();
  }
}

sub feature_iterator
{
  my( $self ) = @_;

  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return $self->_feature_indexes2feature_iterator(
      $feature_indexes
    );
  } else {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
  
    return $feature_factory->feature_iterator();
  }
}

sub feature_indexes
{
  my( $self ) = @_;
  
  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return $feature_indexes;
  } else {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
  
    return $feature_factory->feature_indexes();
  }
}

sub features
{
  my( $self ) = @_;
  
  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return $self->_feature_indexes2features(
      $feature_indexes
    );
  } else {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
  
    return $feature_factory->features();
  }
}

sub num_of_features
{
  my( $self ) = @_;

  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return scalar( @{ $feature_indexes } );
  } else {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
  
    return $feature_factory->num_of_features();
  }
}

sub cached_num_of_features
{
  my( $self ) = @_;
  
  my $feature_indexes = $self->_cached_feature_indexes();

  if( defined( $feature_indexes ) ) {
    return scalar( @{ $feature_indexes } );
  } else {
    return $self->SUPER::cached_num_of_features();
  }
}

##########################################################################
# CACHING
##########################################################################

sub _cached_feature_indexes
{
  my( $self ) = @_;
  
  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    return undef;
  }

  my $cache_digest = $cache->cache_digest( 'CachingFeatureIndexesRefFeatureFactory::feature_indexes' );
  $cache_digest->add( $self->features_digest_id() );

  my $feature_indexes;

  my $cached_data;
  if( $cache->peek( $cache_digest, \$cached_data ) ) {
    $feature_indexes = shift( @{ $cached_data } );
  } else {
    $feature_indexes = $self->_processed_feature_indexes();

    $cached_data = [ $feature_indexes ];
    $cache->poke( $cache_digest, $cached_data );
  }

  return $feature_indexes;
}

sub _processed_feature_indexes
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }
  
  return $feature_factory->feature_indexes();
}

##########################################################################

1;
