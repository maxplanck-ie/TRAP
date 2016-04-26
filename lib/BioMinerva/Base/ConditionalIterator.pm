##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ConditionalIterator;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IteratorI;
@ISA = qw( BioMinerva::Base::IteratorI );

use Carp qw( confess );

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

###--- <scalar_property id='iterator' get_id='' set_id=''>
###---   <auto:comment id="iterator" md5="GRutBKHgSqZ9EGjGi5zcNA">

=head2 iterator

 Title   : iterator property
 
 Usage   : $object->iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="iterator" md5="kg/CP306R4tpbB7EMP/+cw">

sub iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'iterator' } = shift @_;
  }
  return $self->{ 'iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_iterator" md5="E3XD4F6XzJBylmsheOtLig">

sub get_iterator {
  return shift->{ 'iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_iterator" md5="dPy+MLzBf4XkeB80UWbkOw">

sub set_iterator {
  my $self = shift @_;
  $self->{ 'iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='condition' get_id='' set_id=''>
###---   <auto:comment id="condition" md5="YivGsCm1cb1CbwF0QPQh5g">

=head2 condition

 Title   : condition property
 
 Usage   : $object->condition(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="condition" md5="xQUN5HYstbvgVroVMh2YbA">

sub condition {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'condition' } = shift @_;
  }
  return $self->{ 'condition' };
}

###---   </auto:code>
###---   <auto:code get_id="get_condition" md5="PTL0op7NljkxSChZmM1XsQ">

sub get_condition {
  return shift->{ 'condition' };
}

###---   </auto:code>
###---   <auto:code set_id="set_condition" md5="Q3aysPBb+49Y0X41Vu7qww">

sub set_condition {
  my $self = shift @_;
  $self->{ 'condition' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_iterated' get_id='' set_id=''>
###---   <auto:comment id="_iterated" md5="4CQABAmsx5Lv+nuvUTZHlQ">

=head2 _iterated

 Title   : _iterated property
 
 Usage   : $object->_iterated(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_iterated" md5="IuOZFmDi1z94m4N2K6MM0Q">

sub _iterated {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_iterated' } = shift @_;
  }
  return $self->{ '_iterated' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_iterated" md5="9JVvIcDTkxreToeYXo5ZHQ">

sub _get_iterated {
  return shift->{ '_iterated' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_iterated" md5="8H7uaNuOdDmgqetCVPqgBQ">

sub _set_iterated {
  my $self = shift @_;
  $self->{ '_iterated' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'iterator', $self->iterator() );
  $target->property( 'condition', $self->condition() );
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
  $self->get_iterator()->reset();
  $self->_set_iterated( 0 );
}

sub valid
{
  my( $self ) = @_;
  if( !$self->_get_iterated() ) {
    $self->_test_iterate();
    $self->_set_iterated( 1 );
  }
  return $self->get_iterator()->valid();
}

sub iterate
{
  my( $self ) = @_;

  $self->get_iterator()->iterate();
  $self->_test_iterate();
}

sub value
{
  my( $self ) = @_;
  return $self->get_iterator()->value();
}

##########################################################################

sub _test_iterate
{
  my( $self ) = @_;

  my $iterator = $self->get_iterator();
  my $condition = $self->get_condition();
  
  while( 1 ) {
    if( !$iterator->valid() ) { 
      last; 
    }
    if( $condition->test( $iterator->value() ) ) {
      last;
    }
    $iterator->iterate();
  }
}

##########################################################################

1;
