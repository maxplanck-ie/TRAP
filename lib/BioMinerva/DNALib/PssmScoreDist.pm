##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PssmScoreDist;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

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
  return new BioMinerva::DNALib::PssmScoreDist();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='pdf' get_id='' set_id='' link_id='' type='Math::DiscreteDistribution'>
###---   <auto:comment id="pdf" md5="aJSILFJqob0Ie9AxYRCzGw">

=head2 pdf

 Title   : pdf property
 
 Usage   : $object->pdf(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pdf" md5="MZ4LzjTxfMW2gEeQmyFGTA">

sub pdf {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pdf' } = shift @_;
  }
  return $self->{ 'pdf' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pdf" md5="ZDGmdfF2e582pWhGqKZNeA">

sub get_pdf {
  return shift->{ 'pdf' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pdf" md5="GznmxQcD9zKu0QdYFnAHIQ">

sub set_pdf {
  my $self = shift @_;
  $self->{ 'pdf' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pdf" md5="G4axwa33Gqyz5zkSMsaVWg">

sub link_pdf {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pdf' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pdf' } =
      $registry->type_id2object(
        'Math::DiscreteDistribution', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='epsilon' get_id='' set_id=''>
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
###---   <auto:code get_id="get_epsilon" md5="JbLWmMCh2qPwet7pj2wlTQ">

sub get_epsilon {
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pdf', $self->pdf() );
  $target->property( 'epsilon', $self->epsilon() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'pdf' );
  $target->property( 'epsilon' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'pdf' ) { $self->pdf( @values ); }
  elsif( $property eq 'epsilon' ) { $self->epsilon( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_pdf( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub p_value
{
  my( $self, $score ) = @_;

  my $pdf = $self->get_pdf();
  if( !ref( $pdf ) ) {
    croak( "Undefined pdf in $self" );
  }

  my $epsilon = $self->get_epsilon();
  if( !defined( $epsilon ) ) {
    croak( "Undefined epsilon in $self" );
  }
  
  return 1 - $pdf->pdf(
    POSIX::floor( $score / $epsilon + 0.5 )
  );
}

##########################################################################

1;

