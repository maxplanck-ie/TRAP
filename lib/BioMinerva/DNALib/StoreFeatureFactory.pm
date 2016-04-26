##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StoreFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureFactory;
@ISA = qw( BioMinerva::DNALib::FeatureFactory );

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
    $clone = new BioMinerva::StoreFeatureFactory();
  }
  $self->SUPER::clone( $clone );

  croak( "Not implemented yet" );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <array_property id='feature' ids='features' add_id='add_feature' type='BioMinerva::DNALib::Feature'>
###---   <auto:comment id="features" md5="6MUDqzUkcdyQJQEQwfGDKA">

=head2 features

 Title   : features (array property)
 
 Usage   : C<<< my $features = $object->features();
           if( defined( $features ) ) { 
             foreach my $feature( @{ $features } ) {
               ...
             }
           } >>>
           
           C<<< $object->features( $features ); >>>
 
           C<<< $object->features( undef ); >>>

 Function: Accessor to the array property C<features>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of features to be set
           clear-accessor: undef

 Return  : reference to the current array of features or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="features" md5="DreI22fb9leNOq6EPYxmnw">

sub features {
  my $self = shift @_;
  if( @_ ) {
    my $features = shift @_;
    if( defined( $features ) && ref( $features ) ne 'ARRAY' ) {
      confess( "Property 'features' requires an ARRAY argument (now: $features)." );
    }
    $self->{ 'features' } = $features;
  }
  return $self->{ 'features' };
}

###---   </auto:code>
###---   <auto:comment id="add_feature" md5="htMXQrTvDNhz7OksVC699Q">

=head2 add_feature

 Title   : add_feature (features property)
 
 Usage   : C<<< $object->add_feature( $feature, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< features >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_feature" md5="1UwtrnUpa3ALpohmmmZIpA">

sub add_feature {
  my $self = shift @_;
  my @features = @_;
  $self->{ 'features' } ||= [];
  push @{ $self->{ 'features' } }, @features;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub features_digest
{
  my( $self ) = @_;
  
  croak( "Not implemented yet" );
}

##########################################################################
# NEW STUFF
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;

  my $features = $self->features();
  if( !ref( $features ) ) {
    croak( "No features in $self" );
  }

  my $feature = $features->[ $feature_index ];
  if( !ref( $feature ) ) {
    return undef;
  }

  $feature = $feature->feature();
  $feature->set_index( $feature_index );
  return $feature;
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

  my $num_of_features = $self->num_of_features();
  my @feature_indexes = ( 0 .. ( $num_of_features - 1 ) );
  return \@feature_indexes;
}

sub num_of_features
{
  my( $self ) = @_;

  return $self->_features2num_of_features( $self->features() );
}

# returns undef, if num_of_features can't be accessed fast
sub cached_num_of_features
{
  my( $self ) = @_;

  return $self->_features2num_of_features( $self->features() );
}

##########################################################################
# OLD COMPATIBILITY
##########################################################################

sub index_iterator
{
  my( $self ) = @_;

  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $self->feature_indexes() );
  return $iterator;
}

sub index2primary_sequence_id
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index )->get_primary_sequence_id();
}

sub index2type
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index )->get_type();
}

sub index2start
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index )->get_start();
}

sub index2sequence
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index );
}

sub index2feature
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index );
}

sub index2flat_feature
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index );
}

sub index2feature_id
{
  my( $self, $index ) = @_;
  return 
    $self->feature_index2feature( $index )->get_id();
}

sub index2parent_feature_ids
{
  my( $self, $index ) = @_;
  confess( "Not overridden in $self" );
}

sub index2attr
{
  my( $self, $index, $attr_key ) = @_;
  return 
    $self->feature_index2feature( $index )->attr( $attr_key );
}

##########################################################################

1;

