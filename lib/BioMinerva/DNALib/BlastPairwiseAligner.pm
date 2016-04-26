##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BlastPairwiseAligner;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Matcher;
@ISA = qw( BioMinerva::DNALib::Matcher );

##########################################################################

use File::Temp;
use BioMinerva::DNALib::FastaWriterSequenceProcessor;
use BioMinerva::DNALib::BlastPairwiseAlignment;
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

###--- <scalar_property id="pairwise_alignment_processor" get_id='' set_id='' type='BioMinerva::DNALib::PairwiseAlignmentProcessor'>
###---   <auto:comment id="pairwise_alignment_processor" md5="9svCa42IAE5G44rB6whI0A">

=head2 pairwise_alignment_processor

 Title   : pairwise_alignment_processor property
 
 Usage   : $object->pairwise_alignment_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pairwise_alignment_processor" md5="99fUB/W2cU5DL/M8eHC3ng">

sub pairwise_alignment_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pairwise_alignment_processor' } = shift @_;
  }
  return $self->{ 'pairwise_alignment_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pairwise_alignment_processor" md5="rIAYvwTKttyo9QxAabjwQw">

sub get_pairwise_alignment_processor {
  return shift->{ 'pairwise_alignment_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pairwise_alignment_processor" md5="AtujGksclcsm0itC8M5/HA">

sub set_pairwise_alignment_processor {
  my $self = shift @_;
  $self->{ 'pairwise_alignment_processor' } = shift @_;
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

###--- <scalar_property id="e_value_cutoff" get_id='' set_id=''>
###---   <auto:comment id="e_value_cutoff" md5="DglylErQ0JowZ1n3CUJEIA">

=head2 e_value_cutoff

 Title   : e_value_cutoff property
 
 Usage   : $object->e_value_cutoff(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="e_value_cutoff" md5="9mraDuVvXAx7IK0wdwJWzw">

sub e_value_cutoff {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'e_value_cutoff' } = shift @_;
  }
  return $self->{ 'e_value_cutoff' };
}

###---   </auto:code>
###---   <auto:code get_id="get_e_value_cutoff" md5="0lsfU+thpa8Mu8oupDYGGw">

sub get_e_value_cutoff {
  return shift->{ 'e_value_cutoff' };
}

###---   </auto:code>
###---   <auto:code set_id="set_e_value_cutoff" md5="AMWWscWcSxk8/Q4T1HF9uA">

sub set_e_value_cutoff {
  my $self = shift @_;
  $self->{ 'e_value_cutoff' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->get_sequence_factory() );
  $target->property( 'pairwise_alignment_processor', $self->get_pairwise_alignment_processor() );
  $target->property( 'blast_database', $self->get_blast_database() );
  $target->property( 'blastall_exec_file', $self->get_blastall_exec_file() );
  $target->property( 'e_value_cutoff', $self->get_e_value_cutoff() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub align_sequence
{
  my( $self, $sequence ) = @_;

  my $blast_database = $self->get_blast_database();
  if( !ref( $blast_database ) ) {
    croak( "Undefined blast_database in $self" );
  }

  my $sequence_id = $sequence->display_id();

  my $fasta_file_temp = new File::Temp(
    SUFFIX => ".$sequence_id.fa",
    UNLINK => 1
  );

  $self->_write_fasta( $fasta_file_temp->filename(), $sequence );

  my $blast_database_title = $blast_database->blast_database_title();

  my $blast_file_temp = new File::Temp(
    SUFFIX => ".$sequence_id.$blast_database_title.blast",
    UNLINK => 1
  );

  $self->_exec_blast( 
    $blast_database,
    $fasta_file_temp->filename(),
    $blast_file_temp->filename()
  );

  $self->_parse_blast_file( 
    $self->get_sequence_factory(),
    $blast_database->get_sequence_factory(),
    $blast_file_temp->filename()
  );
}

##########################################################################

sub _write_fasta
{
  my( $self, $fasta_file, $sequence ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }

  my $fasta_writer_sequence_processor = new BioMinerva::DNALib::FastaWriterSequenceProcessor();
  $fasta_writer_sequence_processor->file( $fasta_file );
  $fasta_writer_sequence_processor->set_sequence_factory( $sequence_factory );

  $fasta_writer_sequence_processor->process_sequence( $sequence );
}

sub _exec_blast
{
  my( $self, $blast_database, $fasta_file, $blast_file ) = @_;

  my @cmd = (
    $self->get_blastall_exec_file() || "blastall", 
    "-p", "blastn",
    "-m", "8",
    "-d", $blast_database->blast_database_file_base(),
    "-i", $fasta_file,
    "-o", $blast_file
  );

  if( defined( $self->get_e_value_cutoff() ) ) {
    push @cmd, "-e", $self->get_e_value_cutoff();
  }
  
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
  my( $self, $query_sequence_factory, $target_sequence_factory, $blast_file ) = @_;

  my $pairwise_alignment_processor = $self->get_pairwise_alignment_processor();
  if( !ref( $pairwise_alignment_processor ) ) {
    croak( "Undefined pairwise_alignment_processor in $self" );
  }

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

    my $blast_pairwise_alignment = new BioMinerva::DNALib::BlastPairwiseAlignment();

    $blast_pairwise_alignment->set_query_sequence(
      $query_sequence_factory->sequence_id_start_end2sequence(
        $query_sequence_id,
        $query_start,
        $query_end
      )
    );

    $blast_pairwise_alignment->set_target_sequence(
      $target_sequence_factory->sequence_id_start_end2sequence(
        $target_sequence_id,
        $target_start,
        $target_end
      )
    );

    $blast_pairwise_alignment->set_identity( $identity );
    $blast_pairwise_alignment->set_alignment_length( $alignment_length );
    $blast_pairwise_alignment->set_mismatches( $mismatches );
    $blast_pairwise_alignment->set_gaps( $gaps );
    $blast_pairwise_alignment->set_e_value( $e_value );
    $blast_pairwise_alignment->set_bit_score( $bit_score );
    
    $pairwise_alignment_processor->process_pairwise_alignment(
      $blast_pairwise_alignment 
    );
  }

  if( !close( $blast_stream ) ) {
    confess( "Can't close blast_file '$blast_file'" );
  }
}

##########################################################################

1;
