##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::IdObject;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use strict;
use warnings;
use vars qw( @ISA );
use BioMinerva::Base::Object;
@ISA = qw( BioMinerva::Base::Object );

use Digest::MD5;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone {
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::Base::IdObject();
  }
#  $self->SUPER::clone( $clone );

  $clone->set_id( $self->get_id() );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='id' get_id='' set_id=''>
###---   <auto:comment id="id" md5="zxaBjSV/khNAMDPqA3gl5Q">

=head2 id

 Title   : id property
 
 Usage   : $object->id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="id" md5="LcWD/ucgl2d171/x5P3ZKQ">

sub id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'id' } = shift @_;
  }
  return $self->{ 'id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_id" md5="zcd/oK6+Sze9f1NNcA7alg">

sub get_id {
  return shift->{ 'id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_id" md5="yGe3HI3i9d0pAoYdAFa8Jw">

sub set_id {
  my $self = shift @_;
  $self->{ 'id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = new Digest::MD5();

  $digest->add( ref( $self ) );
  $digest->add( $self->get_id() || '' );

  return $digest;
}

sub digest_id
{
  my( $self ) = @_;

  return $self->digest()->digest();
}

sub display_id
{
  my( $self ) = @_;

  return $self->get_id();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'id', $self->get_id() );
  $target->property( 'display_id', $self->display_id() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'id' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'id' ) { $self->set_id( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;
