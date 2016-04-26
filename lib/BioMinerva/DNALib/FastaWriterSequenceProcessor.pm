##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FastaWriterSequenceProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SequenceProcessor;
@ISA = qw( BioMinerva::DNALib::SequenceProcessor );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::FastaWriterSequenceProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="_file" get_id="" set_id="">
###---   <auto:comment id="_file" md5="31QhDSRdKIjbSGenoUh5gA">

=head2 _file

 Title   : _file property
 
 Usage   : $object->_file(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_file" md5="Pkx48YqrB5WSopEKKiwC1g">

sub _file {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_file' } = shift @_;
  }
  return $self->{ '_file' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_file" md5="h8Licw6bBVnBpl/X7HLhPw">

sub _get_file {
  return shift->{ '_file' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_file" md5="vGZXr/E1Zatez320A+AdcQ">

sub _set_file {
  my $self = shift @_;
  $self->{ '_file' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_stream">
###---   <auto:comment id="_stream" md5="b0mdzB7/UVSpuq8tl0UohA">

=head2 _stream

 Title   : _stream property
 
 Usage   : $object->_stream(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_stream" md5="uQBkP9wkF4rduWF7nGgeIA">

sub _stream {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_stream' } = shift @_;
  }
  return $self->{ '_stream' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="sequence_factory" get_id="" set_id="" link_id="" type="BioMinerva::DNALib::SequenceFactory">
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

###--- <scalar_property id="line_length">
###---   <auto:comment id="line_length" md5="aOaPjX6dp1ztj8WX15N1Lg">

=head2 line_length

 Title   : line_length property
 
 Usage   : $object->line_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="line_length" md5="04yr+p6Ea+6SPmP/yP1NxQ">

sub line_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'line_length' } = shift @_;
  }
  return $self->{ 'line_length' };
}

###---   </auto:code>
###--- </scalar_property>

sub stream
{
  my( $self ) = @_;

  if( !ref( $self->_stream() ) ) {
    return \*STDOUT;
  } else {
    return $self->_stream();
  }
}

sub file
{
  my( $self, $file ) = @_;

  if( defined( $file ) ) {
    my $stream;
    if( !open( $stream, '>', $file ) ) {
      croak( "Can not open '$file' for writing (system: '$!')" );
    }

    $self->_file( $file );
    $self->_stream( $stream );
  } else {
    return $self->_file();
  }
}

sub display_id
{
  my( $self ) = @_;

  my $display_id = $self->SUPER::display_id();
  if( !defined( $display_id ) ) { 
    $display_id = $self->file();
  }
  return $display_id;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'file', $self->_file() );
  $target->property( 'line_length', $self->line_length() );
  $target->property( 'sequence_factory', $self->sequence_factory() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
  $target->property( 'line_length' );
  $target->property( 'sequence_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  elsif( $property eq 'line_length' ) { $self->line_length( @values ); }
  elsif( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_sequence_factory( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_sequence {
  my( $self, $sequence ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }
  
  # ----- header line -----
  my $location = $sequence->location_str();
  my $id = defined( $sequence->get_id() )
    ? $sequence->get_id()
    : $location;

  ### ----- here masking of the original seq -----
  my $seq = $sequence_factory->sequence2seq( $sequence );
    
  if( !defined( $seq ) ) {
    carp( "Seq for sequence $sequence is not provided by the sequence_factory in $self; output skipped" );
    return;
  }

  if( length( $seq ) != $sequence->length() ) {
    confess( 
      "A returned length(\$seq)=" 
      . length( $seq )
      . " not equal to the expected length " 
      . $sequence->length()
      . " of the sequence $sequence in $self" 
    );
  }

  ### ----- final writing -----
  $self->_write_fasta( $seq, "$id" );
}

##########################################################################

sub _write_fasta
{
  my( $self, $seq, $header ) = @_;
  
  if( !defined( $header ) ) 
    { confess( "Can not write a fasta seq without a header in $self" ); }
  
  my $line_length = $self->line_length();
  if( !defined( $line_length ) || $line_length < 0 ) { $line_length = 60; }
  elsif( $line_length == 0 ) { $line_length = length( $seq ); }

  print { $self->stream() } ">$header\n";

  for( my $pos = 0; $pos < length( $seq ); ) {
    my $line = substr( $seq, $pos, $line_length );
    print { $self->stream() } $line;
    print { $self->stream() } "\n";
    $pos += $line_length;
  }
}

##########################################################################

1;
