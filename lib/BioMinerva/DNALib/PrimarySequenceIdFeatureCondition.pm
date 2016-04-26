##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PrimarySequenceIdFeatureCondition;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureCondition;
@ISA = qw( BioMinerva::DNALib::FeatureCondition );

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
    $clone = new BioMinerva::DNALib::PrimarySequenceIdFeatureCondition();
  }

  $self->SUPER::clone( $clone );
  $clone->set_primary_sequence_id( $self->get_primary_sequence_id() );
  
  return $clone;
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
  $target->property( 'primary_sequence_id', $self->get_primary_sequence_id() );
}

sub digest
{
  my( $self ) = @_;

  my $digest = $self->SUPER::digest();
  $digest->add( $self->get_primary_sequence_id() || '' );

  return $digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature ) = @_;

  return 
    $feature->get_primary_sequence_id()
    eq
    $self->get_primary_sequence_id();
}

##########################################################################

1;
