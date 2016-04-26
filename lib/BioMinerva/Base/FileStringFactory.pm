##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::FileStringFactory;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::StringFactory;
@ISA = qw( BioMinerva::Base::StringFactory );

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
  return new BioMinerva::Base::FileStringFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="stream" get_id="" set_id="">
###---   <auto:comment id="stream" md5="H6hzT/7G5mCXwM+REmq6IA">

=head2 stream

 Title   : stream property
 
 Usage   : $object->stream(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="stream" md5="i4uMDEyX9WGQ5XoyyLMTlg">

sub stream {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'stream' } = shift @_;
  }
  return $self->{ 'stream' };
}

###---   </auto:code>
###---   <auto:code get_id="get_stream" md5="bD009lh9OIXcCI37D32baw">

sub get_stream {
  return shift->{ 'stream' };
}

###---   </auto:code>
###---   <auto:code set_id="set_stream" md5="TYyMhVo+VpOJV0sbWiIl2w">

sub set_stream {
  my $self = shift @_;
  $self->{ 'stream' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_stream_processed" get_id="" set_id="">
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

###--- <scalar_property id="_strings" get_id="" set_id="">
###---   <auto:comment id="_strings" md5="p/VgZTxNvR3geNAJo5gObw">

=head2 _strings

 Title   : _strings property
 
 Usage   : $object->_strings(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_strings" md5="+ANwOEwXGSVhfk8Rh5Hg5A">

sub _strings {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_strings' } = shift @_;
  }
  return $self->{ '_strings' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_strings" md5="xMmiYmZ+7U/CmXEnS3/7nA">

sub _get_strings {
  return shift->{ '_strings' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_strings" md5="80YhZfODWfmv+Fj6bK8rLA">

sub _set_strings {
  my $self = shift @_;
  $self->{ '_strings' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub file
{
  my( $self, $file ) = @_;

  if( defined( $file ) ) {
    my $stream;
    if( !open( $stream, $file ) ) {
      croak( "Can not open '$file' for reading (system: '$!')" );
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

  my $display_id = $self->id();
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
  $target->property( 'display_id', $self->display_id() );
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

sub strings
{
  my( $self ) = @_;
  $self->_process_stream();
  return $self->_get_strings();
}

sub _process_stream
{
  my( $self ) = @_;
  
  if( $self->_get_stream_processed() ) { return; }

  my $stream = $self->get_stream();
  my @lines = <$stream>;
  chomp( @lines );
  $self->_set_strings( \@lines );

  $self->_set_stream_processed( 1 );
}

##########################################################################

1;

