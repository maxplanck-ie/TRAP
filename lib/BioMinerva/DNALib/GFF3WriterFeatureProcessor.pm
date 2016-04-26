##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3WriterFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureProcessor );

use Carp qw( confess carp croak );
use URI::Escape;
use BioMinerva::DNALib::Feature;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::GFF3WriterFeatureProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

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

###--- <scalar_property id="_stream" assignable_once="1">
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

###--- <scalar_property id='source_attr' get_id='get_source_attr' set_id='set_source_attr' assignable_once="1">
###---   <auto:comment id="source_attr" md5="WR32UQF6JTN8pFudc3oLFQ">

=head2 source_attr

 Title   : source_attr property
 
 Usage   : $object->source_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="source_attr" md5="p83O06i1IyD+ZA/mhAKNBg">

sub source_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'source_attr' } = shift @_;
  }
  return $self->{ 'source_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_source_attr" md5="UxUF5ORAvRbU1Ihvu9VoXQ">

sub get_source_attr {
  return shift->{ 'source_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_source_attr" md5="W9d3pMD35K95CjdgWgLldg">

sub set_source_attr {
  my $self = shift @_;
  $self->{ 'source_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='no_escaping' get_id='get_no_escaping' set_id='set_no_escaping' assignable_once="1">
###---   <auto:comment id="no_escaping" md5="up0TqPwLzEAJk3PNupvPAg">

=head2 no_escaping

 Title   : no_escaping property
 
 Usage   : $object->no_escaping(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="no_escaping" md5="8ATluWQTQZ2NuQir03uKkQ">

sub no_escaping {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'no_escaping' } = shift @_;
  }
  return $self->{ 'no_escaping' };
}

###---   </auto:code>
###---   <auto:code get_id="get_no_escaping" md5="H1xBz5iPngrGlEj75DrUcA">

sub get_no_escaping {
  return shift->{ 'no_escaping' };
}

###---   </auto:code>
###---   <auto:code set_id="set_no_escaping" md5="b2Lpl0umGuW0KD/XNslYQg">

sub set_no_escaping {
  my $self = shift @_;
  $self->{ 'no_escaping' } = shift @_;
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
  $target->property( 'source_attr', $self->get_source_attr() );
  $target->property( 'no_escaping', $self->get_no_escaping() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
  $target->property( 'source_attr' );
  $target->property( 'no_escaping' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  elsif( $property eq 'source_attr' ) { $self->set_source_attr( @values ); }
  elsif( $property eq 'no_escaping' ) { $self->set_no_escaping( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature
{
  my( $self, $feature ) = @_;

  my %temp_id2parent_ids;
  my %temp_id2processed;
  
  $self->_build_temp_id2parent_ids( 
    \%temp_id2parent_ids, 
    $feature 
  );
  $self->_write_features_level(
    \%temp_id2parent_ids, 
    \%temp_id2processed, 
    [ $feature ] 
  );
}

##########################################################################

sub _build_temp_id2parent_ids
{
  my( $self, $temp_id2parent_ids, $feature ) = @_;

  my $part_features = $feature->part_features() || [];
  if( !@{ $part_features } ) {
    return;
  }
  
  my $feature_id = $feature->get_id();
  if( !defined( $feature_id ) || $feature_id eq '' ) {
    croak( "A parent feature must have an id, not like in $feature" );
  }
  
  foreach my $part_feature( @{ $part_features } ) {
    my $part_temp_id = $part_feature->digest()->digest();
    $temp_id2parent_ids->{ $part_temp_id } ||= [];
    push @{ $temp_id2parent_ids->{ $part_temp_id } }, $feature_id;

    $self->_build_temp_id2parent_ids( $temp_id2parent_ids, $part_feature );
  }
}

sub _write_features_level
{
  my( $self, $temp_id2parent_ids, $temp_id2processed, $features ) = @_;

  my @next_features;
  
  foreach my $feature( @{ $features || [] } ) {
    my $temp_id = $feature->digest()->digest();

    if( $temp_id2processed->{ $temp_id } ) { next; }
    $temp_id2processed->{ $temp_id } = 1;

    push @next_features, @{ $feature->part_features() || [] };

    $self->_write_feature_line( $feature, $temp_id2parent_ids->{ $temp_id } );
  }
 
  if( @next_features ) {
    $self->_write_features_level(
      $temp_id2parent_ids, $temp_id2processed, \@next_features );
  }
}

##########################################################################

sub _write_feature_line
{
  my( $self, $feature, $parent_ids ) = @_;

  my %attrs = %{ $feature->attrs() || {} };
  my $source = $feature->get_source();
  if( $self->get_source_attr() ) {
    $source = $self->get_source_attr();
  }
  my $score = $feature->get_score();
  my $phase;
  if( exists( $attrs{ "Phase" } ) ) {
    $phase = join( ":", @{ $attrs{ "Phase" } || [] } );
    delete $attrs{ "Phase" };
  }
  if( defined( $feature->get_id() ) ) {
    $attrs{ 'ID' } = $feature->get_id();
  }
  if( @{ $parent_ids || [] } ) {
    $attrs{ 'Parent' } = $parent_ids;
  }
  
  $self->_write_gff3_line( 
    $feature, $source, $score, $phase, \%attrs );
}

##########################################################################

sub _write_gff3_line
{
  my( $self, $feature, $source, $score, $phase, $attrs ) = @_;
  
  foreach my $key( sort keys %{ $attrs } ) {
    $attrs->{ $key } =
      $self->_gff3_attribute( $attrs->{ $key }, 0 );
  }
  
  my $attrs_str = join( ";", 
    map { defined( $attrs->{ $_ } ) ? ( $_ . "=" . $attrs->{ $_ } ) : "" } 
    keys %{ $attrs } );

  my $strand = $feature->get_strand();  
  if( !defined( $strand ) ) { $strand = '.'; }
  elsif( $strand > 0 ) { $strand = '+'; }
  elsif( $strand < 0 ) { $strand = '-'; }
  else { $strand = '.'; }

  my @arr = (
    $feature->get_primary_sequence_id(),
    $source,
    $feature->get_type(),
    $feature->get_start(),
    $feature->get_end(),
    $score,
    $strand,
    $phase,
    $attrs_str
  );

  print { $self->stream() }
    join( "\t", map { defined( $_ ) ? $_ : '.' } @arr )
    . "\n";
}

sub _gff3_attribute
{
  my( $self, $arg, $leave_spaces ) = @_;

  if( !defined( $arg ) ) { 
    return undef; 
  } elsif( ref( $arg ) eq "" ) { 
    return $self->_gff_attribute_scalar( $arg, $leave_spaces ); 
  } elsif( ref( $arg ) eq "SCALAR" ) { 
    return $self->_gff_attribute_scalar( $arg, $leave_spaces ); 
  } elsif( ref( $arg ) eq "ARRAY" ) {
    if( scalar( @{ $arg } ) == 0 ) { return undef; }
    return join( 
      ",",
      map { 
        my $v = $self->_gff_attribute_scalar( $_, $leave_spaces );
        defined( $v ) ? $v : "";
      } @{ $arg } 
    );
  }
  return undef;
}

sub _gff_attribute_scalar
{
  my( $self, $arg, $leave_spaces ) = @_;
  if( $self->get_no_escaping() ) { return $arg; }
  my $chars = $leave_spaces ? '^A-Za-z0-9\-_.!~*\'()\s' : '^A-Za-z0-9\-_.!~*\'()';
  return uri_escape( $arg, $chars );
}

##########################################################################

1;
