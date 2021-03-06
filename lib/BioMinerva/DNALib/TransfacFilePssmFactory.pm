##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TransfacFilePssmFactory;

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
  carp( "TransfacFilePssmFactory is obsoleted; use TransfacFilePscmFactory" );
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

###--- <scalar_property id="ID_attr" get_id="" set_id="">
###---   <auto:comment id="ID_attr" md5="G49ygCS5JMrtNN4DKnzM9A">

=head2 ID_attr

 Title   : ID_attr property
 
 Usage   : $object->ID_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ID_attr" md5="8PN2qRpgOELZb2qGPTL70g">

sub ID_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ID_attr' } = shift @_;
  }
  return $self->{ 'ID_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ID_attr" md5="WxBoX5S+tRniKIDoQTFTjg">

sub get_ID_attr {
  return shift->{ 'ID_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ID_attr" md5="uyxZqzWYfVBA457nN74K2g">

sub set_ID_attr {
  my $self = shift @_;
  $self->{ 'ID_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="AC_attr" get_id="" set_id="">
###---   <auto:comment id="AC_attr" md5="3NRN5FzBkKbrvz1Oxn04jw">

=head2 AC_attr

 Title   : AC_attr property
 
 Usage   : $object->AC_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="AC_attr" md5="1yx4s9WMEPDWDLe6F1IqcA">

sub AC_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'AC_attr' } = shift @_;
  }
  return $self->{ 'AC_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_AC_attr" md5="IPhsK3tOSnwD070TMgos1A">

sub get_AC_attr {
  return shift->{ 'AC_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_AC_attr" md5="++IniVRmckLjjEerP56LFw">

sub set_AC_attr {
  my $self = shift @_;
  $self->{ 'AC_attr' } = shift @_;
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
  $target->property( 'use_id', $self->use_id() );
  $target->property( 'ID_attr', $self->ID_attr() );
  $target->property( 'AC_attr', $self->AC_attr() );
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
    @{ $self->_transfac_stream2pscms( $self->stream() ) || [] };
    
  foreach my $pscm( @pscms ) {
    my $pssm = $self->pscm2pssm( $pscm );
    if( $self->_check_pssm( $pssm ) ) {
      $self->_add_pssm( $pssm );
    }
  }

  $self->_set_stream_processed( 1 );
}  

sub _transfac_stream2pscms
{
  my( $self, $transfac_stream ) = @_;

  my $use_id = $self->get_use_id();
  my $ID_attr = $self->get_ID_attr();
  my $AC_attr = $self->get_AC_attr();

  my $transfac_matrix_file_str = join( "", <$transfac_stream> );

  my @pscms;

  my @matrix_strs = split( /\/\/\n/, $transfac_matrix_file_str );
  foreach my $matrix_str( @matrix_strs ) {
    my @m_strs = split( /\n/, $matrix_str );
    my %key2value;
    my @matrix;
    
    foreach my $m_str( @m_strs ) {
      if( $m_str =~ /^([0-9][0-9])\s+(.*)$/ ) {
        $matrix[ $1 - 1 ] = $self->_line2acgt( $2 );
      } elsif( $m_str =~ /^(BF)\s+(.*?);.*$/ ) { 
        $key2value{ $1 } ||= [];
        push @{ $key2value{ $1 } }, $2;
      } elsif( $m_str =~ /^([0-9A-Z][0-9A-Z])\s+(.*)$/ ) { 
        $key2value{ $1 } ||= [];
        push @{ $key2value{ $1 } }, $2;
      }
    }

    if( scalar( @matrix ) == 0 ) { next; }

    my $ID = exists( $key2value{ 'ID' } )
      ? join( ":", @{ $key2value{ 'ID' } } )
      : undef;
      
    my $AC = exists( $key2value{ 'AC' } )
      ? join( ":", @{ $key2value{ 'AC' } } )
      : undef;
      
    my $pscm = new BioMinerva::DNALib::Pscm();
    if( !defined( $use_id ) ) {
      $pscm->set_id( $AC );
    } elsif( $use_id eq 'AC' ) {
      $pscm->set_id( $AC );
    } elsif( $use_id eq 'ID' ) {
      $pscm->set_id( $ID );
    } else {
      croak( "Incorrect use_id '$use_id'. "
        . "Use one of: ID, AC" );
    }
      
    $pscm->matrix( \@matrix );

    if( defined( $AC_attr ) ) {
      $pscm->add_attr( $AC_attr, $AC );
    }
    if( defined( $ID_attr ) ) {
      $pscm->add_attr( $ID_attr, $ID );
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
  elsif( $line =~ /^[^\s]+\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s*$/ )
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

