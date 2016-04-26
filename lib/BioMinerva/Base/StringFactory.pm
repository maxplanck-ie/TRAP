##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::StringFactory;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess carp croak );

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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  if( $property eq 'file' ) { $self->file( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#   }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub strings
{
  my( $self ) = @_;
  confess( "Not overridden yet in $self" );
}

##########################################################################

1;

