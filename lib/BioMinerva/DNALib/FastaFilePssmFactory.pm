##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FastaFilePssmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PssmFactory;
@ISA = qw( BioMinerva::DNALib::PssmFactory );

##########################################################################

use BioMinerva::DNALib::Pscm;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  carp( "FastaFilePssmFactory is obsoleted; use FastaFilePscmFactory" );
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="stream" assignable_once="1">
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
###--- </scalar_property>

###--- <array_property id="pssm" ids="_pssms" add_id="_add_pssm" type="BioMinerva::DNALib::Pssm">
###---   <auto:comment id="_pssms" md5="HHYRe4C/oObIPY8LQoVqzA">

=head2 _pssms

 Title   : _pssms (array property)
 
 Usage   : C<<< my $_pssms = $object->_pssms();
           if( defined( $_pssms ) ) { 
             foreach my $pssm( @{ $_pssms } ) {
               ...
             }
           } >>>
           
           C<<< $object->_pssms( $_pssms ); >>>
 
           C<<< $object->_pssms( undef ); >>>

 Function: Accessor to the array property C<_pssms>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of _pssms to be set
           clear-accessor: undef

 Return  : reference to the current array of _pssms or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_pssms" md5="8Pby4zsTeza65tf5WuaErQ">

sub _pssms {
  my $self = shift @_;
  if( @_ ) {
    my $_pssms = shift @_;
    if( defined( $_pssms ) && ref( $_pssms ) ne 'ARRAY' ) {
      confess( "Property '_pssms' requires an ARRAY argument (now: $_pssms)." );
    }
    $self->{ '_pssms' } = $_pssms;
  }
  return $self->{ '_pssms' };
}

###---   </auto:code>
###---   <auto:comment id="_add_pssm" md5="GIly677AsOASulWHDbWZtw">

=head2 _add_pssm

 Title   : _add_pssm (_pssms property)
 
 Usage   : C<<< $object->_add_pssm( $pssm, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< _pssms >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_pssm" md5="4OeIWNsMbAjWFVsXSHmQEA">

sub _add_pssm {
  my $self = shift @_;
  my @_pssms = @_;
  $self->{ '_pssms' } ||= [];
  push @{ $self->{ '_pssms' } }, @_pssms;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <scalar_property id='_stream_processed' get_id='' set_id=''>
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

###--- <scalar_property id="use_id" get_id="" set_id="">
###---   <auto:comment id="use_id" md5="0oBtrg+5XYPdcajyiXyILA">

=head2 use_id

 Title   : use_id property
 
 Usage   : $object->use_id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="use_id" md5="IcH+D/AI8BcNHEfD2FXB3g">

sub use_id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'use_id' } = shift @_;
  }
  return $self->{ 'use_id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_use_id" md5="hEaqoo8/fSmVXNBHQbVlSA">

sub get_use_id {
  return shift->{ 'use_id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_use_id" md5="RdIJuKq0bAnZaXB0LrDMRQ">

sub set_use_id {
  my $self = shift @_;
  $self->{ 'use_id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub file
{
  my( $self, $file ) = @_;

  my $stream;
  if( !open( $stream, $file ) ) {
    croak( "Can not open '$file' for reading (system: $!) in $self" );
  }

  $self->stream( $stream );
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'use_id', $self->get_use_id() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pssms
{
  my( $self, @args ) = @_;
  $self->_process_stream();
  return $self->_pssms();
}

##########################################################################

sub _process_stream
{
  my( $self ) = @_;
  
  if( $self->_get_stream_processed() ) { return; }
  
  my @pscms = 
    @{ $self->_fasta_stream2pscms( $self->stream() ) || [] };
    
  foreach my $pscm( @pscms ) {
    my $pssm = $self->pscm2pssm( $pscm );
    if( $self->_check_pssm( $pssm ) ) {
      $self->_add_pssm( $pssm );
    }
  }

  $self->_set_stream_processed( 1 );
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

sub _fasta_stream2pscms
{
  my( $self, $stream ) = @_;

  my $use_id = $self->get_use_id();

  my $fasta_matrix_file_str = join( "", <$stream> );

  my @matrix_strs = split( />/, $fasta_matrix_file_str );
  
  my @pscms;

  foreach my $matrix_str( @matrix_strs ) {
    if( !$matrix_str ) { next; }

    my @m_strs = split( /\n/, $matrix_str );
    my $attrs =  $self->_fasta_header2hash( shift( @m_strs ) );
    my $id = $attrs->{ defined( $use_id ) ? $use_id : '' };
   
    my @matrix;
    foreach my $m_str( @m_strs ) {
      push @matrix, $self->_line2acgt( $m_str );
    }
    
    if( scalar( @matrix ) == 0 ) { next; }
    $id =~ s/\s+$//;
    
    my $pscm = new BioMinerva::DNALib::Pscm();
    $pscm->set_id( $id );
    $pscm->matrix( \@matrix );

    foreach my $attr_key( keys( %{ $attrs } ) ) {
      if( !$attr_key ) { next; }
      $pscm->add_attr( $attr_key, $attrs->{ $attr_key } );
    }
    
    push @pscms, $pscm;
  }

  return \@pscms;
}

sub _line2acgt
{
  my( $self, $line ) = @_;
  
  my %m;
  if( $line =~ /^\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s*$/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  elsif( $line =~ /^[^\s]+\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s*$/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  elsif( $line =~ /^\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+[A-Za-z]/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  elsif( $line =~ /^[^\s]+\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+[A-Za-z]/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  else
    { croak( "_line2acgt: incorrect line format '$line' in $self" ); }
  return \%m;
}

##########################################################################

1;

