##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::IupacMatcher;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Matcher;
@ISA = qw( BioMinerva::DNALib::Matcher );

##########################################################################

use BioMinerva::DNALib::IupacMatch;
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

###--- <scalar_property id="iupac_str" get_id='' set_id=''>
###---   <auto:comment id="iupac_str" md5="QBCNUR8cs8Hd2Ca5m7v4Zg">

=head2 iupac_str

 Title   : iupac_str property
 
 Usage   : $object->iupac_str(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="iupac_str" md5="61gPLxy7MkK52MuVUBpsbA">

sub iupac_str {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'iupac_str' } = shift @_;
  }
  return $self->{ 'iupac_str' };
}

###---   </auto:code>
###---   <auto:code get_id="get_iupac_str" md5="W1nOIoi65vGi2AwpcdfZJw">

sub get_iupac_str {
  return shift->{ 'iupac_str' };
}

###---   </auto:code>
###---   <auto:code set_id="set_iupac_str" md5="MS7lWahWHkENYUO2jLu4ZA">

sub set_iupac_str {
  my $self = shift @_;
  $self->{ 'iupac_str' } = shift @_;
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

###--- <scalar_property id="mismatches" get_id='' set_id=''>
###---   <auto:comment id="mismatches" md5="fKYgme6thmOYZPXi3xFMFQ">

=head2 mismatches

 Title   : mismatches property
 
 Usage   : $object->mismatches(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="mismatches" md5="agLc28W2FM4MAPlDCt75Dg">

sub mismatches {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'mismatches' } = shift @_;
  }
  return $self->{ 'mismatches' };
}

###---   </auto:code>
###---   <auto:code get_id="get_mismatches" md5="tUjzjdo57aravnFteeQOKg">

sub get_mismatches {
  return shift->{ 'mismatches' };
}

###---   </auto:code>
###---   <auto:code set_id="set_mismatches" md5="u3jeO2TLJP44B4ho1MkRHg">

sub set_mismatches {
  my $self = shift @_;
  $self->{ 'mismatches' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'iupac_str', $self->iupac_str() );
  $target->property( 'strands', $self->strands() );
  $target->property( 'mismatches', $self->mismatches() );
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

  confess( "Not implemented yet in $self" );
}

sub score2p_value
{
  my( $self, $score ) = @_;

  confess( "Not implemented yet in $self" );
}

##########################################################################

sub _iupac_complement
{
  my( $self, $iupac ) = @_;

  $iupac = reverse( $iupac );
  $iupac =~ tr/ACGTWRKSYMBHDVN/TGCAWYMSRKVDHBN/;
  return $iupac;
}

my %iupac_letters2bits = (
  "A" => 1, "C" => 2, "G" => 4, "T" => 8,
  "W" => 9, "R" => 5, "K" => 12, "S" => 6, "Y" => 10, "M" => 3,
  "B" => 14, "H" => 11, "D" => 13, "V" => 7,
  "N" => 15
);

my %iupac_bits2letters = (
 1  => "A", 2  => "C", 4  => "G", 8  => "T",
 9  => "W", 5  => "R", 12 => "K", 6  => "S", 10 => "Y", 3  => "M", 
 14 => "B", 11 => "H", 13 => "D", 7  => "V",
 15 => "N"
);

sub _iupac_letter_matches
{
  my( $self, $letter, $pattern ) = @_;
  my $l = $iupac_letters2bits{ $letter } || 0x00; 
  my $p = $iupac_letters2bits{ $pattern } || 0x00; 
  return ( $l & $p ) && !( $l & (0xF - $p) );
}

sub _process_sequence_seq_strand
{
  my( $self, $match_processor, $sequence, $seq, $strand ) = @_;

  my $iupac_str = $self->get_iupac_str();
  if( !defined( $iupac_str ) ) {
    croak( "Undefined iupac_str in $self" );
  }

  my @iupac = split( //, ( $strand < 0 )
    ? $self->_iupac_complement( $iupac_str )
    : $iupac_str
  );
  my $iupac_length = scalar( @iupac );
  
  my $seq_pos;
  my $seq_cur_pos;
  my $mismatches;
  my $iupac_pos;
  my $score;
  my $c;
  
  my $match = new BioMinerva::DNALib::IupacMatch();
  $match->set_ref_sequence( $sequence );
  $match->set_ref_seq( $seq );
  $match->set_matcher( $self );
  $match->set_strand( $strand );
    
  for( $seq_pos = 0; $seq_pos < length( $seq ); ++$seq_pos ) 
  {
    $score = 0;
    $mismatches = $self->get_mismatches() || 0;

    $seq_cur_pos = $seq_pos;
    $iupac_pos = 0;
    
    while( $iupac_pos < $iupac_length ) {
      $c = uc( substr( $seq, $seq_cur_pos, 1 ) );
      if( !defined( $c ) ) {
        $score = undef; last;
      } elsif( $c eq '-' && $iupac_pos ) { 
        ++$seq_cur_pos; next; 
      }
      if( !$self->_iupac_letter_matches( $c, $iupac[ $iupac_pos ] ) ) {
        if( $mismatches <= 0 ) {
          $score = undef; last;
        }
        --$mismatches;
      } else {
        ++$score;
      }
      if( ++$seq_cur_pos >= length( $seq ) ) {
        $score = undef; last;
      }
      ++$iupac_pos;
    }
      
    # ----- threshold -----
    if( !defined( $score ) ) { next; }
    
    # ----- feature -----
    $match->set_start( $seq_pos );
    $match->set_end( $seq_cur_pos - 1 );
    $match->set_score( $score );
    
    $match_processor->process_match( $match );
  }
}

##########################################################################

1;
