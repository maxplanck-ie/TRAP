##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Matcher;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use BioMinerva::Base::IdObject;
use Carp qw( confess carp );

use BioMinerva::DNALib::CountMatchProcessor;
use BioMinerva::DNALib::SumOfScoresMatchProcessor;
use BioMinerva::DNALib::StoreMatchProcessor;

##########################################################################

use vars qw( @ISA );
@ISA = qw( BioMinerva::Base::IdObject );

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

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_sequence_seq
{
  my( $self, $match_processor, $sequence, $seq ) = @_;
  confess( "Not overridden in $self" );
}

sub matches
{
  my( $self, $sequence, $seq ) = @_;

  my $match_processor = new BioMinerva::DNALib::StoreMatchProcessor();
  $self->process_sequence_seq( $match_processor, $sequence, $seq );
  return $match_processor->matches();
}

sub num_of_matches
{
  my( $self, $sequence, $seq ) = @_;

  my $match_processor = new BioMinerva::DNALib::CountMatchProcessor();
  $self->process_sequence_seq( $match_processor, $sequence, $seq );
  return $match_processor->num_of_matches();
}

sub sum_of_match_scores
{
  my( $self, $sequence, $seq ) = @_;

  my $match_processor = new BioMinerva::DNALib::SumOfScoresMatchProcessor();
  $self->process_sequence_seq( $match_processor, $sequence, $seq );
  return $match_processor->sum_of_scores();
}

sub max_num_of_matches
{
  my( $self, $sequence ) = @_;
  confess( "Not overridden in $self" );
}

sub score2p_value
{
  my( $self, $score ) = @_;
  confess( "Not overridden in $self" );
}

##########################################################################

sub pos_shuffled_matcher
{
  my( $self ) = @_;
  confess( "Not overridden in $self" );
}

##########################################################################

1;
