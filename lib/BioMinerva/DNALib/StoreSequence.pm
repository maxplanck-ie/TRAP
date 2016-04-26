##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StoreSequence;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Sequence;
@ISA = qw( BioMinerva::DNALib::Sequence );

use Carp qw( confess croak carp );

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
    $clone = new BioMinerva::DNALib::StoreSequence();
  }
  $self->SUPER::clone( $clone );

  $clone->set_seq( $self->get_seq() );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='seq' get_id='' set_id=''>
###---   <auto:comment id="seq" md5="NEbI0+0eK96v8u5gbiveSQ">

=head2 seq

 Title   : seq property
 
 Usage   : $object->seq(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="seq" md5="68A4oIHYeOVnPpiDs0NclQ">

sub seq {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'seq' } = shift @_;
  }
  return $self->{ 'seq' };
}

###---   </auto:code>
###---   <auto:code get_id="get_seq" md5="nWd4JtlBDxdry4kAivPtfA">

sub get_seq {
  return shift->{ 'seq' };
}

###---   </auto:code>
###---   <auto:code set_id="set_seq" md5="/PrclqysBnZ5lp/nut0kzw">

sub set_seq {
  my $self = shift @_;
  $self->{ 'seq' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  $digest->add( $self->get_seq() || '' );

  return $digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;

