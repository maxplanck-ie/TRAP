##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::DBAdaptor;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use BioMinerva::Base::IdObject;
use vars qw( @ISA );
@ISA = qw( BioMinerva::Base::IdObject );

use DBI;
use Carp qw( confess carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::Base::DBAdaptor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="dbname">
###---   <auto:comment id="dbname" md5="r67R/LcQmC35F2psqkWnMQ">

=head2 dbname

 Title   : dbname property
 
 Usage   : $object->dbname(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="dbname" md5="pn+XrPlb5aKd+6HETFgaEA">

sub dbname {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'dbname' } = shift @_;
  }
  return $self->{ 'dbname' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="host">
###---   <auto:comment id="host" md5="2lhmz/vlhhiUckM6EYdL8w">

=head2 host

 Title   : host property
 
 Usage   : $object->host(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="host" md5="nI/veKdeLN4OIB5iErGUmg">

sub host {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'host' } = shift @_;
  }
  return $self->{ 'host' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="driver">
###---   <auto:comment id="driver" md5="GZwzzok4GO26Ja3hAP9T5g">

=head2 driver

 Title   : driver property
 
 Usage   : $object->driver(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="driver" md5="lf4uWUp+hy1iKAHwrTG3ww">

sub driver {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'driver' } = shift @_;
  }
  return $self->{ 'driver' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="user">
###---   <auto:comment id="user" md5="ARhXWnE+Z5wE1Ilxvqmw1A">

=head2 user

 Title   : user property
 
 Usage   : $object->user(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="user" md5="JxvoCQSIb9Lx7DNgAgRy+Q">

sub user {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'user' } = shift @_;
  }
  return $self->{ 'user' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pass">
###---   <auto:comment id="pass" md5="z8RLEXL6Y3EXFGGuR3k19g">

=head2 pass

 Title   : pass property
 
 Usage   : $object->pass(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pass" md5="FgEgZGPan3Zv9UzcEieAWA">

sub pass {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pass' } = shift @_;
  }
  return $self->{ 'pass' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="port">
###---   <auto:comment id="port" md5="17mJPRl1SAuLwWKpJRTfFA">

=head2 port

 Title   : port property
 
 Usage   : $object->port(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="port" md5="WKMPtbAuS8Y4TUV7fOk41g">

sub port {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'port' } = shift @_;
  }
  return $self->{ 'port' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_db_handle">
###---   <auto:comment id="_db_handle" md5="IdzyLvI8cphrMvKY4NMZSg">

=head2 _db_handle

 Title   : _db_handle property
 
 Usage   : $object->_db_handle(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_db_handle" md5="pdHtCsXDVbtLV2HJT6zVvQ">

sub _db_handle {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_db_handle' } = shift @_;
  }
  return $self->{ '_db_handle' };
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'dbname', $self->dbname() );
  $target->property( 'host', $self->host() );
  $target->property( 'driver', $self->driver() );
  $target->property( 'user', $self->user() );
  $target->property( 'pass', $self->pass() );
  $target->property( 'port', $self->port() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'dbname' );
  $target->property( 'host' );
  $target->property( 'driver' );
  $target->property( 'user' );
  $target->property( 'pass' );
  $target->property( 'port' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'dbname' ) { $self->dbname( @values ); }
  elsif( $property eq 'host' ) { $self->host( @values ); }
  elsif( $property eq 'driver' ) { $self->driver( @values ); }
  elsif( $property eq 'user' ) { $self->user( @values ); }
  elsif( $property eq 'pass' ) { $self->pass( @values ); }
  elsif( $property eq 'port' ) { $self->port( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub connect
{
  my( $self ) = @_;

  my $db_handle = $self->_db_handle();
  
  if( ref( $db_handle ) ) {
    return $db_handle;
  }
  
  my $dsn = 
    "DBI:" . ( $self->driver() || 'mysql' ) .
    ":database=". $self->dbname() .
    ";host=" . ( $self->host() || 'localhost' ) .
    ";port=" . ( $self->port() || '3306' );

  eval {
    $db_handle = DBI->connect(
      $dsn,
      $self->user(),
      $self->pass(),
      {
        'RaiseError' => 1
      }
    );
  };

  if( !$db_handle || $@ || !$db_handle->ping() ) {
    confess( "Connect to a database failed in $self" );
  }
  
  $self->_db_handle( $db_handle );

  return $db_handle;
}

sub db_handle
{
  my( $self ) = @_;

  my $db_handle = $self->_db_handle();
  if( !ref( $db_handle ) ) {
    $self->connect();
  }

  return $self->_db_handle();
}

sub disconnect
{
  my( $self ) = @_;
  carp( "Do not use disconnect anymore, just ignore it in $self" );
}

##########################################################################

1;

