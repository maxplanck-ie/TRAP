##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::LinkedFeatureFactory;

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

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_factory' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureFactory'>
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
###---   <auto:code link_id="link_feature_factory" md5="Q/CRdOmwILlT6wXJxvYYNw">

sub link_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
}

##########################################################################
# GENERAL
##########################################################################

sub display_id
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    return $self->SUPER::display_id();
  }

  return $feature_factory->display_id();
}

sub get_start_pack_format
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    confess( "Undefined feature_factory in $self" )
  }

  return $feature_factory->get_start_pack_format();
}

sub get_index_pack_format
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    confess( "Undefined feature_factory in $self" )
  }

  return $feature_factory->get_index_pack_format();
}

##########################################################################
# INDEX2FEATURE PROPERTIES ACCESSORS
##########################################################################

sub index2primary_sequence_id
{
  my( $self, $index ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2primary_sequence_id( $index );
}

sub index2type
{
  my( $self, $index ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2type( $index );
}

sub index2start
{
  my( $self, $index ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2start( $index );
}

sub index2sequence
{
  my( $self, $index, $sequence ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2sequence( $index, $sequence );
}

sub index2feature
{
  my( $self, $index, $feature ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2feature( $index, $feature );
}

sub index2flat_feature
{
  my( $self, $index, $feature ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2flat_feature( $index, $feature );
}

sub index2feature_id
{
  my( $self, $index ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2feature_id( $index );
}

sub index2parent_feature_ids
{
  my( $self, $index ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2parent_feature_ids( $index );
}

sub index2attr
{
  my( $self, $index, $attr_key ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->index2attr( $index, $attr_key );
}

##########################################################################

1;

