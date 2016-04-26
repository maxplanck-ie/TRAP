##########################################################################
# This matrix stores the (regularized) probabilities for each of 
# A, C, G, T on a set of positions.
##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Pspm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Psm;
@ISA = qw( BioMinerva::DNALib::Psm );

##########################################################################

use Carp qw( confess carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub pspm {
  my( $self ) = @_;

  my $pspm = new BioMinerva::DNALib::Pspm();
  $pspm->set_pscm( $self->get_pscm() );
  
  return $pspm;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pscm" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::Pscm">
###---   <auto:comment id="pscm" md5="TaQSlB/eriP8A0pfX8pVjg">

=head2 pscm

 Title   : pscm property
 
 Usage   : $object->pscm(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pscm" md5="M94khYBNWBbIzPuKUJ5xrg">

sub pscm {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pscm' } = shift @_;
  }
  return $self->{ 'pscm' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pscm" md5="3++GmldzFJTIc9ap5pM6+g">

sub get_pscm {
  return shift->{ 'pscm' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pscm" md5="Qs0i/Fz8x0Q3GCxm0A5j/Q">

sub set_pscm {
  my $self = shift @_;
  $self->{ 'pscm' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pscm" md5="wMuFA5bWuL5IcqUv9dogNg">

sub link_pscm {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pscm' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pscm' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::Pscm', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub get_type {
  my( $self ) = @_;
  return 'pspm';
}

sub matrix {
  my $self = shift;
  
  if( @_ ) {
    my $matrix = shift @_;

    if( ref( $matrix ) ne 'ARRAY' ) {
      confess( 
        "In Pspm -matrix should be a reference to an array (1..len) "
        . "of hash pointers {A=>count, C=>count}" );
    }
    for( my $pos = 0; $pos < scalar( @{ $matrix } ); ++$pos ) {
      foreach my $nucleotide( qw( A C G T ) ) {
        my $prob = $matrix->[ $pos ]->{ $nucleotide };
        if( !defined( $prob ) || $prob < 0.0 || $prob > 1.0 ) {
          confess( 
            "In Pspm, position $pos: "
            . "probability not correctly given for nucleotide '$nucleotide': '$prob'." );
        }
      }
    }

    $self->{ 'matrix' } = $matrix;
    return;
  }
  
  if( exists( $self->{ 'matrix' } ) ) {
    return $self->{ 'matrix' };
  } elsif( defined( $self->pscm() ) ) {
    confess( "This should not happen anymore in $self" );
#    my $bg_prob_vec = $self->_pscm2nucleotide_allpos_prob_dist( $self->pscm() );
#    return $self->_pscm_matrix2pspm_matrix( $self->pscm()->matrix(), $bg_prob_vec );
  } else {
    return undef;
  }
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm', $self->pscm() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pssm_matrix
{
  my( $self, $bg_prob_vec ) = @_;
  
  my $pspm_matrix = $self->matrix();
  
  my $pssm_matrix = [];
  for( my $i = 0; $i < scalar( @{ $pspm_matrix } ); $i++ ) {
    foreach my $nucleotide( qw( A C G T ) ) {
      $pssm_matrix->[ $i ]->{ $nucleotide } =
        log( 
          $pspm_matrix->[ $i ]->{ $nucleotide } 
          / $bg_prob_vec->{ $nucleotide } 
        );
    }
  }

  return $pssm_matrix;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pos_shuffled_pspm
{
  my( $self ) = @_;

  my $pscm = $self->get_pscm();
  if( !ref( $pscm ) ) {
    croak( "Undefined pscm in $self" );
  }
 
  my $pspm = $self->pspm();
  $pspm->set_pscm( $pscm->pos_shuffled_pscm() );
  return $pspm;
}

##########################################################################

1;

