##########################################################################
# This matrix stores the COUNTS for each of A, C, G, T on a set
# of positions.
# (the first step after aligning a site)
##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Pscm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Psm;
@ISA = qw( BioMinerva::DNALib::Psm );

##########################################################################

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub pscm {
  my( $self ) = @_;
  
  my $pscm = new BioMinerva::DNALib::Pscm();
  $pscm->matrix( $self->_copy_matrix( $self->matrix() ) );

  return $pscm;
}

##########################################################################
# PROPERTIES
##########################################################################

sub get_type {
  my( $self ) = @_;
  return 'pscm';
}

sub matrix {
  my $self = shift;
  if( @_ ) {
    my $matrix = shift @_;

    if( ref( $matrix ) ne 'ARRAY' ) {
      confess( 
        "In Pscm -matrix should be a reference to an array (1..len) "
        . "of hash pointers {A=>count, C=>count}" );
    }

    for( my $pos = 0; $pos < scalar( @{ $matrix } ); ++$pos ) {
      foreach my $nucleotide( qw( A C G T ) ) {
        if( !defined( $matrix->[ $pos ]->{ $nucleotide } ) ) {
          confess( 
            "In Pscm, position $pos: "
            . "count not defined for nucleotide '$nucleotide' "
            . "(currently: "
            . $self->_matrix2str( $matrix )
            . ")" );
        }
      }
    }

    $self->{ 'matrix' } = $matrix;
  }
  return $self->{ 'matrix' };
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub nucleotide_allpos_count_dist {
  my( $self ) = @_;
  
  my $pscm_matrix = $self->matrix();
  if( !defined( $pscm_matrix ) ) {
    confess( "Pscm not defined in $self" );
  }
  my $pscm_length = scalar( @{ $pscm_matrix } );

  my %c;
  for( my $i = 0; $i < $pscm_length; $i++ ) {
    foreach my $nucleotide( qw( A C G T ) ) {
      $c{ $nucleotide } += $pscm_matrix->[ $i ]->{ $nucleotide };
    }
  }

  return \%c;
}

sub nucleotide_allpos_prob_dist {
  my( $self ) = @_;
  
  my %c = %{ $self->nucleotide_allpos_count_dist(); };
  
  my $n = 0;
  foreach my $nucleotide( qw( A C G T ) ) 
    { $n += $c{ $nucleotide }; }

  my $add = 0;
  foreach my $nucleotide( qw( A C G T ) ) {
    if( $c{ $nucleotide } == 0 ) { $add = 1; }
  }
  
  my %p;
  foreach my $nucleotide( qw( A C G T ) ) {
    $p{ $nucleotide } 
      = ( $c{ $nucleotide } + $add / 4.0 ) / ( $n + $add );
  }

  return \%p;
}

sub pspm_matrix {
  my( $self, $bg_prob_vec, $prec, $cutoff ) = @_;

  # ----- calculate pspm matrix -----
  my @pspm_matrix;
  
  my $pscm_matrix = $self->matrix();
  for( my $i = 0; $i < scalar( @{ $pscm_matrix } ); $i++ ) 
  {
    # ----- calculate raw_p -----
    my %raw_p;
    
    my $sum = 0;
    foreach my $nucleotide( qw( A C G T ) )
      { $sum += $pscm_matrix->[ $i ]->{ $nucleotide }; }
      
    if( $sum == 0 ) {
      confess( "It is not allowed to have zeros for all A,C,G,T (pos=$i) in $self" );
    } else {
      foreach my $nucleotide( qw( A C G T ) ) {
        $raw_p{ $nucleotide } 
          = $pscm_matrix->[ $i ]->{ $nucleotide } / $sum;
      }
    }
    
    # ---- info content & sample size? -----
    my $delta = 0;
    my $rs = 0;

    foreach my $nucleotide( qw( A C G T ) ) {
      if( $pscm_matrix->[ $i ]->{ $nucleotide } > 0 ) { 
        $delta += $raw_p{ $nucleotide }
          * log( $raw_p{ $nucleotide } / $bg_prob_vec->{ $nucleotide } );
      }
      $rs += $pscm_matrix->[ $i ]->{ $nucleotide };
    }
    $delta *= 2 * $rs;

    # ----- what to add to the pspm matrix -----
    my %corrected_p;

    if( $delta <= $cutoff ) {
      %corrected_p = %{ $bg_prob_vec };
    } else {
      my $deltaw = $delta;
      my $w = 0.5;
      my $v = 0.25;
      
      while( abs($delta - $cutoff - $deltaw) > $prec ) { # XXX: strange, init: delta=deltaw, check!!!
        $deltaw = 0;
        
        foreach my $nucleotide( qw( A C G T ) ) {
          $deltaw += 
            ( (1 - $w) * $raw_p{ $nucleotide } + $w * $bg_prob_vec->{ $nucleotide } )
            * log(
              ( (1 - $w) * $raw_p{ $nucleotide } + $w * $bg_prob_vec->{ $nucleotide } )
              / $bg_prob_vec->{ $nucleotide }
            );
        }
        
        $deltaw *= 2 * $rs;
        if( $deltaw >= $delta - 1.5 ) {
          $w += $v;
        } else {
          $w -= $v;
        }
        $v *= 0.5;
      }
      
      foreach my $nucleotide( qw( A C G T ) ) {
        $corrected_p{ $nucleotide }
          = (1 - $w) * $raw_p{ $nucleotide } + $w * $bg_prob_vec->{ $nucleotide };
      }
    }

    $pspm_matrix[ $i ] = \%corrected_p;
  }

  return \@pspm_matrix;
}

##########################################################################

sub _matrix2str
{
  my( $self, $matrix ) = @_;

  my $matrix_str;
  for( my $pos = 0; $pos < scalar( @{ $matrix } ); ++$pos ) {
    $matrix_str .= ( $pos ? ", " : "" ) . $pos . ":";
    foreach my $nucleotide( keys %{ $matrix->[ $pos ] } ) {
      my $count = $matrix->[ $pos ]->{ $nucleotide };
      $matrix_str .= " " . $nucleotide . "=" . (
        defined( $count )
          ? $count
          : "?"
      )
    }
  }
  
  return $matrix_str;
}

sub _copy_matrix
{
  my( $self, $matrix ) = @_;

  if( !ref( $matrix ) ) { return undef; }

  my @copied_matrix;
  foreach my $row( @{ $matrix } ) {
    my %copied_row = %{ $row };
    push @copied_matrix, \%copied_row;
  }

  return \@copied_matrix;
}

sub _pos_shuffled_matrix
{
  my( $self, $matrix ) = @_;
  
  if( !ref( $matrix ) ) {
    croak( "Undefined matrix" );
  }

  my $copied_matrix = $self->_copy_matrix( $matrix );
  my @shuffled_matrix = BioMinerva::Base::shuffle( @{ $copied_matrix } );
  return \@shuffled_matrix;
}

sub pos_shuffled_pscm
{
  my( $self ) = @_;

  my $shuffled_matrix = 
    $self->_pos_shuffled_matrix( 
      $self->matrix() 
    );

  my $pscm = $self->pscm();
  $pscm->matrix( $shuffled_matrix );
  return $pscm;
}

##########################################################################

1;

