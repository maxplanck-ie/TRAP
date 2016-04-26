##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::IteratorI;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Object;
@ISA = qw( BioMinerva::Base::Object );

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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
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
  confess( "Must be overriden in $self" );
}

sub valid
{
  my( $self ) = @_;
  confess( "Must be overriden in $self" );
}

sub iterate
{
  my( $self ) = @_;
  confess( "Must be overriden in $self" );
}

sub value
{
  my( $self ) = @_;
  confess( "Must be overriden in $self" );
}

sub clone
{
  my( $self ) = @_;
  confess( "Must be overriden in $self" );
}

sub size
{
  my( $self ) = @_;
  confess( "Must be overriden in $self" );
}

##########################################################################

1;
