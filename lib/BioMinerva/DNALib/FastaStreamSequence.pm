##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FastaStreamSequence;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Sequence;
@ISA = qw( BioMinerva::DNALib::Sequence );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################

###--- <scalar_property id="stream_start_pos" get_id="" set_id="">
###---   <auto:comment id="stream_start_pos" md5="XOeKcqozhr/dwWae+RziAQ">

=head2 stream_start_pos

 Title   : stream_start_pos property
 
 Usage   : $object->stream_start_pos(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="stream_start_pos" md5="R6iAPzcKuabEPLdvf0AcBQ">

sub stream_start_pos {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'stream_start_pos' } = shift @_;
  }
  return $self->{ 'stream_start_pos' };
}

###---   </auto:code>
###---   <auto:code get_id="get_stream_start_pos" md5="9zfgExiDUqVFIfJD1oZY3g">

sub get_stream_start_pos {
  return shift->{ 'stream_start_pos' };
}

###---   </auto:code>
###---   <auto:code set_id="set_stream_start_pos" md5="/cS3/Lq02c5vxx84hdb5IQ">

sub set_stream_start_pos {
  my $self = shift @_;
  $self->{ 'stream_start_pos' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="chars_per_line" get_id="" set_id="">
###---   <auto:comment id="chars_per_line" md5="/iPWWy5qWChXfr4hBF1I1A">

=head2 chars_per_line

 Title   : chars_per_line property
 
 Usage   : $object->chars_per_line(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="chars_per_line" md5="tIOpGac6Kb6LtqhZrVByqg">

sub chars_per_line {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'chars_per_line' } = shift @_;
  }
  return $self->{ 'chars_per_line' };
}

###---   </auto:code>
###---   <auto:code get_id="get_chars_per_line" md5="tJO2a9pFsSIUBJ/M7U2Prw">

sub get_chars_per_line {
  return shift->{ 'chars_per_line' };
}

###---   </auto:code>
###---   <auto:code set_id="set_chars_per_line" md5="2qJWL738lfi2Ld29kQtJWw">

sub set_chars_per_line {
  my $self = shift @_;
  $self->{ 'chars_per_line' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="bases_per_line" get_id="" set_id="">
###---   <auto:comment id="bases_per_line" md5="s03CP/9RBcUYX/loZFnqIQ">

=head2 bases_per_line

 Title   : bases_per_line property
 
 Usage   : $object->bases_per_line(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bases_per_line" md5="TTYcVk0ZtJwU6qtFYELMlA">

sub bases_per_line {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bases_per_line' } = shift @_;
  }
  return $self->{ 'bases_per_line' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bases_per_line" md5="oYn7lYTRpmRq4gxSVDZm8Q">

sub get_bases_per_line {
  return shift->{ 'bases_per_line' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bases_per_line" md5="ogflD/TbX3rPsIgngFUP7g">

sub set_bases_per_line {
  my $self = shift @_;
  $self->{ 'bases_per_line' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="line_no" get_id="" set_id="">
###---   <auto:comment id="line_no" md5="sIP2poEePcpY22mpODFOyw">

=head2 line_no

 Title   : line_no property
 
 Usage   : $object->line_no(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="line_no" md5="xxeUxZhoCTk7I0dAr/UbFg">

sub line_no {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'line_no' } = shift @_;
  }
  return $self->{ 'line_no' };
}

###---   </auto:code>
###---   <auto:code get_id="get_line_no" md5="wfoigr6paJv11TsXWmt9vA">

sub get_line_no {
  return shift->{ 'line_no' };
}

###---   </auto:code>
###---   <auto:code set_id="set_line_no" md5="arb+oWzR6hfkYVnKyMvm8A">

sub set_line_no {
  my $self = shift @_;
  $self->{ 'line_no' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'stream_start_pos', $self->stream_start_pos() );
  $target->property( 'chars_per_line', $self->chars_per_line() );
  $target->property( 'bases_per_line', $self->bases_per_line() );
  $target->property( 'line_no', $self->line_no() );
}

##########################################################################

1;
