##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PosShuffledRefPscmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefPscmFactory;
@ISA = qw( BioMinerva::DNALib::RefPscmFactory );

use Carp qw( confess carp croak );

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

###--- <scalar_property id="_pscms" get_id='' set_id=''>
###---   <auto:comment id="_pscms" md5="9fL9gXSfrnJIrB9X0xmYIQ">

=head2 _pscms

 Title   : _pscms property
 
 Usage   : $object->_pscms(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_pscms" md5="Gt9Rz3oIFuLz1fS2ZezF5A">

sub _pscms {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_pscms' } = shift @_;
  }
  return $self->{ '_pscms' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_pscms" md5="8kceDfuuFopo9XMfM9nwkw">

sub _get_pscms {
  return shift->{ '_pscms' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_pscms" md5="tlJ8ouTPMoHAyImRoVy4cw">

sub _set_pscms {
  my $self = shift @_;
  $self->{ '_pscms' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pscms
{
  my( $self ) = @_;

  if( !defined( $self->_get_pscms() ) ) {
    my $pscm_factory = $self->get_pscm_factory();
    if( !ref( $pscm_factory ) ) {
      croak( "Undefined pscm_factory in $self" );
    }
    
    my @pscms;
    foreach my $ref_pscm( @{ $pscm_factory->pscms() || [] } ) {
      my $pscm = $ref_pscm->pos_shuffled_pscm();
      $pscm->set_id( $ref_pscm->get_id() );
      push @pscms, $pscm;
    }

    $self->_set_pscms( \@pscms );
  }
  
  return $self->_get_pscms();
}

##########################################################################

1;

