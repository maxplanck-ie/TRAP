##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::MatcherFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess carp );

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

##########################################################################
# FUNCTIONALITY
##########################################################################

sub matchers
{
  my( $self ) = @_;

  confess( "Not overridden in $self" );
}

sub matcher_id2matcher
{
  my( $self, $matcher_id ) = @_;

  my $matchers = $self->matchers();
  foreach my $matcher( @{ $matchers || [] } ) {
    if( $matcher->get_id() eq $matcher_id ) {
      return $matcher;
    }
  }
  return undef;
}

##########################################################################

1;

