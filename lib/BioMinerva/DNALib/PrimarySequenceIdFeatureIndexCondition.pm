##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PrimarySequenceIdFeatureIndexCondition;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIndexCondition;
@ISA = qw( BioMinerva::DNALib::FeatureIndexCondition );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::PrimarySequenceIdFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="primary_sequence_id" get_id="" set_id="">
###---   <auto:comment id="primary_sequence_id" md5="biAKCpTbLEYDB0Z7cVYOTA">

=head2 primary_sequence_id

 Title   : primary_sequence_id property
 
 Usage   : $object->primary_sequence_id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="primary_sequence_id" md5="JgJrMRpWKFUbftQpSmnO0A">

sub primary_sequence_id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'primary_sequence_id' } = shift @_;
  }
  return $self->{ 'primary_sequence_id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_primary_sequence_id" md5="GY24CkWQyyYV5XIuQ8+jyA">

sub get_primary_sequence_id {
  return shift->{ 'primary_sequence_id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_primary_sequence_id" md5="u0w5JJgYEXxeT/MCXwh+aA">

sub set_primary_sequence_id {
  my $self = shift @_;
  $self->{ 'primary_sequence_id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub display_id
{
  my( $self ) = @_;

  my $display_id = $self->SUPER::display_id();
  if( defined( $display_id ) ) { $display_id .= ':'; }
  else { $display_id = ""; }
  return 
    $display_id
    . "primary_sequence_id="
    . $self->get_primary_sequence_id();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'primary_sequence_id', $self->primary_sequence_id() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'primary_sequence_id' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'primary_sequence_id' ) { $self->primary_sequence_id( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  return 
    $self->get_feature_factory()->index2primary_sequence_id( $feature_index )
    eq $self->get_primary_sequence_id();
}

##########################################################################

1;
