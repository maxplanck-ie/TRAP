##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::NilsNebulusMaxConservedScoreMatrixOverlappingFeaturesProcessor;

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

###--- <scalar_property id='_upstream_id2matcher_id2max' get_id='' set_id=''>
###---   <auto:comment id="_upstream_id2matcher_id2max" md5="KCIArwZA89terPJycQIqCQ">

=head2 _upstream_id2matcher_id2max

 Title   : _upstream_id2matcher_id2max property
 
 Usage   : $object->_upstream_id2matcher_id2max(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_upstream_id2matcher_id2max" md5="MjF+8sjoazz3Z3yYOslf8w">

sub _upstream_id2matcher_id2max {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_upstream_id2matcher_id2max' } = shift @_;
  }
  return $self->{ '_upstream_id2matcher_id2max' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_upstream_id2matcher_id2max" md5="w+mwUoJaFPDzNN5uKjc2iA">

sub _get_upstream_id2matcher_id2max {
  return shift->{ '_upstream_id2matcher_id2max' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_upstream_id2matcher_id2max" md5="tAzYbgY+ksJIad9gWf9w+A">

sub _set_upstream_id2matcher_id2max {
  my $self = shift @_;
  $self->{ '_upstream_id2matcher_id2max' } = shift @_;
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

  my $upstream_id2matcher_id2max = $self->_get_upstream_id2matcher_id2max() || {};
  
  foreach my $feature( @{ $features || [] } ) {
    my @matcher_ids = @{ $feature->attr( 'matcher' ) || [] };
    foreach my $matcher_id( @matcher_ids ) {
      $upstream_id2matcher_id2max->{ $upstream_id } ||= {};
      my $current = $upstream_id2matcher_id2max->{ $upstream_id }->{ $matcher_id } || 0;
      if( $feature->get_score() > $current ) { 
        $current = $feature->get_score(); 
      }
      $upstream_id2matcher_id2max->{ $upstream_id }->{ $matcher_id } = $current;
    }
  }

  $self->_set_upstream_id2matcher_id2max( $upstream_id2matcher_id2max );
}

sub out {
  my( $self ) = @_;

  my $upstream_id2matcher_id2max = $self->_get_upstream_id2matcher_id2max() || {};

  my @upstream_ids = sort keys %{ $upstream_id2matcher_id2max };
  
  my %matcher_id2flag;

  foreach my $upstream_id( @upstream_ids ) {
    foreach my $matcher_id( keys %{ $upstream_id2matcher_id2max->{ $upstream_id } } ) {
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
        $upstream_id2matcher_id2max->{ $upstream_id }->{ $matcher_id } || 0;
    }
    print "\n";
  }
}

##########################################################################

1;
