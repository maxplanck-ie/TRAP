##########################################################################
# TODO:
# - indexing object must be reusable between factories
##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Digest::MD5;
use BioMinerva::DNALib::ArrayFeatureIndexIterator;
use BioMinerva::DNALib::FeatureIndexIterator2FeatureIterator;

use BioMinerva::DNALib::FeatureIteratorProgressInfo;
use BioMinerva::Base::InfoViewer;

use BioMinerva::DNALib::ConditionalRefFeatureFactory;
use BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory;
#use BioMinerva::DNALib::StoreFeatureIndexesRefFeatureFactory;

###

use BioMinerva::DNALib::StartSortedIndexIterator;
use BioMinerva::DNALib::SurroundingSequenceIterator;
use BioMinerva::DNALib::IndexSubsetFeatureFactory;
use BioMinerva::DNALib::CachedFilteredFeatureFactory;
use BioMinerva::DNALib::PrimarySequenceIdFeatureIndexCondition;
use BioMinerva::DNALib::TypeEqFeatureIndexCondition;
use BioMinerva::DNALib::ContainedFeatureIndexCondition;
use BioMinerva::DNALib::OverlappingFeatureIndexCondition;
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
    $clone = new BioMinerva::FeatureFactory();
  }

  $self->SUPER::clone( $clone );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='cache' get_id='' set_id='' link_id='' type='BioMinerva::Base::Cache'>
###---   <auto:comment id="cache" md5="3kOEDljBE8sswmQg2RTsnQ">

=head2 cache

 Title   : cache property
 
 Usage   : $object->cache(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cache" md5="LJrSpqSu7SrbkDOYQEz2Cw">

sub cache {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cache' } = shift @_;
  }
  return $self->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cache" md5="sNbj7L09T3yplxvvYxRswA">

sub get_cache {
  return shift->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cache" md5="4imknzaQxLx3YpnQdSAhdQ">

sub set_cache {
  my $self = shift @_;
  $self->{ 'cache' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_cache" md5="x9nExR+XV4n0gEzzuyH1iA">

sub link_cache {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'cache' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'cache' } =
      $registry->type_id2object(
        'BioMinerva::Base::Cache', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_feature_id2index_hash' get_id='' set_id=''>
###---   <auto:comment id="_feature_id2index_hash" md5="li7h6EKzSFUD5YJG3DLNyg">

=head2 _feature_id2index_hash

 Title   : _feature_id2index_hash property
 
 Usage   : $object->_feature_id2index_hash(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_feature_id2index_hash" md5="y/S0dMIR90mqMz1TiKfk2w">

sub _feature_id2index_hash {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_feature_id2index_hash' } = shift @_;
  }
  return $self->{ '_feature_id2index_hash' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_feature_id2index_hash" md5="jOnRATBCetJGj4FhzzXGKQ">

sub _get_feature_id2index_hash {
  return shift->{ '_feature_id2index_hash' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_feature_id2index_hash" md5="gZL2Wt1idwVs/5h3W1yljw">

sub _set_feature_id2index_hash {
  my $self = shift @_;
  $self->{ '_feature_id2index_hash' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'cache', $self->get_cache() );
#  $target->property( 'features_digest_id', $self->features_digest_id() );
}

# Identifies the features and their order, therefore the feature_comparator
# is added here automatically.
sub features_digest
{
  my( $self ) = @_;
  
  my $digest = new Digest::MD5();
  
  $digest->add( ref( $self ) );

  my $feature_comparator = $self->feature_comparator();
  $digest->add( ref( $feature_comparator ) ? $feature_comparator->digest() : '' );
  
  return $digest;
}

sub features_digest_id
{
  my( $self ) = @_;

  return $self->features_digest()->b64digest();
}

sub feature_comparator
{
  my( $self ) = @_;

  return undef;
}

#Should always return a feature_factory; if a cached one can not be provided
#should return self.
sub cached_feature_factory
{
  my( $self ) = @_;

  return $self;
}

# ========================================================================
# ========================================================================
# * XXX * XXX * XXX * XXX * XXX * NEW INTERFACE * XXX * XXX * XXX * XXX *
# ========================================================================
# ========================================================================

##########################################################################
# BASIC ACCESSORS
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;
  confess( "Not overridden in $self" );
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub feature_index_iterator
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub feature_iterator
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub feature_indexes
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub features
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

sub num_of_features
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

# returns undef, if num_of_features can't be accessed fast
sub cached_num_of_features
{
  my( $self ) = @_;
  return undef;
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub conditioned_feature_factory
{
  my( $self, $feature_condition ) = @_;
 
  return $self->_conditioned_feature_factory( $feature_condition );
}

sub categories
{
  my( $self, $feature_categorizer ) = @_;

  return $self->_categories( $feature_categorizer );
}

sub category2count
{
  my( $self, $feature_categorizer ) = @_;

  return $self->_category2count( $feature_categorizer );
}

#Guarantees, that the order of the array elements corresponds to
#the feature_comparator
sub category2feature_factory
{
  my( $self, $feature_categorizer ) = @_;

  return $self->_category2feature_factory( $feature_categorizer );
}

##########################################################################
# CONDITIONS and CATEGORIES
##########################################################################

#TODO: the conditions/categories stuff should get the same structure
#      as the relation between features() and _xxx2features()
#TODO: for future version

=for nothing
sub primary_feature_factory
{
  my( $self ) = @_;
}
=cut

# The advantage of such a call (compared to having it completely separated
# from this class) is, that it may be cached/optimized, when a certain
# database has better ways than iteration to provide the result.
sub _categories
{
  my( $self, $feature_categorizer ) = @_;

  my $category2count = $self->category2count( $feature_categorizer );
  my @categories = keys( %{ $category2count || {} } );

  return \@categories;
}

sub _category2count
{
  my( $self, $feature_categorizer ) = @_;

  my $cached_category2count =
    $self->_cached_category2count( $feature_categorizer );
    
  if( defined( $cached_category2count ) ) {
    return $cached_category2count;
  } else {
    return $self->_processed_category2count( $feature_categorizer );
  }
}

#TODO: this is also a good point to fill a cache, in case iteration would be necessary
#TODO: here is a point where different strategies are possible; implement them
#      as separate _function calls like the conversion utilities below
sub _category2feature_factory
{
  my( $self, $feature_categorizer ) = @_;

  my $categories = $self->categories( $feature_categorizer );

  my $category2feature_factory = {};

  $self->_category2feature_factory_conditioned(
    $category2feature_factory,
    $feature_categorizer,
    $categories
  );

  return $category2feature_factory;

=for nothing
  my $category2feature_indexes = $self->_cached_category2feature_indexes(
    $feature_categorizer 
  );
  if( !defined( $category2feature_indexes ) ) {
    return undef;
  }

  my $category2feature_factory = {};

  my @categories = keys( %{ $category2feature_indexes } );
  foreach my $category( @categories ) {
    my $feature_factory = new BioMinerva::DNALib::StoreFeatureIndexesRefFeatureFactory();
    $feature_factory->set_feature_factory( $feature_factory );
    $feature_factory->set_feature_indexes( $category2feature_indexes->{ $category } );
    $feature_factory->set_cache( $self->get_cache() );
  }

  return $category2feature_factory;
=cut

}

sub _category2feature_factory_conditioned
{
  my( $self, $category2feature_factory, $feature_categorizer, $categories ) = @_;

  foreach my $category( @{ $categories || [] } ) {
    my $feature_condition = $feature_categorizer->feature_condition( $category );
    my $feature_factory = $self->_conditioned_feature_factory( $feature_condition );
    $category2feature_factory->{ $category } = $feature_factory;
  }
}

sub _conditioned_feature_factory
{
  my( $self, $feature_condition ) = @_;
  
  my $feature_factory = new BioMinerva::DNALib::ConditionalRefFeatureFactory();
  $feature_factory->set_feature_factory( $self );
  $feature_factory->set_feature_condition( $feature_condition );

  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    return $feature_factory;
  }
  
  my $cached_feature_factory = new BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory();
  $cached_feature_factory->set_feature_factory( $feature_factory );
  $cached_feature_factory->set_cache( $self->get_cache() );
  
  return $cached_feature_factory;
}

##########################################################################

sub _cached_category2count
{
  my( $self, $feature_categorizer ) = @_;

  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    return undef;
  }

  my $cache_digest = $cache->cache_digest( 'FeatureFactory::category2count' );
  $cache_digest->add( $feature_categorizer->digest_id() );

  my $category2count;

  my $cached_data;
  if( $cache->peek( $cache_digest, \$cached_data ) ) {
    $category2count = shift( @{ $cached_data } );
  } else {
    $category2count = $self->_processed_category2count( $feature_categorizer );

    $cached_data = [ $category2count ];
    $cache->poke( $cache_digest, $cached_data );
  }

  return $category2count;
}

sub _cached_category2feature_indexes
{
  my( $self, $feature_categorizer ) = @_;

  return $self->_category2feature_indexes( $feature_categorizer );
}

##########################################################################
# PROCESSING UTILITIES: categories/counts
##########################################################################

sub _processed_category2count
{
  my( $self, $feature_categorizer ) = @_;
  
  my $feature_iterator = $self->feature_iterator();

  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    "Counting categories of features (" 
    . $self->display_id()
    . "|"
    . $feature_categorizer->display_id() 
    . ")" 
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $category2count = {};

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO: try
  {
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      my $category = $feature_categorizer->category( $feature_iterator->feature() );
      if( defined( $category ) ) {
        ++$category2count->{ $category };
      }
    }
  }
#TODO: catch
  $info_viewer->pop_info();

  return $category2count;
}

sub _category2feature_indexes
{
  my( $self, $feature_categorizer ) = @_;
  
  my $feature_iterator = $self->feature_iterator();

  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    "Categorizing features (" 
    . $self->display_id()
    . "|"
    . $feature_categorizer->display_id() 
    . ")" 
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $category2feature_indexes = {};

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO:  try
  {
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      my $feature = $feature_iterator->feature();
      my $category = $feature_categorizer->category( $feature );
      if( defined( $category ) ) {
        $category2feature_indexes->{ $category } ||= [];
        push @{ $category2feature_indexes->{ $category } }, $feature->get_index();
      }
    }
  }
#TODO: catch:
  $info_viewer->pop_info();

  return $category2feature_indexes;
}

##########################################################################
# PROCESSING UTILITIES: from feature_index_iterator
##########################################################################

sub _feature_index_iterator2feature_indexes
{
  my( $self, $feature_index_iterator ) = @_;

  my $feature_indexes = [];
  for(
    $feature_index_iterator->reset();
    $feature_index_iterator->valid();
    $feature_index_iterator->iterate()
  ) {
    push @{ $feature_indexes }, $feature_index_iterator->feature_index();
  }

  return $feature_indexes;
}

sub _feature_index_iterator2feature_iterator
{
  my( $self, $feature_index_iterator ) = @_;
  
  my $feature_iterator = new BioMinerva::DNALib::FeatureIndexIterator2FeatureIterator();
  $feature_iterator->set_feature_factory( $self );
  $feature_iterator->set_feature_index_iterator( $feature_index_iterator );

  return $feature_iterator;
}

sub _feature_index_iterator2features
{
  my( $self, $feature_index_iterator ) = @_;

  my $features = [];
  for(
    $feature_index_iterator->reset();
    $feature_index_iterator->valid();
    $feature_index_iterator->iterate()
  ) {
    push @{ $features }, $self->feature_index2feature(
      $feature_index_iterator->feature_index()
    );
  }

  return $features;
}

##########################################################################
# PROCESSING UTILITIES: from feature_indexes
##########################################################################

sub _feature_indexes2feature_index_iterator
{
  my( $self, $feature_indexes ) = @_;

  my $feature_index_iterator = new BioMinerva::DNALib::ArrayFeatureIndexIterator();
  $feature_index_iterator->set_feature_factory( $self );
  $feature_index_iterator->set_feature_indexes( $feature_indexes );

  return $feature_index_iterator;
}

sub _feature_indexes2feature_iterator
{
  my( $self, $feature_indexes ) = @_;

  return $self->_feature_index_iterator2feature_iterator(
    $self->_feature_indexes2feature_index_iterator(
      $feature_indexes
    )
  );
}

sub _feature_indexes2features
{
  my( $self, $feature_indexes ) = @_;

  my $features = [];
  foreach my $feature_index( @{ $feature_indexes } ) {
    push @{ $features }, $self->feature_index2feature( $feature_index );
  }

  return $features;
}

##########################################################################
# PROCESSING UTILITIES: from feature_iterator
##########################################################################

sub _feature_iterator2feature_indexes
{
  my( $self, $feature_iterator ) = @_;

  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    "Indexing features ("
    . $self->display_id()
    . ")"
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $feature_indexes = [];

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO: try
  {
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      push @{ $feature_indexes }, $feature_iterator->feature()->get_index();
    }
  }
#TODO: catch
  $info_viewer->pop_info();

  return $feature_indexes;
}

sub _feature_iterator2feature_index_iterator
{
  my( $self, $feature_iterator ) = @_;
  
  my $feature_index_iterator = 
    new BioMinerva::DNALib::FeatureIterator2FeatureIndexIterator();
  $feature_index_iterator->set_feature_iterator( $feature_iterator );

  return $feature_index_iterator;
}

sub _feature_iterator2features
{
  my( $self, $feature_iterator ) = @_;

  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    "Creating features ("
    . $self->display_id()
    . ")"
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $features = [];

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO:  try
  {
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      push @{ $features }, $feature_iterator->feature();
    }
  }
#TODO: catch:
  $info_viewer->pop_info();

  return $features;
}

sub _feature_iterator2num_of_features
{
  my( $self, $feature_iterator ) = @_;

  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    "Counting num_of_features ("
    . $self->display_id()
    . ")"
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $num_of_features = 0;

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
 
#TODO: try
  {
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      ++$num_of_features;
    }
  }
#TODO: catch
  $info_viewer->pop_info();

  return $num_of_features;
}

##########################################################################
# PROCESSING UTILITIES: from features
##########################################################################

sub _features2num_of_features
{
  my( $self, $features ) = @_;

  if( !ref( $features ) ) {
    return undef;
  }

  return scalar( @{ $features || [] } );
}

# ========================================================================
# ========================================================================
# * XXX * XXX * XXX * XXX * XXX * OLD INTERFACE * XXX * XXX * XXX * XXX *
# ========================================================================
# ========================================================================

##########################################################################
# INDEX ITERATOR
##########################################################################

sub index_iterator
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

sub start_sorted_index_iterator
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my $primary_sequence_ids = $self->primary_sequence_ids();
  if( scalar( @{ $primary_sequence_ids || [] } ) > 1 ) {
    confess( "Sorting based on start position makes sense only, "
      . "if all features have the same primary_sequence_id (currently: "
      . join( ",", @{ $primary_sequence_ids || [] } )
      . ") in $self" );
  }
  
  my $iterator = new BioMinerva::DNALib::StartSortedIndexIterator();
  $iterator->set_feature_factory( $self );
  $iterator->set_index_iterator( $self->index_iterator() );

  return $iterator;
}

sub sorted_index_iterator
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my $iterator = new BioMinerva::DNALib::SortedIndexIterator();
  $iterator->set_feature_factory( $self );
  $iterator->set_index_iterator( $self->index_iterator() );

  return $iterator;
}

##########################################################################
# SURROUNDING SEQUENCE ITERATOR
##########################################################################

=for nothing
sub surrounding_sequence_iterator
{
  my( $self ) = @_;

  my $iterator = new BioMinerva::DNALib::SurroundingSequenceIterator();
  $iterator->set_feature_factory( $self );
  $iterator->set_start_sorted_index_iterator(
    $self->start_sorted_index_iterator()
  );

  return $iterator;
}
=cut

##########################################################################
# GENERAL
##########################################################################

=for nothing
sub num_of_features
{
  my( $self ) = @_;
  return $self->index_iterator()->size();
}
=cut

sub get_start_pack_format
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  return 'L';
}

sub get_index_pack_format
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  return 'L';
}

##########################################################################
# PRIMARY_SEQUENCE_IDS
##########################################################################

sub primary_sequence_ids
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my %primary_sequence_ids2flag;
  
  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    $primary_sequence_ids2flag{   
      $self->index2primary_sequence_id(
        $index_iterator->value()
      ) 
    } = 1;
  }

  my @primary_sequence_ids = keys %primary_sequence_ids2flag;
  return \@primary_sequence_ids;
}

##########################################################################
# DERIVED FACTORIES
##########################################################################

sub index_subset_feature_factory
{
  my( $self, $index_iterator ) = @_;

  carp( "Obsoleted call" );

  my $feature_factory = 
    new BioMinerva::DNALib::IndexSubsetFeatureFactory();
  $feature_factory->set_feature_factory( $self );
  $feature_factory->set_index_iterator( $index_iterator );
  return $feature_factory;
}

sub filtered_feature_factory
{
  my( $self, $feature_index_condition ) = @_;

  carp( "Obsoleted call" );

  my $feature_factory = 
    new BioMinerva::DNALib::CachedFilteredFeatureFactory();
  $feature_factory->set_feature_factory( $self );
  $feature_factory->set_feature_index_condition( $feature_index_condition );
  return $feature_factory;
}

##########################################################################

sub primary_sequence_id_feature_factory
{
  my( $self, $primary_sequence_id ) = @_;

  carp( "Obsoleted call" );

  my $feature_index_condition = 
    new BioMinerva::DNALib::PrimarySequenceIdFeatureIndexCondition();
  $feature_index_condition->set_feature_factory( $self );
  $feature_index_condition->set_primary_sequence_id( $primary_sequence_id );
  return 
    $self->filtered_feature_factory( $feature_index_condition );
}

sub contained_feature_factory
{
  my( $self, $sequence ) = @_;
  
  carp( "Obsoleted call" );

  my $feature_index_condition = 
    new BioMinerva::DNALib::ContainedFeatureIndexCondition();
  $feature_index_condition->set_feature_factory( $self );
  $feature_index_condition->set_sequence( $sequence );
  return 
    $self->filtered_feature_factory( $feature_index_condition );
}

sub overlapping_feature_factory
{
  my( $self, $sequence ) = @_;

  carp( "Obsoleted call" );
  
  my $feature_index_condition = 
    new BioMinerva::DNALib::OverlappingFeatureIndexCondition();
  $feature_index_condition->set_feature_factory( $self );
  $feature_index_condition->set_sequence( $sequence );
  return 
    $self->filtered_feature_factory( $feature_index_condition );
}

sub type_eq_feature_factory
{
  my( $self, $type ) = @_;

  carp( "Obsoleted call" );
  
  my $feature_index_condition = 
    new BioMinerva::DNALib::TypeEqFeatureIndexCondition();
  $feature_index_condition->set_feature_factory( $self );
  $feature_index_condition->set_type( $type );
  return 
    $self->filtered_feature_factory( $feature_index_condition );
}

sub score_in_range_feature_factory
{
  my( $self, $min_score, $max_score ) = @_;

  carp( "Obsoleted call" );
  
  my $feature_index_condition = 
    new BioMinerva::DNALib::ScoreInRangeFeatureIndexCondition();
  $feature_index_condition->set_feature_factory( $self );
  $feature_index_condition->set_min_score( $min_score );
  $feature_index_condition->set_max_score( $max_score );
  return 
    $self->filtered_feature_factory( $feature_index_condition );
}

sub toplevel_feature_factory
{
  my( $self ) = @_;
  confess( "Not implemented yet in $self" );
}

sub surrounding_regions_feature_factory
{
  my( $self, $sequence ) = @_;
  confess( "Not implemented yet in $self" );
}

##########################################################################
# INDEX2FEATURE PROPERTIES ACCESSORS
##########################################################################

sub index2primary_sequence_id
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2type
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2start
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2sequence
{
  my( $self, $index, $sequence ) = @_;
  confess( "Not overridden in $self" );
}

sub index2feature
{
  my( $self, $index, $feature ) = @_;
  confess( "Not overridden in $self" );
}

sub index2flat_feature
{
  my( $self, $index, $feature ) = @_;
  confess( "Not overridden in $self" );
}

sub index2feature_id
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2parent_feature_ids
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2attr
{
  my( $self, $index, $attr_key ) = @_;
  confess( "Not overridden in $self" );
}

##########################################################################

sub feature_id2index
{
  my( $self, $feature_id ) = @_;

  carp( "Obsoleted call" );

  if( !defined( $feature_id ) ) {
    confess( "Must be called with a defined feature_id in $self" );
  }
  
  my $feature_id2index_hash = $self->_build_feature_id2index_hash();
  return $feature_id2index_hash->{ $feature_id };
}

sub feature_id2feature
{
  my( $self, $feature_id ) = @_;

  carp( "Obsoleted call" );

  my $index = $self->feature_id2index( $feature_id );
  if( !defined( $index ) ) { return undef; }
  return $self->index2feature( $index );
}

sub _build_feature_id2index_hash
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my $feature_id2index_hash = $self->_get_feature_id2index_hash();
  if( defined( $feature_id2index_hash ) ) {
    return $feature_id2index_hash;
  }

  $feature_id2index_hash = {};
  
  my $counter = 0;
  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $feature_id = $self->index2feature_id( $index );
    if( defined( $feature_id ) ) {
      if( exists( $feature_id2index_hash->{ $feature_id } ) ) {
        croak( "Multiple features with feature_id='$feature_id' detected in $self" );
      }
      $feature_id2index_hash->{ $feature_id } = $index;
    }
    ++$counter;
    if( !( $counter % 10000 ) ) {
      print STDERR "\r#Building feature_id2index_hash: $counter feature(s) done...     ";
    }
  }

  print STDERR "\r#Building feature_id2index_hash: $counter feature(s) processed"
    . ( " " x 20 ) . "\n";
    
  $self->_set_feature_id2index_hash( $feature_id2index_hash );

  return $feature_id2index_hash;
}

##########################################################################
# ALL FEATURES ARRAY BUILDERS
##########################################################################

sub indexes
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my @indexes;

  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    push @indexes, $index_iterator->value();
  }

  return \@indexes;
}

sub feature_ids
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my @feature_ids;

  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $feature_id = $self->index2feature_id( $index );
    push @feature_ids, $feature_id;
  }

  return \@feature_ids;
}

sub sequences
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my @sequences;

  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $sequence = $self->index2sequence( $index );
    push @sequences, $sequence;
  }

  return \@sequences;
}

sub flat_features
{
  my( $self ) = @_;

  carp( "Obsoleted call" );

  my @flat_features;

  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $flat_feature = $self->index2flat_feature( $index );
    push @flat_features, $flat_feature;
  }

  return \@flat_features;
}

=for nothing
sub features
{
  my( $self ) = @_;

  my @features;

  my $index_iterator = $self->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $feature = $self->index2feature( $index );
    push @features, $feature;
  }

  return \@features;
}
=cut

##########################################################################

1;

