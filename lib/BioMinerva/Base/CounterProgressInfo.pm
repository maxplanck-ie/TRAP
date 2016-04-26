##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::CounterProgressInfo;

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

###--- <scalar_property id="size" get_id="" set_id="">
###---   <auto:comment id="size" md5="ENxW0b+vCTybd8IUW50J7g">

=head2 size

 Title   : size property
 
 Usage   : $object->size(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="size" md5="lz08oqq2J3yf1P4Is9sgDA">

sub size {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'size' } = shift @_;
  }
  return $self->{ 'size' };
}

###---   </auto:code>
###---   <auto:code get_id="get_size" md5="KInU2+5WJQyPEcAqLuqpog">

sub get_size {
  return shift->{ 'size' };
}

###---   </auto:code>
###---   <auto:code set_id="set_size" md5="9BOxSfJ7DAiGVbX/b8zRLQ">

sub set_size {
  my $self = shift @_;
  $self->{ 'size' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="count" get_id="" set_id="">
###---   <auto:comment id="count" md5="udWD5SXA9o899jGy9MtiGA">

=head2 count

 Title   : count property
 
 Usage   : $object->count(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="count" md5="3K8A1YYOaXoG2enbhQ42TQ">

sub count {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'count' } = shift @_;
  }
  return $self->{ 'count' };
}

###---   </auto:code>
###---   <auto:code get_id="get_count" md5="4y//YOSt4p/33I3d8jGHHQ">

sub get_count {
  return shift->{ 'count' };
}

###---   </auto:code>
###---   <auto:code set_id="set_count" md5="cMvumDNnSvAB2nHr2QKyBg">

sub set_count {
  my $self = shift @_;
  $self->{ 'count' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

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
  $target->property( 'size', $self->get_size() );
  $target->property( 'count', $self->get_count() );
  $target->property( 'phase', $self->get_phase() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;
