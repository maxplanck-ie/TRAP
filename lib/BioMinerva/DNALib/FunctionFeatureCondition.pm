##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FunctionFeatureCondition;

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
    $clone = new BioMinerva::DNALib::FunctionFeatureCondition();
  }

  $self->SUPER::clone( $clone );
  
  $clone->set_function( $self->get_function() );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='function' get_id='' set_id=''>
###---   <auto:comment id="function" md5="98HHl8EyPDYemK+1pzPisQ">

=head2 function

 Title   : function property
 
 Usage   : $object->function(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="function" md5="LFYp16QZ6l+pqz1Ie0d5UA">

sub function {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'function' } = shift @_;
  }
  return $self->{ 'function' };
}

###---   </auto:code>
###---   <auto:code get_id="get_function" md5="380IZeT/lPQ8QKcdkwXTlg">

sub get_function {
  return shift->{ 'function' };
}

###---   </auto:code>
###---   <auto:code set_id="set_function" md5="WwvcXGN9199MAPfWsWxZhg">

sub set_function {
  my $self = shift @_;
  $self->{ 'function' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'function', $self->get_function() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature ) = @_;

  my $function = $self->get_function();
  if( !$function ) {
    croak( "Undefined function in $self" )
  }

  return $function->( $feature );
}

##########################################################################

1;
