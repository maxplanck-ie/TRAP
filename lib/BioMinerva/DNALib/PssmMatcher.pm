##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PssmMatcher;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Matcher;
@ISA = qw( BioMinerva::DNALib::Matcher );

##########################################################################

use BioMinerva::DNALib::PssmMatch;
use Carp qw( confess carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub pssm_matcher {
  my( $self ) = @_;

  my $matcher = new BioMinerva::DNALib::PssmMatcher();
  $matcher->set_pssm( $self->get_pssm() );
  $matcher->set_strands( $self->get_strands() );
  $matcher->set_cutoff( $self->get_cutoff() );
  $matcher->set_score_dist( $self->get_score_dist() );

  return $matcher;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pssm" get_id='' set_id='' link_id='' type='BioMinerva::DNALib::Pssm'>
###---   <auto:comment id="pssm" md5="HxiVY65h9TdplfrKUM2J4w">

=head2 pssm

 Title   : pssm property
 
 Usage   : $object->pssm(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm" md5="RO4JrjspgmxwuNMyKe80VA">

sub pssm {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm' } = shift @_;
  }
  return $self->{ 'pssm' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm" md5="dAhKB1to+ms2MP4wOsCN3Q">

sub get_pssm {
  return shift->{ 'pssm' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm" md5="rGlziWuAwxZmKZbXAO9u3g">

sub set_pssm {
  my $self = shift @_;
  $self->{ 'pssm' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pssm" md5="/lw2fopCzr9/g3IdwhTRJA">

sub link_pssm {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pssm' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pssm' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::Pssm', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="strands" get_id='' set_id=''>
###---   <auto:comment id="strands" md5="aMTHU2PzgpDRxSU80f0eRA">

=head2 strands

 Title   : strands property
 
 Usage   : $object->strands(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="strands" md5="PeIYQ+LCYQTjBtcBUhTIjw">

sub strands {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'strands' } = shift @_;
  }
  return $self->{ 'strands' };
}

###---   </auto:code>
###---   <auto:code get_id="get_strands" md5="xNTXmF3qu/pVSul+xohrLQ">

sub get_strands {
  return shift->{ 'strands' };
}

###---   </auto:code>
###---   <auto:code set_id="set_strands" md5="DKFfaDmLYglwppBxhAApXw">

sub set_strands {
  my $self = shift @_;
  $self->{ 'strands' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="cutoff" get_id='' set_id=''>
###---   <auto:comment id="cutoff" md5="bTXq2jMxBZgJCyKc0fwjNQ">

=head2 cutoff

 Title   : cutoff property
 
 Usage   : $object->cutoff(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cutoff" md5="uyTQ+0zzTaj3E1dUlrcJ/Q">

sub cutoff {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cutoff' } = shift @_;
  }
  return $self->{ 'cutoff' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cutoff" md5="33q4n8XOX4qDnQkFPwneow">

sub get_cutoff {
  return shift->{ 'cutoff' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cutoff" md5="fwL9+c7qrTUINin4GLJd+w">

sub set_cutoff {
  my $self = shift @_;
  $self->{ 'cutoff' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="score_dist" get_id='' set_id='' link_id='' type='BioMinerva::DNALib::PssmScoreDist'>
###---   <auto:comment id="score_dist" md5="H62roYj70N1f0nvbrRGE/g">

=head2 score_dist

 Title   : score_dist property
 
 Usage   : $object->score_dist(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="score_dist" md5="CZ85WEmYug7bkR8NEHqP4w">

sub score_dist {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'score_dist' } = shift @_;
  }
  return $self->{ 'score_dist' };
}

###---   </auto:code>
###---   <auto:code get_id="get_score_dist" md5="lJ4i1M5Y1uqRYg3DD8vNCg">

sub get_score_dist {
  return shift->{ 'score_dist' };
}

###---   </auto:code>
###---   <auto:code set_id="set_score_dist" md5="RAJg8duDwGk6QUVIKyX94A">

sub set_score_dist {
  my $self = shift @_;
  $self->{ 'score_dist' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_score_dist" md5="bzHE0ew7r9lT+TU/3Fsm2Q">

sub link_score_dist {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'score_dist' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'score_dist' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PssmScoreDist', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pssm', $self->pssm() );
  $target->property( 'strands', $self->strands() );
  $target->property( 'cutoff', $self->cutoff() );
  $target->property( 'score_dist', $self->score_dist() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_sequence_seq
{
  my( $self, $match_processor, $sequence, $seq ) = @_;

  my $strands = $self->get_strands();
  if( !$strands || $strands > 0 ) {
    $self->_process_sequence_seq_strand(
      $match_processor, $sequence, $seq, +1 
    );
  }
  if( !$strands || $strands < 0 ) {
    $self->_process_sequence_seq_strand(
      $match_processor, $sequence, $seq, -1 
    );
  }
}

sub max_num_of_matches
{
  my( $self, $sequence ) = @_;
  
  my $strands = $self->get_strands();
  if( !$strands ) {
    confess( "max_num_of_matches is ill-defined when !strands in $self" );
  }

  my $pssm = $self->get_pssm();
  if( !ref( $pssm ) ) {
    croak( "Undefined pssm in $self" );
  }
  
  return $sequence->length() - $pssm->length() + 1;
}

sub score2p_value
{
  my( $self, $score ) = @_;

  my $score_dist = $self->get_score_dist();
  if( !ref( $score_dist ) ) {
    croak( "Undefined score_dist in $self" );
  }
  
  return $score_dist->p_value( $score );
}

##########################################################################

sub pos_shuffled_matcher
{
  my( $self ) = @_;

  my $pssm = $self->get_pssm();
  if( !ref( $pssm ) ) {
    croak( "Undefined pssm in $self" );
  }
  
  my $matcher = $self->pssm_matcher();
  $matcher->set_pssm( $pssm->pos_shuffled_pssm() );
  return $matcher;
}

##########################################################################

sub _process_sequence_seq_strand
{
  my( $self, $match_processor, $sequence, $seq, $strand ) = @_;

  my $pssm = $self->get_pssm();
  if( !ref( $pssm ) ) {
    croak( "Undefined pssm in $self" );
  }

  my $pssm_matrix = ( $strand < 0 )
    ? $pssm->get_complemented_matrix()
    : $pssm->get_matrix();
  my $pssm_length = scalar( @{ $pssm_matrix } );
  my $cutoff = $self->get_cutoff();
  
  my $seq_pos;
  my $seq_cur_pos;
  my $pssm_pos;
  my $score;
  my $s;
  
  my $match = new BioMinerva::DNALib::PssmMatch();
  $match->set_ref_sequence( $sequence );
  $match->set_ref_seq( $seq );
  $match->set_matcher( $self );
  $match->set_strand( $strand );
  
  for( $seq_pos = 0; $seq_pos < length( $seq ); ++$seq_pos ) 
  {
    # ----- score -----
    $score = 0;

    $seq_cur_pos = $seq_pos;
    for( $pssm_pos = 0; $pssm_pos < $pssm_length; ) {
      $s = $pssm_matrix->[ $pssm_pos ]->{ uc( substr( $seq, $seq_cur_pos, 1 ) ) };
      if( !defined( $s ) ) { 
        if( substr( $seq, $seq_cur_pos, 1 ) eq '-' && $pssm_pos ) 
          { ++$seq_cur_pos; next; }
        $score = undef;
        last;
      } else {
        $score += $s;
        ++$seq_cur_pos;
        ++$pssm_pos;
      }
    }
      
    # ----- threshold -----
    if( !defined( $score ) ) { next; }
    elsif( $score < $cutoff ) { next; }
    
    # ----- feature -----
    $match->set_start( $seq_pos );
    $match->set_end( $seq_cur_pos - 1 );
    $match->set_score( $score );
    
    $match_processor->process_match( $match );
  }
}

##########################################################################

1;
