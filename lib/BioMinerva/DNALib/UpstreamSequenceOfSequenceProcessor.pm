##########################################################################

package BioMinerva::DNALib::UpstreamSequenceOfSequenceProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SequenceProcessor;
@ISA = qw( BioMinerva::DNALib::SequenceProcessor );

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
  return new BioMinerva::DNALib::UpstreamSequenceOfSequenceProcessor();
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

###--- <scalar_property id='upstream_length' get_id='' set_id=''>
###---   <auto:comment id="upstream_length" md5="uFJT3P8QDmZQUOj1ssrOyQ">

=head2 upstream_length

 Title   : upstream_length property
 
 Usage   : $object->upstream_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="upstream_length" md5="rpxnVsbvlMRlcUggMEdKLA">

sub upstream_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'upstream_length' } = shift @_;
  }
  return $self->{ 'upstream_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_upstream_length" md5="NbCjOsKIjmC7ajx2ay3SZg">

sub get_upstream_length {
  return shift->{ 'upstream_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_upstream_length" md5="8GYNByl8UCkvQqHwJjO+rw">

sub set_upstream_length {
  my $self = shift @_;
  $self->{ 'upstream_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='downstream_length' get_id='' set_id=''>
###---   <auto:comment id="downstream_length" md5="L7Eo5dbbHtCHOeiOCoY/4w">

=head2 downstream_length

 Title   : downstream_length property
 
 Usage   : $object->downstream_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="downstream_length" md5="pcz5NSx/XHeNfzBY9LhxTg">

sub downstream_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'downstream_length' } = shift @_;
  }
  return $self->{ 'downstream_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_downstream_length" md5="i0NRwxfz2waRCVBlU1G3Mg">

sub get_downstream_length {
  return shift->{ 'downstream_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_downstream_length" md5="89TO1BSFGtkpgiMqDkAyVw">

sub set_downstream_length {
  my $self = shift @_;
  $self->{ 'downstream_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_processor', $self->sequence_processor() );
  $target->property( 'upstream_length', $self->upstream_length() );
  $target->property( 'downstream_length', $self->downstream_length() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'sequence_processor' );
  $target->property( 'upstream_length' );
  $target->property( 'downstream_length' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'sequence_processor' ) { $self->sequence_processor( @values ); }
  elsif( $property eq 'upstream_length' ) { $self->upstream_length( @values ); }
  elsif( $property eq 'downstream_length' ) { $self->downstream_length( @values ); }
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

sub process_sequence
{
  my( $self, $sequence ) = @_;

  my $sequence_processor = $self->get_sequence_processor();
  if( !ref( $sequence_processor ) ) {
    carp( "Undefined $sequence_processor in $self" );
  }
  
  my $target_sequence =
    $sequence->upstream_sequence(
      $self->get_upstream_length() || 0,
      $self->get_downstream_length() || 0
    );
  $target_sequence->id( 
    $sequence->id() . "upstream"
  );
  
  $sequence_processor->process_sequence( $target_sequence );
}

##########################################################################

1;
