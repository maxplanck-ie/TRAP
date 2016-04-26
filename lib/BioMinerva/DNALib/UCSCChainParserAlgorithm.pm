##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::UCSCChainParserAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Carp qw( confess croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::UCSCChainParserAlgorithm();
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

###--- <scalar_property id="t_feature_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="t_feature_processor" md5="cnHsN9iPnh/wThbxm6ymmQ">

=head2 t_feature_processor

 Title   : t_feature_processor property
 
 Usage   : $object->t_feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="t_feature_processor" md5="zvE58YFf1o83nnUjDnWLcQ">

sub t_feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 't_feature_processor' } = shift @_;
  }
  return $self->{ 't_feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_t_feature_processor" md5="eA2MpobXOQq2x+d6WvcsaQ">

sub get_t_feature_processor {
  return shift->{ 't_feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_t_feature_processor" md5="y/4E7RTJ/JTb/4fZ7qCjoQ">

sub set_t_feature_processor {
  my $self = shift @_;
  $self->{ 't_feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_t_feature_processor" md5="4WtnBGv6IRirsP/f93715g">

sub link_t_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 't_feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 't_feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="q_feature_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="q_feature_processor" md5="EuM4sl/VL1XqioK29AvOTg">

=head2 q_feature_processor

 Title   : q_feature_processor property
 
 Usage   : $object->q_feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="q_feature_processor" md5="8iPwG7j78ssRRUVE07u/Yg">

sub q_feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'q_feature_processor' } = shift @_;
  }
  return $self->{ 'q_feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_q_feature_processor" md5="Bzj8UMwC3XIj8DMBK/CJjA">

sub get_q_feature_processor {
  return shift->{ 'q_feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_q_feature_processor" md5="lTS+btmaSulEK8WBKPNlDQ">

sub set_q_feature_processor {
  my $self = shift @_;
  $self->{ 'q_feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_q_feature_processor" md5="5PfRJ+I0BQ01SWUosWXiRg">

sub link_q_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'q_feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'q_feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="links_only" get_id="" set_id="">
###---   <auto:comment id="links_only" md5="cxKmkouP4BleVvJ1v1zgww">

=head2 links_only

 Title   : links_only property
 
 Usage   : $object->links_only(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="links_only" md5="+2z9vZHVaFuiwSmVV4UvZA">

sub links_only {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'links_only' } = shift @_;
  }
  return $self->{ 'links_only' };
}

###---   </auto:code>
###---   <auto:code get_id="get_links_only" md5="2kWn9HX3ZW61fZNRq6z9+g">

sub get_links_only {
  return shift->{ 'links_only' };
}

###---   </auto:code>
###---   <auto:code set_id="set_links_only" md5="SZDm1Fd3Vw1tVTgcURRKUw">

sub set_links_only {
  my $self = shift @_;
  $self->{ 'links_only' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="remove_chr" get_id="" set_id="">
###---   <auto:comment id="remove_chr" md5="Dazd8FhuSLPysBKgPA9yaQ">

=head2 remove_chr

 Title   : remove_chr property
 
 Usage   : $object->remove_chr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="remove_chr" md5="GoKSSgRAbA69FSRZ3vuf8Q">

sub remove_chr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'remove_chr' } = shift @_;
  }
  return $self->{ 'remove_chr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_remove_chr" md5="gMblWmEcEk69G1L081oBRA">

sub get_remove_chr {
  return shift->{ 'remove_chr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_remove_chr" md5="EOSdYWRoszo5/e8C+yc/3Q">

sub set_remove_chr {
  my $self = shift @_;
  $self->{ 'remove_chr' } = shift @_;
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'file', $self->_file() );
  $target->property( 't_feature_processor', $self->t_feature_processor() );
  $target->property( 'q_feature_processor', $self->q_feature_processor() );
  $target->property( 'links_only', $self->links_only() );
  $target->property( 'remove_chr', $self->remove_chr() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
  $target->property( 't_feature_processor' );
  $target->property( 'q_feature_processor' );
  $target->property( 'links_only' );
  $target->property( 'remove_chr' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  elsif( $property eq 't_feature_processor' ) { $self->t_feature_processor( @values ); }
  elsif( $property eq 'q_feature_processor' ) { $self->q_feature_processor( @values ); }
  elsif( $property eq 'links_only' ) { $self->links_only( @values ); }
  elsif( $property eq 'remove_chr' ) { $self->remove_chr( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_t_feature_processor( $registry );
  $self->link_q_feature_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $stream = $self->get_stream();
  my $tfeature_processor = $self->get_t_feature_processor();
  my $qfeature_processor = $self->get_q_feature_processor();
  my $links_only = $self->get_links_only();
  my $remove_chr = $self->get_remove_chr();

  if( !ref( $tfeature_processor ) && !ref( $qfeature_processor ) ) {
    croak( "Neither t_feature_processor, not q_feature_processor defined in $self" );
  }
  if( !$stream ) {
    croak( "No file/stream provided in $self" );
  }
  
  my $chain_tfeature;
  my $chain_qfeature;
  my $chain_tSize;
  my $chain_qSize;
  my $chain_tStart_cur;
  my $chain_qStart_cur;
  my $chain_qName;
  my $chain_qStrand;

  my $counter = 0;
  while( 1 ) {
    my $index = tell( $stream );
    my $line = <$stream>;
    if( !defined( $line ) ) { 
      last; 
    }

    chomp $line;
    if( $line =~ /^#/ ) { 
      next; 
    } elsif( $line =~ /^\s*$/ ) {
      next;
    } elsif( $line =~ /^chain\s*/ ) {
      if( ref( $chain_tfeature ) ) {
        confess( "Incorrect logic when processing the chain file" );
      }
      
      ( undef, 
        my $score, 
        my $tName, 
        my $tSize,
        my $tStrand,
        my $tStart,
        my $tEnd,
        my $qName,
        my $qSize,
        my $qStrand,
        my $qStart,
        my $qEnd,
        my $id
      ) =
        split( /\s/, $line );

      # ----- use 1-based coordinate system -----
      $tStart += 1;
      $tEnd += 1;
      if( $tStrand eq '+' ) { $tStrand = +1; }
      elsif( $tStrand eq '-' ) { $tStrand = -1; }

      $qStart += 1;
      $qEnd += 1;
      if( $qStrand eq '+' ) { $qStrand = +1; }
      elsif( $qStrand eq '-' ) { $qStrand = -1; }
     
      if( $remove_chr ) {
        $tName =~ s/^chr//;
        $qName =~ s/^chr//;
      }
      
      # ----- for coordinate processing -----
      $chain_tSize = $tSize + 1;
      $chain_tStart_cur = $tStart;

      $chain_qSize = $qSize + 1;
      $chain_qName = $qName;
      $chain_qStrand = $qStrand;
      $chain_qStart_cur = $qStart;

      # ----- create tfeature -----
      $chain_tfeature = new BioMinerva::DNALib::Feature();
      $chain_tfeature->type( 'region' );
      $chain_tfeature->id( $index );
      $chain_tfeature->primary_sequence_id( $tName );
      $chain_tfeature->strand( $tStrand );
      if( $tStrand >= 0 ) {
        $chain_tfeature->start( $tStart );
        $chain_tfeature->end( $tEnd );
      } else {
        $chain_tfeature->start( $chain_tSize - $tEnd );
        $chain_tfeature->end( $chain_tSize - $tStart );
      }
      if( defined( $id ) ) {
        $chain_tfeature->add_attr( 'ID', $id );
      }
      $chain_tfeature->set_score( $score );
      
      # ----- create qfeature -----
      $chain_qfeature = new BioMinerva::DNALib::Feature();
      $chain_qfeature->type( 'region' );
      $chain_qfeature->id( $index );
      $chain_qfeature->primary_sequence_id( $qName );
      $chain_qfeature->strand( $qStrand );
      if( $qStrand >= 0 ) {
        $chain_qfeature->start( $qStart );
        $chain_qfeature->end( $qEnd );
      } else {
        $chain_qfeature->start( $chain_qSize - $qEnd );
        $chain_qfeature->end( $chain_qSize - $qStart );
      }
      if( defined( $id ) ) {
        $chain_qfeature->add_attr( 'ID', $id );
      }
      $chain_qfeature->set_score( $score );
    } else {
      ( my $size,
        my $dt,
        my $dq
      ) =
        split( /\s/, $line );

      if( !ref( $chain_tfeature ) ) {
        confess( "Incorrect file format, chain line missing" );
      }
      
      # ----- create tfeature -----
      if( ref( $tfeature_processor ) ) {
        my $tfeature = new BioMinerva::DNALib::Feature();
        $tfeature->type( 'nucleotide_match' );
        $tfeature->primary_sequence_id( $chain_tfeature->primary_sequence_id() );
        $tfeature->strand( $chain_tfeature->strand() );
        if( $chain_tfeature->strand() >= 0 ) {
          $tfeature->start( $chain_tStart_cur );
          $tfeature->end( $chain_tStart_cur + $size - 1 );
        } else {
          $tfeature->start( $chain_tSize - ( $chain_tStart_cur + $size - 1 ) );
          $tfeature->end( $chain_tSize - $chain_tStart_cur );
        }
        $tfeature->id( $index );
        if( !$links_only ) {
          $chain_tfeature->add_part( $tfeature );
        } else {
          $tfeature_processor->process_feature( $tfeature );
        }
      }

      # ----- create tfeature -----
      if( ref( $qfeature_processor ) ) {
        my $qfeature = new BioMinerva::DNALib::Feature();
        $qfeature->type( 'nucleotide_match' );
        $qfeature->primary_sequence_id( $chain_qfeature->primary_sequence_id() );
        $qfeature->strand( $chain_qfeature->strand() );
        if( $chain_qfeature->strand() >= 0 ) {
          $qfeature->start( $chain_qStart_cur );
          $qfeature->end( $chain_qStart_cur + $size - 1 );
        } else {
          $qfeature->start( $chain_qSize - ( $chain_qStart_cur + $size - 1 ) );
          $qfeature->end( $chain_qSize - $chain_qStart_cur );
        }
        $qfeature->id( $index );
        if( !$links_only ) {
          $chain_qfeature->add_part( $qfeature );
        } else {
          $qfeature_processor->process_feature( $qfeature );
        }
      }
      
      if( defined( $dt ) ) {
        $chain_tStart_cur += $size + $dt;
        $chain_qStart_cur += $size + $dq;
      } else {
        if( ref( $tfeature_processor ) ) {
          if( !$links_only ) {
            $tfeature_processor->process_feature( $chain_tfeature );
          }
        }
        $chain_tfeature = undef;

        if( ref( $qfeature_processor ) ) {
          if( !$links_only ) {
            $qfeature_processor->process_feature( $chain_qfeature );
          }
        }
        $chain_qfeature = undef;
      }
    }
    
    ++$counter;
    if( !( $counter % 10000 ) ) {
      print STDERR "\r#Processing chain features: $counter done...     ";
    }
  }
}

##########################################################################

1;
