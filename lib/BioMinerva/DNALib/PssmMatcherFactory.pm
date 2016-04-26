##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PssmMatcherFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatcherFactory;
@ISA = qw( BioMinerva::DNALib::MatcherFactory );

use BioMinerva::DNALib::PssmMatcher;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub pssm_matcher_factory {
  my( $self ) = @_;

  my $factory = new BioMinerva::DNALib::PssmMatcherFactory();
  $factory->set_pssm_score_dist_factory( $self->get_pssm_score_dist_factory() );
  $factory->set_pssm_factory( $self->get_pssm_factory() );
  $factory->set_strands( $self->get_strands() );
  $factory->set_cutoff( $self->get_cutoff() );

  return $factory;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pssm_score_dist_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PssmScoreDistFactory'>
###---   <auto:comment id="pssm_score_dist_factory" md5="276vBpGLOIbOfPAdXEjbmQ">

=head2 pssm_score_dist_factory

 Title   : pssm_score_dist_factory property
 
 Usage   : $object->pssm_score_dist_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_score_dist_factory" md5="bboTX/MjbN2fJjhqtyLn3Q">

sub pssm_score_dist_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_score_dist_factory' } = shift @_;
  }
  return $self->{ 'pssm_score_dist_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm_score_dist_factory" md5="NL6K7pBaXGqPQ7Jxcgi9Tw">

sub get_pssm_score_dist_factory {
  return shift->{ 'pssm_score_dist_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm_score_dist_factory" md5="cbylCTyTlufj+8/woJuMKA">

sub set_pssm_score_dist_factory {
  my $self = shift @_;
  $self->{ 'pssm_score_dist_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pssm_score_dist_factory" md5="Xk3DRa7iPBivlfxf0TD0jg">

sub link_pssm_score_dist_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pssm_score_dist_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pssm_score_dist_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PssmScoreDistFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pssm_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PssmFactory'>
###---   <auto:comment id="pssm_factory" md5="awwO6csVHX/Nl5YmALt/CQ">

=head2 pssm_factory

 Title   : pssm_factory property
 
 Usage   : $object->pssm_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_factory" md5="T104AFB28a2j+ZEoIfsh4g">

sub pssm_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_factory' } = shift @_;
  }
  return $self->{ 'pssm_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm_factory" md5="Tgn2lJkJ6Lw8ORDx/yegTQ">

sub get_pssm_factory {
  return shift->{ 'pssm_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm_factory" md5="aJGXuKNb6WRdG/Eb0RituA">

sub set_pssm_factory {
  my $self = shift @_;
  $self->{ 'pssm_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pssm_factory" md5="/rbQr9V+BN68aLi1nARm6g">

sub link_pssm_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pssm_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pssm_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PssmFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="strands" get_id="" set_id="">
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

###--- <scalar_property id="cutoff" get_id="" set_id="">
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pssm_score_dist_factory', $self->pssm_score_dist_factory() );
  $target->property( 'pssm_factory', $self->pssm_factory() );
  $target->property( 'strands', $self->strands() );
  $target->property( 'cutoff', $self->cutoff() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub matchers
{
  my( $self ) = @_;

  my $pssm_factory = $self->get_pssm_factory();
  if( !ref( $pssm_factory ) ) {
    croak( "Undefined pssm_factory in $self" );
  }

  my @matchers;
  foreach my $pssm( @{ $pssm_factory->pssms() || [] } ) {
    push @matchers, $self->_pssm2matcher( $pssm );
  }
  
  return \@matchers;
}

sub matcher_id2matcher
{
  my( $self, $matcher_id ) = @_;

  my $pssm_factory = $self->get_pssm_factory();
  if( !ref( $pssm_factory ) ) {
    croak( "Undefined pssm_factory in $self" );
  }

  my $pssm = $pssm_factory->pssm_id2pssm( $matcher_id );
  if( !ref( $pssm ) ) { return undef; }

  return $self->_pssm2matcher( $pssm );
}

##########################################################################

sub _pssm2matcher
{
  my( $self, $pssm ) = @_;

  my $cutoff = $self->get_cutoff();
  my $pssm_score_dist_factory = $self->get_pssm_score_dist_factory();
  
  if( !defined( $cutoff ) && !ref( $pssm_score_dist_factory ) ) {
    croak( "Undefined both pssm_score_dist_factory and cutoff in $self" );
  }

  my $strands = $self->get_strands();
  if( !defined( $strands ) ) {
    croak( "Undefined strands in $self" );
  }
  
  my $calc_cutoff = defined( $cutoff )
    ? $cutoff
    : $pssm_score_dist_factory->cutoff( $pssm, $pssm->pspm() );
  my $score_dist = ref( $pssm_score_dist_factory )
    ? $pssm_score_dist_factory->score_dist( $pssm, $pssm->pspm() )
    : undef;
  
  my $matcher = new BioMinerva::DNALib::PssmMatcher();
  $matcher->set_id( $pssm->get_id() );
  $matcher->set_pssm( $pssm );
  $matcher->set_strands( $strands );
  $matcher->set_cutoff( $calc_cutoff );
  $matcher->set_score_dist( $score_dist );

  return $matcher;
}

##########################################################################

1;

