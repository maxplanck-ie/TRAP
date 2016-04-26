##########################################################################

package BioMinerva::DNALib::BioAlignIOWriterBioSimpleAlignProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::BioSimpleAlignProcessor;
@ISA = qw( BioMinerva::DNALib::BioSimpleAlignProcessor );

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
  return new BioMinerva::DNALib::BioAlignIOWriterBioSimpleAlignProcessor();
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

###--- <scalar_property id="_stream" get_id="" set_id="">
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
###---   <auto:code get_id="_get_stream" md5="F60JkMN4ttRWhHAUpBTd/g">

sub _get_stream {
  return shift->{ '_stream' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_stream" md5="tILg3wVlhyKYX/rJq22YEw">

sub _set_stream {
  my $self = shift @_;
  $self->{ '_stream' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_bio_align_io" get_id="" set_id="">
###---   <auto:comment id="_bio_align_io" md5="+JL2v9NXn5AZHgYHtwAbsw">

=head2 _bio_align_io

 Title   : _bio_align_io property
 
 Usage   : $object->_bio_align_io(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_bio_align_io" md5="ujqX8vjCckxhr4cwOKcRUw">

sub _bio_align_io {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_bio_align_io' } = shift @_;
  }
  return $self->{ '_bio_align_io' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_bio_align_io" md5="reyptBklKfhiyQzB4B74ww">

sub _get_bio_align_io {
  return shift->{ '_bio_align_io' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_bio_align_io" md5="0MyHZmmj1pr4872P/kyrPg">

sub _set_bio_align_io {
  my $self = shift @_;
  $self->{ '_bio_align_io' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="format" get_id="" set_id="">
###---   <auto:comment id="format" md5="jDjszg4Fs3LWVeKVGAjIEw">

=head2 format

 Title   : format property
 
 Usage   : $object->format(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="format" md5="kNevuQzUKId9wDTd8V2BwA">

sub format {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'format' } = shift @_;
  }
  return $self->{ 'format' };
}

###---   </auto:code>
###---   <auto:code get_id="get_format" md5="k8kd8IsEVLUdxhYamdTcXg">

sub get_format {
  return shift->{ 'format' };
}

###---   </auto:code>
###---   <auto:code set_id="set_format" md5="dN/bfoogDKdKvLjp9CtdiQ">

sub set_format {
  my $self = shift @_;
  $self->{ 'format' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub get_bio_align_io
{
  my( $self ) = @_;

  if( !ref( $self->_get_bio_align_io() ) ) {
    $self->_set_bio_align_io(
      new Bio::AlignIO( 
        -fh => $self->_get_stream(), 
        -format => ( $self->get_format() || 'maf' )
      )
    );
  }

  return $self->_get_bio_align_io();
}

sub stream
{
  my( $self ) = @_;

  if( !ref( $self->_get_stream() ) ) {
    return \*STDOUT;
  } else {
    return $self->_get_stream();
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

    $self->_set_file( $file );
    $self->_set_stream( $stream );
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
  $target->property( 'format', $self->_format() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
  $target->property( 'format' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  elsif( $property eq 'format' ) { $self->format( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_bio_simple_align
{
  my( $self, $bio_simple_align ) = @_;

  $self->get_bio_align_io()->write_aln( $bio_simple_align );
}

##########################################################################

1;
