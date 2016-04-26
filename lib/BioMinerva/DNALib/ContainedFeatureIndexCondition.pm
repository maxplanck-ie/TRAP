##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ContainedFeatureIndexCondition;

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
  return new BioMinerva::DNALib::ContainedFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="sequence" get_id="" set_id="">
###---   <auto:comment id="sequence" md5="ZGFBT/wYJMeTODcKpN96fg">

=head2 sequence

 Title   : sequence property
 
 Usage   : $object->sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence" md5="q3OjEMxe3Xcp8q//AD1K+A">

sub sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence' } = shift @_;
  }
  return $self->{ 'sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence" md5="V2c+LlO5SJUhlCNygNmj8Q">

sub get_sequence {
  return shift->{ 'sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence" md5="P0J0Qv5ujwgAA16pWYPxdA">

sub set_sequence {
  my $self = shift @_;
  $self->{ 'sequence' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub display_id
{
  my( $self ) = @_;

  my $sequence = $self->get_sequence();
  if( !ref( $sequence ) ) {
    confess( "Undefined sequence in $self" )
  }

  my $display_id = $self->SUPER::display_id();
  if( defined( $display_id ) ) { $display_id .= ':'; }
  else { $display_id = ""; }
  return 
    $display_id
    . "contained("
    . $sequence->location_str()
    . ")";
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence', $self->sequence() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence' ) { $self->sequence( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  return 
    $self->get_sequence()->contains(
      $self->get_feature_factory()->index2sequence( $feature_index )
    );
}

##########################################################################

1;
