##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::MafStreamBioSimpleAlignFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::BioSimpleAlignFactory;
@ISA = qw( BioMinerva::DNALib::BioSimpleAlignFactory );

use BioMinerva::Base::Cache;
use BioMinerva::Base::ArrayIterator;
use BioMinerva::DNALib::Sequence;
use BioMinerva::DNALib::Feature;
use Bio::SimpleAlign;
use BioMinerva::Base::CounterProgressInfo;
use BioMinerva::Base::InfoViewer;
use Carp qw( confess croak carp );

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

  my $stream = $self->get_stream();
  if( !defined( $stream ) ) {
    croak( "Undefined file/stream in $self" );
  }
  
  if( !seek( $stream, $index, 0 ) ) {
    confess( "Failed to seek to index $index in $self" );
  }

  my $line = <$stream>;
  if( $line !~ /^a score=([-.0-9]+)$/ ) {
    confess( "Incorrect header line at index $index in $self: $line" );
  }
  
  my $bio_simple_align = new Bio::SimpleAlign();
  $bio_simple_align->score( $1 );
  $bio_simple_align->id( $index );

  while( my $line = <$stream> ) {
    if( $line =~ /^\s*$/ ) {
      last;
    } elsif( $line !~ /^s\s+/ ) {
      confess( "Incorrect sequence line at index $index in $self: $line" );
    }
    my( undef, $primary_sequence_id, $start, $length, $strand, $primary_sequence_length, $seq ) =
      split( /\s+/, $line );
      
    my $bio_seq = new Bio::LocatableSeq(
      '-id' => $primary_sequence_id,
      '-start' => $start,
      '-end' => $start + $length - 1,
      '-strand' => $strand,
      '-seq' => $seq
    );

=for nothing
    $bio_seq->display_name( $primary_sequence_id );
    if( $strand eq '-' ) {
      $bio_seq->start( $primary_sequence_length - $end );
      $bio_seq->end( $primary_sequence_length - $start );
      $bio_seq->strand( -1 );
    } else {
      $bio_seq->start( $start );
      $bio_seq->end( $end );
      $bio_seq->strand( +1 );
    }
    $bio_seq->attach_seq( $seq );
=cut

    $bio_simple_align->add_seq( $bio_seq );
  }
  
  return $bio_simple_align;
}

sub index_bio_seq_no2sequence
{
  my( $self, $index, $bio_seq_no ) = @_;

  if( $bio_seq_no < 1 ) {
    confess( "Incorrect bio_seq_no=$bio_seq_no (should be at least 1)" );
  }
  
  my $stream = $self->get_stream();
  if( !defined( $stream ) ) {
    croak( "Undefined file/stream in $self" );
  }
  
  if( !seek( $stream, $index, 0 ) ) {
    confess( "Failed to seek to index $index in $self" );
  }

  my $line = <$stream>;
  if( $line !~ /^a score=([-.0-9]+)$/ ) {
    confess( "Incorrect header line at index $index in $self: $line" );
  }

  while( my $line = <$stream> ) {
    if( $line =~ /^\s*$/ ) {
      last;
    } elsif( $line !~ /^s\s+/ ) {
      confess( "Incorrect sequence line at index $index in $self: $line" );
    }
    if( --$bio_seq_no ) {
      next;
    }
    
    my( undef, $primary_sequence_id, $start, $length, $strand ) =
      split( /\s+/, $line );
      
    my $sequence = new BioMinerva::DNALib::Sequence();
    $sequence->set_id( $index );
    $sequence->set_primary_sequence_id( $primary_sequence_id );
    $sequence->set_start( $start );
    $sequence->set_end( $start + $length - 1 );
    if( $strand eq '+' ) { $strand = +1; }
    elsif( $strand eq '-' ) { $strand = -1; }
    $sequence->set_strand( $strand );

    return $sequence;
  }
  
  return undef;
}

sub index_bio_seq_no2feature
{
  my( $self, $index, $bio_seq_no ) = @_;
  
  if( $bio_seq_no < 1 ) {
    confess( "Incorrect bio_seq_no=$bio_seq_no (should be at least 1)" );
  }
  
  my $stream = $self->get_stream();
  if( !defined( $stream ) ) {
    croak( "Undefined file/stream in $self" );
  }
  
  if( !seek( $stream, $index, 0 ) ) {
    croak( "Failed to seek to index $index in $self" );
  }

  my $line = <$stream>;
  if( $line !~ /^a score=([-.0-9]+)$/ ) {
    croak( "Incorrect header line at index $index in $self: $line" );
  }
  my $score = $1;

  my $counter_bio_seq_no = 0;
  my $feature;
  
  while( my $line = <$stream> ) {
    if( $line =~ /^\s*$/ ) {
      last;
    } elsif( $line !~ /^s\s+/ ) {
      croak( "Incorrect sequence line at index $index in $self: $line" );
    }
    if( ++$counter_bio_seq_no != $bio_seq_no ) {
      next;
    }
    
    my( undef, $primary_sequence_id, $start, $length, $strand ) =
      split( /\s+/, $line );

    $feature = new BioMinerva::DNALib::Feature();
    $feature->set_id( $index );
    $feature->set_type( 'nucleotide_match' );
    $feature->set_primary_sequence_id( $primary_sequence_id );
    $feature->set_start( $start );
    $feature->set_end( $start + $length - 1 );
    if( $strand eq '+' ) { $strand = +1; }
    elsif( $strand eq '-' ) { $strand = -1; }
    $feature->set_strand( $strand );
    $feature->set_score( $score );
  }
 
  if( !ref( $feature ) ) {
    croak( "Incorrect bio_seq_no=$bio_seq_no for alignment index="
      . "$index in $self" );
  }
  $feature->add_attr( 'conservation', $counter_bio_seq_no );
  return $feature;
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
  
  if( $self->_get_indexes_processed() ) {
    return;
  }

  my $indexes;

  my $cache = $self->get_cache();
  if( !ref( $cache ) ) {
    $indexes = $self->_do_calc_indexes();
  } else {
    my $cache_digest = $cache->cache_digest( 'MafStreamBioSimpleAlignFactory::indexes' );
    $cache_digest->add( $cache->file_info( $self->_get_file() ) ); #TODO: move file_info to File

    my $cached_data;
    if( $cache->peek( $cache_digest, \$cached_data ) ) {
      $indexes = shift( @{ $cached_data } );
    } else {
      $indexes = $self->_do_calc_indexes();

      $cached_data = [ $indexes ];
      $cache->poke( $cache_digest, $cached_data );
    }
  }

  $self->_set_indexes( $indexes );

  $self->_set_indexes_processed( 1 );
}

sub _do_calc_indexes
{
  my( $self ) = @_;

  my $stream = $self->stream();
  my $last_index;

  if( tell( $stream ) != 0 && !seek( $stream, 0, 0 ) ) {
    croak( "Failed to seek the input stream in $self" );
  }

  if( seek( $stream, 0, 1 ) ) {
    if( !seek( $stream, 0, 2 ) ) {
      croak( "Failed to seek to the end the input stream in $self" );
    }
    $last_index = tell( $stream ); 
    if( !seek( $stream, 0, 0 ) ) {
      croak( "Failed to seek back to the start the input stream in $self" );
    }
  }

  my $indexes = [];

  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( 
    "Indexing ("
    . $self->display_id()
    . ")" 
  );
  $progress_info->set_phase_attr( "alignment" );
  $progress_info->set_count_attr( undef );
  $progress_info->set_size( $last_index );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO: try
  my $count = 0;
  while( 1 ) {
    my $index = tell( $stream );
    my $line = <$stream>;
    if( !defined( $line ) ) { last; }

    if( $line =~ /^#/ ) { next; }
    elsif( $line !~ /^a\s+score=/ ) { next; }
    
    $progress_info->set_count( $index );
    $progress_info->set_phase( $count++ );
    push @{ $indexes }, $index;

  }
  $progress_info->set_phase( $count );
  $progress_info->set_count( $last_index );
#TODO: catch:
  $info_viewer->pop_info();

  return $indexes;
}

##########################################################################

1;
