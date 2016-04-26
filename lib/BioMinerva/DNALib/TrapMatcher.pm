##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TrapMatcher;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Matcher;
@ISA = qw( BioMinerva::DNALib::Matcher );

##########################################################################

use BioMinerva::DNALib::TrapMatch;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::TrapMatcher();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pscm" get_id='' set_id='' link_id='' type='BioMinerva::DNALib::Pscm'>
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

###--- <scalar_property id="r0" get_id='' set_id=''>
###---   <auto:comment id="r0" md5="K7WZshnQqMIcwdwJPSQS4Q">

=head2 r0

 Title   : r0 property
 
 Usage   : $object->r0(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="r0" md5="FPeKAFBvYD65nuKhC3xo+w">

sub r0 {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'r0' } = shift @_;
  }
  return $self->{ 'r0' };
}

###---   </auto:code>
###---   <auto:code get_id="get_r0" md5="rBlmNvzI0NqLjWeP6ExDbQ">

sub get_r0 {
  return shift->{ 'r0' };
}

###---   </auto:code>
###---   <auto:code set_id="set_r0" md5="w8TrYHeYf89wgb01rjuzcw">

sub set_r0 {
  my $self = shift @_;
  $self->{ 'r0' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="lambda" get_id='' set_id='' link_id=''>
###---   <auto:comment id="lambda" md5="c1Cq61R3T8L5XJYfWmmLcQ">

=head2 lambda

 Title   : lambda property
 
 Usage   : $object->lambda(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="lambda" md5="2nUkDkI+/zSx9B7OguNHmw">

sub lambda {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'lambda' } = shift @_;
  }
  return $self->{ 'lambda' };
}

###---   </auto:code>
###---   <auto:code get_id="get_lambda" md5="DK+hugFov/CqnmDuGJ6FRA">

sub get_lambda {
  return shift->{ 'lambda' };
}

###---   </auto:code>
###---   <auto:code set_id="set_lambda" md5="93clSERgnzx9hPwHI+TLUA">

sub set_lambda {
  my $self = shift @_;
  $self->{ 'lambda' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm', $self->pscm() );
  $target->property( 'strands', $self->strands() );
  $target->property( 'r0', $self->r0() );
  $target->property( 'lambda', $self->lambda() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'pscm' );
  $target->property( 'strands' );
  $target->property( 'r0' );
  $target->property( 'lambda' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'pscm' ) { $self->pscm( @values ); }
  elsif( $property eq 'strands' ) { $self->strands( @values ); }
  elsif( $property eq 'r0' ) { $self->r0( @values ); }
  elsif( $property eq 'lambda' ) { $self->lambda( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_pscm( $registry );
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

sub score2p_value
{
  my( $self, $score ) = @_;

  my $r0 = $self->get_r0();
  if( !defined( $r0 ) ) {
    croak( "Undefined r0 in $self" );
  }
 
  if( !defined( $score ) ) { return undef; }

  my $x = $r0 * exp( -$score );
  return $x / ( 1.0 + $x );
}

##########################################################################

sub _process_sequence_seq_strand
{
  my( $self, $match_processor, $sequence, $seq, $strand ) = @_;

  my $trap_matrix = $self->_trap_matrix( $strand );
  
  my $seq_pos;
  my $seq_cur_pos;
  my $trap_pos;
  my $trap_length = scalar( @{ $trap_matrix } );
  my $score;
  my $s;
  
  my $match = new BioMinerva::DNALib::TrapMatch();
  $match->set_ref_sequence( $sequence );
  $match->set_ref_seq( $seq );
  $match->set_matcher( $self );
  $match->set_strand( $strand );

  for( $seq_pos = 0; $seq_pos < length( $seq ); ++$seq_pos ) 
  {
    # ----- score -----
    $score = 0;

    $seq_cur_pos = $seq_pos;
    for( $trap_pos = 0; $trap_pos < $trap_length; ) {
      $s = $trap_matrix->[ $trap_pos ]->{ uc( substr( $seq, $seq_cur_pos, 1 ) ) };
      if( !defined( $s ) ) { 
        if( substr( $seq, $seq_cur_pos, 1 ) eq '-' && $trap_pos ) 
          { ++$seq_cur_pos; next; }
        $score = undef;
        last;
      } else {
        $score += $s;
        ++$seq_cur_pos;
        ++$trap_pos;
      }
    }
      
    # ----- feature -----
    $match->set_start( $seq_pos );
    $match->set_end( $seq_cur_pos - 1 );
    $match->set_score( $score );
    
    $match_processor->process_match( $match );
  }
}

##########################################################################

sub _trap_matrix
{
  my( $self, $strand ) = @_;
  
  my $lambda = $self->get_lambda();
  if( !defined( $lambda ) ) {
    croak( "Undefined lambda in $self" );
  }
  
  my $pscm = $self->get_pscm();
  if( !ref( $pscm ) ) {
    croak( "Undefined pscm in $self" );
  }

  my $pseudo_count = 1; #XXX
  
  my $pscm_matrix = ( $strand < 0 )
    ? $pscm->get_complemented_matrix()
    : $pscm->get_matrix();

  my $pos2max_count = [];
  
  for( my $pos = 0; $pos < scalar( @{ $pscm_matrix } ); ++$pos ) {
    my $max_count = -1;
    foreach my $nucleotide( qw( A C G T ) ) {
      my $count = $pscm_matrix->[ $pos ]->{ $nucleotide } + $pseudo_count;
      if( !defined( $count ) ) {
        confess( "For position $pos/$nucleotide count is not defined in $pscm" );
      }
      if( $max_count < $count ) { $max_count = $count; }
    }
    $pos2max_count->[ $pos ] = $max_count;
  }

  my $trap_matrix = [];
  
  for( my $pos = 0; $pos < scalar( @{ $pscm_matrix } ); ++$pos ) {
    my $max_count = $pos2max_count->[ $pos ];
    foreach my $nucleotide( qw( A C G T ) ) {
      my $count = $pscm_matrix->[ $pos ]->{ $nucleotide } + $pseudo_count;
      $trap_matrix->[ $pos ] ||= {};
      $trap_matrix->[ $pos ]->{ $nucleotide } = -log( $count / $max_count ) / $lambda;
    }
  }

  return $trap_matrix;
}

##########################################################################

1;
