##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TypeEqFeatureIndexCondition;

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
  return new BioMinerva::DNALib::TypeEqFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="type" get_id="" set_id="">
###---   <auto:comment id="type" md5="XezXTEMbnbJDRq3e1bk7dw">

=head2 type

 Title   : type property
 
 Usage   : $object->type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="type" md5="p0Cj5KdyYQ7fWlzcEur9vw">

sub type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'type' } = shift @_;
  }
  return $self->{ 'type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_type" md5="bsqUsOoQFpKYVSsxsj/MGg">

sub get_type {
  return shift->{ 'type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_type" md5="vgQvqMIBCa/6ytBNof6ytA">

sub set_type {
  my $self = shift @_;
  $self->{ 'type' } = shift @_;
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
    . "type="
    . $self->get_type();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'type', $self->type() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'type' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'type' ) { $self->type( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  return 
    $self->get_feature_factory()->index2type( $feature_index )
    eq $self->get_type();
}

##########################################################################

1;
