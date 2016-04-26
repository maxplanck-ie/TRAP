##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3FeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIterator;
@ISA = qw( BioMinerva::DNALib::FeatureIterator );

use BioMinerva::DNALib::GFF3Feature;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::GFF3FeatureIterator();
  }

  $self->SUPER::clone( $clone );

#  $clone->set_stream( $self->get_stream() ); WARNING: dup the stream!
  confess( "Not completed yet" );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='stream' get_id='' set_id=''>
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

###--- <scalar_property id='_last_index' get_id='' set_id=''>
###---   <auto:comment id="_last_index" md5="6xK3dqCXFsJrGkfY19MscA">

=head2 _last_index

 Title   : _last_index property
 
 Usage   : $object->_last_index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_last_index" md5="cwpiDv6Q4ZyizfP1Jwk08Q">

sub _last_index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_last_index' } = shift @_;
  }
  return $self->{ '_last_index' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_last_index" md5="e+xT+nHlsaNRWp33D7wy3A">

sub _get_last_index {
  return shift->{ '_last_index' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_last_index" md5="WWAAiLnKvCGDPupuP9c0nA">

sub _set_last_index {
  my $self = shift @_;
  $self->{ '_last_index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_index' get_id='' set_id=''>
###---   <auto:comment id="_index" md5="uxE4qqV8unwT6sK0Ckk9sA">

=head2 _index

 Title   : _index property
 
 Usage   : $object->_index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_index" md5="u6tM2S9FfYYF/VGNu76oDQ">

sub _index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_index' } = shift @_;
  }
  return $self->{ '_index' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_index" md5="CbbS41lnhjt0lfC4zPpFhw">

sub _get_index {
  return shift->{ '_index' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_index" md5="YE+FDFDoSQ3fcJRvZ7KImg">

sub _set_index {
  my $self = shift @_;
  $self->{ '_index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_gff3line' get_id='' set_id=''>
###---   <auto:comment id="_gff3line" md5="2O42X7LousYwluBXiKlCag">

=head2 _gff3line

 Title   : _gff3line property
 
 Usage   : $object->_gff3line(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_gff3line" md5="Q/vZNPElM4eKZd/QGS09UA">

sub _gff3line {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_gff3line' } = shift @_;
  }
  return $self->{ '_gff3line' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_gff3line" md5="f1VMQdTjZhxVQIoJ6EMltA">

sub _get_gff3line {
  return shift->{ '_gff3line' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_gff3line" md5="JLCXLM+oHf7SCQPAqB/kPg">

sub _set_gff3line {
  my $self = shift @_;
  $self->{ '_gff3line' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_count' get_id='' set_id=''>
###---   <auto:comment id="_count" md5="8Ek1Y1MCL9LjJzcxlFhdnQ">

=head2 _count

 Title   : _count property
 
 Usage   : $object->_count(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_count" md5="cXLnZFaOJ4MNFukSrAcDLw">

sub _count {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_count' } = shift @_;
  }
  return $self->{ '_count' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_count" md5="qdq6YcR8YmYUv6LInWFi2w">

sub _get_count {
  return shift->{ '_count' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_count" md5="zOM0ORr5SXGcQO4LcokDaw">

sub _set_count {
  my $self = shift @_;
  $self->{ '_count' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;

  my $stream = $self->get_stream();
  if( !$stream ) {
    croak( "Undefined stream in $self" );
  }

  if( tell( $stream ) != 0 && !seek( $stream, 0, 0 ) ) {
    croak( "Failed to seek the input stream in $self" );
  }

  if( seek( $stream, 0, 1 ) ) {
    if( !seek( $stream, 0, 2 ) ) {
      croak( "Failed to seek to the end the input stream in $self" );
    }
    my $last_index = tell( $stream ); 
    if( !seek( $stream, 0, 0 ) ) {
      croak( "Failed to seek back to the start the input stream in $self" );
    }
    $self->_set_last_index( $last_index );
  }
  
  $self->_set_count( 0 );
  $self->_test_iterate( $stream );
}

sub valid
{
  my( $self ) = @_;
  
  return defined( $self->_get_index() );
}

sub iterate
{
  my( $self ) = @_;
  
  my $stream = $self->get_stream();
  if( !$stream ) {
    croak( "Undefined stream in $self" );
  }
  
  $self->_test_iterate( $stream );
  $self->_set_count( $self->_get_count() + 1 );
}

sub feature
{
  my( $self ) = @_;

  my $feature = new BioMinerva::DNALib::GFF3Feature();
  $feature->set_index( $self->_get_index() );
  $feature->set_gff3line( $self->_get_gff3line() );
  
  return $feature;
}

sub size
{
  my( $self ) = @_;

  return undef;
}

sub count
{
  my( $self ) = @_;

  return $self->_get_count() || 0;
}

sub progress
{
  my( $self ) = @_;

  my $last_index = $self->_get_last_index();
  if( $last_index ) {
    my $stream = $self->get_stream();
    if( !$stream ) { return undef; }
    return tell( $stream ) / $last_index;
  }
  
  return undef;
}

##########################################################################

sub _test_iterate
{
  my( $self, $stream ) = @_;
  
  while( 1 ) {
    my $index = tell( $stream );

    my $gff3line = <$stream>;
    if( !defined( $gff3line ) ) { 
      last; 
    }
    if( $gff3line =~ /^#/ ) {
      if( $gff3line =~ /^##FASTA\s*$/ ) {
        last; 
      }
      next; 
    }
    if( $gff3line =~ /^\s*$/ ) { next; }
    chomp $gff3line;

    $self->_set_index( $index );
    $self->_set_gff3line( $gff3line );
    return;
  }

  $self->_set_index( undef );
  $self->_set_gff3line( undef );
}

##########################################################################

1;
