##########################################################################

package BioMinerva::DNALib::PrintPairwiseAlignmentProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PairwiseAlignmentProcessor;
@ISA = qw( BioMinerva::DNALib::PairwiseAlignmentProcessor );

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

###--- <scalar_property id="query_sequence_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::SequenceFactory'>
###---   <auto:comment id="query_sequence_factory" md5="b/aOPPnRr9tHOW6e+rSSsQ">

=head2 query_sequence_factory

 Title   : query_sequence_factory property
 
 Usage   : $object->query_sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="query_sequence_factory" md5="LtSwoRL7UXqsbaNMhS8HtQ">

sub query_sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'query_sequence_factory' } = shift @_;
  }
  return $self->{ 'query_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_query_sequence_factory" md5="pvwDtcb12JBFD8BhLIb4IA">

sub get_query_sequence_factory {
  return shift->{ 'query_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_query_sequence_factory" md5="oBhbj1bMn9X2YILYVQ2k9A">

sub set_query_sequence_factory {
  my $self = shift @_;
  $self->{ 'query_sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_query_sequence_factory" md5="yDHRg27akJce5l0LF5bUYg">

sub link_query_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'query_sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'query_sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="target_sequence_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::SequenceFactory'>
###---   <auto:comment id="target_sequence_factory" md5="JkZ4+FfvDaKzJivvWq5plQ">

=head2 target_sequence_factory

 Title   : target_sequence_factory property
 
 Usage   : $object->target_sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="target_sequence_factory" md5="9WG4S9hamhUMMbznRRFI1A">

sub target_sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'target_sequence_factory' } = shift @_;
  }
  return $self->{ 'target_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_target_sequence_factory" md5="jKwBYoS6Bpv+jNhk7PiwRA">

sub get_target_sequence_factory {
  return shift->{ 'target_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_target_sequence_factory" md5="D8rhM1Rm8wdyD/d8opbLMg">

sub set_target_sequence_factory {
  my $self = shift @_;
  $self->{ 'target_sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_target_sequence_factory" md5="2aFvf278hJSJVcVc5U18XQ">

sub link_target_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'target_sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'target_sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_pairwise_alignment
{
  my( $self, $pairwise_alignment ) = @_;

  my $query_seq = $self->get_query_sequence_factory()->sequence2seq(
    $pairwise_alignment->get_query_sequence()
  );

  my $target_seq = $self->get_target_sequence_factory()->sequence2seq(
    $pairwise_alignment->get_target_sequence()
  );

  print 
    $pairwise_alignment, "\n",
    $query_seq, "\t", $pairwise_alignment->get_query_sequence()->location_str(), "\n",
    $target_seq, "\t", $pairwise_alignment->get_target_sequence()->location_str(), "\n",
    "\n";
}

##########################################################################

1;
