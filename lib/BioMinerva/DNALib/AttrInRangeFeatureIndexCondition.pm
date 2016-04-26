##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::AttrInRangeFeatureIndexCondition;

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
  return new BioMinerva::DNALib::AttrInRangeFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="attr" get_id="" set_id="">
###---   <auto:comment id="attr" md5="xFNVrbKsW1g2CMFxdRxucg">

=head2 attr

 Title   : attr property
 
 Usage   : $object->attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="attr" md5="Gh+gdIEZ6omgrzFCwhtYsA">

sub attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'attr' } = shift @_;
  }
  return $self->{ 'attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_attr" md5="LV4chhoY5V0HULPGHiNdpQ">

sub get_attr {
  return shift->{ 'attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_attr" md5="tzGA8wtCAVjfFT766JycnA">

sub set_attr {
  my $self = shift @_;
  $self->{ 'attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="min_value" get_id="" set_id="">
###---   <auto:comment id="min_value" md5="h6mBrWn6EFiN0jK4VUlxhA">

=head2 min_value

 Title   : min_value property
 
 Usage   : $object->min_value(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="min_value" md5="UCyXC3DHgIZKwB1CXN+aNQ">

sub min_value {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'min_value' } = shift @_;
  }
  return $self->{ 'min_value' };
}

###---   </auto:code>
###---   <auto:code get_id="get_min_value" md5="sMveewIWVo254DIaw6s4kA">

sub get_min_value {
  return shift->{ 'min_value' };
}

###---   </auto:code>
###---   <auto:code set_id="set_min_value" md5="pHobvcweI0aRCPcWvG5Sfw">

sub set_min_value {
  my $self = shift @_;
  $self->{ 'min_value' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="max_value" get_id="" set_id="">
###---   <auto:comment id="max_value" md5="kndJKU7Ex73I2M6J8MCwzA">

=head2 max_value

 Title   : max_value property
 
 Usage   : $object->max_value(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="max_value" md5="gY2pDlC5k2V5gRhvrdKNXQ">

sub max_value {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'max_value' } = shift @_;
  }
  return $self->{ 'max_value' };
}

###---   </auto:code>
###---   <auto:code get_id="get_max_value" md5="DFvsNCKYd0EqAOKrm8B7Ow">

sub get_max_value {
  return shift->{ 'max_value' };
}

###---   </auto:code>
###---   <auto:code set_id="set_max_value" md5="2XCJ08WeQuxlCPa5VqUP1Q">

sub set_max_value {
  my $self = shift @_;
  $self->{ 'max_value' } = shift @_;
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
    . $self->get_attr()
    . "("
    . $self->get_min_score()
    . ".."
    . $self->get_max_score()
    . ")";
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'attr', $self->attr() );
  $target->property( 'min_value', $self->min_value() );
  $target->property( 'max_value', $self->max_value() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'attr' );
  $target->property( 'min_value' );
  $target->property( 'max_value' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'attr' ) { $self->attr( @values ); }
  elsif( $property eq 'min_value' ) { $self->min_value( @values ); }
  elsif( $property eq 'max_value' ) { $self->max_value( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }
 
  my $attr = $self->get_attr();
  if( !defined( $attr ) ) {
    croak( "Undefined attr in $self" )
  }
 
  my $value = 
    $feature_factory->index2attr( $feature_index, $attr )->[ 0 ];
  return 
    $value >= $self->get_min_value() && $value <= $self->get_max_value();
}

##########################################################################

1;
