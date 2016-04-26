##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureIndexIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

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
    $clone = new BioMinerva::DNALib::FeatureIndexIterator();
  }

  $self->SUPER::clone( $clone );

  $clone->set_feature_factory( $self->get_feature_factory() );
  
  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_factory' get_id='' set_id=''>
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
###--- </scalar_property>

sub reset
{
  my( $self ) = @_;

  confess( "Not overridden yet in $self" );
}

sub valid
{
  my( $self ) = @_;

  confess( "Not overridden yet in $self" );
}

sub iterate
{
  my( $self ) = @_;

  confess( "Not overridden yet in $self" );
}

sub feature_index
{
  my( $self ) = @_;

  confess( "Not overridden yet in $self" );
}

sub size
{
  my( $self ) = @_;

  return undef;
}

sub count
{
  my( $self ) = @_;

  return undef;
}

sub progress
{
  my( $self ) = @_;

  return undef;
}

##########################################################################

1;
