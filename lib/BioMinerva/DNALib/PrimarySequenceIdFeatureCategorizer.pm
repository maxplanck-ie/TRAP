##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PrimarySequenceIdFeatureCategorizer;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureCategorizer;
@ISA = qw( BioMinerva::DNALib::FeatureCategorizer );

use Carp qw( confess carp croak );
use BioMinerva::DNALib::PrimarySequenceIdFeatureCondition;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::PrimarySequenceIdFeatureCategorizer();
  }

  $self->SUPER::clone( $clone );
  
  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

sub display_id
{
  my( $self ) = @_;

  my $display_id = $self->SUPER::display_id();
  if( defined( $display_id ) ) { $display_id .= ':'; }
  else { $display_id = ""; }
  return 
    "primary_sequence_id";
}

sub features_digest
{
  my( $self, $features_digest ) = @_;

  $self->SUPER::features_digest( $features_digest );
  $features_digest->add( 'primary_sequence_id' );

  return $features_digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub category
{
  my( $self, $feature ) = @_;

  return $feature->get_primary_sequence_id();
}

sub category2feature_condition
{
  my( $self, $category ) = @_;

  my $feature_condition = new BioMinerva::DNALib::PrimarySequenceIdFeatureCondition();
  $feature_condition->set_primary_sequence_id( $category );

  return $feature_condition;
}

##########################################################################

1;
