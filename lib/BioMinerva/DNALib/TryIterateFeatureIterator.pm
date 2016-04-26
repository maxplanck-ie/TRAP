##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TryIterateFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIterator;
@ISA = qw( BioMinerva::DNALib::FeatureIterator );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::TryIterateFeatureIterator();
  }

  $self->SUPER::clone( $clone );

  $clone->_set_valid( $self->_get_valid() );
  $clone->_set_count( $self->_get_count() );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='_valid' get_id='' set_id=''>
###---   <auto:comment id="_valid" md5="1H9xFlT+NXFsV3mFTb3Flg">

=head2 _valid

 Title   : _valid property
 
 Usage   : $object->_valid(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_valid" md5="Fy1bU5Lxok1IO5Y4ut0qyg">

sub _valid {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_valid' } = shift @_;
  }
  return $self->{ '_valid' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_valid" md5="9aoI9DKPoR9oVgPpnVOE7Q">

sub _get_valid {
  return shift->{ '_valid' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_valid" md5="akdzZKhUctL61UKcKHe+wQ">

sub _set_valid {
  my $self = shift @_;
  $self->{ '_valid' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_count' get_id='' set_id=''>
###---   <auto:comment id="_count" md5="8Ek1Y1MCL9LjJzcxlFhdnQ">

=head2 _count

 Title   : _count property
 
 Usage   : $object->_count(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_count" md5="cXLnZFaOJ4MNFukSrAcDLw">

sub _count {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_count' } = shift @_;
  }
  return $self->{ '_count' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_count" md5="qdq6YcR8YmYUv6LInWFi2w">

sub _get_count {
  return shift->{ '_count' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_count" md5="zOM0ORr5SXGcQO4LcokDaw">

sub _set_count {
  my $self = shift @_;
  $self->{ '_count' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
 
  if( $self->_try_iterate( 1 ) ) {
    $self->_set_valid( 1 );
    $self->_set_count( 0 );
  } else {
    $self->_set_valid( 0 );
    $self->_set_count( undef );
  }
}

sub valid
{
  my( $self ) = @_;
  
  return $self->_get_valid();
}

sub iterate
{
  my( $self ) = @_;
  
  if( $self->_try_iterate( 0 ) ) {
#    $self->_set_valid( 1 ); #not necessary, is already =1
    $self->_set_count( $self->_get_count() + 1 );
  } else {
    $self->_set_valid( 0 );
  }
}

sub count
{
  my( $self ) = @_;

  return $self->_get_count();
}

##########################################################################

sub _try_iterate
{
  my( $self, $reset ) = @_;

  confess( "Not defined yet" );

  #return whether iterated
}

##########################################################################

1;
