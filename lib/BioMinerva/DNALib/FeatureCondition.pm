##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureCondition;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

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

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::FeatureCondition();
  }

  $self->SUPER::clone( $clone );
  
  return $clone;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature ) = @_;

  confess( "Not overridden yet in $self" );
}

##########################################################################

1;
