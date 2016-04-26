##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ObjectProcessor;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

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

sub process_object
{
  my( $self, $object ) = @_;
  confess( "Not overridden yet in $self" );
}

=for nothing
sub process_object_to_object
{
  my( $self, $object, $target_object ) = @_;
}
=cut

##########################################################################

1;
