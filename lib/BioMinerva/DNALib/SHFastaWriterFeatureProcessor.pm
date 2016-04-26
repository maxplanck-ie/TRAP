##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SHFastaWriterFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureProcessor );

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
  return new BioMinerva::DNALib::SHFastaWriterFeatureProcessor();
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

###--- <scalar_property id="sequence_factory" get_id="" set_id="" link_id="" type="BioMinerva::DNALib::SequenceFactory">
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
###---   <auto:code link_id="link_sequence_factory" md5="g4SZ0RvMuykyQ2/p+m3Kwg">

sub link_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="line_length" get_id="" set_id="">
###---   <auto:comment id="line_length" md5="aOaPjX6dp1ztj8WX15N1Lg">

=head2 line_length

 Title   : line_length property
 
 Usage   : $object->line_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="line_length" md5="04yr+p6Ea+6SPmP/yP1NxQ">

sub line_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'line_length' } = shift @_;
  }
  return $self->{ 'line_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_line_length" md5="oC84PVhUD225kn0GGNvZTg">

sub get_line_length {
  return shift->{ 'line_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_line_length" md5="QiX2Hg3DwPZBjDtV1qwBaA">

sub set_line_length {
  my $self = shift @_;
  $self->{ 'line_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="subfeature_action" get_id="" set_id="">
###---   <auto:comment id="subfeature_action" md5="TG+Ly2CXyRLASGTnxm8u5A">

=head2 subfeature_action

 Title   : subfeature_action property
 
 Usage   : $object->subfeature_action(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="subfeature_action" md5="AfE3k+742XXhJZI/+F8zhQ">

sub subfeature_action {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'subfeature_action' } = shift @_;
  }
  return $self->{ 'subfeature_action' };
}

###---   </auto:code>
###---   <auto:code get_id="get_subfeature_action" md5="z9Ojz4o4gV8GlVPzM8Vp3g">

sub get_subfeature_action {
  return shift->{ 'subfeature_action' };
}

###---   </auto:code>
###---   <auto:code set_id="set_subfeature_action" md5="2hAAgqWJpfKT4BMp+NwkjQ">

sub set_subfeature_action {
  my $self = shift @_;
  $self->{ 'subfeature_action' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="spacer_action" get_id="" set_id="">
###---   <auto:comment id="spacer_action" md5="7wmjOudQFw/GJcJWA5ApjQ">

=head2 spacer_action

 Title   : spacer_action property
 
 Usage   : $object->spacer_action(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="spacer_action" md5="uSj0/YqLW7e8ui4kTJYETg">

sub spacer_action {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'spacer_action' } = shift @_;
  }
  return $self->{ 'spacer_action' };
}

###---   </auto:code>
###---   <auto:code get_id="get_spacer_action" md5="7PSb9SNxU8wIukm66JEfgw">

sub get_spacer_action {
  return shift->{ 'spacer_action' };
}

###---   </auto:code>
###---   <auto:code set_id="set_spacer_action" md5="g4uRQm69Z3srhDLYL41kHw">

sub set_spacer_action {
  my $self = shift @_;
  $self->{ 'spacer_action' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="subfeatures_type" get_id="" set_id="">
###---   <auto:comment id="subfeatures_type" md5="bg0eeOR21SlxxFuJFxjgbQ">

=head2 subfeatures_type

 Title   : subfeatures_type property
 
 Usage   : $object->subfeatures_type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="subfeatures_type" md5="Hz52Z0JmmkiLEAUu/6AvQQ">

sub subfeatures_type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'subfeatures_type' } = shift @_;
  }
  return $self->{ 'subfeatures_type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_subfeatures_type" md5="YF0+G4BFf4pOzhI+eLj79A">

sub get_subfeatures_type {
  return shift->{ 'subfeatures_type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_subfeatures_type" md5="HMVmJjPzgnPkjivNxTRR1g">

sub set_subfeatures_type {
  my $self = shift @_;
  $self->{ 'subfeatures_type' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="force_strand" get_id="" set_id="">
###---   <auto:comment id="force_strand" md5="WtadFTrLes9DGmdI/yqNZQ">

=head2 force_strand

 Title   : force_strand property
 
 Usage   : $object->force_strand(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="force_strand" md5="bRkScBtMSu78GG4FAMYX5A">

sub force_strand {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'force_strand' } = shift @_;
  }
  return $self->{ 'force_strand' };
}

###---   </auto:code>
###---   <auto:code get_id="get_force_strand" md5="stOmj6zMnkcr1vtorFjWtQ">

sub get_force_strand {
  return shift->{ 'force_strand' };
}

###---   </auto:code>
###---   <auto:code set_id="set_force_strand" md5="Hz2fY21Jw8n8DvrhbHI4Ew">

sub set_force_strand {
  my $self = shift @_;
  $self->{ 'force_strand' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="ignore_missing_sequences" get_id='' set_id=''>
###---   <auto:comment id="ignore_missing_sequences" md5="hupxSKm3CvTGX9nzgV5/8w">

=head2 ignore_missing_sequences

 Title   : ignore_missing_sequences property
 
 Usage   : $object->ignore_missing_sequences(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ignore_missing_sequences" md5="YID4uC7JEFOoVu6aFRWkvQ">

sub ignore_missing_sequences {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ignore_missing_sequences' } = shift @_;
  }
  return $self->{ 'ignore_missing_sequences' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ignore_missing_sequences" md5="N630owE8M7QKIzMsdn0s1A">

sub get_ignore_missing_sequences {
  return shift->{ 'ignore_missing_sequences' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ignore_missing_sequences" md5="hPYX7+sLl1dRwk0h4GHAZg">

sub set_ignore_missing_sequences {
  my $self = shift @_;
  $self->{ 'ignore_missing_sequences' } = shift @_;
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
    $self->_stream( $stream );
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
  $target->property( 'line_length', $self->line_length() );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'subfeature_action', $self->subfeature_action() );
  $target->property( 'spacer_action', $self->spacer_action() );
  $target->property( 'subfeatures_type', $self->subfeatures_type() );
  $target->property( 'force_strand', $self->force_strand() );
  $target->property( 'ignore_missing_sequences', $self->get_ignore_missing_sequences() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
  $target->property( 'line_length' );
  $target->property( 'sequence_factory' );
  $target->property( 'subfeature_action' );
  $target->property( 'spacer_action' );
  $target->property( 'subfeatures_type' );
  $target->property( 'force_strand' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  elsif( $property eq 'line_length' ) { $self->line_length( @values ); }
  elsif( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  elsif( $property eq 'subfeature_action' ) { $self->subfeature_action( @values ); }
  elsif( $property eq 'spacer_action' ) { $self->spacer_action( @values ); }
  elsif( $property eq 'subfeatures_type' ) { $self->subfeatures_type( @values ); }
  elsif( $property eq 'force_strand' ) { $self->force_strand( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_sequence_factory( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature {
  my( $self, $feature ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }
  
  my $original_strand = undef;
  # ----- nonconventional strand ignorance -----
  if( defined( $self->get_force_strand() ) ) {
    $original_strand = $feature->get_strand();
    if( $original_strand > 0 ) { $original_strand = '+'; }
    elsif( $original_strand < 0 ) { $original_strand = '-'; }
    
    $feature = $feature->clone();
    $feature->set_strand( $self->get_force_strand() );
    foreach my $part_feature( @{ $feature->part_features() || [] } ) {
      $part_feature->set_strand( $self->get_force_strand() );
    }
  }
  
  # ----- header line -----
  my $location = $feature->location_str();
  my $id = defined( $feature->get_id() )
    ? $feature->get_id()
    : $location;

  ### ----- here masking of the original seq -----
  my $seq;
  
  if( ( defined( $self->get_subfeature_action() ) || defined( $self->get_spacer_action() ) ) ) {
    my $subfeatures = defined( $self->get_subfeatures_type() ) 
      ? $feature->subfeatures_by_type( $self->get_subfeatures_type() )
      : $feature->part_features();
    my $elements = $feature->unified_subsequences_and_spacer_sequence_elements( $subfeatures );

    $seq = "";
    foreach my $element( @{ $elements || [] } ) {
      my $subsequence = $element->{ 'sequence' };

      $subsequence->trim( $feature );
      
      my $subseq = $sequence_factory->sequence2seq( $subsequence );
      if( !defined( $subseq ) ) { 
        if( $self->get_ignore_missing_sequences() ) {
          return;
        } else {
          confess( "Sequence for $subsequence is not provided by the sequence_factory in $self" );
        }
      }
      
      if( length( $subseq ) != $subsequence->length() ) {
        confess( 
          "Returned length(\$subseq)=" 
          . length( $subseq )
          . " unequal to expected length " 
          . $subsequence->length()
          . " of $subsequence" 
        );
      }

      if( $element->{ 'type' } eq 'subfeature' ) {
        $subseq = $self->_subfeature_seq_action( $subseq, $self->subfeature_action() );
      } else {
        $subseq = $self->_subfeature_seq_action( $subseq, $self->spacer_action() );
      }
      $seq .= $subseq;
    }
  } else {
    $seq = $sequence_factory->sequence2seq( $feature );
    
    if( !defined( $seq ) ) {
      if( $self->get_ignore_missing_sequences() ) {
        return;
      } else {
        carp( "Sequence for $feature is not provided by the sequence_factory in $self; output skipped" );
      }
    }
  }

  if( length( $seq ) != $feature->length() ) {
    confess( 
      "Returned length( \$seq )=" 
      . length( $seq )
      . " unequal to expected length " 
      . $feature->length()
      . " of $feature" 
    );
  }

  my $strand = $feature->get_strand();
  if( $strand > 0 ) { $strand = '+'; }
  elsif( $strand < 0 ) { $strand = '-'; }
  
  my $attr = {};
  $attr->{ 'seq_id' } = $feature->get_primary_sequence_id();
  $attr->{ 'type' } = $feature->get_type();
  $attr->{ 'start' } = $feature->get_start();
  $attr->{ 'end' } = $feature->get_end();
  $attr->{ 'strand' } = $strand;
  if( defined( $original_strand ) ) {
    $attr->{ 'original_strand' } = $original_strand;
  }
  $attr->{ 'target' } = 
    $feature->get_primary_sequence_id()
    . ":"
    . $feature->get_start()
    . ".."
    . $feature->get_end();
  
  my $attr_str = join( " ",
    map { "/$_='" . $attr->{ $_ } . "'" }
    keys( %{ $attr } )
  );
  
  ### ----- final writing -----
  $self->_write_fasta( $seq, "$id\t$attr_str" );
}

##########################################################################

sub _write_fasta
{
  my( $self, $seq, $header ) = @_;
  
  if( !defined( $header ) ) 
    { confess( "Can not write a fasta seq without a header in $self" ); }
  
  my $line_length = $self->get_line_length();
  if( !defined( $line_length ) || $line_length < 0 ) { $line_length = 60; }
  elsif( $line_length == 0 ) { $line_length = length( $seq ); }

  print { $self->stream() } ">$header\n";

  for( my $pos = 0; $pos < length( $seq ); ) {
    my $line = substr( $seq, $pos, $line_length );
    print { $self->stream() } $line;
    print { $self->stream() } "\n";
    $pos += $line_length;
  }
}

##########################################################################

sub _subfeature_seq_action
{
  my( $self, $seq, $action ) = @_;

  if( !defined( $action ) ) {
  } elsif( $action eq 'lc' ) {
    $seq = lc( $seq );
  } elsif( $action eq 'uc' ) {
    $seq = uc( $seq );
  } elsif( length( $action ) == 1 ) {
    $seq = $action x length( $seq );
  } else {
    confess( "Unknown action '$action' to be performed on a sequence in $self" );
  }
  
  return $seq;
}

##########################################################################

1;
