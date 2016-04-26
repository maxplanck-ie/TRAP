##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::PhaseProgressInfo;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::ProgressInfo;
@ISA = qw( BioMinerva::Base::ProgressInfo );

use Carp qw( confess croak carp );

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

###--- <scalar_property id="phase" get_id="" set_id="">
###---   <auto:comment id="phase" md5="vCfdDI8A9bhGbEoV+UQjcA">

=head2 phase

 Title   : phase property
 
 Usage   : $object->phase(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="phase" md5="o8vg8fCyw6CunRq5cXBO/w">

sub phase {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'phase' } = shift @_;
  }
  return $self->{ 'phase' };
}

###---   </auto:code>
###---   <auto:code get_id="get_phase" md5="1loTMQJIg7dVF3Z7V1/zHg">

sub get_phase {
  return shift->{ 'phase' };
}

###---   </auto:code>
###---   <auto:code set_id="set_phase" md5="ChH5PBjJqq8TTNdxt0VXxA">

sub set_phase {
  my $self = shift @_;
  $self->{ 'phase' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'phase', $self->get_phase() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;
