##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ShuffledPssmMatcherFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PssmMatcherFactory;
@ISA = qw( BioMinerva::DNALib::PssmMatcherFactory );

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

###--- <scalar_property id="pssm_matcher_factory" get_id="" set_id="" type='BioMinerva::DNALib::PssmMatcherFactory'>
###---   <auto:comment id="pssm_matcher_factory" md5="JAlUXmM83xvLxYuXwspYOg">

=head2 pssm_matcher_factory

 Title   : pssm_matcher_factory property
 
 Usage   : $object->pssm_matcher_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_matcher_factory" md5="lKz7UpcRpC/MkvoG4XZ3sA">

sub pssm_matcher_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_matcher_factory' } = shift @_;
  }
  return $self->{ 'pssm_matcher_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm_matcher_factory" md5="6GzON2QqZy+aM+hPN3cSlg">

sub get_pssm_matcher_factory {
  return shift->{ 'pssm_matcher_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm_matcher_factory" md5="+zhDvjIy2C7NMHZhYAG3tA">

sub set_pssm_matcher_factory {
  my $self = shift @_;
  $self->{ 'pssm_matcher_factory' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_matchers" get_id="" set_id="">
###---   <auto:comment id="_matchers" md5="cL0waZ0elDfQ4bp9RPfOvQ">

=head2 _matchers

 Title   : _matchers property
 
 Usage   : $object->_matchers(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_matchers" md5="ktw9ZvXL11/lxpiqdSMUtw">

sub _matchers {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_matchers' } = shift @_;
  }
  return $self->{ '_matchers' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_matchers" md5="c3unRNEgq3BV4mZaVjl/5Q">

sub _get_matchers {
  return shift->{ '_matchers' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_matchers" md5="mU3M05gplwjKHXyvpA4kZQ">

sub _set_matchers {
  my $self = shift @_;
  $self->{ '_matchers' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pssm_matcher_factory', $self->get_pssm_matcher_factory() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub matchers
{
  my( $self ) = @_;

  $self->_process_matchers();
  return $self->_get_matchers();
}

##########################################################################

sub _process_matchers
{
  my( $self ) = @_;

  if( $self->_get_matchers() ) { return; }
  
  my $pssm_matcher_factory = $self->get_pssm_matcher_factory();
  if( !ref( $pssm_matcher_factory ) ) {
    croak( "Undefined pssm_matcher_factory in $self" );
  }

  my @shuffled_matchers;
  my $matchers = $pssm_matcher_factory->matchers();
  foreach my $matcher( @{ $matchers || [] } ) {
    my $shuffled_pssm = $matcher->pssm->pos_shuffled_pssm();

    my $shuffled_matcher = new BioMinerva::DNALib::PssmMatcher();
    $shuffled_matcher->set_id( $matcher->get_id() );
    $shuffled_matcher->set_pssm( $shuffled_pssm );
    $shuffled_matcher->set_strands( $matcher->get_strands() );
    $shuffled_matcher->set_cutoff( $matcher->get_cutoff() );
    $shuffled_matcher->set_score_dist( $matcher->get_score_dist() );
    push @shuffled_matchers, $shuffled_matcher;
  }
  
  $self->_set_matchers( \@shuffled_matchers );
}

##########################################################################

1;

