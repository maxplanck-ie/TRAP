##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Pssm;

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

sub pssm {
  my( $self ) = @_;

  my $pssm = new BioMinerva::DNALib::Pssm();
  $pssm->set_pspm( $self->get_pspm() );
  $pssm->set_gc( $self->get_gc() );
  $pssm->set_bg_prob_vec( $self->get_bg_prob_vec() );
  
  return $pssm;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pspm" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::Pspm">
###---   <auto:comment id="pspm" md5="+zRFMteIUEf7eNGOHQkxOA">

=head2 pspm

 Title   : pspm property
 
 Usage   : $object->pspm(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pspm" md5="KXrHWdgi0SFN8So+TVQuKw">

sub pspm {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pspm' } = shift @_;
  }
  return $self->{ 'pspm' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pspm" md5="0D9ghtvIaDY/Cpeddop6bQ">

sub get_pspm {
  return shift->{ 'pspm' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pspm" md5="W9mqayap4edSry+WtsVkxQ">

sub set_pspm {
  my $self = shift @_;
  $self->{ 'pspm' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pspm" md5="QPYnR3eVptZ5dIYVqdZ6Ag">

sub link_pspm {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pspm' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pspm' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::Pspm', $ref
      );
  }
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

###--- <scalar_property id='bg_prob_vec' get_id='' set_id=''>
###---   <auto:comment id="bg_prob_vec" md5="iHLrXPARTqEC9Z7KRz9x8w">

=head2 bg_prob_vec

 Title   : bg_prob_vec property
 
 Usage   : $object->bg_prob_vec(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bg_prob_vec" md5="Adug8UBnNJZT+qUr/9BHMg">

sub bg_prob_vec {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bg_prob_vec' } = shift @_;
  }
  return $self->{ 'bg_prob_vec' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bg_prob_vec" md5="lbdPhcPLfcBDxluAz2Q+zg">

sub get_bg_prob_vec {
  return shift->{ 'bg_prob_vec' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bg_prob_vec" md5="pRytK0GoSrL5aaf9yQGTTw">

sub set_bg_prob_vec {
  my $self = shift @_;
  $self->{ 'bg_prob_vec' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub get_type {
  my( $self ) = @_;
  return 'pssm';
}

sub matrix {
  my $self = shift;
  if( @_ ) {
    my $matrix = shift @_;

    if( ref( $matrix ) ne 'ARRAY' ) {
      confess( 
        "In Pssm -matrix should be a reference to an array (1..len) "
        . "of hash pointers {A=>count, C=>count}" );
    }
    for( my $pos = 0; $pos < scalar( @{ $matrix } ); ++$pos ) {
      foreach my $nucleotide( qw( A C G T ) ) {
        my $score = $matrix->[ $pos ]->{ $nucleotide };
        if( !defined( $score ) ) {
          confess( 
            "In Pssm, position $pos: "
            . "probability not correctly given for nucleotide '$nucleotide': '$score'" );
        }
      }
    }

    $self->{ 'matrix' } = $matrix;
  }
  if( !defined( $self->{ 'matrix' } ) && defined( $self->pspm() ) ) {
    confess( "Should not happen anymore" );
  } else {
    return $self->{ 'matrix' };
  }
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pspm', $self->pspm() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pos_shuffled_pssm
{
  my( $self ) = @_;

  my $pspm = $self->get_pspm();
  if( !ref( $pspm ) ) {
    croak( "Undefined pspm in $self" );
  }
 
  my $pssm = $self->pssm();
  $pssm->set_pspm( $pspm->pos_shuffled_pspm() );
  return $pssm;
}

##########################################################################

1;

