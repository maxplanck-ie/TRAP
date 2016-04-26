##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EqAttrFeatureIndexCondition;

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
  return new BioMinerva::DNALib::EqAttrFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="attr_key" get_id="" set_id="">
###---   <auto:comment id="attr_key" md5="7q2af2m3RljcNmWCd0CT0w">

=head2 attr_key

 Title   : attr_key property
 
 Usage   : $object->attr_key(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="attr_key" md5="iq7IXd7j8gGSk5ZEykxXBw">

sub attr_key {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'attr_key' } = shift @_;
  }
  return $self->{ 'attr_key' };
}

###---   </auto:code>
###---   <auto:code get_id="get_attr_key" md5="ZHc1t5C0mmuLEvhWVmRAoQ">

sub get_attr_key {
  return shift->{ 'attr_key' };
}

###---   </auto:code>
###---   <auto:code set_id="set_attr_key" md5="PgOMIRyo5+vLdrO7tLqUtA">

sub set_attr_key {
  my $self = shift @_;
  $self->{ 'attr_key' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="attr_value" get_id="" set_id="">
###---   <auto:comment id="attr_value" md5="D38TcBlOgsEkTerVHAfeNQ">

=head2 attr_value

 Title   : attr_value property
 
 Usage   : $object->attr_value(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="attr_value" md5="9PFvZJ4sVLeZeE2jZozX4g">

sub attr_value {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'attr_value' } = shift @_;
  }
  return $self->{ 'attr_value' };
}

###---   </auto:code>
###---   <auto:code get_id="get_attr_value" md5="k88e1A1ni8HQS59zk7zDgw">

sub get_attr_value {
  return shift->{ 'attr_value' };
}

###---   </auto:code>
###---   <auto:code set_id="set_attr_value" md5="OW6ZtbEYE/rUWqKzJAWR+w">

sub set_attr_value {
  my $self = shift @_;
  $self->{ 'attr_value' } = shift @_;
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
    . $self->get_attr_key()
    . "="
    . $self->get_attr_value();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'attr_key', $self->attr_key() );
  $target->property( 'attr_value', $self->attr_value() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'attr_key' );
  $target->property( 'attr_value' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'attr_key' ) { $self->attr_key( @values ); }
  elsif( $property eq 'attr_value' ) { $self->attr_value( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  my $attr_value = $self->get_feature_factory()->
    index2flat_feature( $feature_index )->attr( $self->get_attr_key() );

  return
    $attr_value eq $self->get_attr_value();
}

##########################################################################

1;
