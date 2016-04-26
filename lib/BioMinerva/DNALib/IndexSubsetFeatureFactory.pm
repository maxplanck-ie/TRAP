##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::IndexSubsetFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::LinkedFeatureFactory;
@ISA = qw( BioMinerva::DNALib::LinkedFeatureFactory );

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
  return new BioMinerva::DNALib::IndexSubsetFeatureFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='index_iterator' set_id='' get_id=''>
###---   <auto:comment id="index_iterator" md5="oDGoqFK8L8pwPJU/pclZ1g">

=head2 index_iterator

 Title   : index_iterator property
 
 Usage   : $object->index_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index_iterator" md5="o/ecrvch4lbSIJzJKN1miw">

sub index_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index_iterator' } = shift @_;
  }
  return $self->{ 'index_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index_iterator" md5="f5GDbhhgosjfHQLoB4AKTQ">

sub get_index_iterator {
  return shift->{ 'index_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index_iterator" md5="DI/uEiREc3Z5pwcJI1Yvmw">

sub set_index_iterator {
  my $self = shift @_;
  $self->{ 'index_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'index_iterator', $self->index_iterator() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'index_iterator' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'index_iterator' ) { $self->index_iterator( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
#  $self->link_index_iterator( $registry ); #XXX: ill defined
}

##########################################################################
# INDEX ITERATOR
##########################################################################

#see properties

##########################################################################

1;

