##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ArrayIterator;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IteratorI;
@ISA = qw( BioMinerva::Base::IteratorI );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='array' get_id='get_array' set_id='set_array'>
###---   <auto:comment id="array" md5="AgcZM19d1xb6zAyjGtDplg">

=head2 array

 Title   : array property
 
 Usage   : $object->array(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="array" md5="3kDOM3CKNGZ5R12uvMWOQQ">

sub array {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'array' } = shift @_;
  }
  return $self->{ 'array' };
}

###---   </auto:code>
###---   <auto:code get_id="get_array" md5="PYi+BvYcFouqTwkbt6wN2g">

sub get_array {
  return shift->{ 'array' };
}

###---   </auto:code>
###---   <auto:code set_id="set_array" md5="IPHPp0QqdOBCJaYRSXD1Zw">

sub set_array {
  my $self = shift @_;
  $self->{ 'array' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='index' get_id='get_index' set_id='set_index'>
###---   <auto:comment id="index" md5="aMJMKGFZg4HDWb8/1cfHiA">

=head2 index

 Title   : index property
 
 Usage   : $object->index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index" md5="7BAnGPK4NgFDGMFKVWXqTg">

sub index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index' } = shift @_;
  }
  return $self->{ 'index' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index" md5="7Lq+jJug+kSPckjiQV6D2A">

sub get_index {
  return shift->{ 'index' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index" md5="uBZWh3Xod+gC3juCQuhrzg">

sub set_index {
  my $self = shift @_;
  $self->{ 'index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'array', $self->array() );
  $target->property( 'index', $self->index() );
#  $target->property( '', $self->() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
#  $target->property( '' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  elsif( $property eq '' ) { $self->( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
  $self->set_index( 0 );
}

sub valid
{
  my( $self ) = @_;
  return $self->get_index() < scalar( @{ $self->get_array() || [] } );
}

sub iterate
{
  my( $self ) = @_;
  $self->set_index( $self->get_index() + 1 );
}

sub value
{
  my( $self ) = @_;
  my $array = $self->get_array();
  return $array->[ $self->get_index() ];
}

sub clone
{
  my( $self ) = @_;
  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $self->get_array() );
  $iterator->set_index( $self->get_index() );
  return $iterator;
}

sub size
{
  my( $self ) = @_;
  my $array = $self->get_array();
  if( !defined( $array ) ) { return undef; }
  return scalar( @{ $array } );
}

##########################################################################

1;
