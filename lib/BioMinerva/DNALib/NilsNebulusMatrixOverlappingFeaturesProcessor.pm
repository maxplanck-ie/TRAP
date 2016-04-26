##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::NilsNebulusMatrixOverlappingFeaturesProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::OverlappingFeaturesProcessor;
@ISA = qw( BioMinerva::DNALib::OverlappingFeaturesProcessor );

use Carp qw( confess croak carp );

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

###--- <scalar_property id='min_score' get_id='' set_id=''>
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

###--- <scalar_property id='_upstream_id2matcher_id2count' get_id='' set_id=''>
###---   <auto:comment id="_upstream_id2matcher_id2count" md5="zyzwyYbnLFeyIlnYLLai5w">

=head2 _upstream_id2matcher_id2count

 Title   : _upstream_id2matcher_id2count property
 
 Usage   : $object->_upstream_id2matcher_id2count(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_upstream_id2matcher_id2count" md5="hfPYyXx8Nbxu/lXZYrG17g">

sub _upstream_id2matcher_id2count {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_upstream_id2matcher_id2count' } = shift @_;
  }
  return $self->{ '_upstream_id2matcher_id2count' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_upstream_id2matcher_id2count" md5="7MHvVuRXOu5DdNaUHvSP9A">

sub _get_upstream_id2matcher_id2count {
  return shift->{ '_upstream_id2matcher_id2count' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_upstream_id2matcher_id2count" md5="Q7uQC8tAGlZsVwuKQiAZvg">

sub _set_upstream_id2matcher_id2count {
  my $self = shift @_;
  $self->{ '_upstream_id2matcher_id2count' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'min_score', $self->min_score() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;
  
  my $min_score = $self->get_min_score();
  if( !defined( $min_score ) ) {
    croak( "No min_score in $self" );
  }

  my $upstream_id = $mask_feature->get_id();

  my $upstream_id2matcher_id2count = $self->_get_upstream_id2matcher_id2count() || {};
  
  foreach my $feature( @{ $features || [] } ) {
    if( $feature->get_score() < $min_score ) { next; }
    my @matcher_ids = @{ $feature->attr( 'matcher' ) || [] };
    foreach my $matcher_id( @matcher_ids ) {
      $upstream_id2matcher_id2count->{ $upstream_id } ||= {};
      ++( $upstream_id2matcher_id2count->{ $upstream_id }->{ $matcher_id } );
    }
  }

  $self->_set_upstream_id2matcher_id2count( $upstream_id2matcher_id2count );
}

sub out {
  my( $self ) = @_;

  my $upstream_id2matcher_id2count = $self->_get_upstream_id2matcher_id2count() || {};

  my @upstream_ids = sort keys %{ $upstream_id2matcher_id2count };
  
  my %matcher_id2flag;

  foreach my $upstream_id( @upstream_ids ) {
    foreach my $matcher_id( keys %{ $upstream_id2matcher_id2count->{ $upstream_id } } ) {
      $matcher_id2flag{ $matcher_id } = 1;
    }
  }

  my @matcher_ids = sort keys %matcher_id2flag;

  print "MATRIX";

  print "\t";
  foreach my $matcher_id( @matcher_ids ) {
    print "\t", $matcher_id;
  }
  print "\n";
  
  foreach my $upstream_id( @upstream_ids ) {
    print $upstream_id;
    foreach my $matcher_id( @matcher_ids ) {
      print "\t",
        $upstream_id2matcher_id2count->{ $upstream_id }->{ $matcher_id } || 0;
    }
    print "\n";
  }
}

##########################################################################

1;
