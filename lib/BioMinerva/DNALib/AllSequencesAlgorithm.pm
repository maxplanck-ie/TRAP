##########################################################################

package BioMinerva::DNALib::AllSequencesAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::DNALib::Feature;
use BioMinerva::Base::InfoViewer;
use BioMinerva::Base::CounterProgressInfo;
use Carp qw( confess croak croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::AllSequencesAlgorithm();
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

###--- <scalar_property id="sequence_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::SequenceProcessor'>
###---   <auto:comment id="sequence_processor" md5="4t89G5O4/eECGNi9ismy0A">

=head2 sequence_processor

 Title   : sequence_processor property
 
 Usage   : $object->sequence_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_processor" md5="y/hMskw3mVzxmD61TO5mCw">

sub sequence_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_processor' } = shift @_;
  }
  return $self->{ 'sequence_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_processor" md5="jMvV69tKJZQ7opmgFpf26Q">

sub get_sequence_processor {
  return shift->{ 'sequence_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_processor" md5="kUB7qzorWB3eR53SPa2HNA">

sub set_sequence_processor {
  my $self = shift @_;
  $self->{ 'sequence_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_sequence_processor" md5="vT8hjAjZl8jUDuNgHSAcZQ">

sub link_sequence_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'sequence_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'sequence_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceProcessor', $ref
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
  $target->property( 'sequence_processor', $self->sequence_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence_factory' );
  $target->property( 'sequence_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  elsif( $property eq 'sequence_processor' ) { $self->sequence_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_sequence_factory( $registry );
  $self->link_sequence_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  my $sequence_processor = $self->get_sequence_processor();

  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }

  if( !ref( $sequence_processor ) ) {
    croak( "Undefined sequence_processor in $self" );
  }

  my $sequences = $sequence_factory->sequences() || [];
  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "Sequences" );
  $progress_info->set_size( scalar( @{ $sequences || [] } ) );
  $progress_info->set_count_attr( "sequence" );
  $progress_info->set_phase_attr( "sequence_id" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO:  try
  my $counter = 0;
  foreach my $sequence( @{ $sequences } ) {
    $progress_info->set_count( $counter++ );
    $progress_info->set_phase( $sequence->location_str() );

    $sequence_processor->process_sequence( $sequence );
  }
  $progress_info->set_count( $counter );
  $progress_info->set_phase( undef );
#TODO: catch:
  $info_viewer->pop_info();
}

##########################################################################

1;
