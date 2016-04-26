##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::Cache;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use BioMinerva::Base::CacheDigest;
use Carp qw( confess carp );
use Storable qw( thaw freeze );
use Digest::MD5 qw( md5 md5_hex );

##########################################################################
# STATIC
##########################################################################

#warning: hexdigest here, since it becomes a part of a filename
sub machine_memory_organization_id
{
  our $machine_memory_organization_digest_id;

  if( !defined( $machine_memory_organization_digest_id ) ) {
    my $machine_memory_organization_test = [
      0x1, 3.1415926536, 0x1000000, [ 1, 2, 3 ]
    ];

    my $machine_memory_organization_digest = new Digest::MD5();
    $machine_memory_organization_digest->add( 
      freeze( 
        $machine_memory_organization_test
      ) 
    );

    $machine_memory_organization_digest_id =
      $machine_memory_organization_digest->hexdigest();
  }

  return $machine_memory_organization_digest_id;
}

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
#  $target->property( 'stream', $self->stream() );
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
  
#  if( $property eq '' ) { $self->skip_equal( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub cache_digest
{
  my( $self, $cached_type_id ) = @_;

  my $cache_digest = new BioMinerva::Base::CacheDigest();
  $cache_digest->add( BioMinerva::Base::Cache::machine_memory_organization_id() );
  $cache_digest->add( $cached_type_id );

  return $cache_digest;
}

sub poke
{
  my( $self, $cache_digest, $value ) = @_;
  $self->_do_poke( $cache_digest, freeze( $value ) );
}

sub peek 
{
  my( $self, $cache_digest, $value_ref ) = @_;
  
  my $serialized;

  if( $self->_do_peek( $cache_digest, \$serialized ) ) {
    ${ $value_ref } = thaw( $serialized );
    return 1;
  }
  return undef;
}

sub invalidate
{
  my( $self ) = @_;

  confess( "Not implemented yet" );
}

sub save
{
  my( $self ) = @_;

  confess( "Not implemented yet" );
}

##########################################################################

sub _do_poke
{
  my( $self, $cache_digest, $serialized ) = @_;

  confess( "Not implemented yet" );
}

sub _do_peek
{
  my( $self, $cache_digest, $serialized_ref ) = @_;

  confess( "Not implemented yet" );
}

##########################################################################
# TODO: STATIC FUNCTIONALITY, to be implemented in future File module
##########################################################################

sub file_info
{
  my( $self, $file ) = @_;

  my(
    $dev,
    $ino,
    $mode,
    $nlink,
    $uid,
    $gid,
    $rdev,
    $size,
    $atime,
    $mtime,
    $ctime,
    $blksize,
    $blocks
  ) = stat( $file );

  return ( $file, $size, $mtime );
}

sub file_digest
{
  my( $file ) = @_;

  if( !defined( $file ) ) {
    croak( "File name must be provided" );
  }

  my(
    $dev,
    $ino,
    $mode,
    $nlink,
    $uid,
    $gid,
    $rdev,
    $size,
    $atime,
    $mtime,
    $ctime,
    $blksize,
    $blocks
  ) = stat( $file );
  
  my $digest = new Digest::MD5();

  $digest->add( $file );
  $digest->add( defined( $size ) ? $size : '' );
  $digest->add( defined( $mtime ) ? $mtime : '' );

  return $digest;
}

sub file_digest_id
{
  my( $file ) = @_;

  my $file_digest = file_digest( $file );
  if( !ref( $file_digest ) ) {
    return undef;
  }

  return $file_digest->hexdigest();
}

##########################################################################

1;

