##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ProgressInfo;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess croak carp );
use POSIX qw( floor );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  my $self = $class->SUPER::new();

#  $self->set_rotating_char_attr( "tick" );
  $self->set_count_attr( "count" );
  $self->set_progress_attr( "progress" );
  $self->set_elapsed_time_attr( "elapsed" );
  $self->set_remaining_time_attr( "remains" );
  
  return $self;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="title" get_id="" set_id="">
###---   <auto:comment id="title" md5="TfDEeQJMvsEYcuh0mBcq1Q">

=head2 title

 Title   : title property
 
 Usage   : $object->title(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="title" md5="w7vPwHWb1hSIfQWB4dYOdQ">

sub title {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'title' } = shift @_;
  }
  return $self->{ 'title' };
}

###---   </auto:code>
###---   <auto:code get_id="get_title" md5="QvfWyDYQUUmJ5RITWV9RhQ">

sub get_title {
  return shift->{ 'title' };
}

###---   </auto:code>
###---   <auto:code set_id="set_title" md5="9CKwy+GOvrx46M/MVpXX9w">

sub set_title {
  my $self = shift @_;
  $self->{ 'title' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="timer_counter" get_id="" set_id="">
###---   <auto:comment id="timer_counter" md5="8iDPedQIpMJzrh9GFRKB/Q">

=head2 timer_counter

 Title   : timer_counter property
 
 Usage   : $object->timer_counter(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="timer_counter" md5="tz+Ts+fHhqxfCQBgxeRhPQ">

sub timer_counter {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'timer_counter' } = shift @_;
  }
  return $self->{ 'timer_counter' };
}

###---   </auto:code>
###---   <auto:code get_id="get_timer_counter" md5="rAaOLZBWvdLPrrQvlx0+wA">

sub get_timer_counter {
  return shift->{ 'timer_counter' };
}

###---   </auto:code>
###---   <auto:code set_id="set_timer_counter" md5="+K6pJ7aZjXJZYDYq9DYjfA">

sub set_timer_counter {
  my $self = shift @_;
  $self->{ 'timer_counter' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="rotating_char_attr" get_id="" set_id="">
###---   <auto:comment id="rotating_char_attr" md5="lZlxPGucZPJ3zBRVE9Wu+Q">

=head2 rotating_char_attr

 Title   : rotating_char_attr property
 
 Usage   : $object->rotating_char_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="rotating_char_attr" md5="Cdi25Ra2Gx34EmmmzDYpGw">

sub rotating_char_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'rotating_char_attr' } = shift @_;
  }
  return $self->{ 'rotating_char_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_rotating_char_attr" md5="Cf4s8FCiVHvWFEmgZPa0TQ">

sub get_rotating_char_attr {
  return shift->{ 'rotating_char_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_rotating_char_attr" md5="ke33GnRMb0as+dm+DJU7oA">

sub set_rotating_char_attr {
  my $self = shift @_;
  $self->{ 'rotating_char_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='count_attr' get_id='' set_id=''>
###---   <auto:comment id="count_attr" md5="uKwnEIb+22qYpaOEVttnIA">

=head2 count_attr

 Title   : count_attr property
 
 Usage   : $object->count_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="count_attr" md5="ZAkih0SexxN7xTvxHERGIw">

sub count_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'count_attr' } = shift @_;
  }
  return $self->{ 'count_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_count_attr" md5="/IstYLDnpNkjHkXJGCly7w">

sub get_count_attr {
  return shift->{ 'count_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_count_attr" md5="Fd7H4lZDifVP2l2ogU3I2A">

sub set_count_attr {
  my $self = shift @_;
  $self->{ 'count_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='progress_attr' get_id='' set_id=''>
###---   <auto:comment id="progress_attr" md5="KIDTejVRJGb5pLAylexCWg">

=head2 progress_attr

 Title   : progress_attr property
 
 Usage   : $object->progress_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="progress_attr" md5="h9GcpOyWZyt2s7N6fMUUrQ">

sub progress_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'progress_attr' } = shift @_;
  }
  return $self->{ 'progress_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_progress_attr" md5="P3HFCq2xVobWHU2VEtEUJw">

sub get_progress_attr {
  return shift->{ 'progress_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_progress_attr" md5="34/r7WKmUqTg+u4dE77/mg">

sub set_progress_attr {
  my $self = shift @_;
  $self->{ 'progress_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='phase_attr' get_id='' set_id=''>
###---   <auto:comment id="phase_attr" md5="zeTsyDkFfsOURZtoC6CFYA">

=head2 phase_attr

 Title   : phase_attr property
 
 Usage   : $object->phase_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="phase_attr" md5="k1T5E95As6HmnGqG8GFUvQ">

sub phase_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'phase_attr' } = shift @_;
  }
  return $self->{ 'phase_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_phase_attr" md5="vaA9mQbRltNK3XuQYDBS2Q">

sub get_phase_attr {
  return shift->{ 'phase_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_phase_attr" md5="5R1EJFL/HWJdmM3GrWn7gg">

sub set_phase_attr {
  my $self = shift @_;
  $self->{ 'phase_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='elapsed_time_attr' get_id='' set_id=''>
###---   <auto:comment id="elapsed_time_attr" md5="DgYTV08ztJYbR1LLukWqqA">

=head2 elapsed_time_attr

 Title   : elapsed_time_attr property
 
 Usage   : $object->elapsed_time_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="elapsed_time_attr" md5="0OKESEOAAy8WFzdR8kXVig">

sub elapsed_time_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'elapsed_time_attr' } = shift @_;
  }
  return $self->{ 'elapsed_time_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_elapsed_time_attr" md5="LaDJCS2sOPFyTTShP/cy9A">

sub get_elapsed_time_attr {
  return shift->{ 'elapsed_time_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_elapsed_time_attr" md5="9+mpY9OCLI4tNl2Oj53L2g">

sub set_elapsed_time_attr {
  my $self = shift @_;
  $self->{ 'elapsed_time_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='remaining_time_attr' get_id='' set_id=''>
###---   <auto:comment id="remaining_time_attr" md5="w//xfL4H17pZpFpziqBD/w">

=head2 remaining_time_attr

 Title   : remaining_time_attr property
 
 Usage   : $object->remaining_time_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="remaining_time_attr" md5="R43AwxTT5IJoUZp2WnQQtg">

sub remaining_time_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'remaining_time_attr' } = shift @_;
  }
  return $self->{ 'remaining_time_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_remaining_time_attr" md5="Tq70hZlCwds71yu0x5aZ7g">

sub get_remaining_time_attr {
  return shift->{ 'remaining_time_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_remaining_time_attr" md5="+xtwQnDkXBVQl5NZ6awZFQ">

sub set_remaining_time_attr {
  my $self = shift @_;
  $self->{ 'remaining_time_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='start_time' get_id='' set_id=''>
###---   <auto:comment id="start_time" md5="oVZVIOfVDXjMjlndtg9KlQ">

=head2 start_time

 Title   : start_time property
 
 Usage   : $object->start_time(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="start_time" md5="RELpHClq3mwW1sS8AtU5Zw">

sub start_time {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'start_time' } = shift @_;
  }
  return $self->{ 'start_time' };
}

###---   </auto:code>
###---   <auto:code get_id="get_start_time" md5="fuV1vTfgRqewsaCqJ7vlCw">

sub get_start_time {
  return shift->{ 'start_time' };
}

###---   </auto:code>
###---   <auto:code set_id="set_start_time" md5="gTQdURiJVmaFNbf5vBrANw">

sub set_start_time {
  my $self = shift @_;
  $self->{ 'start_time' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'title', $self->get_title() );
  $target->property( 'timer_counter', $self->get_timer_counter() );
  $target->property( 'rotating_char_attr', $self->get_rotating_char_attr() );
  $target->property( 'count_attr', $self->get_count_attr() );
  $target->property( 'progress_attr', $self->get_progress_attr() );
  $target->property( 'phase_attr', $self->get_phase_attr() );
  $target->property( 'elapsed_time_attr', $self->get_elapsed_time_attr() );
  $target->property( 'remaining_time_attr', $self->get_remaining_time_attr() );
  $target->property( 'start_time', $self->get_start_time() );
}

sub display_id
{
  my( $self ) = @_;

  my $title = $self->get_title();
  if( defined( $title ) ) {
    return $title;
  }

  return $self->SUPER::display_id();
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _init_notification
{
  my( $self ) = @_;
  
  $self->set_timer_counter( 0 );
  $self->set_start_time( time() );
}

sub _timer_notification
{
  my( $self ) = @_;

  $self->set_timer_counter( $self->get_timer_counter() + 1 );
}

sub _destroy_notification
{
  my( $self ) = @_;
}

##########################################################################

sub get_count
{
  my( $self ) = @_;

  return undef;
}

sub get_size
{
  my( $self ) = @_;

  return undef;
}

sub get_phase
{
  my( $self ) = @_;

  return undef;
}

sub progress
{
  my( $self ) = @_;

  my $size = $self->get_size();
  my $count = $self->get_count();

  if( defined( $count ) && $size ) {
    return $count / $size;
  }

  return undef;
}

##########################################################################

our $_chars = [ '|', '/', '-', '\\' ];

our $_time_diff_divisors = [
  24 * 60 * 60,
  60 * 60,
  60,
  1
];

our $_time_diff_chars = [
  'd', 'h', 'm', 's'
];

sub _time_diff2dhms
{
  my( $self, $time_diff ) = @_;

  my $dhms = "";
  my $i = 0;

  while( 1 ) {
    my $divisor = $_time_diff_divisors->[ $i ];
    my $div = floor( $time_diff / $divisor );
    if( $div || $divisor == 1 ) {
      $dhms .= $div . $_time_diff_chars->[ $i ];
      if( $divisor == 1 ) { 
        last; 
      }
    }
    $time_diff %= $_time_diff_divisors->[ $i ];
    ++$i;
  }

  return $dhms;
}

sub info_hash
{
  my( $self ) = @_;

  my $info_hash = {};
  
  my $rotating_char_attr = $self->get_rotating_char_attr();
  if( defined( $rotating_char_attr ) ) {
    my $timer_counter = $self->get_timer_counter();
    my $char = $_chars->[ $timer_counter % scalar( @{ $_chars } ) ];

    $info_hash->{ $rotating_char_attr } = $char;
  }

  my $count_attr = $self->get_count_attr();
  if( defined( $count_attr ) ) {
    my $count = $self->get_count();
    
    if( defined( $count ) ) {
      my $size = $self->get_size();
      if( $size ) {
        $info_hash->{ $count_attr } = "$count/$size";
      } else {
        $info_hash->{ $count_attr } = $count;
      }
    }
  }

  my $progress = $self->progress();
  my $elapsed_time_diff = time() - $self->get_start_time();
  
  my $progress_attr = $self->get_progress_attr();
  if( defined( $progress_attr ) ) {
    if( defined( $progress ) ) {
      $info_hash->{ $progress_attr } =
        sprintf( "%.1f", $progress * 100.0 ) . "%";
    }
  }
  
  my $phase_attr = $self->get_phase_attr();
  if( defined( $phase_attr ) ) {
    my $phase = $self->get_phase();

    if( defined( $phase ) ) {
      $info_hash->{ $phase_attr } = $phase;
    }
  }

  my $elapsed_time_attr = $self->get_elapsed_time_attr();
  if( defined( $elapsed_time_attr ) ) {
    $info_hash->{ $elapsed_time_attr } = 
      $self->_time_diff2dhms( $elapsed_time_diff );
  }

  my $remaining_time_attr = $self->get_remaining_time_attr();
  if( defined( $remaining_time_attr ) && defined( $progress )
    && $progress != 1.0 && $progress > 0.005 ) {
    my $remaining_time_diff = 
      ( $elapsed_time_diff / $progress - $elapsed_time_diff );
    $info_hash->{ $remaining_time_attr } = 
      $self->_time_diff2dhms( $remaining_time_diff );
  }
  
  return $info_hash;
}

##########################################################################

1;
