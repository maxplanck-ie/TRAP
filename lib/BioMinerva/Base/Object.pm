##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::Object;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
@ISA = qw();

use Carp qw( confess carp croak );
use BioMinerva::Base::StringifyStateReporter;
use BioMinerva::Base::ConfPropertiesReporter;

use overload(
  '""' => \&stringify
);

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller, @args ) = @_;
  my $class = ref( $caller ) || $caller;

  my $self = {};
  bless( $self, $class );

  return $self;
}

##########################################################################
# PROPERTIES
##########################################################################

sub id
{
  return undef;
}

# 1. report state properties
# 2. list settable properties
# 3. set a property
# Motivation: at least two stringify's are needed
#             configurator is too complex and unnecessary
#             configurator has the address of virtual function design flaw
# Note: up to now, only two repetitions of parameter lists were present

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
#  $self->SUPER::report_conf_properties( $target );
#example:  $target->property( 'id' ); #here place for extra args (scalar, array, type, etc)
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;

  my $reporter = new BioMinerva::Base::ConfPropertiesReporter();
  $self->report_conf_properties( $reporter );
  
  croak( 
    "Don't know how to set property '$property' in $self (known properties: "
    . ( 
      @{ $reporter->properties() || [] }
      ? join( ', ', @{ $reporter->properties() } )
      : '-none-'
    )
    . ')'
  );
}

sub report_state
{
  my( $self, $target ) = @_;

#  $self->SUPER::report_state( $target );
#  $target->property( 'id', $self->id() );
}

sub link_references
{
  my( $self, $registry ) = @_;
}

sub stringify
{
  my( $self ) = @_;

  my $reporter = new BioMinerva::Base::StringifyStateReporter();

  {
    my $class = ref( $self );
    $class =~ s/^BioMinerva::Base:://;
    $reporter->class( $class );

    $self->report_state( $reporter );
  }

  return $reporter->str();
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;
