##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PscmFactory2PssmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PssmFactory;
@ISA = qw( BioMinerva::DNALib::PssmFactory );

use Carp qw( confess carp croak );
use BioMinerva::DNALib::Pspm;
use BioMinerva::DNALib::Pssm;

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

###--- <scalar_property id='pscm_factory' get_id='' set_id='' type='BioMinerva::DNALib::PscmFactory'>
###---   <auto:comment id="pscm_factory" md5="eyMNJtNWrZ6cTfZI/AyGxg">

=head2 pscm_factory

 Title   : pscm_factory property
 
 Usage   : $object->pscm_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pscm_factory" md5="Cwh8NCoaZKYRUM+KT49zRw">

sub pscm_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pscm_factory' } = shift @_;
  }
  return $self->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pscm_factory" md5="2njW0KLi9cGbCsEKY4+cXA">

sub get_pscm_factory {
  return shift->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pscm_factory" md5="Jh/KXKRV9iiZIJ/iSKAxnA">

sub set_pscm_factory {
  my $self = shift @_;
  $self->{ 'pscm_factory' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='gc' get_id='' set_id=''>
###---   <auto:comment id="gc" md5="xMvLmfQMavEOSVh0ou0Q5A">

=head2 gc

 Title   : gc property
 
 Usage   : $object->gc(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gc" md5="Gt4H2jnZX/pl9vAkXRBAmA">

sub gc {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gc' } = shift @_;
  }
  return $self->{ 'gc' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gc" md5="xlYgkdPXrvv77uxpYwBeqw">

sub get_gc {
  return shift->{ 'gc' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gc" md5="rVQsVklK1F862pOdhvCZdg">

sub set_gc {
  my $self = shift @_;
  $self->{ 'gc' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm_factory', $self->get_pscm_factory() );
  $target->property( 'gc', $self->get_gc() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pssms
{
  my( $self ) = @_;

  my $pscm_factory = $self->get_pscm_factory();
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }
  
  my $ref_pscms = $pscm_factory->pscms();
  
  my @pssms;
  foreach my $ref_pscm( @{ $ref_pscms || [] } ) {
    push @pssms, $self->_pscm2pssm( $ref_pscm );
  }

  return \@pssms;
}

sub pssm_id2pssm
{
  my( $self, $pssm_id ) = @_;

  my $pscm_factory = $self->get_pscm_factory();
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }

  my $pscm = $pscm_factory->pscm_id2pscm( $pssm_id );
  if( !ref( $pscm ) ) { return undef; }

  return $self->_pscm2pssm( $pscm );
}

##########################################################################

sub _pscm2pssm
{
  my( $self, $pscm ) = @_;

  my $pspm = $self->pscm2pspm( $pscm );
  my $pssm = $self->pspm2pssm( $pspm );
  return $pssm;
}

sub _pscm2pspm
{
  my( $self, $pscm ) = @_;

  my $precision = 0.0001;
  my $cutoff = 1.5;
  
  my $pspm = new BioMinerva::DNALib::Pspm();
  $pspm->pscm( $pscm );
  $pspm->set_id( $pscm->get_id() );
  $pspm->matrix(
    $pscm->pspm_matrix( 
      $pscm->nucleotide_allpos_prob_dist(), #TODO: magic add!
      $precision,
      $cutoff
    )
  );
  my %attrs = %{ $pscm->attrs() || {} };
  $pspm->attrs( \%attrs );
#  $pspm->add_attr( 'pspm_precision', $precision );
#  $pspm->add_attr( 'pspm_cutoff', $cutoff );
 
  return $pspm;
}

sub _pspm2pssm
{
  my( $self, $pspm ) = @_;

  my $gc = $self->get_gc();
  if( !defined( $gc ) ) {
    croak( "Undefined gc in $self" );
  }
  
  my $bg_prob_vec = $self->_bg_prob_vec( $gc );
  
  my $pssm = new BioMinerva::DNALib::Pssm();
  $pssm->pspm( $pspm );
  $pssm->set_id( $pspm->get_id() );
  $pssm->set_gc( $gc );
  $pssm->set_bg_prob_vec( $bg_prob_vec );
  $pssm->matrix( 
    $pspm->pssm_matrix( $bg_prob_vec ) 
  );
  my %attrs = %{ $pspm->attrs() || {} };
  $pssm->attrs( \%attrs );
  $pssm->add_attr( 'gc', $gc );
 
  return $pssm;
}

sub _bg_prob_vec {
  my( $self, $gc ) = @_;

  my $bg_prob_vec = {
    'A' => ( 1.0 - $gc ) / 2, 
    'C' => $gc / 2, 
    'G' => $gc / 2,
    'T' => ( 1.0 - $gc ) / 2
  };

  return $bg_prob_vec;
}

##########################################################################

1;

