##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::RawStreamSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::StreamSequenceFactory;
@ISA = qw( BioMinerva::DNALib::StreamSequenceFactory );

use BioMinerva::DNALib::FastaStreamSequence;
use Carp qw( confess carp );
use POSIX qw( floor );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::RawStreamSequenceFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="_sequence" get_id="_get_sequence" set_id="_set_sequence">
###---   <auto:comment id="_sequence" md5="VMWsLVMUEuQonQWA6X/62A">

=head2 _sequence

 Title   : _sequence property
 
 Usage   : $object->_sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_sequence" md5="Iy92Z693p8fNT/IOz/m3Sw">

sub _sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_sequence' } = shift @_;
  }
  return $self->{ '_sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_sequence" md5="gcvir6rER5mtl2YrgtyuNQ">

sub _get_sequence {
  return shift->{ '_sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_sequence" md5="V5ic9HMyzEay3uXKsC2kyg">

sub _set_sequence {
  my $self = shift @_;
  $self->{ '_sequence' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_stream_processed" get_id="_get_stream_processed" set_id="_set_stream_processed">
###---   <auto:comment id="_stream_processed" md5="vkgzEjnLYlgEPfS3PetTJA">

=head2 _stream_processed

 Title   : _stream_processed property
 
 Usage   : $object->_stream_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_stream_processed" md5="9CwKAkN475p18yeVe/1zCA">

sub _stream_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_stream_processed' } = shift @_;
  }
  return $self->{ '_stream_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_stream_processed" md5="pa6UwClP2VwAdYnNeo47bw">

sub _get_stream_processed {
  return shift->{ '_stream_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_stream_processed" md5="ZoEA9GF5CVzfKQ8wkFowTQ">

sub _set_stream_processed {
  my $self = shift @_;
  $self->{ '_stream_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="sequence_id" get_id="get_sequence_id" set_id="set_sequence_id">
###---   <auto:comment id="sequence_id" md5="4OCI/k6lCO01EokAe6YtLw">

=head2 sequence_id

 Title   : sequence_id property
 
 Usage   : $object->sequence_id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_id" md5="uzMPj5UaFL8/A/m51UdMlw">

sub sequence_id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_id' } = shift @_;
  }
  return $self->{ 'sequence_id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_id" md5="vlqMCfmRwY9AsT/Qg7/GeQ">

sub get_sequence_id {
  return shift->{ 'sequence_id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_id" md5="PKNM1QxXSA2aXdbiJiysOQ">

sub set_sequence_id {
  my $self = shift @_;
  $self->{ 'sequence_id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub file
{
  my( $self, @args ) = @_;

  if( @args ) {
    $self->sequence_id( @args );
  }
  return $self->SUPER::file( @args );
}

sub sequence_ids
{
  # ----- this is to keep the same order of sequences as in the file -----
  my( $self ) = @_;
  $self->_process_stream();
  return [ $self->_get_sequence()->id() ];
}

sub sequences
{
  # ----- this is to keep the same order of sequences as in the file -----
  my( $self ) = @_;
  $self->_process_stream();
  return [ $self->_get_sequence() ];
}

sub sequence_id2sequence
{
  my( $self, $sequence_id ) = @_;
  $self->_process_stream();
  if( $self->_get_sequence()->id() eq $sequence_id ) {
    return $self->_get_sequence();
  } else {
    return undef;
  }
}

sub sequence2seq
{
  my( $self, $sequence ) = @_;
  my $raw_sequence =
    $self->sequence_id2sequence( $sequence->primary_sequence_id() );
  if( !ref( $raw_sequence ) ) { return undef; }  
  return $self->_get_seq( $raw_sequence, $sequence );
}###--- <scalar_property id="_sequence" get_id="_get_sequence" set_id="_set_sequence"/>


sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( '_sequence', $self->_get_sequence() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
#  $target->property( 'add_line_no_to_seq_id' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  if( $property eq 'add_line_no_to_seq_id' ) { $self->add_line_no_to_seq_id( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _process_stream
{
  my( $self ) = @_;

  if( $self->_get_stream_processed() ) { return; }
  
  my $stream = $self->get_stream();
  if( !seek( $stream, 0, 2 ) ) { #2->SEEK_END
    confess( "Failed to seek a raw sequence stream to end in $self" ) 
  }
  my $length = tell( $stream );
  my $sequence_id = $self->get_sequence_id();
  
  my $sequence = new BioMinerva::DNALib::Sequence();
  $sequence->primary_sequence_id( $sequence_id );
  $sequence->id( $sequence_id );
  $sequence->start( 1 );
  $sequence->end( $length );
  $sequence->strand( +1 );

  $self->_set_sequence( $sequence );
  $self->_set_stream_processed( 1 );
  
  print STDERR "Added raw sequence '$sequence_id' (length=$length)\n";
}

sub _get_seq
{
  my( $self, $raw_sequence, $sequence ) = @_;

  # ----- calculation of relative locations of raw and seq -----
  my( $s_start, $f_start, $copy_length );
  {
    my $d_start = $sequence->start() - $raw_sequence->start();

    if( $d_start >= 0 ) { $s_start = 0; $f_start = $d_start; }
    elsif( $d_start <= -$sequence->length() ) { next; }
    else { $s_start = -$d_start; $f_start = 0; }
  
    my $f_to_copy = $raw_sequence->length() - $f_start;
    my $s_to_copy = $sequence->length() - $s_start;
    $copy_length = ( $f_to_copy < $s_to_copy ) ? $f_to_copy : $s_to_copy;
    if( $copy_length <= 0 ) { next; }
  }
 
  # ----- seeking to the f_start position in the file -----
  my $stream = $self->stream();
  if( !seek( $stream, $f_start, 0 ) ) { #0->SEEK_SET 
    confess( "Failed to seek a raw sequence stream to pos $f_start in $self" ) 
  };
  
  # ----- filling the seq from the file -----
  my $seq = '?' x $sequence->length();

  my $seq_frag;
  if( read( $stream, $seq_frag, $copy_length ) != $copy_length ) {
    confess( "Failed to read $copy_length bytes from a raw sequence in $self" ) 
  }
  substr( $seq, $s_start, $copy_length ) = substr( $seq_frag, 0, $copy_length );
  
  if( !$sequence->strand() ) {
  } elsif( $sequence->strand() < 0 ) {
    $seq = reverse $seq;
    $seq =~ tr/ACGTWRKSYMBHDVNacgtwrksymbhdvn/TGCAWYMSRKVDHBNtgcawymsrkvdhbn/;
  }
 
  return $seq;
}

##########################################################################

1;

