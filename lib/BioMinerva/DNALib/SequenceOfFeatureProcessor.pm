##########################################################################

package BioMinerva::DNALib::SequenceOfFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureProcessor );

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
  return new BioMinerva::DNALib::SequenceOfFeatureProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='sequence_processor' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::SequenceProcessor'>
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
  $target->property( 'sequence_processor', $self->sequence_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence_processor' ) { $self->sequence_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_sequence_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature
{
  my( $self, $feature ) = @_;

  my $sequence_processor = $self->get_sequence_processor();
  if( !ref( $sequence_processor ) ) {
    carp( "Undefined sequence_processor in $self" );
  }
  
  $sequence_processor->process_sequence( $feature );
}

##########################################################################

1;
