##########################################################################

package BioMinerva::DNALib::NilsNebulusOverlappingFeaturesProcessor;

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

  my @site_matchers;
  
  foreach my $feature( @{ $features || [] } ) {
    if( $feature->get_score() < $min_score ) { next; }
    push @site_matchers, @{ $feature->attr( 'matcher' ) || [] };
  }

  print
    $upstream_id,
    "\t",
    join( ":", @site_matchers ),
    "\n";
}

##########################################################################

1;
