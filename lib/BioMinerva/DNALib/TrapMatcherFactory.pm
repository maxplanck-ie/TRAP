##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TrapMatcherFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatcherFactory;
@ISA = qw( BioMinerva::DNALib::MatcherFactory );

use BioMinerva::DNALib::TrapMatcher;
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
  return new BioMinerva::DNALib::TrapMatcherFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pscm_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PscmFactory'>
###---   <auto:comment id="pscm_factory" md5="eyMNJtNWrZ6cTfZI/AyGxg">

=head2 pscm_factory

 Title   : pscm_factory property
 
 Usage   : $object->pscm_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pscm_factory" md5="Cwh8NCoaZKYRUM+KT49zRw">

sub pscm_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pscm_factory' } = shift @_;
  }
  return $self->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pscm_factory" md5="2njW0KLi9cGbCsEKY4+cXA">

sub get_pscm_factory {
  return shift->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pscm_factory" md5="Jh/KXKRV9iiZIJ/iSKAxnA">

sub set_pscm_factory {
  my $self = shift @_;
  $self->{ 'pscm_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pscm_factory" md5="j30XX4NdakVzRw/WhuvSDg">

sub link_pscm_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pscm_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pscm_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PscmFactory', $ref
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

###--- <scalar_property id="r0" get_id="" set_id="">
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

###--- <scalar_property id="lambda" get_id="" set_id="">
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

###--- <scalar_property id="_matchers_processed" get_id="" set_id="">
###---   <auto:comment id="_matchers_processed" md5="pJZZ2Daema7PuD6d/13L4g">

=head2 _matchers_processed

 Title   : _matchers_processed property
 
 Usage   : $object->_matchers_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_matchers_processed" md5="cMrTUgO3MZG9KHK75tnVcA">

sub _matchers_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_matchers_processed' } = shift @_;
  }
  return $self->{ '_matchers_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_matchers_processed" md5="z444vCW7Q2//BT7eVbbJpw">

sub _get_matchers_processed {
  return shift->{ '_matchers_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_matchers_processed" md5="mxcBoAswAp8I7XxASQMSgg">

sub _set_matchers_processed {
  my $self = shift @_;
  $self->{ '_matchers_processed' } = shift @_;
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
  $target->property( 'pscm_factory', $self->pscm_factory() );
  $target->property( 'strands', $self->strands() );
  $target->property( 'r0', $self->r0() );
  $target->property( 'lambda', $self->lambda() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'pscm_factory' );
  $target->property( 'strands' );
  $target->property( 'r0' );
  $target->property( 'lambda' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'pscm_factory' ) { $self->pscm_factory( @values ); }
  elsif( $property eq 'strands' ) { $self->strands( @values ); }
  elsif( $property eq 'r0' ) { $self->r0( @values ); }
  elsif( $property eq 'lambda' ) { $self->lambda( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_pscm_factory( $registry );
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

  if( $self->_get_matchers_processed() ) { return; }
  
  my $pscm_factory = $self->get_pscm_factory();
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }

  my $strands = $self->get_strands();
  if( !defined( $strands ) ) {
    croak( "Undefined strands in $self" );
  }
  
  my $r0 = $self->get_r0();
  if( !defined( $r0 ) ) {
    croak( "Undefined r0 in $self" );
  }
  
  my $lambda = $self->get_lambda();
  if( !defined( $lambda ) ) {
    croak( "Undefined lambda in $self" );
  }
  
  my @trap_matchers;
  
  foreach my $pscm( @{ $pscm_factory->pscms() || [] } )
  {
    my $trap_matcher = new BioMinerva::DNALib::TrapMatcher();
    $trap_matcher->set_id( $pscm->get_id() );
    $trap_matcher->set_pscm( $pscm );
    $trap_matcher->set_strands( $strands );
    $trap_matcher->set_r0( $r0 );
    $trap_matcher->set_lambda( $lambda );

    push @trap_matchers, $trap_matcher;
  }
  
  $self->_set_matchers( \@trap_matchers );

  $self->_set_matchers_processed( 1 );
}

##########################################################################

1;

