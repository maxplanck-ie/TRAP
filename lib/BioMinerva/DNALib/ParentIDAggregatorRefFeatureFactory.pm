##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ParentIDAggregatorRefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefFeatureFactory;
@ISA = qw( BioMinerva::DNALib::RefFeatureFactory );

use Carp qw( confess carp croak );
use BioMinerva::Base::ProgressInfo;

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

###--- <scalar_property id='_var_feature_index2part_feature_indexes' get_id='' set_id=''>
###---   <auto:comment id="_var_feature_index2part_feature_indexes" md5="lq+dpDxqYNo/DaUknfP0gA">

=head2 _var_feature_index2part_feature_indexes

 Title   : _var_feature_index2part_feature_indexes property
 
 Usage   : $object->_var_feature_index2part_feature_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_var_feature_index2part_feature_indexes" md5="P9XzJbBmDNtsRKEh1cmf5A">

sub _var_feature_index2part_feature_indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_var_feature_index2part_feature_indexes' } = shift @_;
  }
  return $self->{ '_var_feature_index2part_feature_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_var_feature_index2part_feature_indexes" md5="RTSnTYJHUsAsAwVmqm0NZw">

sub _get_var_feature_index2part_feature_indexes {
  return shift->{ '_var_feature_index2part_feature_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_var_feature_index2part_feature_indexes" md5="cg3fXHPScM0SUMacFtpzyA">

sub _set_var_feature_index2part_feature_indexes {
  my $self = shift @_;
  $self->{ '_var_feature_index2part_feature_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_var_toplevel_feature_indexes' get_id='' set_id=''>
###---   <auto:comment id="_var_toplevel_feature_indexes" md5="nDEHl4eJeayGzmUJsPswRA">

=head2 _var_toplevel_feature_indexes

 Title   : _var_toplevel_feature_indexes property
 
 Usage   : $object->_var_toplevel_feature_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_var_toplevel_feature_indexes" md5="C1QYSrmFy3aGIPi7bIxofg">

sub _var_toplevel_feature_indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_var_toplevel_feature_indexes' } = shift @_;
  }
  return $self->{ '_var_toplevel_feature_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_var_toplevel_feature_indexes" md5="Icegde6jHD4rEWilCmkq3g">

sub _get_var_toplevel_feature_indexes {
  return shift->{ '_var_toplevel_feature_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_var_toplevel_feature_indexes" md5="CySxn0iE+VGBFmtKMHieHw">

sub _set_var_toplevel_feature_indexes {
  my $self = shift @_;
  $self->{ '_var_toplevel_feature_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub operator_display_id
{
  my( $self ) = @_;

  return 'parent-child-aggregator';
}

sub features_digest
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  my $digest = $feature_factory->features_digest();
  $digest->add( 'ParentIDAggregator' );
  
  return $digest;
}

# always keeps the original order
sub feature_comparator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_comparator();
}

sub cached_feature_factory
{
  my( $self ) = @_;

  my $cache = $self->get_cache();
  if( ref( $cache ) ) {
    return $self;

  }

  my $ref_feature_factory = $self->get_feature_factory();
  if( ref( $ref_feature_factory ) ) {
    $cache = $ref_feature_factory->get_cache();
    if( ref( $cache ) ) {
      $self->set_cache( $cache );
    }
    return $self;
  }

  return $self;
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;

  my $feature_index2part_feature_indexes =
    $self->_cached_feature_index2part_feature_indexes();

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $self->_build_feature( 
    $feature_factory,
    $feature_index2part_feature_indexes,
    {}, 
    $feature_index 
  );
}

sub feature_index_iterator
{
  my( $self ) = @_;
  
  return $self->_feature_indexes2feature_index_iterator(
    $self->feature_indexes()
  );
}

sub feature_iterator
{
  my( $self ) = @_;

  return $self->_feature_indexes2feature_iterator(
    $self->feature_indexes()
  );
}

sub feature_indexes
{
  my( $self ) = @_;

  return $self->_cached_toplevel_feature_indexes();
}

sub features
{
  my( $self ) = @_;

  return $self->_feature_indexes2features(
    $self->feature_indexes()
  );
}

sub num_of_features
{
  my( $self ) = @_;
  
  return $self->_feature_indexes2num_of_features(
    $self->feature_indexes()
  );
}

##########################################################################

sub _build_feature
{
  my( $self, $feature_factory, $feature_index2part_feature_indexes,
    $local_feature_index2feature, $feature_index ) = @_;

  my $feature;
  if( !exists( $local_feature_index2feature->{ $feature_index } ) ) {
    $feature = $feature_factory->feature_index2feature( $feature_index );
    $local_feature_index2feature->{ $feature_index } = $feature;
  } else {
    $feature = $local_feature_index2feature->{ $feature_index };
  }

  if( exists( $feature_index2part_feature_indexes->{ $feature_index } ) ) {
    my $part_feature_indexes = $feature_index2part_feature_indexes->{ $feature_index };
    foreach my $part_feature_index( @{ $part_feature_indexes || [] } ) {
      $feature->add_part_feature(
        $self->_build_feature( 
          $feature_factory,
          $feature_index2part_feature_indexes,
          $local_feature_index2feature,
          $part_feature_index 
        )
      );
    }
  }

  return $feature;
}

sub _cached_feature_index2part_feature_indexes
{
  my( $self ) = @_;

  my $feature_index2part_feature_indexes = $self->_get_var_feature_index2part_feature_indexes();
  if( !defined( $feature_index2part_feature_indexes ) ) {
    $self->_retrieve_vars();
    $feature_index2part_feature_indexes = $self->_get_var_feature_index2part_feature_indexes();
  }
  return $feature_index2part_feature_indexes;
}

sub _cached_toplevel_feature_indexes
{
  my( $self ) = @_;

  my $toplevel_feature_indexes = $self->_get_var_toplevel_feature_indexes();
  if( !defined( $toplevel_feature_indexes ) ) {
    $self->_retrieve_vars();
    $toplevel_feature_indexes = $self->_get_var_toplevel_feature_indexes();
  }
  return $toplevel_feature_indexes;
}

##########################################################################

sub _retrieve_vars
{
  my( $self ) = @_;
  
  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    $self->_build_vars();
    return;
  }

  my $cache_digest = $cache->cache_digest( 'ParentIDAggregator' );
  $cache_digest->add( $self->features_digest_id() );

  my $cached_data;
  if( $cache->peek( $cache_digest, \$cached_data ) ) {
    $self->_set_var_toplevel_feature_indexes( shift( @{ $cached_data } ) );
    $self->_set_var_feature_index2part_feature_indexes( shift( @{ $cached_data } ) );
  } else {
    $self->_build_vars();

    $cached_data = [
      $self->_get_var_toplevel_feature_indexes(),
      $self->_get_var_feature_index2part_feature_indexes()
    ];

    $cache->poke( $cache_digest, $cached_data );
  }
}

sub _build_vars
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  my $feature_id2feature_index = {};
  my $toplevel_feature_indexes = [];
  my $feature_index2parent_feature_ids = {};

  {
    my $feature_iterator = $feature_factory->feature_iterator();

    my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
    $progress_info->set_title(
      'Parent/ID scan (' 
      . $self->display_id()
      . ')'
    );
    $progress_info->set_feature_iterator( $feature_iterator );

    my $info_viewer = BioMinerva::Base::InfoViewer::global();
    $info_viewer->push_info( $progress_info );

#TODO: try
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      my $feature = $feature_iterator->feature();
      my $feature_id = $feature->get_id();
      my $feature_index = $feature->get_index();
      my $parent_feature_ids = $feature->attr( 'Parent' );

      if( defined( $feature_id ) ) {
        if( exists( $feature_id2feature_index->{ $feature_id } ) ) {
          $feature_id2feature_index->{ $feature_id } = undef;
        } else {
          $feature_id2feature_index->{ $feature_id } = $feature_index;
        }
      }
      
      if( scalar( @{ $parent_feature_ids || [] } ) ) {
        $feature_index2parent_feature_ids->{ $feature_index } = $parent_feature_ids;
      } else {
        push @{ $toplevel_feature_indexes }, $feature_index;
      }
    }
#TODO: catch
    $info_viewer->pop_info();
  }
  
  my $feature_index2part_feature_indexes = {};
  
  {
    my $progress_info = new BioMinerva::Base::ProgressInfo();
    $progress_info->set_title( 
      'Parent/ID build (' 
      . $self->display_id()
      . ')'
    );

    my $info_viewer = BioMinerva::Base::InfoViewer::global();
    $info_viewer->push_info( $progress_info );

#TODO: try
    foreach my $feature_index( keys( %{ $feature_index2parent_feature_ids } ) ) {
      my $parent_feature_ids = $feature_index2parent_feature_ids->{ $feature_index };
      foreach my $parent_feature_id( @{ $parent_feature_ids } ) {
        if( !exists( $feature_id2feature_index->{ $parent_feature_id } ) ) {
          croak( "Inconsistent ref factory: can not find parent with ID='$parent_feature_id' in $self" );
        }
        my $parent_feature_index = $feature_id2feature_index->{ $parent_feature_id };
        if( !defined( $parent_feature_index ) ) {
          croak( "Inconsistent ref factory: ID='$parent_feature_id' refers to multiple features in $self" );
        }
        $feature_index2part_feature_indexes->{ $parent_feature_index } ||= [];
        push @{ $feature_index2part_feature_indexes->{ $parent_feature_index } }, $feature_index;
      }
    }
#TODO: catch
    $info_viewer->pop_info();
  }

  $self->_set_var_toplevel_feature_indexes(
    $toplevel_feature_indexes
  );
  $self->_set_var_feature_index2part_feature_indexes(
    $feature_index2part_feature_indexes
  );
}

##########################################################################

1;
