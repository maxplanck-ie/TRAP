##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StoreFeatureIndexesRefFeatureFactory;

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
    $clone = new BioMinerva::StoreFeatureIndexesRefFeatureFactory();
  }
  $self->SUPER::clone( $clone );

  if( defined( $self->get_feature_indexes() ) ) {
    my @feature_indexes = @{ $self->get_feature_indexes() || [] };
    $clone->set_feature_indexes( \@feature_indexes );
  }

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <array_property id="feature_index" ids="feature_indexes" add_id="add_feature_index">
###---   <auto:comment id="feature_indexes" md5="j5gpbigUpJG/WtAzEaH5iA">

=head2 feature_indexes

 Title   : feature_indexes (array property)
 
 Usage   : C<<< my $feature_indexes = $object->feature_indexes();
           if( defined( $feature_indexes ) ) { 
             foreach my $feature_index( @{ $feature_indexes } ) {
               ...
             }
           } >>>
           
           C<<< $object->feature_indexes( $feature_indexes ); >>>
 
           C<<< $object->feature_indexes( undef ); >>>

 Function: Accessor to the array property C<feature_indexes>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of feature_indexes to be set
           clear-accessor: undef

 Return  : reference to the current array of feature_indexes or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="feature_indexes" md5="Ssx8nWcYtf2f6E/hKka6Gg">

sub feature_indexes {
  my $self = shift @_;
  if( @_ ) {
    my $feature_indexes = shift @_;
    if( defined( $feature_indexes ) && ref( $feature_indexes ) ne 'ARRAY' ) {
      confess( "Property 'feature_indexes' requires an ARRAY argument (now: $feature_indexes)." );
    }
    $self->{ 'feature_indexes' } = $feature_indexes;
  }
  return $self->{ 'feature_indexes' };
}

###---   </auto:code>
###---   <auto:comment id="add_feature_index" md5="cQR4v47cW+VClHZtbdrSJQ">

=head2 add_feature_index

 Title   : add_feature_index (feature_indexes property)
 
 Usage   : C<<< $object->add_feature_index( $feature_index, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< feature_indexes >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_feature_index" md5="9/0Li7olh4vaz3gPgUqpoA">

sub add_feature_index {
  my $self = shift @_;
  my @feature_indexes = @_;
  $self->{ 'feature_indexes' } ||= [];
  push @{ $self->{ 'feature_indexes' } }, @feature_indexes;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_indexes', $self->feature_indexes() );
}

sub display_id
{
  my( $self ) = @_;
  
  return
    "subset("
    . $self->SUPER::display_id()
    . ")";
}

sub feature_comparator
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_comparator();
}

sub features_digest
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  my $features_digest = $feature_factory->features_digest();
  $features_digest->add( $self->feature_indexes() || '' );

  return $features_digest;
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index_iterator
{
  my( $self ) = @_;

  return $self->_feature_indexes2feature_index_iterator(
    $self->feature_indexes() || []
  );
}

sub feature_iterator
{
  my( $self ) = @_;

  return $self->_feature_indexes2feature_iterator(
    $self->feature_indexes() || []
  );
}

sub features
{
  my( $self ) = @_;
  
  return $self->_feature_indexes2features(
    $self->feature_indexes() || []
  );
}

sub num_of_features
{
  my( $self ) = @_;

  my $feature_indexes = $self->feature_indexes();
  
  if( defined( $feature_indexes ) ) {
    return scalar( @{ $feature_indexes } );
  } else {
    return undef;
  }
}

sub cached_num_of_features
{
  my( $self ) = @_;

  return $self->num_of_features();
}

##########################################################################

1;
