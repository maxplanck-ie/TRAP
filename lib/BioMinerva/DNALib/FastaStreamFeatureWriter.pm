##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FastaStreamFeatureWriter;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::StreamFeatureWriter;
@ISA = qw( BioMinerva::DNALib::StreamFeatureWriter );

use Carp qw( confess carp );
use URI::Escape;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::FastaStreamFeatureWriter();
}

##########################################################################
# PROPERTIES
##########################################################################

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

###--- <scalar_property id="line_length" assignable_once="1">
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
###--- </scalar_property>

###--- <scalar_property id="subfeature_action" assignable_once="1">
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
###--- </scalar_property>

###--- <scalar_property id="spacer_action" assignable_once="1">
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
###--- </scalar_property>

###--- <scalar_property id="subfeatures_type" assignable_once="1">
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'line_length', $self->line_length() );
  $target->property( 'subfeature_action', $self->subfeature_action() );
  $target->property( 'spacer_action', $self->spacer_action() );
  $target->property( 'subfeatures_type', $self->subfeatures_type() );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'ignore_missing_sequences', $self->get_ignore_missing_sequences() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'line_length' );
  $target->property( 'subfeature_action' );
  $target->property( 'spacer_action' );
  $target->property( 'subfeatures_type' );
  $target->property( 'sequence_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'line_length' ) { $self->line_length( @values ); }
  elsif( $property eq 'subfeature_action' ) { $self->subfeature_action( @values ); }
  elsif( $property eq 'spacer_action' ) { $self->spacer_action( @values ); }
  elsif( $property eq 'subfeatures_type' ) { $self->subfeatures_type( @values ); }
  elsif( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
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

sub write_feature {
  my( $self, $feature ) = @_;

  # ----- header line -----
  my $type = $feature->type() || "";
  my $id = $self->_feature2id( $feature );
  my $location = $self->_location_sequence( $feature );

  my %attrs_hash = %{ $feature->attrs() || {} };
  foreach my $key( sort keys %attrs_hash ) {
    $attrs_hash{ $key } =
      $self->_format_attribute( $attrs_hash{ $key }, 0 );
  }
  my $attrs = join( ";", 
    map { defined( $attrs_hash{ $_ } ) ? ( $_ . "=" . $attrs_hash{ $_ } ) : "" } 
    keys %attrs_hash );
  
  my $notes = "";

  ### ----- here masking of the original seq -----
  my $seq;
  
  if( ( defined( $self->subfeature_action() ) || defined( $self->spacer_action() ) ) ) {
    my $subfeatures = defined( $self->subfeatures_type() ) 
      ? $feature->subfeatures_by_type( $self->subfeatures_type() )
      : $feature->parts();
    my $elements = $feature->unified_subsequences_and_spacer_sequence_elements( $subfeatures );

    $seq = "";
    foreach my $element( @{ $elements || [] } ) {
      my $subsequence = $element->{ 'sequence' };

      if( !$feature->contains( $subsequence ) ) {
        confess( "Splicing problem: $self does not contain $subsequence" );
      }

      my $subseq = $self->_sequence2seq( $subsequence );
      if( !defined( $subseq ) ) { 
        if( $self->get_ignore_missing_sequences() ) {
          return;
        } else {
          carp( "Sequence for $subsequence is not provided by the sequence_factory in $self; output skipped" );
        }
      }
      
      if( length( $subseq ) != $subsequence->length() ) {
        confess( 
          "Returned length( \$subseq )=" 
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
    $seq = $self->_sequence2seq( $feature );
    
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

  ### ----- final writing -----
  $self->_write_fasta( $seq, "$id\t$type|$location|$notes|$attrs" );
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

sub _write_fasta
{
  my( $self, $seq, $header ) = @_;
  
  if( !defined( $header ) ) 
    { confess( "Can not write a fasta seq without a header in $self" ); }
  
  my $line_length = $self->line_length();
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

sub _feature2id
{
  my( $self, $feature ) = @_;

  my $id = $feature->id();
  if( !defined( $id ) ) 
    { $id = join( ":", @{ $feature->attr( 'ID' ) || [] } ) }
  if( defined( $id ) && $id ne '' ) 
    { return $id; }
  confess( "No ID in $feature" );
}

sub _sequence2seq
{
  my( $self, $sequence ) = @_;

  if( !ref( $self->sequence_factory() ) ) {
    confess( "In order to write sequences sequence_factory must be defined in $self" );
  }
  
  return $self->sequence_factory()->sequence2seq( $sequence );
}

sub _location_sequence {
  my( $self, $sequence ) = @_;
  
  my $location = join( ":",
    ( $sequence->primary_sequence_id() || "?" ),
    ( $sequence->start() || "?" )
    . ".."
    . ( $sequence->end() || "?" ),
    ( $sequence->strand() || "" )
  );

  return $location;
}

sub _format_attribute
{
  my( $self, $arg, $leave_spaces ) = @_;

  if( !defined( $arg ) ) { 
    return undef; 
  } elsif( ref( $arg ) eq "" ) { 
    return $self->_format_attribute_scalar( $arg, $leave_spaces ); 
  } elsif( ref( $arg ) eq "SCALAR" ) { 
    return $self->_format_attribute_scalar( $arg, $leave_spaces ); 
  } elsif( ref( $arg ) eq "ARRAY" ) {
    if( scalar( @{ $arg } ) == 0 ) { return undef; }
    return join( 
      ",",
      map { 
        my $v = $self->_format_attribute_scalar( $_, $leave_spaces );
        defined( $v ) ? $v : "";
      } @{ $arg } 
    );
  }
  return undef;
}

sub _format_attribute_scalar
{
  my( $self, $arg, $leave_spaces ) = @_;
  my $chars = $leave_spaces ? '^A-Za-z0-9\-_.!~*\'()\s' : '^A-Za-z0-9\-_.!~*\'()';
  return uri_escape( $arg, $chars );
}

##########################################################################

1;
