##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::NilsNebulusSumConservedScoreMatrixOverlappingFeaturesProcessor;

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

###--- <scalar_property id='_upstream_id2matcher_id2sum' get_id='' set_id=''>
###---   <auto:comment id="_upstream_id2matcher_id2sum" md5="Y+jDAUEGJv6YYiD826LjCA">

=head2 _upstream_id2matcher_id2sum

 Title   : _upstream_id2matcher_id2sum property
 
 Usage   : $object->_upstream_id2matcher_id2sum(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_upstream_id2matcher_id2sum" md5="N1smxe4YotHOgLBBLMuipg">

sub _upstream_id2matcher_id2sum {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_upstream_id2matcher_id2sum' } = shift @_;
  }
  return $self->{ '_upstream_id2matcher_id2sum' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_upstream_id2matcher_id2sum" md5="XZakvCWsooAvXqE6SAiHrg">

sub _get_upstream_id2matcher_id2sum {
  return shift->{ '_upstream_id2matcher_id2sum' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_upstream_id2matcher_id2sum" md5="jp94Gqkiu0vo9wuJTRHxeQ">

sub _set_upstream_id2matcher_id2sum {
  my $self = shift @_;
  $self->{ '_upstream_id2matcher_id2sum' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;
  
  my $upstream_id = $mask_feature->get_id();

  my $upstream_id2matcher_id2sum = $self->_get_upstream_id2matcher_id2sum() || {};
  
  foreach my $feature( @{ $features || [] } ) {
    my @matcher_ids = @{ $feature->attr( 'matcher' ) || [] };
    foreach my $matcher_id( @matcher_ids ) {
      $upstream_id2matcher_id2sum->{ $upstream_id } ||= {};
      $upstream_id2matcher_id2sum->{ $upstream_id }->{ $matcher_id }
        += $feature->get_score() - 1;
    }
  }

  $self->_set_upstream_id2matcher_id2sum( $upstream_id2matcher_id2sum );
}

sub out {
  my( $self ) = @_;

  my $upstream_id2matcher_id2sum = $self->_get_upstream_id2matcher_id2sum() || {};

  my @upstream_ids = sort keys %{ $upstream_id2matcher_id2sum };
  
  my %matcher_id2flag;

  foreach my $upstream_id( @upstream_ids ) {
    foreach my $matcher_id( keys %{ $upstream_id2matcher_id2sum->{ $upstream_id } } ) {
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
        $upstream_id2matcher_id2sum->{ $upstream_id }->{ $matcher_id } || 0;
    }
    print "\n";
  }
}

##########################################################################

1;
