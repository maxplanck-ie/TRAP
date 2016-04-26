# $Id: PssmScoreDistFactory.pm,v 1.1 2006/11/01 09:27:57 kielbasa Exp $
#
# BioMinerva module for BioMinerva::Factory::CRM::PssmAnnotatorFromPssm
#
# Cared for by Steffen Grossmann <grossman@molgen.mpg.de>
#
# Copyright Steffen Grossmann
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

BioMinerva::Factory::CRM::PssmAnnotatorFromPssm - A factory to create
BioMinerva::CRM::PssmAnnotator objects from BioMinerva::CRM::Pssm
objects.

=head1 SYNOPSIS

Start by creating the factory. Set desired parameters here!

   use BioMinerva::Factory::CRM::PssmAnnotatorFromPssm;

   my $annofac = BioMinerva::Factory::CRM::PssmAnnotatorFromPssm->new
                   (-pvalue => 0.05,
                    -type_I_seqlength => 500,
                    -type_II_instances => 1,
		    -cutoff_to_use => 'type_I');

Get a BioMinerva::CRM::Pssm object somehow (maybe by using other factories)

   my $pssm;

Create BioMinerva::CRM::PssmAnnotator from it.

   my $pssmanno = $annofac->create($pssm);


=head1 DESCRIPTION

This factory is an object which can create
BioMinerva::CRM::PssmAnnotator objects from BioMinerva::CRM::Pssm
objects. Whereas the latter only represent raw PSSMs, the former bring
the full functionality for sequence scanning. To this end, a lot of
statistical calculations have to be carried out by the factory.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
BioMinerva modules. Your participation is much appreciated.

=head1 AUTHOR - Steffen Grossmann

Email grossman@molgen.mpg.de

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...
##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PssmScoreDistFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use Carp qw( confess carp croak );
use Math::DiscreteDistribution;
use BioMinerva::Base::FileCache;
use BioMinerva::Base::DirCache;
use BioMinerva::DNALib::PssmScoreDist;
use BioMinerva::Base::InfoViewer;
use BioMinerva::Base::ProgressInfo;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::PssmScoreDistFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='cutoff_name' get_id='' set_id=''>
###---   <auto:comment id="cutoff_name" md5="mnqMaJPgrHtg/X1S5yawyw">

=head2 cutoff_name

 Title   : cutoff_name property
 
 Usage   : $object->cutoff_name(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cutoff_name" md5="Ss7vUuhFPZyliX5Vx/yK0Q">

sub cutoff_name {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cutoff_name' } = shift @_;
  }
  return $self->{ 'cutoff_name' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cutoff_name" md5="TSymldvd5t8Fgl1gYbx3PQ">

sub get_cutoff_name {
  return shift->{ 'cutoff_name' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cutoff_name" md5="seaVwuoOtD1chTnJMYa7fg">

sub set_cutoff_name {
  my $self = shift @_;
  $self->{ 'cutoff_name' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='t1n' get_id='' set_id=''>
###---   <auto:comment id="t1n" md5="g8SBa4xCBjWDTf6Zmyd4PA">

=head2 t1n

 Title   : t1n property
 
 Usage   : $object->t1n(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="t1n" md5="aECkZufuEMMGY2qrOrJgOQ">

sub t1n {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 't1n' } = shift @_;
  }
  return $self->{ 't1n' };
}

###---   </auto:code>
###---   <auto:code get_id="get_t1n" md5="qQRG9S0p/aKJIMo8+czhwQ">

sub get_t1n {
  return shift->{ 't1n' };
}

###---   </auto:code>
###---   <auto:code set_id="set_t1n" md5="IvhDb0PmmXPLNuYmQEigdA">

sub set_t1n {
  my $self = shift @_;
  $self->{ 't1n' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='t2m' get_id='' set_id=''>
###---   <auto:comment id="t2m" md5="fbqiUnW7t02dH8Qwv29cqQ">

=head2 t2m

 Title   : t2m property
 
 Usage   : $object->t2m(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="t2m" md5="IghywlPIhfKQukKzyeLRCQ">

sub t2m {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 't2m' } = shift @_;
  }
  return $self->{ 't2m' };
}

###---   </auto:code>
###---   <auto:code get_id="get_t2m" md5="aLJ1zDC6g8dm5LdFX8xNZA">

sub get_t2m {
  return shift->{ 't2m' };
}

###---   </auto:code>
###---   <auto:code set_id="set_t2m" md5="GOLBcKh5IvFZ2eH5jHOxew">

sub set_t2m {
  my $self = shift @_;
  $self->{ 't2m' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='pvalue' get_id='' set_id=''>
###---   <auto:comment id="pvalue" md5="Bx13vL1h9E6w7LnWYcv1Bg">

=head2 pvalue

 Title   : pvalue property
 
 Usage   : $object->pvalue(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pvalue" md5="ZS+e8z0mQJzCRB+iszW0DA">

sub pvalue {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pvalue' } = shift @_;
  }
  return $self->{ 'pvalue' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pvalue" md5="LtY3y2NBioqcI5BsUmw56A">

sub get_pvalue {
  return shift->{ 'pvalue' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pvalue" md5="0bCdaDG4R3lFVFRxT2qK2A">

sub set_pvalue {
  my $self = shift @_;
  $self->{ 'pvalue' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='epsilon' get_id='_get_epsilon' set_id=''>
###---   <auto:comment id="epsilon" md5="1hiMl3iaJ7krrMYvKo/kaQ">

=head2 epsilon

 Title   : epsilon property
 
 Usage   : $object->epsilon(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="epsilon" md5="hnJY/MG7dgJ8zK1kjLDD/w">

sub epsilon {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'epsilon' } = shift @_;
  }
  return $self->{ 'epsilon' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_epsilon" md5="PE5kKZHjJdU93vuJU80Y5w">

sub _get_epsilon {
  return shift->{ 'epsilon' };
}

###---   </auto:code>
###---   <auto:code set_id="set_epsilon" md5="gxhw9SlTxqsyNlLKIwtrcA">

sub set_epsilon {
  my $self = shift @_;
  $self->{ 'epsilon' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="cache" get_id="" set_id="" link_id="" type="BioMinerva::Base::Cache">
###---   <auto:comment id="cache" md5="3kOEDljBE8sswmQg2RTsnQ">

=head2 cache

 Title   : cache property
 
 Usage   : $object->cache(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cache" md5="LJrSpqSu7SrbkDOYQEz2Cw">

sub cache {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cache' } = shift @_;
  }
  return $self->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cache" md5="sNbj7L09T3yplxvvYxRswA">

sub get_cache {
  return shift->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cache" md5="4imknzaQxLx3YpnQdSAhdQ">

sub set_cache {
  my $self = shift @_;
  $self->{ 'cache' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_cache" md5="x9nExR+XV4n0gEzzuyH1iA">

sub link_cache {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'cache' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'cache' } =
      $registry->type_id2object(
        'BioMinerva::Base::Cache', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub get_epsilon
{
  my( $self ) = @_;
  
  my $epsilon = $self->_get_epsilon();
  if( !defined( $epsilon ) ) { $epsilon = 0.05; }
  return $epsilon;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'cutoff_name', $self->cutoff_name() );
  $target->property( 't1n', $self->t1n() );
  $target->property( 't2m', $self->t2m() );
  $target->property( 'pvalue', $self->pvalue() );
  $target->property( 'epsilon', $self->epsilon() );
  $target->property( 'cache', $self->cache() );
}

##########################################################################

sub _get_default_cache
{
  my( $self ) = @_;

  my $cache = $self->get_cache();
  if( ref( $cache ) ) {
    return $cache;
  } elsif( defined( $cache ) && !$cache ) {
    return undef;
  }

  our $local_cache;
  if( !ref( $local_cache ) ) {
    $local_cache = BioMinerva::Base::DirCache::file2default_cache(
      '/tmp/PssmScoreDistFactory'
    );
  }
  return $local_cache;
}

##########################################################################

sub cutoff {
  my( $self, $pssm, $pspm ) = @_;

  my $calc = $self->_pssm_pspm( $pssm, $pspm );
  
  my $cutoff_name = $self->get_cutoff_name();
  if( !defined( $cutoff_name ) ) {
    croak( "Undefined cutoff_name in $self" );
  } elsif( $cutoff_name eq 'balanced' ) {
    return $calc->{ 'balanced_cutoff' };
  } elsif( $cutoff_name eq 'type_I' ) {
    return $calc->{ 'type_I_cutoff' };
  } elsif( $cutoff_name eq 'type_II' ) {
    return $calc->{ 'type_II_cutoff' };
  } else {
    croak( "Unknown cutoff_name '$cutoff_name' in $self" );
  }
}

sub score_dist {
  my( $self, $pssm, $pspm ) = @_;
  
  my $calc = $self->_pssm_pspm( $pssm, $pspm );

  my $score_dist = new BioMinerva::DNALib::PssmScoreDist();
  $score_dist->set_pdf( $calc->{ 'bg_score_dist' } );
  $score_dist->set_epsilon( $self->get_epsilon() );

  return $score_dist;
}

##########################################################################

sub _normalize_vs_shuffling
{
  my( $self, $pssm_matrix, $pspm_matrix ) = @_;

  my @strs;
  for( my $i = 0; $i < scalar( @{ $pssm_matrix } ); ++$i ) {
    my $str = 
      join( ":", 
        ( map { $pssm_matrix->[ $i ]->{ $_ } } qw( A C G T ) ),
        ( map { $pspm_matrix->[ $i ]->{ $_ } } qw( A C G T ) )
      );
    push @strs, $str;
  }

  return sort( @strs );
}

sub _pssm_pspm {
  my( $self, $pssm, $pspm ) = @_;

  # ----- init -----
  my $pssm_matrix = $pssm->matrix();
  my $pspm_matrix = $pspm->matrix();

  if( !defined( $pssm_matrix ) )
    { confess( "pssm_matrix undefined." ); }
  if( !defined( $pspm_matrix ) )
    { confess( "pspm_matrix undefined." ); }
 
  my $t1n = $self->get_t1n(); #TODO: move defaults
  if( !defined( $t1n ) ) { $t1n = 500; }
  
  my $t2m = $self->get_t2m();
  if( !defined( $t2m ) ) { $t2m = 1; }

  my $pvalue = $self->get_pvalue();
  if( !defined( $pvalue ) ) { $pvalue = 0.05; }
  
  my $epsilon = $self->get_epsilon();
  
  my $bg_prob_vec = $pssm->get_bg_prob_vec();
  if( !defined( $bg_prob_vec ) ) 
    { confess( "Undefined bg_prob_vec in PSSM matrix $pssm" ); }
    
  my $ret;

  my $cache = $self->_get_default_cache();
  my $cache_digest;
  
  if( ref( $cache ) ) {
    $cache_digest = $cache->cache_digest( 'PssmScoreDistFactory' );
    $cache_digest->add( $self->_normalize_vs_shuffling( $pssm_matrix, $pspm_matrix ) );
    $cache_digest->add( $bg_prob_vec );
    $cache_digest->add( [ $t1n, $t2m, $pvalue, $epsilon ] );
  }
    
  if( !ref( $cache ) || !$cache->peek( $cache_digest, \$ret ) ) 
  {
    my $progress_info = new BioMinerva::Base::ProgressInfo();
    $progress_info->set_title( "Calculating score thresholds (id='" . $pssm->display_id() . "')" );
    $progress_info->set_rotating_char_attr( "tick" );

    my $info_viewer = BioMinerva::Base::InfoViewer::global();
    $info_viewer->push_info( $progress_info );
#TODO: try
    {
      # ----- distributions -----
      my $bg_score_dist = $self->_calc_bg_score_dist( $pssm_matrix, $bg_prob_vec, $epsilon );
      my $sig_score_dist = $self->_calc_sig_score_dist( $pssm_matrix, $pspm_matrix, $epsilon );
     
      # ----- cutoffs -----
      my( 
        $type_I_cutoff, $type_I_quality,
        $type_II_cutoff, $type_II_quality,
        $balanced_cutoff, $balanced_quality 
      ) = @{ $self->_calc_cutoffs(
        $bg_score_dist, $sig_score_dist, $t1n, $t2m, $pvalue, $epsilon
      ) };

      # ----- return -----
      $ret = {
        'type_I_cutoff' => $type_I_cutoff,
        'balanced_cutoff' => $balanced_cutoff,
        'type_II_cutoff' => $type_II_cutoff,

        'type_I_quality' => $type_I_quality,
        'balanced_quality' => $balanced_quality,
        'type_II_quality' => $type_II_quality,

        'bg_score_dist' => $bg_score_dist,
        'sig_score_dist' => $sig_score_dist
      };
    }
#TODO: catch:
    $info_viewer->pop_info();
    
    if( ref( $cache ) ) { 
      $cache->poke( $cache_digest, $ret );
    }
  }

  return $ret;
}

##########################################################################

# distribution of scores which one obtains matching sequences
# generated by random sequence model

sub _calc_bg_score_dist
{
  my( $self, $pssm_matrix, $bg_prob_vec, $epsilon ) = @_;

  # ----- at least one column in the matrices -----
  my $len = scalar( @{ $pssm_matrix } );
  if( $len <= 0 ) {
    confess( "length of pssm_matrix ($pssm_matrix) <= 0 ($len)" );
  }

  my $dist;
  {
    # ----- taking the score distribution at the first position as a start -----
    my @weights = map { $bg_prob_vec->{ $_ } } qw( A C G T );
    my @scores = map { 
      POSIX::floor( $pssm_matrix->[ 0 ]->{ $_ } / $epsilon + 0.5 )
    } qw( A C G T );
    $dist = new Math::DiscreteDistribution( 
      -values => \@scores, -weights => \@weights
    );
    
    # ----- convoluting with the score distributions at the other positions -----
    for( my $i = 1; $i < $len; $i++ ) {
      @scores = map { 
        POSIX::floor( $pssm_matrix->[ $i ]->{ $_ } / $epsilon + 0.5 )
      } qw( A C G T );
      my $tmp_dist = new Math::DiscreteDistribution(
        -values => \@scores, -weights => \@weights 
      );
      $dist = $dist->convolute( $tmp_dist );
    }
  }
  
  return $dist;
}

##########################################################################

# distribution of scores which one obtains matching sequences
# generated by sequence model matching the matrix (so in principle
# sequences, which should be good binding sites)

sub _calc_sig_score_dist
{
  my( $self, $pssm_matrix, $pspm_matrix, $epsilon ) = @_;
 
  # ----- at least one column in the matrices -----
  my $len = scalar( @{ $pssm_matrix } );
  if( $len <= 0 ) {
    confess( "length of pssm_matrix ($pssm_matrix) <= 0 ($len)" );
  }

  my $dist;
  {
    # ----- taking the score distribution at the first position as a start -----
    my @weights = map { $pspm_matrix->[ 0 ]->{ $_ } } qw( A C G T );
    my @scores = map { 
      POSIX::floor( $pssm_matrix->[ 0 ]->{ $_ } / $epsilon + 0.5 )
    } qw( A C G T );
    $dist = new Math::DiscreteDistribution(
      -values => \@scores, -weights => \@weights 
    );

    # ----- convoluting with the score distributions at the other positions -----
    for( my $i = 1; $i < $len; $i++ ) {
      @weights = map { $pspm_matrix->[ $i ]->{ $_ } } qw( A C G T );
      @scores = map { 
        POSIX::floor( $pssm_matrix->[ $i ]->{ $_ } / $epsilon + 0.5 )
      } qw( A C G T );
      my $tmp_dist = new Math::DiscreteDistribution(
        -values => \@scores, -weights => \@weights 
      );
      $dist = $dist->convolute( $tmp_dist );
    }
  }

  return $dist;
}

##########################################################################

sub _calc_cutoffs
{
  my( $self, $bg_score_dist, $sig_score_dist, $n, $m, $p, $epsilon ) = @_;

  my $ret;
  {
    # we need an array holding all values which appear in one or the other distribution
    my @bg_scores = @{ $bg_score_dist->get_values() };
    my @sig_scores = @{ $sig_score_dist->get_values() };
    my @all_scores;

    {
      my %seen_vals;
      map { $seen_vals{ $_ } = 1 } ( @bg_scores, @sig_scores );
      @all_scores = sort { $a <=> $b } keys( %seen_vals );
    }

    my $type_I_cutoff = undef;
    my $type_I_quality;
    my $type_II_cutoff = undef;
    my $type_II_quality;
    my $balanced_cutoff = undef;
    my $balanced_quality;
    my $not_done = 3;
    
    foreach my $s( @all_scores ) {
      my $alpha = 1 - $bg_score_dist->pdf( $s );
      my $alpha_n = 1 - exp( -1 * $n * $alpha );
      my $beta = $sig_score_dist->pdf( $s ) - $sig_score_dist->pwf( $s );
      my $beta_m = 1 - ( 1 - $beta )**$m;

      if( !defined( $type_I_cutoff ) ) {
        if( $alpha_n < $p ) {
          $type_I_cutoff = $s;
          $type_I_quality = $alpha_n;
          --$not_done;
        }
      }
      
      if( !defined( $type_II_cutoff ) ) {
        if( $beta_m > $p ) {
          $type_II_cutoff = $s;
          $type_II_quality = $beta_m;
          --$not_done;
        }
      }
      
      if( !defined( $balanced_cutoff ) ) {
        if( $alpha_n < $beta_m ) {
          $balanced_cutoff = $s;
#          $balanced_quality = $alpha_n;
          $balanced_quality = $beta_m;
          --$not_done;
        }
      }

      if( !$not_done ) { last; }
    }

    $ret = [
      $type_I_cutoff * $epsilon, $type_I_quality,
      $type_II_cutoff * $epsilon, $type_II_quality,
      $balanced_cutoff * $epsilon, $balanced_quality 
    ];
  }
  
  return $ret;
}

##########################################################################

1;
