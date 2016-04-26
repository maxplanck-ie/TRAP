##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Match;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::StrandedRange;
@ISA = qw( BioMinerva::DNALib::StrandedRange );

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

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='ref_sequence' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::Sequence'>
###---   <auto:comment id="ref_sequence" md5="Bqox8lo0XlR2orrBILeHYA">

=head2 ref_sequence

 Title   : ref_sequence property
 
 Usage   : $object->ref_sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ref_sequence" md5="iBlrc3ARl++nIWQoLgSALQ">

sub ref_sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ref_sequence' } = shift @_;
  }
  return $self->{ 'ref_sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ref_sequence" md5="E2HGvu51pNLhBVhdq36lKg">

sub get_ref_sequence {
  return shift->{ 'ref_sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ref_sequence" md5="ZCYerqqQ5XvzQQ4pvIIVFQ">

sub set_ref_sequence {
  my $self = shift @_;
  $self->{ 'ref_sequence' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_ref_sequence" md5="qBSGxRADJSJmbKoJdVqSgw">

sub link_ref_sequence {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'ref_sequence' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'ref_sequence' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::Sequence', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='ref_seq' get_id='' set_id=''>
###---   <auto:comment id="ref_seq" md5="0hr0k35E9kDiwSkvW0pJXA">

=head2 ref_seq

 Title   : ref_seq property
 
 Usage   : $object->ref_seq(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ref_seq" md5="3OcomV6GiLUU/yCI8mJEnA">

sub ref_seq {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ref_seq' } = shift @_;
  }
  return $self->{ 'ref_seq' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ref_seq" md5="z8yt1brYCe/dTEeQAF82PA">

sub get_ref_seq {
  return shift->{ 'ref_seq' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ref_seq" md5="/GP7YKW9wfuU8jaiUBoOPg">

sub set_ref_seq {
  my $self = shift @_;
  $self->{ 'ref_seq' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='matcher' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::Matcher'>
###---   <auto:comment id="matcher" md5="DIX/D2N8iVU9LsEggShT3w">

=head2 matcher

 Title   : matcher property
 
 Usage   : $object->matcher(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="matcher" md5="pn0RyPE+VO0Xij4J54sqYQ">

sub matcher {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'matcher' } = shift @_;
  }
  return $self->{ 'matcher' };
}

###---   </auto:code>
###---   <auto:code get_id="get_matcher" md5="4zxux/eLpPfGmoF3cTXyUg">

sub get_matcher {
  return shift->{ 'matcher' };
}

###---   </auto:code>
###---   <auto:code set_id="set_matcher" md5="MrKA+wxhvBYPGh9nuqZzkA">

sub set_matcher {
  my $self = shift @_;
  $self->{ 'matcher' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_matcher" md5="fC3Aq2Uh87JPpvpywJdjIg">

sub link_matcher {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'matcher' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'matcher' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::Matcher', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='score' get_id='' set_id=''>
###---   <auto:comment id="score" md5="exAYSJKyOxD3I73XTtAFSw">

=head2 score

 Title   : score property
 
 Usage   : $object->score(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="score" md5="HCG1sDgbdQCrNIeKS4B29Q">

sub score {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'score' } = shift @_;
  }
  return $self->{ 'score' };
}

###---   </auto:code>
###---   <auto:code get_id="get_score" md5="APdYZo5eMFi/rdwrLQuhYw">

sub get_score {
  return shift->{ 'score' };
}

###---   </auto:code>
###---   <auto:code set_id="set_score" md5="Rnc+CeD/TTvz8K20COQOXw">

sub set_score {
  my $self = shift @_;
  $self->{ 'score' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( "ref_sequence", $self->ref_sequence() );
  $target->property( "matcher", $self->matcher() );
  $target->property( "score", $self->score() );
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  my $ref_sequence = $self->get_ref_sequence();
  $digest->add( ref( $ref_sequence ) ? $ref_sequence->digest_id() : '' );
  my $matcher = $self->get_matcher();
  $digest->add( ref( $matcher ) ? $matcher->digest_id() : '' );
  $digest->add( $self->get_score() || '' );
  
  return $digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub seq
{
  my( $self ) = @_;

  my $start = $self->get_start();
  return substr( 
    $self->get_ref_seq(), 
    $self->get_start(),
    $self->length()
  );
}

sub sequence
{
  my( $self ) = @_;

  my $sequence = $self->get_ref_sequence()->relative_sequence(
    $self->get_start(),
    $self->get_end(),
    ( $self->get_strand() < 0 ) ? 1 : 0
  );
  $sequence->set_id( $self->get_id() );
  $sequence->add_attr( 'matcher', $self->get_matcher()->get_id() );

  return $sequence;
}

sub p_value
{
  my( $self ) = @_;

  return $self->get_matcher()->score2p_value( $self->get_score() );
}

##########################################################################

1;
