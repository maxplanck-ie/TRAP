##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EnsEmblFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureFactory;
@ISA = qw( BioMinerva::DNALib::FeatureFactory );

use BioMinerva::Base::ArrayIterator;
use BioMinerva::DNALib::Feature;
use Bio::EnsEMBL::Registry;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='database_name' get_id='' set_id=''>
###---   <auto:comment id="database_name" md5="MMGubwYmgLW7DNQgBAavxg">

=head2 database_name

 Title   : database_name property
 
 Usage   : $object->database_name(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="database_name" md5="wLCrFUWpO530nigDIsHExQ">

sub database_name {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'database_name' } = shift @_;
  }
  return $self->{ 'database_name' };
}

###---   </auto:code>
###---   <auto:code get_id="get_database_name" md5="L7SHBrWbdV2N/IiMYnOs2A">

sub get_database_name {
  return shift->{ 'database_name' };
}

###---   </auto:code>
###---   <auto:code set_id="set_database_name" md5="pBrYaS1XGe+Ypi6DTZ/QUw">

sub set_database_name {
  my $self = shift @_;
  $self->{ 'database_name' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='top_level_sequence_type' get_id='' set_id=''>
###---   <auto:comment id="top_level_sequence_type" md5="CTE1A/3rLb5rULf+hKvx3A">

=head2 top_level_sequence_type

 Title   : top_level_sequence_type property
 
 Usage   : $object->top_level_sequence_type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="top_level_sequence_type" md5="h5fUwsvnzTxqRvBiF+BUmg">

sub top_level_sequence_type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'top_level_sequence_type' } = shift @_;
  }
  return $self->{ 'top_level_sequence_type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_top_level_sequence_type" md5="9zAO2LAS2gTp7X0y75a1Fw">

sub get_top_level_sequence_type {
  return shift->{ 'top_level_sequence_type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_top_level_sequence_type" md5="M0KYR9DGqFW7hoNgoytEqA">

sub set_top_level_sequence_type {
  my $self = shift @_;
  $self->{ 'top_level_sequence_type' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='source_attr' get_id='' set_id=''>
###---   <auto:comment id="source_attr" md5="WR32UQF6JTN8pFudc3oLFQ">

=head2 source_attr

 Title   : source_attr property
 
 Usage   : $object->source_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="source_attr" md5="p83O06i1IyD+ZA/mhAKNBg">

sub source_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'source_attr' } = shift @_;
  }
  return $self->{ 'source_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_source_attr" md5="UxUF5ORAvRbU1Ihvu9VoXQ">

sub get_source_attr {
  return shift->{ 'source_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_source_attr" md5="W9d3pMD35K95CjdgWgLldg">

sub set_source_attr {
  my $self = shift @_;
  $self->{ 'source_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id='_feature' ids='_features' add_id='_add_feature'>
###---   <auto:comment id="_features" md5="1LospBWXNFdnFrrJ756PpQ">

=head2 _features

 Title   : _features (array property)
 
 Usage   : C<<< my $_features = $object->_features();
           if( defined( $_features ) ) { 
             foreach my $_feature( @{ $_features } ) {
               ...
             }
           } >>>
           
           C<<< $object->_features( $_features ); >>>
 
           C<<< $object->_features( undef ); >>>

 Function: Accessor to the array property C<_features>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of _features to be set
           clear-accessor: undef

 Return  : reference to the current array of _features or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_features" md5="RNFfhdVb48udmcLN53fjwg">

sub _features {
  my $self = shift @_;
  if( @_ ) {
    my $_features = shift @_;
    if( defined( $_features ) && ref( $_features ) ne 'ARRAY' ) {
      confess( "Property '_features' requires an ARRAY argument (now: $_features)." );
    }
    $self->{ '_features' } = $_features;
  }
  return $self->{ '_features' };
}

###---   </auto:code>
###---   <auto:comment id="_add_feature" md5="YidfEcWvJ8qPfVy9Ywh8YQ">

=head2 _add_feature

 Title   : _add_feature (_features property)
 
 Usage   : C<<< $object->_add_feature( $_feature, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< _features >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_feature" md5="Jz5pjCDNEcQS9ai95RGD5Q">

sub _add_feature {
  my $self = shift @_;
  my @_features = @_;
  $self->{ '_features' } ||= [];
  push @{ $self->{ '_features' } }, @_features;
  return undef;
}

###---   </auto:code>
###--- </array_property>

##########################################################################

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'database_name', $self->get_database_name() );
  $target->property( 'top_level_sequence_type', $self->get_top_level_sequence_type() );
  $target->property( 'source_attr', $self->get_source_attr() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'database_name' );
  $target->property( 'db' );
  $target->property( 'top_level_sequence_type' );
  $target->property( 'source_attr' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'database_name' ) { $self->set_database_name( @values ); }
  elsif( $property eq 'db' ) { $self->set_database_name( @values ); }
  elsif( $property eq 'top_level_sequence_type' ) { $self->set_top_level_sequence_type( @values ); }
  elsif( $property eq 'source_attr' ) { $self->set_source_attr( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

##########################################################################
# INDEX ITERATOR
##########################################################################

sub index_iterator
{
  my( $self ) = @_;
  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $self->indexes() );
  return $iterator;
}

##########################################################################
# INDEX2FEATURE PROPERTIES ACCESSORS
##########################################################################

sub index2primary_sequence_id
{
  my( $self, $index ) = @_;
  return $self->index2feature( $index )->get_primary_sequence_id();
}

sub index2start
{
  my( $self, $index ) = @_;
  return $self->index2feature( $index )->get_start();
}

sub index2sequence
{
  my( $self, $index, $sequence ) = @_;
  return $self->index2feature( $index );
}

sub index2feature
{
  my( $self, $index, $feature ) = @_;
  return $self->_features()->[ $index ];
}

sub index2flat_feature
{
  my( $self, $index, $feature ) = @_;
  return $self->_features()->[ $index ];
}

sub index2feature_id
{
  my( $self, $index ) = @_;
  return $self->index2feature( $index )->get_id();
}

sub index2parent_feature_ids
{
  my( $self, $index ) = @_;
  return [];
}

##########################################################################
# ALL FEATURES ARRAY BUILDERS
##########################################################################

sub indexes
{
  my( $self ) = @_;

  $self->_process_features();
  my $size = scalar( @{ $self->_features() || [] } );
  return [ 0 .. ( $size - 1 ) ];
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub create_ensembl_feature_factory
{
  my( $self, $feature_factory ) = @_;

  if( !ref( $feature_factory ) ) {
    $feature_factory = new BioMinerva::DNALib::EnsEmblFeatureFactory();
  }

  $feature_factory->set_database_name( $self->get_database_name() );
  $feature_factory->set_top_level_sequence_type( $self->get_top_level_sequence_type() );
  $feature_factory->set_source_attr( $self->get_source_attr() );

  return $feature_factory;
}

sub source
{
  my( $self ) = @_;
  
  my $db_adaptor = $self->_db_adaptor();
  return $db_adaptor->dbc()->dbname();
}

sub _process_features
{
  my( $self ) = @_;

  confess( "Not overridden in $self" );
}

sub _db_adaptor
{
  my( $self ) = @_;

  my $database_name = $self->get_database_name();
  if( !$database_name ) {
    croak( "EnsEMBL database_name has not been provided "
      . "[check ~/.ensembl_init for a list of available databases] in $self" 
    );
  }
  
  my $db_adaptor = Bio::EnsEMBL::Registry->get_DBAdaptor( $database_name, "core" );
  if( !ref( $db_adaptor ) ) {
    croak( "Cannot get DBAdaptor for '$database_name' [check ~/.ensembl_init?] in $self" );
  }

  return $db_adaptor;
}

sub _sequence2slice
{
  my( $self, $sequence ) = @_;
  
  # ----- slice extraction -----
  my $db_adaptor = $self->_db_adaptor();
  my $slice_adaptor = $db_adaptor->get_SliceAdaptor()
    || confess( "Cannot get EnsEMBL SliceAdaptor in $self" );

  my $slice = $slice_adaptor->fetch_by_region(
    $self->get_top_level_sequence_type() || 'toplevel',
    $sequence->get_primary_sequence_id(),
    $sequence->start(),
    $sequence->end(),
    $sequence->strand()
  );
}

sub _create_feature
{
  my( $self, $type ) = @_;

  my $source_attr = $self->get_source_attr();
  
  my $feature = new BioMinerva::DNALib::Feature();
  $feature->set_type( $type );

  if( defined( $source_attr ) ) {
    if( $source_attr eq 'Source' ) {
      $feature->set_source( $self->source() );
    } else {
      $feature->add_attr( $source_attr, $self->source() );
    }
  }

  return $feature;
}

##########################################################################

1;

