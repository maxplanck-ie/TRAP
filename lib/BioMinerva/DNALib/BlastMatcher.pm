##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BlastMatcher;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Matcher;
@ISA = qw( BioMinerva::DNALib::Matcher );

##########################################################################

use BioMinerva::DNALib::Match;
use File::Temp;
use File::Basename;
use BioMinerva::DNALib::StoreSequence;
use BioMinerva::DNALib::StoreSequenceFactory;
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

###--- <scalar_property id="blastall_exec_file" get_id='' set_id=''>
###---   <auto:comment id="blastall_exec_file" md5="dkukvmlkzCHI+bbM9CEUFQ">

=head2 blastall_exec_file

 Title   : blastall_exec_file property
 
 Usage   : $object->blastall_exec_file(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="blastall_exec_file" md5="yRg85XypDl79f897qsrKaQ">

sub blastall_exec_file {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'blastall_exec_file' } = shift @_;
  }
  return $self->{ 'blastall_exec_file' };
}

###---   </auto:code>
###---   <auto:code get_id="get_blastall_exec_file" md5="aee0RX9FRSextR189O1duw">

sub get_blastall_exec_file {
  return shift->{ 'blastall_exec_file' };
}

###---   </auto:code>
###---   <auto:code set_id="set_blastall_exec_file" md5="23Ib3Kol/Xyu72PuMqEq7Q">

sub set_blastall_exec_file {
  my $self = shift @_;
  $self->{ 'blastall_exec_file' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="blast_database" get_id='' set_id='' type='BioMinerva::DNALib::BlastDatabase'>
###---   <auto:comment id="blast_database" md5="mAx9d2z7pgozgK+yacvUjg">

=head2 blast_database

 Title   : blast_database property
 
 Usage   : $object->blast_database(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="blast_database" md5="BMYO7Lwi2H4s9PXy6Jue/Q">

sub blast_database {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'blast_database' } = shift @_;
  }
  return $self->{ 'blast_database' };
}

###---   </auto:code>
###---   <auto:code get_id="get_blast_database" md5="IZt5xlZmuWNiPgQdC4XSoQ">

sub get_blast_database {
  return shift->{ 'blast_database' };
}

###---   </auto:code>
###---   <auto:code set_id="set_blast_database" md5="nRellr+dArTJBXc4AQYxEw">

sub set_blast_database {
  my $self = shift @_;
  $self->{ 'blast_database' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="cutoff" get_id='' set_id=''>
###---   <auto:comment id="cutoff" md5="bTXq2jMxBZgJCyKc0fwjNQ">

=head2 cutoff

 Title   : cutoff property
 
 Usage   : $object->cutoff(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cutoff" md5="uyTQ+0zzTaj3E1dUlrcJ/Q">

sub cutoff {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cutoff' } = shift @_;
  }
  return $self->{ 'cutoff' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cutoff" md5="33q4n8XOX4qDnQkFPwneow">

sub get_cutoff {
  return shift->{ 'cutoff' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cutoff" md5="fwL9+c7qrTUINin4GLJd+w">

sub set_cutoff {
  my $self = shift @_;
  $self->{ 'cutoff' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'blastall_exec_file', $self->get_blastall_exec_file() );
  $target->property( 'blast_database', $self->get_blast_database() );
  $target->property( 'cutoff', $self->get_cutoff() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_sequence_seq
{
  my( $self, $match_processor, $sequence, $seq ) = @_;

  my $blast_database = $self->get_blast_database();
  if( !ref( $blast_database ) ) {
    croak( "Undefined blast_database in $self" );
  }

  my $sequence_id = $sequence->display_id();

  my $fasta_file_temp = new File::Temp(
    SUFFIX => ".$sequence_id.fa",
    UNLINK => 1
  );

  $self->_write_fasta( $fasta_file_temp->filename(), $sequence, $seq );

  my $blast_database_title = $blast_database->blast_database_title();

  my $blast_file_temp = new File::Temp(
    SUFFIX => ".$sequence_id.$blast_database_title.blast",
    UNLINK => 1
  );

  $self->_exec_blast( $blast_database, $fasta_file_temp->filename(), $blast_file_temp->filename() );

  my $alignments = $self->_parse_blast_file( $blast_file_temp->filename() );
}

sub max_num_of_matches
{
  my( $self, $sequence ) = @_;
  
  confess( "Not overridden in $self" );
}

sub score2p_value
{
  my( $self, $score ) = @_;

  confess( "Not overridden in $self" );
}

##########################################################################

sub _write_fasta
{
  my( $self, $fasta_file, $sequence, $seq ) = @_;

  my $store_sequence = new BioMinerva::DNALib::StoreSequence();
  $store_sequence->set_sequence( $sequence );
  $store_sequence->set_seq( $seq );

  my $store_sequence_factory = new BioMinerva::DNALib::StoreSequenceFactory();
  $store_sequence_factory->add_store_sequence( $store_sequence );

  my $fasta_writer_sequence_processor = new BioMinerva::DNALib::FastaWriterSequenceProcessor();
  $fasta_writer_sequence_processor->file( $fasta_file );
  $fasta_writer_sequence_processor->set_sequence_factory( $store_sequence_factory );

  $fasta_writer_sequence_processor->process_sequence( $store_sequence );
}

sub _exec_blast
{
  my( $self, $blast_database, $fasta_file, $blast_file ) = @_;

  my @cmd = (
    $self->get_blastall_exec_file() || "blastall", 
    "-p", "blastn",
    "-e", "0.01",
    "-m", "8",
    "-d", $blast_database->blast_database_file_base(),
    "-i", $fasta_file,
    "-o", $blast_file
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
  
  my $ret = $? >> 8;
  return $ret;
}

sub _parse_blast_file
{
  my( $self, $blast_file ) = @_;

  my $blast_stream;
  if( !open( $blast_stream, $blast_file ) ) {
    confess( "Can't reopen blast_file '$blast_file'" );
  }

  while( my $line = <$blast_stream> ) {
    chomp( $line );

    my( 
      $query_sequence_id, $target_sequence_id,
      $identity,
      $alignment_length, $mismatches, $gaps,
      $query_start, $query_end,
      $target_start, $target_end,
      $e_value, $bit_score
    ) = split( /\t/, $line );

    print $line;
  }

  if( !close( $blast_stream ) ) {
    confess( "Can't close blast_file '$blast_file'" );
  }
}

=for nothing

sub _process_sequence_seq_strand
{
  my( $self, $match_processor, $sequence, $seq, $strand ) = @_;

  my $pssm = $self->get_pssm();
  if( !ref( $pssm ) ) {
    croak( "Undefined pssm in $self" );
  }

  my $pssm_matrix = ( $strand < 0 )
    ? $pssm->get_complemented_matrix()
    : $pssm->get_matrix();
  my $pssm_length = scalar( @{ $pssm_matrix } );
  my $cutoff = $self->get_cutoff();
  
  my $seq_pos;
  my $seq_cur_pos;
  my $pssm_pos;
  my $score;
  my $s;
  
  my $match = new BioMinerva::DNALib::PssmMatch();
  $match->set_ref_sequence( $sequence );
  $match->set_ref_seq( $seq );
  $match->set_matcher( $self );
  $match->set_strand( $strand );
  
  for( $seq_pos = 0; $seq_pos < length( $seq ); ++$seq_pos ) 
  {
    # ----- score -----
    $score = 0;

    $seq_cur_pos = $seq_pos;
    for( $pssm_pos = 0; $pssm_pos < $pssm_length; ) {
      $s = $pssm_matrix->[ $pssm_pos ]->{ uc( substr( $seq, $seq_cur_pos, 1 ) ) };
      if( !defined( $s ) ) { 
        if( substr( $seq, $seq_cur_pos, 1 ) eq '-' && $pssm_pos ) 
          { ++$seq_cur_pos; next; }
        $score = undef;
        last;
      } else {
        $score += $s;
        ++$seq_cur_pos;
        ++$pssm_pos;
      }
    }
      
    # ----- threshold -----
    if( !defined( $score ) ) { next; }
    elsif( $score < $cutoff ) { next; }
    
    # ----- feature -----
    $match->set_start( $seq_pos );
    $match->set_end( $seq_cur_pos - 1 );
    $match->set_score( $score );
    
    $match_processor->process_match( $match );
  }
}

=cut

##########################################################################

1;
