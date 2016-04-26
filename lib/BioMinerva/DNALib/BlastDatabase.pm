##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BlastDatabase;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

##########################################################################

use File::Temp;
use File::Basename;
use BioMinerva::Base::ProgressInfo;
use BioMinerva::Base::InfoViewer;
use BioMinerva::DNALib::AllSequencesAlgorithm;
use BioMinerva::DNALib::FastaWriterSequenceProcessor;
use Carp qw( confess carp croak );

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

###--- <scalar_property id="sequence_factory" get_id='' set_id='' type='BioMinerva::DNALib::SequenceFactory'>
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
###--- </scalar_property>

###--- <scalar_property id="blast_database_dir" get_id='' set_id=''>
###---   <auto:comment id="blast_database_dir" md5="csJhkUsAN1gqqsV1IG9jIg">

=head2 blast_database_dir

 Title   : blast_database_dir property
 
 Usage   : $object->blast_database_dir(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="blast_database_dir" md5="43DtvxIt4EX/PwGRiWU3Qg">

sub blast_database_dir {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'blast_database_dir' } = shift @_;
  }
  return $self->{ 'blast_database_dir' };
}

###---   </auto:code>
###---   <auto:code get_id="get_blast_database_dir" md5="D4c7v6uXyt6gC24tM9h7TA">

sub get_blast_database_dir {
  return shift->{ 'blast_database_dir' };
}

###---   </auto:code>
###---   <auto:code set_id="set_blast_database_dir" md5="v/HvZm0s/zVGJ9bBrsyJOA">

sub set_blast_database_dir {
  my $self = shift @_;
  $self->{ 'blast_database_dir' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="formatdb_exec_file" get_id='' set_id=''>
###---   <auto:comment id="formatdb_exec_file" md5="s8g/Len15SU7VgrPfgFzAg">

=head2 formatdb_exec_file

 Title   : formatdb_exec_file property
 
 Usage   : $object->formatdb_exec_file(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="formatdb_exec_file" md5="R0xrPu74DqhgpjsA6xe4Ww">

sub formatdb_exec_file {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'formatdb_exec_file' } = shift @_;
  }
  return $self->{ 'formatdb_exec_file' };
}

###---   </auto:code>
###---   <auto:code get_id="get_formatdb_exec_file" md5="guU5+QLh28/6SJfIKS6hkg">

sub get_formatdb_exec_file {
  return shift->{ 'formatdb_exec_file' };
}

###---   </auto:code>
###---   <auto:code set_id="set_formatdb_exec_file" md5="TASalmdzMYcJyJQd76lV7A">

sub set_formatdb_exec_file {
  my $self = shift @_;
  $self->{ 'formatdb_exec_file' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->get_sequence_factory() );
  $target->property( 'blast_database_dir', $self->get_blast_database_dir() );
  $target->property( 'formatdb_exec_file', $self->get_formatdb_exec_file() );
}

sub display_id
{
  my( $self ) = @_;

  my @ids;

  {
    my $display_id = $self->SUPER::display_id();
    if( defined( $display_id ) ) {
      push @ids, $display_id;
    }
  }

  {
    my $sequence_factory = $self->get_sequence_factory();
    if( ref( $sequence_factory ) ) {
      push @ids, $sequence_factory->display_id();
    }
  }

  push @ids, $self->blast_database_title();

  return join( ":", @ids );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub blast_database_title
{
  my( $self ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }
  
  return $sequence_factory->sequences_digest()->hexdigest();
}

sub blast_database_file_base
{
  my( $self ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }
  
  my $blast_database_title = $self->blast_database_title();

  my $blast_database_dir = $self->get_blast_database_dir();
  my $blast_database_file_base = $blast_database_dir
    ? ( "$blast_database_dir/$blast_database_title" )
    : $blast_database_title;

  if( !$self->_exist_blast_database_files( $blast_database_file_base ) ) {
    my $fasta_file_temp = new File::Temp(
      SUFFIX => ".$blast_database_title.fa",
      UNLINK => 1
    );

    $self->_sequence_factory2fasta_file( $sequence_factory, $fasta_file_temp->filename() );

    $self->_fasta_file2blast_database_files( 
      $fasta_file_temp->filename(),
      $blast_database_title,
      $blast_database_file_base
    );
  }

  return $blast_database_file_base;
}

sub _exist_blast_database_files
{
  my( $self, $blast_database_file_base ) = @_;

  if( !stat( "$blast_database_file_base.nhr" ) ) { return 0; }
  if( !stat( "$blast_database_file_base.nin" ) ) { return 0; }
  if( !stat( "$blast_database_file_base.nsq" ) ) { return 0; }

  return 1;
}

sub _sequence_factory2fasta_file
{
  my( $self, $sequence_factory, $fasta_file ) = @_;

  my $sequence_processor = new BioMinerva::DNALib::FastaWriterSequenceProcessor();
  $sequence_processor->file( $fasta_file );
  $sequence_processor->set_sequence_factory( $sequence_factory );

  my $all_sequences_algorithm = new BioMinerva::DNALib::AllSequencesAlgorithm();
  $all_sequences_algorithm->set_sequence_factory( $sequence_factory );
  $all_sequences_algorithm->set_sequence_processor( $sequence_processor );

  $all_sequences_algorithm->process();
}

sub _fasta_file2blast_database_files
{
  my( $self, $fasta_file, $blast_database_title, $blast_database_file_base ) = @_;

  my $progress_info = new BioMinerva::Base::ProgressInfo();
  $progress_info->set_title( "Formatdb (fa:$fasta_file" . "->blast:$blast_database_title)" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );

  my $ret;

#TODO: try
  {
    my @cmd = (
      $self->get_formatdb_exec_file() || "formatdb", 
      '-t', $blast_database_title,
      '-i', $fasta_file,
      '-p', 'F',
      '-n', $blast_database_file_base
    );
    
    my $result = system( @cmd );
    if( $? == -1 ) {
      croak(
        "Command: \"" . join( " ", @cmd ) . "\""
        . " failed to execute: $!"
      );
    } elsif( $? & 127 ) {
      croak(
        "Command: \"" . join( " ", @cmd ) . "\""
        . " died with signal "
        . ( $? & 127 )
      );
    }
    $ret = $? >> 8;
  }
#TODO: catch
  $info_viewer->pop_info();

  return $ret;
}

##########################################################################

1;
