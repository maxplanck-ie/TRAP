##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::MatcherAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::Base::InfoViewer;
use BioMinerva::Base::CounterProgressInfo;
use Carp qw( confess croak carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::MatcherAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="sequence_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::SequenceFactory'>
###---   <auto:comment id="sequence_factory" md5="nSsQ+7ZMHzvX2Yo/bOKPhw">

=head2 sequence_factory

 Title   : sequence_factory property
 
 Usage   : $object->sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_factory" md5="oJ1dV8kpNuTSxqy5ho2NUQ">

sub sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_factory' } = shift @_;
  }
  return $self->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_factory" md5="6kU+ambkFItqJliIgotJGw">

sub get_sequence_factory {
  return shift->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_factory" md5="ISTcxJ9LtZL/YpCByaB1CA">

sub set_sequence_factory {
  my $self = shift @_;
  $self->{ 'sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_sequence_factory" md5="g4SZ0RvMuykyQ2/p+m3Kwg">

sub link_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="matcher_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::MatcherFactory'>
###---   <auto:comment id="matcher_factory" md5="C8EbJNksS4TIWg1FXg0EFQ">

=head2 matcher_factory

 Title   : matcher_factory property
 
 Usage   : $object->matcher_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="matcher_factory" md5="WIMM0VSPL4ynPomhY0Wn+g">

sub matcher_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'matcher_factory' } = shift @_;
  }
  return $self->{ 'matcher_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_matcher_factory" md5="NdIYyY2UvcIETYjZz3VWIg">

sub get_matcher_factory {
  return shift->{ 'matcher_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_matcher_factory" md5="ydLtHypxF4cReeEs8/GeiA">

sub set_matcher_factory {
  my $self = shift @_;
  $self->{ 'matcher_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_matcher_factory" md5="zc17RVmw//XC2Hy+FYrCJQ">

sub link_matcher_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'matcher_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'matcher_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::MatcherFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="match_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::MatchProcessor'>
###---   <auto:comment id="match_processor" md5="7HpuZe18JBrE6iarK78VHg">

=head2 match_processor

 Title   : match_processor property
 
 Usage   : $object->match_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="match_processor" md5="ZUhlqr6huLsz3NMs/5Z5gg">

sub match_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'match_processor' } = shift @_;
  }
  return $self->{ 'match_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_match_processor" md5="n5O/q73Eae8cYtiEelLhvw">

sub get_match_processor {
  return shift->{ 'match_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_match_processor" md5="dEzKefSsGQhZ110B+WcqLA">

sub set_match_processor {
  my $self = shift @_;
  $self->{ 'match_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_match_processor" md5="HfUNNdLBo90HvfCb7IAMXw">

sub link_match_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'match_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'match_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::MatchProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'matcher_factory', $self->matcher_factory() );
  $target->property( 'match_processor', $self->match_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence_factory' );
  $target->property( 'matcher_factory' );
  $target->property( 'match_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  elsif( $property eq 'matcher_factory' ) { $self->matcher_factory( @values ); }
  elsif( $property eq 'match_processor' ) { $self->match_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_sequence_factory( $registry );
  $self->link_matcher_factory( $registry );
  $self->link_match_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }

  my $matcher_factory = $self->get_matcher_factory();
  if( !ref( $matcher_factory ) ) {
    croak( "Undefined matcher_factory in $self" );
  }

  my $matchers = $matcher_factory->matchers();
  if( !@{ $matchers || [] } ) {
    carp( "No matchers/matrices provided in $self" );
  }
 
  my $match_processor = $self->get_match_processor();
  if( !ref( $match_processor ) ) {
    croak( "Undefined match_processor in $self" );
  }

  my $sequences = $sequence_factory->sequences();
  my $sequences_size = scalar( @{ $sequences || [] } );
  my $matchers_size = scalar( @{ $matchers || [] } );
  
  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "Matching (matchers:$matchers_size)" );
  $progress_info->set_size( $sequences_size );
  $progress_info->set_count_attr( "sequence" );
  $progress_info->set_phase_attr( "sequence_id" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO: try
  my $count = 0;
  foreach my $sequence( @{ $sequences || [] } ) {
    $progress_info->set_count( $count++ );
    $progress_info->set_phase( $sequence->display_id() );
      
    my $seq = $sequence_factory->sequence2seq( $sequence );
    foreach my $matcher( @{ $matchers } ) {
      $matcher->process_sequence_seq( $match_processor, $sequence, $seq );
    }
  }
  $progress_info->set_count( $count );
  $progress_info->set_phase( undef );
#TODO: catch:
  $info_viewer->pop_info();
}

##########################################################################

1;
