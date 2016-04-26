##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::DirCache;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Cache;
@ISA = qw( BioMinerva::Base::Cache );

use Carp qw( confess carp croak );
use Storable qw( retrieve store );

##########################################################################
# STATIC
##########################################################################

sub file2default_cache
{
  my( $file ) = @_;

  if( defined( $file ) && $file ne '-' ) {
    my $dir =
      $file 
      . "." 
      . BioMinerva::Base::Cache::machine_memory_organization_id() 
      . ".dir_cache";

    my $cache = new BioMinerva::Base::DirCache();
    $cache->set_dir( $dir );

    return $cache;
  } else {
    return undef;
  }
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

###--- <scalar_property id='dir' get_id='' set_id=''>
###---   <auto:comment id="dir" md5="HbARZzTiTgGQPilt2n29EQ">

=head2 dir

 Title   : dir property
 
 Usage   : $object->dir(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="dir" md5="pcKIvotMZfmDHI2DwiC1Zw">

sub dir {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'dir' } = shift @_;
  }
  return $self->{ 'dir' };
}

###---   </auto:code>
###---   <auto:code get_id="get_dir" md5="ypKt4ukvKgSO/q47IJN3rA">

sub get_dir {
  return shift->{ 'dir' };
}

###---   </auto:code>
###---   <auto:code set_id="set_dir" md5="1frSnzRK25bqEmJU1soc4g">

sub set_dir {
  my $self = shift @_;
  $self->{ 'dir' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'dir', $self->dir() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub save
{
  my( $self ) = @_;

}

sub _do_peek
{
  my( $self, $cache_digest, $serialized_ref ) = @_;

  my $dir = $self->get_dir();
  if( !defined( $dir ) ) {
    croak( "Undefined dir in $self" );
  }

  my $cache_digest_id = $cache_digest->hexdigest();

#  print STDERR "#Cache retrieve (dir='$dir', cache_digest_id='$cache_digest_id'): ";
  my $serialized = eval {
    retrieve( "$dir/$cache_digest_id" );
  };

  if( defined( $serialized ) ) {
#    print STDERR "OK\n";
    ${ $serialized_ref } = ${ $serialized };
    return 1;
  } elsif( $! ) {
#    print STDERR "failed (system: '$!')\n";
    return undef; 
  } else {
#    print STDERR "not cached\n";
    return undef; 
  }
}

sub _do_poke
{
  my( $self, $cache_digest, $serialized ) = @_;

  my $dir = $self->get_dir();
  if( !defined( $dir ) ) {
    croak( "Undefined dir in $self" );
  }

  $self->_check_dir();

  my $cache_digest_id = $cache_digest->hexdigest();

#  print STDERR "#Storing cache entry (dir='$dir',cache_digest_id='$cache_digest_id')... ";
  eval { 
    store( \$serialized, "$dir/$cache_digest_id" );
  };

#  if( $@ ) {
#    print STDERR "failed (system: $!)\n";
#  } else {
#    print STDERR "OK\n";
#  }
}

sub _check_dir
{
  my( $self ) = @_;

  my $dir = $self->get_dir();
  if( !defined( $dir ) ) {
    croak( "Undefined dir in $self" );
  }

  my $dir_handle;
  if( !opendir( $dir_handle, $dir ) ) {
    if( !mkdir( $dir ) ) {
      croak( "Failed to create directory '$dir' (system: $!)" );
    }
  }
}

##########################################################################

1;

