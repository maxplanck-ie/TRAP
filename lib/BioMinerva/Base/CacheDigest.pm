##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::CacheDigest;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess carp croak );
use Storable qw( thaw freeze );
use Digest::MD5 qw( md5 md5_hex );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  my $self = $class->SUPER::new();
  $self->set_digest( new Digest::MD5() );
  return $self;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='digest' get_id='' set_id=''>
###---   <auto:comment id="digest" md5="HYvKGLa35CiLw7zo9xTgoA">

=head2 digest

 Title   : digest property
 
 Usage   : $object->digest(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="digest" md5="3cqgHAZNjNCBasCqSOuF/A">

sub digest {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'digest' } = shift @_;
  }
  return $self->{ 'digest' };
}

###---   </auto:code>
###---   <auto:code get_id="get_digest" md5="q/rNhwT2fArV7+un/mWuHg">

sub get_digest {
  return shift->{ 'digest' };
}

###---   </auto:code>
###---   <auto:code set_id="set_digest" md5="HS3jKfIbICimArvmIt0/4A">

sub set_digest {
  my $self = shift @_;
  $self->{ 'digest' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub add
{
  my( $self, @data ) = @_;
  $self->get_digest()->add( freeze( \@data ) );
}

sub add_file_info
{
  my( $self, $file ) = @_;

  if( !defined( $file ) ) {
    croak( "File name must be provided in $self" );
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
  
  $self->get_digest()->add( $file );
  $self->get_digest()->add( defined( $size ) ? $size : '' );
  $self->get_digest()->add( defined( $mtime ) ? $mtime : '' );
}

sub b64digest
{
  my( $self ) = @_;
  return $self->get_digest()->clone()->b64digest();
}

sub hexdigest
{
  my( $self ) = @_;
  return $self->get_digest()->clone()->hexdigest();
}

##########################################################################

1;

