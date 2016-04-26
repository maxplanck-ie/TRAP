##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::ScoreInRangeFeatureIndexCondition;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIndexCondition;
@ISA = qw( BioMinerva::DNALib::FeatureIndexCondition );

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
  return new BioMinerva::DNALib::ScoreInRangeFeatureIndexCondition();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="min_score" get_id="" set_id="">
###---   <auto:comment id="min_score" md5="tYfMXSZeFZvD9gKLV21xNA">

=head2 min_score

 Title   : min_score property
 
 Usage   : $object->min_score(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="min_score" md5="C0v0qO7zdAhrI+HU+ufHGg">

sub min_score {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'min_score' } = shift @_;
  }
  return $self->{ 'min_score' };
}

###---   </auto:code>
###---   <auto:code get_id="get_min_score" md5="noGOrPDBorpqSmgiHVjfCQ">

sub get_min_score {
  return shift->{ 'min_score' };
}

###---   </auto:code>
###---   <auto:code set_id="set_min_score" md5="mfOHn8tdJYrxbsTsYUpCQA">

sub set_min_score {
  my $self = shift @_;
  $self->{ 'min_score' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="max_score" get_id="" set_id="">
###---   <auto:comment id="max_score" md5="GVho6m9JkZSaSxAIVmUPqQ">

=head2 max_score

 Title   : max_score property
 
 Usage   : $object->max_score(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="max_score" md5="kyVJlyTDt4jCfFHWV3HBTg">

sub max_score {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'max_score' } = shift @_;
  }
  return $self->{ 'max_score' };
}

###---   </auto:code>
###---   <auto:code get_id="get_max_score" md5="BF3TeLhrO+amh9FR9/FqQQ">

sub get_max_score {
  return shift->{ 'max_score' };
}

###---   </auto:code>
###---   <auto:code set_id="set_max_score" md5="utXw7zGbUQ0irwadbc9zWw">

sub set_max_score {
  my $self = shift @_;
  $self->{ 'max_score' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub display_id
{
  my( $self ) = @_;

  my $display_id = $self->SUPER::display_id();
  if( defined( $display_id ) ) { $display_id .= ':'; }
  else { $display_id = ""; }
  return 
    $display_id
    . "score("
    . $self->get_min_score()
    . ".."
    . $self->get_max_score()
    . ")";
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'min_score', $self->min_score() );
  $target->property( 'max_score', $self->max_score() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'min_score' );
  $target->property( 'max_score' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'min_score' ) { $self->min_score( @values ); }
  elsif( $property eq 'max_score' ) { $self->max_score( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub test
{
  my( $self, $feature_index ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }
  
  my $score = $feature_factory->
    index2flat_feature( $feature_index )->get_score();

  return 
    $score >= $self->get_min_score() && $score <= $self->get_max_score();
}

##########################################################################

1;
