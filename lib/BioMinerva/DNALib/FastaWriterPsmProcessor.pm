##########################################################################

package BioMinerva::DNALib::FastaWriterPsmProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PsmProcessor;;
@ISA = qw( BioMinerva::DNALib::PsmProcessor );

use Carp qw( confess croak carp );
use URI::Escape;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::FastaWriterPsmProcessor();
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
    $self->stream( $stream );
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
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;

  if( $property eq 'file' ) { $self->file( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_psm
{
  my( $self, $psm ) = @_;

  my %attrs = %{ $psm->attrs() || {} };
  $attrs{ 'type' } = [ $psm->get_type() ];
  
  my $chars = "'";
  my @attrs_arr = map {
    "/" . $_ . "='" . uri_escape( join( ':', @{ $attrs{ $_ } } ), $chars ) . "'"
  } keys( %attrs );
  
  my $stream = $self->stream();
  print $stream
    ">", $psm->get_id(),
    "\t", join( ' ', @attrs_arr ),
    "\n";

  my $matrix = $psm->matrix();
  foreach $matrix_row( @{ $matrix || [] } ) {
    print $stream
      join( "\t",
        map { sprintf( "%6.3f", $matrix_row->{ $_ } ) } qw( A C G T )
      ), 
      "\n";
  }
}

##########################################################################

1;
