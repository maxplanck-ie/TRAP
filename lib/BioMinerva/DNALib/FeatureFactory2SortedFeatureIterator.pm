##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureFactory2SortedFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SortedFeatureIterator;
@ISA = qw( BioMinerva::DNALib::SortedFeatureIterator );

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
    $clone = new BioMinerva::DNALib::FeatureFactory2SortedFeatureIterator();
  }

  $self->SUPER::clone( $clone );
  
  return $clone;
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

###--- <scalar_property id='_var_sorted_index_iterator' get_id='' set_id=''>
###---   <auto:comment id="_var_sorted_index_iterator" md5="ZwLRLojRN5TRcZROiDSxfw">

=head2 _var_sorted_index_iterator

 Title   : _var_sorted_index_iterator property
 
 Usage   : $object->_var_sorted_index_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_var_sorted_index_iterator" md5="JMqhxM8GTvUii4ASd7fmUQ">

sub _var_sorted_index_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_var_sorted_index_iterator' } = shift @_;
  }
  return $self->{ '_var_sorted_index_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_var_sorted_index_iterator" md5="F877zORzPbxPM78dzjwZCQ">

sub _get_var_sorted_index_iterator {
  return shift->{ '_var_sorted_index_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_var_sorted_index_iterator" md5="x4rST99aG1H+KUZlOghczw">

sub _set_var_sorted_index_iterator {
  my $self = shift @_;
  $self->{ '_var_sorted_index_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub _get_sorted_index_iterator
{
  my( $self ) = @_;

  my $sorted_index_iterator = $self->_get_var_sorted_index_iterator();
  if( !ref( $sorted_index_iterator ) ) { 
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }
    
    $sorted_index_iterator = $feature_factory->start_sorted_index_iterator();
    $self->_set_var_sorted_index_iterator( $sorted_index_iterator );
  }
  return $sorted_index_iterator;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->get_feature_factory() );
}

sub reset
{
  my( $self ) = @_;

  $self->_get_sorted_index_iterator()->reset();
}

sub valid
{
  my( $self ) = @_;

  return $self->_get_sorted_index_iterator()->valid();
}

sub iterate
{
  my( $self ) = @_;

  return $self->_get_sorted_index_iterator()->iterate();
}

sub value
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }
  
  return $feature_factory->index2feature(
    $self->_get_sorted_index_iterator()->value()
  );
}

sub size
{
  my( $self ) = @_;

  return $self->_get_sorted_index_iterator()->size();
}

##########################################################################

1;

