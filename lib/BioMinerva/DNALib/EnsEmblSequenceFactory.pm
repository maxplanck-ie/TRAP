##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EnsEmblSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SequenceFactory;
@ISA = qw( BioMinerva::DNALib::SequenceFactory );

use BioMinerva::DNALib::Sequence;
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
  return new BioMinerva::DNALib::EnsEmblSequenceFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='database_name' get_id='' set_id=''>
###---   <auto:comment id="database_name" md5="MMGubwYmgLW7DNQgBAavxg">

=head2 database_name

 Title   : database_name property
 
 Usage   : $object->database_name(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="database_name" md5="wLCrFUWpO530nigDIsHExQ">

sub database_name {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'database_name' } = shift @_;
  }
  return $self->{ 'database_name' };
}

###---   </auto:code>
###---   <auto:code get_id="get_database_name" md5="L7SHBrWbdV2N/IiMYnOs2A">

sub get_database_name {
  return shift->{ 'database_name' };
}

###---   </auto:code>
###---   <auto:code set_id="set_database_name" md5="pBrYaS1XGe+Ypi6DTZ/QUw">

sub set_database_name {
  my $self = shift @_;
  $self->{ 'database_name' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='top_level_sequence_type' get_id='' set_id=''>
###---   <auto:comment id="top_level_sequence_type" md5="CTE1A/3rLb5rULf+hKvx3A">

=head2 top_level_sequence_type

 Title   : top_level_sequence_type property
 
 Usage   : $object->top_level_sequence_type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="top_level_sequence_type" md5="h5fUwsvnzTxqRvBiF+BUmg">

sub top_level_sequence_type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'top_level_sequence_type' } = shift @_;
  }
  return $self->{ 'top_level_sequence_type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_top_level_sequence_type" md5="9zAO2LAS2gTp7X0y75a1Fw">

sub get_top_level_sequence_type {
  return shift->{ 'top_level_sequence_type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_top_level_sequence_type" md5="M0KYR9DGqFW7hoNgoytEqA">

sub set_top_level_sequence_type {
  my $self = shift @_;
  $self->{ 'top_level_sequence_type' } = shift @_;
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

###--- <key2scalar_property id="_sequence_id2sequence" ids="_sequence_ids2sequence" values_id="_sequences" keys_id="_sequence_ids">
###---   <auto:comment id="_sequence_ids2sequence" md5="ll2keVBWNunk4Boy75A2YQ">

=head2 _sequence_ids2sequence

 Title   : _sequence_ids2sequence (whole hash accrssor to key2scalar property _sequence_ids2sequence)
 
 Usage   : C<<< 
           my $_sequence_ids2sequence = $object->_sequence_ids2sequence();
           if( defined( $_sequence_ids2sequence ) ) { 
             foreach my $_sequence_id2sequence( keys %{ $_sequence_ids2sequence } ) {
               my $value = $_sequence_ids2sequence->{ $_sequence_id2sequence };
               if( defined( $value ) ) {
                 ...
               }
             }
           } 
           >>>
           
           C<<< $object->_sequence_ids2sequence( $_sequence_ids2sequence ); >>>
 
           C<<< $object->_sequence_ids2sequence( undef ); >>>

 Function: Accessor to the property C<_sequence_ids2sequence> mapping keys to scalars.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _sequence_ids2sequence to be set
           clear-accessor: undef

 Return  : reference to the current hash of _sequence_ids2sequence or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_sequence_ids2sequence" md5="OJsu61tUCGZqVY48nLYqZw">

sub _sequence_ids2sequence {
  my $self = shift @_;
  if( @_ ) {
    my $_sequence_ids2sequence = shift @_;
    if( defined( $_sequence_ids2sequence ) && ref( $_sequence_ids2sequence ) ne 'HASH' ) {
      confess( "Property '_sequence_ids2sequence' requires a HASH argument (now: $_sequence_ids2sequence)." );
    }
    $self->{ '_sequence_ids2sequence' } = $_sequence_ids2sequence;
  }
  return $self->{ '_sequence_ids2sequence' };
}

###---   </auto:code>
###---   <auto:comment id="_sequence_id2sequence" md5="PgJB0yuEzTCwYmLV+PCrUQ">

=head2 _sequence_id2sequence

 Title   : _sequence_id2sequence (single key accessor to key2scalar property _sequence_ids2sequence)
 
 Usage   : C<<< 
           my $value = $object->_sequence_id2sequence( "key" );
           if( defined( $values ) ) { 
             ...
           } 
           >>>
           
           C<<< $object->_sequence_id2sequence( "key", 1 ); >>>
 
           C<<< $object->_sequence_id2sequence( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_sequence_ids2sequence>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, a scalar to be assigned to the key
           clear-accessor: key, undef

 Return  : a value of the object assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_sequence_id2sequence" md5="+/VDhYkZ16F126Oy1mRhtQ">

sub _sequence_id2sequence {
  my $self = shift @_;
  my $_sequence_id2sequence = shift @_;
  if( !defined( $_sequence_id2sequence ) ) {
    confess( 
      "A key must be given to access a single item of key2scalar property '_sequence_ids2sequence'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_sequence_ids2sequence' } ||= {};  
    if( !defined( $value ) ) {
      delete $self->{ '_sequence_ids2sequence' }->{ $_sequence_id2sequence };
    } else {
      $self->{ '_sequence_ids2sequence' }->{ $_sequence_id2sequence } = $value;
    }
  }
  return ( $self->{ '_sequence_ids2sequence' } || {} )->{ $_sequence_id2sequence };
}

###---   </auto:code>
###---   <auto:code id="_sequence_ids" md5="CngkHZgfoyiuQ/WK4KugGg">

sub _sequence_ids {
  my $self = shift @_;
  my @_sequence_ids = keys %{ $self->{ '_sequence_ids2sequence' } || {} };
  return \@_sequence_ids;
}

###---   </auto:code>
###---   <auto:code id="_sequences" md5="izvDh7+3qZr7diVokCL7DQ">

sub _sequences {
  my $self = shift @_;
  my @_sequences = values %{ $self->{ '_sequence_ids2sequence' } || {} };
  return \@_sequences;
}

###---   </auto:code>
###--- </key2scalar_property>

###--- <scalar_property id='_database_processed' get_id='' set_id=''>
###---   <auto:comment id="_database_processed" md5="FDqbYuVDCncDwoDzBlrYPQ">

=head2 _database_processed

 Title   : _database_processed property
 
 Usage   : $object->_database_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_database_processed" md5="1gmpqV8GaBWgLLkqN3NmGQ">

sub _database_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_database_processed' } = shift @_;
  }
  return $self->{ '_database_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_database_processed" md5="VhxmJrps16H9EEvDyZ3NZA">

sub _get_database_processed {
  return shift->{ '_database_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_database_processed" md5="jEsklABQlsTJwEjMSOJfmw">

sub _set_database_processed {
  my $self = shift @_;
  $self->{ '_database_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'database_name', $self->get_database_name() );
  $target->property( 'top_level_sequence_type', $self->get_top_level_sequence_type() );
  $target->property( 'ignore_missing_sequences', $self->get_ignore_missing_sequences() );
}

sub sequences_digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::sequences_digest();

  $digest->add( $self->source() || '' );
  $digest->add( $self->get_top_level_sequence_type() || '' );
  $digest->add( $self->get_ignore_missing_sequences() || '' );

  return $digest;
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub source
{
  my( $self ) = @_;
  
  my $db_adaptor = $self->_db_adaptor();
  return $db_adaptor->dbc()->dbname();
}

sub _db_adaptor
{
  my( $self ) = @_;

  my $database_name = $self->get_database_name();
  if( !$database_name ) {
    croak( "EnsEMBL database_name has not been provided "
      . "[check ~/.ensembl_init for a list of available databases] in $self" 
    );
  }
  
  my $db_adaptor = Bio::EnsEMBL::Registry->get_DBAdaptor( $database_name, "core" )
    || croak( 
    "Cannot get DBAdaptor for '$database_name' [check ~/.ensembl_init?] in $self" 
  );

  return $db_adaptor;
}

##########################################################################

sub sequence_ids
{
  my( $self ) = @_;
  $self->_process_database();
  return $self->_sequence_ids();
}

sub sequences
{
  my( $self ) = @_;
  $self->_process_database();
  my @sequences = 
    sort { $a->get_primary_sequence_id() cmp $b->get_primary_sequence_id() } 
    @{ $self->_sequences() || [] };
  return \@sequences;
}

sub sequence_id2sequence
{
  my( $self, $sequence_id ) = @_;
  $self->_process_database();
  return $self->_sequence_id2sequence( $sequence_id );
}

sub sequence2seq
{
  my( $self, $sequence ) = @_;
  
  # ----- slice extraction -----
  my $db_adaptor = $self->_db_adaptor();
  my $slice_adaptor = $db_adaptor->get_SliceAdaptor()
    || confess( "Cannot get EnsEMBL SliceAdaptor in $self" );

  my $slice = eval {
    $slice_adaptor->fetch_by_region(
      $self->get_top_level_sequence_type() || 'toplevel',
      $sequence->get_primary_sequence_id(),
      $sequence->get_start(),
      $sequence->get_end(),
      $sequence->get_strand()
    );
  };

  if( !$slice ) {
    if( $self->get_ignore_missing_sequences() ) {
      carp( "Cannot retrieve a valid EnsEMBL::Slice for $sequence in $self (EnsEMBL: $@)" );
      return $self->SUPER::sequence2seq( $sequence );
    } else {
      croak( "Cannot retrieve a valid EnsEMBL::Slice for $sequence in $self (EnsEMBL: $@)" );
    }
  }

  return $slice->seq();
}

sub _process_database
{
  my( $self ) = @_;
  
  # ----- single shot -----
  if( $self->_get_database_processed() ) { return; }
  
  # ----- slice extraction -----
  my $db_adaptor = $self->_db_adaptor();
  my $slice_adaptor = $db_adaptor->get_SliceAdaptor()
    || confess( "Cannot get EnsEMBL SliceAdaptor in $self" );
    
  my $slices = $slice_adaptor->fetch_all( 
    $self->get_top_level_sequence_type() || 'toplevel'
  );

  foreach my $slice( @{ $slices || [] } ) {
    my $sequence_id = $slice->seq_region_name();
    
    my $sequence = new BioMinerva::DNALib::Sequence();
    $sequence->set_id( $sequence_id );
    $sequence->set_primary_sequence_id( $sequence_id );
    $sequence->set_start( $slice->start() );
    $sequence->set_end( $slice->end() );
    $sequence->set_strand( $slice->strand() );
    $sequence->set_source( $db_adaptor->dbc()->dbname() );

    $self->_sequence_id2sequence( $sequence_id, $sequence );
  }

  # ----- single shot -----
  $self->_set_database_processed( 1 );
}

##########################################################################

1;

