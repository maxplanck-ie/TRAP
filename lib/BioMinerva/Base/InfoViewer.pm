##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::InfoViewer;

# for proper versioning
use BioMinerva::Base;
use Term::ANSIColor;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

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

###--- <scalar_property id="refresh_seconds" get_id="" set_id="">
###---   <auto:comment id="refresh_seconds" md5="CyJQSsuD9LyJ6OrHvM2TnQ">

=head2 refresh_seconds

 Title   : refresh_seconds property
 
 Usage   : $object->refresh_seconds(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="refresh_seconds" md5="Mg54xgtlbvaI8eIDmIb+XA">

sub refresh_seconds {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'refresh_seconds' } = shift @_;
  }
  return $self->{ 'refresh_seconds' };
}

###---   </auto:code>
###---   <auto:code get_id="get_refresh_seconds" md5="Bl4tBmLyCHMwX7Lk3QlaLw">

sub get_refresh_seconds {
  return shift->{ 'refresh_seconds' };
}

###---   </auto:code>
###---   <auto:code set_id="set_refresh_seconds" md5="tglDEy+9/kq2uhAa7nLZDA">

sub set_refresh_seconds {
  my $self = shift @_;
  $self->{ 'refresh_seconds' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="infos" get_id="" set_id="">
###---   <auto:comment id="infos" md5="uRBaiBHTOo5MzUfkXFG0Ew">

=head2 infos

 Title   : infos property
 
 Usage   : $object->infos(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="infos" md5="g0C7cMwMNo84NeJCJ08g2g">

sub infos {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'infos' } = shift @_;
  }
  return $self->{ 'infos' };
}

###---   </auto:code>
###---   <auto:code get_id="get_infos" md5="VgLgOj0ZERFYgiYPJ3KUlA">

sub get_infos {
  return shift->{ 'infos' };
}

###---   </auto:code>
###---   <auto:code set_id="set_infos" md5="S0i2BYq0STW4pGQ8VPfg3A">

sub set_infos {
  my $self = shift @_;
  $self->{ 'infos' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_last_line_length" get_id="" set_id="">
###---   <auto:comment id="_last_line_length" md5="PafChpxfupvxNwsIOKmEpw">

=head2 _last_line_length

 Title   : _last_line_length property
 
 Usage   : $object->_last_line_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_last_line_length" md5="cuXZToL+cOZM8T+K2Wj3bw">

sub _last_line_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_last_line_length' } = shift @_;
  }
  return $self->{ '_last_line_length' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_last_line_length" md5="p9UEeT7DNEahps/1k5CFKQ">

sub _get_last_line_length {
  return shift->{ '_last_line_length' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_last_line_length" md5="gY2T2bb10bYPRICqhqNBDg">

sub _set_last_line_length {
  my $self = shift @_;
  $self->{ '_last_line_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'refresh_seconds', $self->get_refresh_seconds() );
  $target->property( 'infos', $self->get_infos() );
}

sub global
{
  our $info_viewer;

  if( !ref( $info_viewer ) ) {
    $info_viewer = new BioMinerva::Base::InfoViewer();
  }

  return $info_viewer;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub push_info
{
  my( $self, $info ) = @_;

  alarm( 0 );

  my $infos = $self->get_infos() || [];
  push @{ $infos }, $info;
  $self->set_infos( $infos );
  
  $self->_init_notification();

  $SIG{ 'ALRM' } = \&_global_sig_alrm;
  alarm( $self->_get_default_refresh_seconds() );
}

sub pop_info
{
  my( $self ) = @_;
  
  alarm( 0 );

  $self->_destroy_notification();

  my $infos = $self->get_infos();
  if( !scalar( @{ $infos } ) ) {
    confess( "Incorrect push/pop info braces: no info to pop in $self" );
  }
  my $info = pop @{ $infos };
  $self->set_infos( $infos );

  if( scalar( @{ $infos } ) ) {
    $self->_timer_notification();
    alarm( $self->_get_default_refresh_seconds() );
  } else {
    $SIG{ 'ALRM' } = 'DEFAULT';
  }

  return $info;
}

sub message
{
  my( $self, $message ) = @_;
  
  my $alarm = alarm( 0 );

#  my $infos = $self->get_infos() || [];
#  if( scalar( @{ $infos } ) ) {
#    print STDERR "\n";
#  }

  print STDERR "\n#", $message, "\n";
  
  if( $alarm ) {
    alarm( $alarm );
  }
}

##########################################################################

sub _global_sig_alrm
{
  my $info_viewer = global();
  $info_viewer->_timer_notification();
  
  alarm( $info_viewer->_get_default_refresh_seconds() );
}

##########################################################################

sub _get_default_refresh_seconds
{
  my( $self ) = @_;

  return $self->get_refresh_seconds() || 1;
}

##########################################################################

sub _top_info
{
  my( $self ) = @_;

  my $infos = $self->get_infos();
  if( !scalar( @{ $infos || [] } ) ) {
    croak( "Incorrect state of infos: empty in $self" );
  }
  
  return $infos->[ scalar( @{ $infos } ) - 1 ];
}

sub _top_info2info_str
{
  my( $self, $top_info ) = @_;

  my $info_hash = $top_info->info_hash();
  my $info_str = join( ", ",
    map {
      Term::ANSIColor::colored( $_, "bold" )
      . ":" 
      . Term::ANSIColor::colored( $info_hash->{ $_ }, "blue" )
    } sort keys %{ $info_hash }
  );

  my $display_id = $top_info->display_id();
  
  return
    defined( $display_id )
      ? "$display_id ($info_str)"
      : "$info_str";
}

sub _init_notification
{
  my( $self ) = @_;

  my $top_info = $self->_top_info();
  $top_info->_init_notification();

  my $info_str = $self->_top_info2info_str( $top_info );
  
  if( $self->_get_last_line_length() ) {
    print STDERR "\n";
  }
  
  print STDERR "\r#", $info_str;
  
  $self->_set_last_line_length( length( $info_str ) );
}

sub _timer_notification
{
  my( $self ) = @_;

  my $top_info = $self->_top_info();
  $top_info->_timer_notification();

  my $info_str = $self->_top_info2info_str( $top_info );
  
  my $last_line_length = $self->_get_last_line_length();
  my $diff = defined( $last_line_length )
    ? ( $last_line_length - length( $info_str ) )
    : 0;
  
  print STDERR "\r#", $info_str,
    ( $diff > 0 ) ? ( " " x $diff ) : "";

  $self->_set_last_line_length( length( $info_str ) );
}

sub _destroy_notification
{
  my( $self ) = @_;
  
  my $top_info = $self->_top_info();
  $top_info->_destroy_notification();
  
  my $info_str = $self->_top_info2info_str( $top_info );
  
  my $last_line_length = $self->_get_last_line_length();
  my $diff = defined( $last_line_length )
    ? ( $last_line_length - length( $info_str ) )
    : 0;
  
  print STDERR "\r#", $info_str,
    ( $diff > 0 ) ? ( " " x $diff ) : "",
    "\n";

  $self->_set_last_line_length( 0 );
}

##########################################################################

1;
