##########################################################################

package BioMinerva::DNALib::CountMatchProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatchProcessor;
@ISA = qw( BioMinerva::DNALib::MatchProcessor );

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

##########################################################################
# FUNCTIONALITY
##########################################################################

sub num_of_matches
{
  my( $self ) = @_;

  return $self->get_count();
}

sub process_match
{
  my( $self, $match ) = @_;

  $self->set_count(
    ( $self->get_count() || 0 ) + 1
  );
}

##########################################################################

1;
