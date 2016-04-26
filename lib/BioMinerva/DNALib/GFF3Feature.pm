##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3Feature;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Feature;
@ISA = qw( BioMinerva::DNALib::Feature );

use URI::Escape;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone {
  my( $self, $clone ) = @_;
  
  confess( "Not completed yet" );
}

sub clone_without_part_features {
  my( $self, $clone ) = @_;
  
  confess( "Not completed yet" );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='gff3line' get_id='' set_id=''>
###---   <auto:comment id="gff3line" md5="MxJeSw3hT/iJxeqtPOeO+A">

=head2 gff3line

 Title   : gff3line property
 
 Usage   : $object->gff3line(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gff3line" md5="VKtPwgHXHnf+U3QHxi1Mgw">

sub gff3line {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gff3line' } = shift @_;
  }
  return $self->{ 'gff3line' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gff3line" md5="PcR+YeiKbJ88TmfcOLdfFA">

sub get_gff3line {
  return shift->{ 'gff3line' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gff3line" md5="0mIHTxwMdl2xJ3ECHukGug">

sub set_gff3line {
  my $self = shift @_;
  $self->{ 'gff3line' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_var_split_gff3line' get_id='' set_id=''>
###---   <auto:comment id="_var_split_gff3line" md5="xzhUlXeq/S7k3kJgwUaysA">

=head2 _var_split_gff3line

 Title   : _var_split_gff3line property
 
 Usage   : $object->_var_split_gff3line(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_var_split_gff3line" md5="ha55E5AowdpJwoSRLdLifQ">

sub _var_split_gff3line {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_var_split_gff3line' } = shift @_;
  }
  return $self->{ '_var_split_gff3line' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_var_split_gff3line" md5="r6utT+t1+QrF7QrAOntzYQ">

sub _get_var_split_gff3line {
  return shift->{ '_var_split_gff3line' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_var_split_gff3line" md5="KDHLDgDPL2BmY2mTg6eoaA">

sub _set_var_split_gff3line {
  my $self = shift @_;
  $self->{ '_var_split_gff3line' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_var_attrs' get_id='' set_id=''>
###---   <auto:comment id="_var_attrs" md5="sPnrVQYlI97BL7u/dXSEZQ">

=head2 _var_attrs

 Title   : _var_attrs property
 
 Usage   : $object->_var_attrs(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_var_attrs" md5="56PvLkJQgvs6Ilax1kz0/A">

sub _var_attrs {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_var_attrs' } = shift @_;
  }
  return $self->{ '_var_attrs' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_var_attrs" md5="lBFzogMV2Fs/5HS8wT1pwg">

sub _get_var_attrs {
  return shift->{ '_var_attrs' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_var_attrs" md5="6JxhfZnsZhrI7wKPJWg+bw">

sub _set_var_attrs {
  my $self = shift @_;
  $self->{ '_var_attrs' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub set_feature
{
  my $self = shift @_;
  
  confess( "Not completed yet" );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _split_gff3line
{
  my( $self ) = @_;

  my $split_gff3line = $self->_get_var_split_gff3line();
  if( defined( $split_gff3line ) ) {
    return $split_gff3line;
  }
  my $gff3line = $self->get_gff3line();
  
  my @split_gff3line = map { ( $_ eq '.' ) ? undef : $_ } split( /\t/, $gff3line );
  if( scalar( @split_gff3line ) >= 8 && scalar( @split_gff3line ) <= 9 ) {
    $self->_set_var_split_gff3line( \@split_gff3line );
    return \@split_gff3line;
  }
  
  @split_gff3line = map { ( $_ eq '.' ) ? undef : $_ } split( /[\s]+/, $gff3line );
  if( scalar( @split_gff3line ) >= 8 && scalar( @split_gff3line ) <= 9 ) {
    $self->_set_var_split_gff3line( \@split_gff3line );
    return \@split_gff3line;
  }

  croak( "Incorrect gff3line, no 9 tab-separated fields '$gff3line' in $self" );
}

sub _process_attrs
{
  my( $self ) = @_;
 
  if( $self->_get_var_attrs() ) { return; }

  my $split_gff3line = $self->_split_gff3line();
  my $gff_version = 3; #$self->get_feature_factory()->get_gff_version(); #TODO: GFF3 feature here!

  my $attrs = {};
  
  if( !$gff_version || $gff_version >= 3 ) {
    foreach my $attr( split( /;/, $split_gff3line->[ 8 ] || "" ) ) {
      if( $attr =~ /^([^=]+)=(.*)$/ ) {
        my @values = map { uri_unescape( $_ ) } split( /,/, $2 );
        $attrs->{ $1 } = \@values;
      } else {
        croak(
          "Incorrect attribute column format '$attr' in $self"
        );
      }
    }
  } else {
    my $attr_str = $split_gff3line->[ 8 ] || "";
    while( $attr_str =~ /\s*([^\s]+)\s+((([^;"]*?)(\s*;|$))|("([^"]+)"\s*(;|$)))/g ) {
      my $attr_key = $1;
      my $attr_values_str = $4 || $7 || '1'; #TODO: '1'???, see why if it is
        # empty the writer forgets the attribute key
      my @values = map { uri_unescape( $_ ) } split( /,/, $attr_values_str );
      $attrs->{ $attr_key } = \@values;
    }
    if( $' ) {
      croak(
        "Incorrect attribute column format '$'' in $self"
      );
    }
  }
  
  my $id = delete( $attrs->{ 'ID' } );
  if( !defined( $id ) ) {
  } elsif( scalar( @{ $id } ) == 1 ) {
    $self->SUPER::set_id( $id->[ 0 ] );
  } else {
    croak( "There can be only a single ID per a feature in $self" );
  }
  
  $self->_set_var_attrs( $attrs );
}

sub get_id
{
  my( $self ) = @_;
  $self->_process_attrs();
  return $self->SUPER::get_id();
}

sub set_id
{
  my( $self ) = @_;
  confess( "Can't set a read-only property in $self" );
}

sub get_primary_sequence_id
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 0 ];
}

sub get_type
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 2 ];
}

sub get_start
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 3 ];
}

sub get_end
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 4 ];
}

sub get_score
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 5 ];
}

sub get_strand
{
  my( $self ) = @_;
  my $strand = $self->_split_gff3line()->[ 6 ];
  if( !defined( $strand ) ) { return undef; }
  elsif( $strand eq '+' || $strand eq '1' || $strand eq '+1' ) { return +1; }
  elsif( $strand eq '-' || $strand eq '-1' ) { return -1; }
  elsif( $strand eq '?' ) { return undef; }
  elsif( $strand eq '0' ) { return 0; }
  else {
    croak( "Don't know how to handle strand '$strand' in $self" );
  }
}

sub get_source
{
  my( $self ) = @_;
  return $self->_split_gff3line()->[ 1 ];
}

sub get_part_features
{
  my( $self ) = @_;
  return undef;
}

sub attr #TODO
{
  my( $self, $attr ) = @_;
  return $self->get_attr( $attr );
}

sub attrs #TODO
{
  my( $self ) = @_;
  return $self->get_attrs();
}

sub get_attrs
{
  my( $self ) = @_;
  $self->_process_attrs();
  return $self->_get_var_attrs();
}

sub get_attr
{
  my( $self, $attr ) = @_;
  $self->get_attrs()->{ $attr };
}

##########################################################################

1;
