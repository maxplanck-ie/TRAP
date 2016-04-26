##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioAlignIOBioSimpleAlignFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::BioSimpleAlignFactory;
@ISA = qw( BioMinerva::DNALib::BioSimpleAlignFactory );

use BioMinerva::Base::Cache;
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
  return new BioMinerva::DNALib::BioAlignIOBioSimpleAlignFactory();
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

###--- <scalar_property id="_file" get_id="" set_id=''>
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

###--- <scalar_property id="_indexes" get_id="" set_id=''>
###---   <auto:comment id="_indexes" md5="K+rRhlFpAGuwiQUnJf7y/g">

=head2 _indexes

 Title   : _indexes property
 
 Usage   : $object->_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_indexes" md5="HL7/73caqO40xg0fieJjYw">

sub _indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_indexes' } = shift @_;
  }
  return $self->{ '_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_indexes" md5="vTWVazy3G0AJZqQzzLtgzg">

sub _get_indexes {
  return shift->{ '_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_indexes" md5="qvfANu0/OFxG78PYg3QpaA">

sub _set_indexes {
  my $self = shift @_;
  $self->{ '_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_indexes_processed" get_id="" set_id=''>
###---   <auto:comment id="_indexes_processed" md5="FiETyTn/Y7kOUfLDdFn5aQ">

=head2 _indexes_processed

 Title   : _indexes_processed property
 
 Usage   : $object->_indexes_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_indexes_processed" md5="Wzgxocm5PKbJAMWADnMNlQ">

sub _indexes_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_indexes_processed' } = shift @_;
  }
  return $self->{ '_indexes_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_indexes_processed" md5="f+gJPu0gAY5M/z78bDE/lQ">

sub _get_indexes_processed {
  return shift->{ '_indexes_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_indexes_processed" md5="SjzSJ1PuTUpdebOk/FDoQA">

sub _set_indexes_processed {
  my $self = shift @_;
  $self->{ '_indexes_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="cache" get_id="" set_id="" link_id="" type="BioMinerva::Base::Cache">
###---   <auto:comment id="cache" md5="3kOEDljBE8sswmQg2RTsnQ">

=head2 cache

 Title   : cache property
 
 Usage   : $object->cache(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cache" md5="LJrSpqSu7SrbkDOYQEz2Cw">

sub cache {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cache' } = shift @_;
  }
  return $self->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cache" md5="sNbj7L09T3yplxvvYxRswA">

sub get_cache {
  return shift->{ 'cache' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cache" md5="4imknzaQxLx3YpnQdSAhdQ">

sub set_cache {
  my $self = shift @_;
  $self->{ 'cache' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_cache" md5="x9nExR+XV4n0gEzzuyH1iA">

sub link_cache {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'cache' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'cache' } =
      $registry->type_id2object(
        'BioMinerva::Base::Cache', $ref
      );
  }
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

sub file
{
  my( $self, $file ) = @_;

  if( defined( $file ) ) {
    my $stream;
    if( !open( $stream, $file ) ) {
      croak( "Can not open '$file' for reading (system: '$!')" );
    }

    $self->_set_file( $file );
    $self->set_stream( $stream );
  } else {
    return $self->_get_file();
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
  $target->property( 'cache', $self->cache() );
  $target->property( 'format', $self->format() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub indexes
{
  my( $self ) = @_;

  $self->_process_indexes();
  return $self->_indexes();
}

##########################################################################

sub index2bio_simple_align
{
  my( $self, $index ) = @_;
  
  my $file = $self->_get_file();
  my $stream;
  if( !open( $stream, $file ) ) {
    croak( "Undefined file/stream in $self" );
  }
#  my $stream = $self->get_stream();
#  if( !defined( $stream ) ) {
#    croak( "Undefined file/stream in $self" );
#  }
  
  my $bio_align_io = 
    new Bio::AlignIO( 
      -fh => $stream, 
      -format => ( $self->get_format() || 'maf' )
    );
    
  my $bio_simple_align = $bio_align_io->next_aln();
 
  seek( $stream, $index, 0 );

  $bio_simple_align = $bio_align_io->next_aln();

  return $bio_simple_align;
}

##########################################################################

sub index_iterator
{
  my( $self ) = @_;

  my $indexes = $self->indexes();

  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $indexes );
  
  return $iterator;
}

##########################################################################

sub _process_indexes
{
  my( $self ) = @_;

  croak( "Unmaintained, probably not used anymore" );

  if( $self->_get_indexes_processed() ) {
    return;
  }
  
  my $file = $self->_get_file();
  
  my $cache = $self->get_cache();
  my $cache_signature = ref( $cache ) 
    ? $cache->signature( [ 
        $cache->file_info( $file )
      ] )
    : undef;
    
  my $indexes;
  if( !ref( $cache ) || !$cache->peek( $cache_signature, \$indexes ) ) 
  {
    my $stream;
    if( !open( $stream, $file ) ) {
      croak( "Undefined file/stream in $self" );
    }

#  my $stream = $self->get_stream();
#  if( !defined( $stream ) ) {
#    croak( "Undefined file/stream in $self" );
#  }

    my $bio_align_io = 
      new Bio::AlignIO( 
        -fh => $stream, 
        -format => ( $self->get_format() || 'maf' )
      );

    $indexes = [];
    my $counter = 0;
    my $index = tell( $stream );
    while( my $aln = $bio_align_io->next_aln() )
    {
      push @{ $indexes }, $index;
      $index = tell( $stream );

      ++$counter;
      if( !( $counter % 100 ) ) {
        print STDERR "\r#Indexing features (file='"
          . $self->_get_file()
          . "'): $counter done...     ";
      }
    }

    if( ref( $cache ) ) { 
      $cache->poke( $cache_signature, $indexes );
      $cache->save();
    }
    
    print STDERR "\r#Indexed $counter feature(s) (file='"
      . $self->_get_file()
      . "')"
      . ( " " x 20 ) . "\n";
  }

  $self->_set_indexes( $indexes );

  $self->_set_indexes_processed( 1 );
}

##########################################################################

1;
