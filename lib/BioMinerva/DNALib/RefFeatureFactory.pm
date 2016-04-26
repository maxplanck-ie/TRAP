##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::RefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureFactory;
@ISA = qw( BioMinerva::DNALib::FeatureFactory );

use BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory;
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
    $clone = new BioMinerva::RefFeatureFactory();
  }
  $self->SUPER::clone( $clone );

  $clone->set_feature_factory( $self->get_feature_factory() );
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
  $target->property( 'feature_factory', $self->get_feature_factory() );
}

sub display_id
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  my $feature_factory_display_id = ref( $feature_factory )
    ? $feature_factory->display_id()
    : undef;

  my $super_display_id = $self->SUPER::display_id();

  return
    ( defined( $super_display_id )
      ? ( $super_display_id . ":" )
      : ""
    )
    . $self->operator_display_id()
    . '('
    . (
      defined( $feature_factory_display_id )
        ? $feature_factory_display_id
        : '<undef feature_factory>'
    )
    . ')';
}

sub operator_display_id
{
  my( $self ) = @_;

  return 'ref';
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  my $feature_factory = $self->get_feature_factory();
  $digest->add( ref( $feature_factory ) ? $feature_factory->digest_id() : '' );
  
  return $digest;
}

sub cached_feature_factory
{
  my( $self ) = @_;

  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    my $ref_feature_factory = $self->get_feature_factory();
    if( ref( $ref_feature_factory ) ) {
      $cache = $ref_feature_factory->get_cache();
    }
  }

  if( ref( $cache ) ) {
    my $feature_factory = new BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory();
    $feature_factory->set_cache( $cache );
    $feature_factory->set_feature_factory( $self );
    return $feature_factory;
  } else {
    return $self->SUPER::cached_feature_factory();
  }
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

##########################################################################

1;
