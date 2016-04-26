##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureFactory2SequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SequenceFactory;
@ISA = qw( BioMinerva::DNALib::SequenceFactory );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;

  carp( "Obsoleted class" );

  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::FeatureFactory2SequenceFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="sequence_factory" get_id="get_sequence_factory" set_id="set_sequence_factory">
###---   <auto:comment id="sequence_factory" md5="nSsQ+7ZMHzvX2Yo/bOKPhw">

=head2 sequence_factory

 Title   : sequence_factory property
 
 Usage   : $object->sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_factory" md5="oJ1dV8kpNuTSxqy5ho2NUQ">

sub sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_factory' } = shift @_;
  }
  return $self->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_factory" md5="6kU+ambkFItqJliIgotJGw">

sub get_sequence_factory {
  return shift->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_factory" md5="ISTcxJ9LtZL/YpCByaB1CA">

sub set_sequence_factory {
  my $self = shift @_;
  $self->{ 'sequence_factory' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="feature_factory" get_id="get_feature_factory" set_id="set_feature_factory">
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'feature_factory', $self->feature_factory() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence_factory' );
  $target->property( 'feature_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  elsif( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->set_sequence_factory(
    $registry->type_id2object( 
      'BioMinerva::DNALib::SequenceFactory',
      $self->get_sequence_factory() 
    )
  );
  $self->set_feature_factory(
    $registry->type_id2object( 
      'BioMinerva::DNALib::FeatureFactory',
      $self->get_feature_factory() 
    )
  );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub sequence_ids
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  return $feature_factory->feature_ids();
}

sub sequences
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  return $feature_factory->sequences();
}

sub sequence_id2sequence
{
  my( $self, $sequence_id ) = @_;
  
  confess( "Not overridden in $self" );
}

sub sequence2seq
{
  my( $self, $sequence ) = @_;
 
  my $sequence_factory = $self->get_sequence_factory();
  return $sequence_factory->sequence2seq( $sequence );
}

##########################################################################

1;
