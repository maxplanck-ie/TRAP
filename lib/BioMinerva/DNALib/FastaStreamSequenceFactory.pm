##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FastaStreamSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FragmentedSequenceFactory;
@ISA = qw( BioMinerva::DNALib::FragmentedSequenceFactory );

use BioMinerva::DNALib::FastaStreamSequence;
use BioMinerva::Base::Cache;
use BioMinerva::Base::InfoViewer;
use BioMinerva::Base::CounterProgressInfo;
use BioMinerva::Base::FileCache;
use Carp qw( confess carp croak );
use POSIX qw( floor );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="ignore_location" get_id='' set_id=''>
###---   <auto:comment id="ignore_location" md5="rqnYu8R6r1YFybuAfZI4+g">

=head2 ignore_location

 Title   : ignore_location property
 
 Usage   : $object->ignore_location(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ignore_location" md5="LyW+n3DZeaNaCHp2lZfECg">

sub ignore_location {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ignore_location' } = shift @_;
  }
  return $self->{ 'ignore_location' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ignore_location" md5="Ta8KMRSXr7Le3db506f1GA">

sub get_ignore_location {
  return shift->{ 'ignore_location' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ignore_location" md5="hZQY6RdxlZowQ4/ytpxcQw">

sub set_ignore_location {
  my $self = shift @_;
  $self->{ 'ignore_location' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="stream" get_id="get_stream" set_id="set_stream" assignable_once="1">
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

###--- <scalar_property id="_file" get_id="_get_file" set_id="_set_file" assignable_once="1">
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
  $target->property( 'ignore_location', $self->get_ignore_location() );
  $target->property( 'file', $self->_get_file() );
  $target->property( 'cache', $self->get_cache() );
}

sub sequences_digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::sequences_digest();

  $digest->add( $self->get_ignore_location() || '' );
  $digest->add( BioMinerva::Base::Cache::file_digest_id( $self->_get_file() ) || '' );

  return $digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _process_sequences
{
  my( $self ) = @_;

  if( $self->_get_stream_processed() ) { return; }
  
  my $cache = $self->_get_default_cache();
  if( ref( $cache ) ) {
    my $cache_digest = $cache->cache_digest( 'FastaStreamSequenceFactory' );
    $cache_digest->add_file_info( $self->_get_file() );

    my $cached_data;
    if( $cache->peek( $cache_digest, \$cached_data ) ) {
      $self->_stored_sequences( shift( @{ $cached_data } ) );
      $self->_sequence_ids2stored_sequences( shift( @{ $cached_data } ) );
      $self->_primary_sequence_ids2stored_sequences( shift( @{ $cached_data } ) );
    } else {
      $self->_do_process_sequences();

      $cached_data = [
        $self->_stored_sequences(),
        $self->_sequence_ids2stored_sequences(),
        $self->_primary_sequence_ids2stored_sequences()
      ];

      $cache->poke( $cache_digest, $cached_data );
    }
  } else {
    $self->_do_process_sequences();
  }
  
  $self->_set_stream_processed( 1 );
}
 
sub _get_default_cache
{
  my( $self ) = @_;

  my $cache = $self->get_cache();
  if( ref( $cache ) ) {
    return $cache;
  } elsif( defined( $cache ) && !$cache ) {
    return undef;
  } else {
    return BioMinerva::Base::FileCache::file2default_cache( $self->_get_file() );
  }
}

sub _do_process_sequences
{
  my( $self ) = @_;
  my $line_no = 0;
  my $stream = $self->get_stream();

  if( !defined( $stream ) ) {
    croak( "File/stream undefined in $self" );
  }
  
  if( tell( $stream ) != 0 && !seek( $stream, 0, 0 ) ) {
    croak( "Failed to seek the input stream in $self" );
  }

  my $stream_size;
  if( seek( $stream, 0, 1 ) ) {
    if( !seek( $stream, 0, 2 ) ) {
      croak( "Failed to seek to the end the input stream in $self" );
    }
    $stream_size = tell( $stream ); 
    if( !seek( $stream, 0, 0 ) ) {
      croak( "Failed to seek back to the start the input stream in $self" );
    }
  }
  
  my $sequence;
  my $header;
  my $length;
  
  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "Indexing " . $self->display_id() );
  $progress_info->set_phase_attr( "sequence_id" );
  $progress_info->set_count_attr( undef );
  $progress_info->set_size( $stream_size );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO: try
  my $counter = 0;
  while( 1 ) {
    my $stream_pos = tell( $stream );
    my $line = <$stream>;
    ++$line_no;
    
    $progress_info->set_count( $stream_pos );

    if( !defined( $line ) ) {
      if( ref( $sequence ) ) {
        $self->_add_header_sequence_length( $header, $sequence, $length ); 
        $sequence = undef;
      }
      last;
    } elsif( $line =~ /^>(.*)$/ ) {
      if( ref( $sequence ) ) { 
        $self->_add_header_sequence_length( $header, $sequence, $length ); 
        $sequence = undef;
      }

      $sequence = new BioMinerva::DNALib::FastaStreamSequence();
      $header = $1;
      $header =~ s/\s+$//;
      $length = 0;

      $sequence->set_stream_start_pos( tell( $stream ) );
      $sequence->set_line_no( $line_no );

      if( $header =~ /^([^\s]+)/ ) {
        $progress_info->set_phase( $1 );
      }
    } else {
      chomp( $line );
      if( $line =~ /^\s*$/ ) {
        if( ref( $sequence ) ) { 
          $self->_add_header_sequence_length( $header, $sequence, $length ); 
          $sequence = undef;
        }
        next;
      }
      
      if( !ref( $sequence ) ) {
        croak( "Invalid fasta format: no sequence header (line_no=$line_no) in $self" );
      }
      
      if( $length == 0 ) {
        $sequence->set_chars_per_line( tell( $stream ) - $stream_pos );
        $sequence->set_bases_per_line( length( $line ) );
      } else {
        ; #TODO: here checking, where all lines of the same length
      }
      $length += length( $line );
    }
  }
  $progress_info->set_count( tell( $stream ) );
  $progress_info->set_phase( undef );
#TODO: catch:
  $info_viewer->pop_info();
}

sub _add_header_sequence_length
{
  my( $self, $header, $fasta_sequence, $length ) = @_;

  my $ignore_location = $self->get_ignore_location();
  
  my $attrs = $self->_fasta_header2hash( $header );

  my $sequence_id = delete $attrs->{ '' };
  my $primary_sequence_id = $sequence_id;
  my $start = 1;
  my $end = $length;
  my $strand = +1;

  if( !$ignore_location ) {
    if( defined( $attrs->{ 'primary_sequence_id' } ) ) {
      $primary_sequence_id = delete $attrs->{ 'primary_sequence_id' };
    }

    if( defined( $attrs->{ 'start' } ) && defined( $attrs->{ 'end' } ) ) {
      $start = delete $attrs->{ 'start' };
      $end = delete $attrs->{ 'end' };
      if( $end - $start + 1 != $length ) {
        croak( "Provided start=$start and end=$end of sequence_id '$sequence_id' "
          . "do not match actual length=$length of the sequence in $self" 
        );
      }
    }

    if( defined( $attrs->{ 'strand' } ) ) {
      $strand = delete $attrs->{ 'strand' };
      if( !$strand ) { $strand = +1; }
      elsif( $strand eq '+' ) { $strand = +1; }
      elsif( $strand eq '-' ) { $strand = -1; }
    }
  }

  $fasta_sequence->set_primary_sequence_id( $primary_sequence_id );
  $fasta_sequence->set_id( $sequence_id );
  $fasta_sequence->set_start( $start );
  $fasta_sequence->set_end( $end );
  $fasta_sequence->set_strand( $strand );
  
  foreach my $attr_key( keys %{ $attrs || {} } ) {
    $fasta_sequence->set_by_key_attr( $attr_key, $attrs->{ $attr_key } );
  }
  
  $self->_add_sequence( $fasta_sequence, $primary_sequence_id, $sequence_id );
}

sub _fasta_header2hash
{
  my( $self, $header ) = @_;

  my $attrs = {};
  
  if( $header !~ /^(\S+)((\s*$)|\s+(.*))/ ) {
    croak( "_fasta_header2hash: empty header line" );
  }

  $attrs->{ '' } = $1;
  
  my $attrs_str = $4;
  if( defined( $attrs_str ) ) {
    while( $attrs_str =~ /\/(\w+)=('(.*?)'|"(.*?)")/g ) {
      $attrs->{ $1 } = $3 || $4;
    }
  }

  return $attrs;
}

##########################################################################

sub _do_seek_seq
{
  my( $self, $fasta_sequence, $f_offs ) = @_;

  # ----- seeking to the f_offs position in the file -----
  my $stream = $self->stream();

  {
    my $line_no = POSIX::floor( $f_offs / $fasta_sequence->get_bases_per_line() );
    my $line_pos = $f_offs % $fasta_sequence->get_bases_per_line();
    if( 
      !seek( 
        $stream,
        $fasta_sequence->get_stream_start_pos()
          + $line_no * $fasta_sequence->get_chars_per_line()
          + $line_pos,
        0 #SEEK_SET
      )
    ) { 
      croak( "Failed to seek a fasta stream in $self" ) 
    };
  }
}

sub _do_get_seq
{
  my( $self, $fasta_sequence, $f_offs, $copy_length ) = @_;

  my $stream = $self->stream();

  my $line = <$stream>;
  if( !$line || $line =~ /^>/ ) { 
    croak( 
      "Fasta stream inconsistency (copy_length=$copy_length,"
      . "f_offs=$f_offs, fasta_sequence=$fasta_sequence) in $self"
    ); 
  }
  chomp( $line );

  return $line;
}

##########################################################################

1;

