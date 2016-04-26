##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::FileCache;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Cache;
@ISA = qw( BioMinerva::Base::Cache );

use Carp qw( confess carp );
use Storable qw( retrieve store );
use BioMinerva::Base::PhaseProgressInfo;
use BioMinerva::Base::InfoViewer;

##########################################################################
# STATIC
##########################################################################

sub file2default_cache
{
  my( $file ) = @_;

  if( defined( $file ) && $file ne '-' ) {
    my $cache_file = 
      $file 
      . "." 
      . BioMinerva::Base::Cache::machine_memory_organization_id() 
      . ".file_cache";

    my $cache = new BioMinerva::Base::FileCache();
    $cache->set_file( $cache_file );

    return $cache;
  } else {
    return undef;
  }
}

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub DESTROY
{
  my( $self ) = @_;
  $self->_process_store();
}

sub create {
  return new BioMinerva::Base::FileCache();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='file' get_id='' set_id=''>
###---   <auto:comment id="file" md5="rzKXfMq5Wr4IVsVSMI/4IA">

=head2 file

 Title   : file property
 
 Usage   : $object->file(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="file" md5="34L2GQwvEVZAPlg2fNEMxg">

sub file {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'file' } = shift @_;
  }
  return $self->{ 'file' };
}

###---   </auto:code>
###---   <auto:code get_id="get_file" md5="flkgc/5YjjNEyEBL1XW9Tw">

sub get_file {
  return shift->{ 'file' };
}

###---   </auto:code>
###---   <auto:code set_id="set_file" md5="OZi6kc9sPkYcSUDIPijEbg">

sub set_file {
  my $self = shift @_;
  $self->{ 'file' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='num_of_changes_to_store'>
###---   <auto:comment id="num_of_changes_to_store" md5="MWMyVnM4boOtIZAPLcxkDg">

=head2 num_of_changes_to_store

 Title   : num_of_changes_to_store property
 
 Usage   : $object->num_of_changes_to_store(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="num_of_changes_to_store" md5="5V7qzB2SbD9ZVeTodTS7Yg">

sub num_of_changes_to_store {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'num_of_changes_to_store' } = shift @_;
  }
  return $self->{ 'num_of_changes_to_store' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <key2scalar_property id='_cache_digest_id2serialized' ids='_cache_digest_ids2serialized'>
###---   <auto:comment id="_cache_digest_ids2serialized" md5="KG2C1WsKsiBS1pLsIKAHiw">

=head2 _cache_digest_ids2serialized

 Title   : _cache_digest_ids2serialized (whole hash accrssor to key2scalar property _cache_digest_ids2serialized)
 
 Usage   : C<<< 
           my $_cache_digest_ids2serialized = $object->_cache_digest_ids2serialized();
           if( defined( $_cache_digest_ids2serialized ) ) { 
             foreach my $_cache_digest_id2serialized( keys %{ $_cache_digest_ids2serialized } ) {
               my $value = $_cache_digest_ids2serialized->{ $_cache_digest_id2serialized };
               if( defined( $value ) ) {
                 ...
               }
             }
           } 
           >>>
           
           C<<< $object->_cache_digest_ids2serialized( $_cache_digest_ids2serialized ); >>>
 
           C<<< $object->_cache_digest_ids2serialized( undef ); >>>

 Function: Accessor to the property C<_cache_digest_ids2serialized> mapping keys to scalars.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _cache_digest_ids2serialized to be set
           clear-accessor: undef

 Return  : reference to the current hash of _cache_digest_ids2serialized or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_cache_digest_ids2serialized" md5="xKjigsm1MLwxgDN2tNWUjA">

sub _cache_digest_ids2serialized {
  my $self = shift @_;
  if( @_ ) {
    my $_cache_digest_ids2serialized = shift @_;
    if( defined( $_cache_digest_ids2serialized ) && ref( $_cache_digest_ids2serialized ) ne 'HASH' ) {
      confess( "Property '_cache_digest_ids2serialized' requires a HASH argument (now: $_cache_digest_ids2serialized)." );
    }
    $self->{ '_cache_digest_ids2serialized' } = $_cache_digest_ids2serialized;
  }
  return $self->{ '_cache_digest_ids2serialized' };
}

###---   </auto:code>
###---   <auto:comment id="_cache_digest_id2serialized" md5="4UbiQmxDjbIuoq4rbkCADQ">

=head2 _cache_digest_id2serialized

 Title   : _cache_digest_id2serialized (single key accessor to key2scalar property _cache_digest_ids2serialized)
 
 Usage   : C<<< 
           my $value = $object->_cache_digest_id2serialized( "key" );
           if( defined( $values ) ) { 
             ...
           } 
           >>>
           
           C<<< $object->_cache_digest_id2serialized( "key", 1 ); >>>
 
           C<<< $object->_cache_digest_id2serialized( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_cache_digest_ids2serialized>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, a scalar to be assigned to the key
           clear-accessor: key, undef

 Return  : a value of the object assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_cache_digest_id2serialized" md5="P+11sMxA6MkDP74ahcabDw">

sub _cache_digest_id2serialized {
  my $self = shift @_;
  my $_cache_digest_id2serialized = shift @_;
  if( !defined( $_cache_digest_id2serialized ) ) {
    confess( 
      "A key must be given to access a single item of key2scalar property '_cache_digest_ids2serialized'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_cache_digest_ids2serialized' } ||= {};  
    if( !defined( $value ) ) {
      delete $self->{ '_cache_digest_ids2serialized' }->{ $_cache_digest_id2serialized };
    } else {
      $self->{ '_cache_digest_ids2serialized' }->{ $_cache_digest_id2serialized } = $value;
    }
  }
  return ( $self->{ '_cache_digest_ids2serialized' } || {} )->{ $_cache_digest_id2serialized };
}

###---   </auto:code>
###--- </key2scalar_property>

###--- <scalar_property id='_retrieve_processed'>
###---   <auto:comment id="_retrieve_processed" md5="dWDGtlUJ/aNuAITGDqGFEw">

=head2 _retrieve_processed

 Title   : _retrieve_processed property
 
 Usage   : $object->_retrieve_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_retrieve_processed" md5="8ZLcaVw7rgwTRH17yDcVww">

sub _retrieve_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_retrieve_processed' } = shift @_;
  }
  return $self->{ '_retrieve_processed' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_changed'>
###---   <auto:comment id="_changed" md5="L2pkhAxAnGzYLyI/2891fA">

=head2 _changed

 Title   : _changed property
 
 Usage   : $object->_changed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_changed" md5="our2ptU4ZrpGkScg8neDWg">

sub _changed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_changed' } = shift @_;
  }
  return $self->{ '_changed' };
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'file', $self->file() );
  $target->property( 'num_of_changes_to_store', $self->num_of_changes_to_store() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'file' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'file' ) { $self->file( @values ); }
  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub save
{
  my( $self ) = @_;

  $self->_process_store();
}

sub _do_peek
{
  my( $self, $cache_digest, $serialized_ref ) = @_;

  $self->_process_retrieve();
  my $serialized = $self->_cache_digest_id2serialized( $cache_digest->hexdigest() );
  if( !defined( $serialized ) ) { 
    return undef; 
  }
  ${ $serialized_ref } = $serialized;
  return 1;
}

sub _do_poke
{
  my( $self, $cache_digest, $serialized ) = @_;

  $self->_cache_digest_id2serialized( $cache_digest->hexdigest(), $serialized );
  $self->_notify_change();
}

sub _notify_change
{
  my( $self ) = @_;
  $self->_changed( ( $self->_changed() || 0 ) + 1 );
  if( defined( $self->num_of_changes_to_store() ) 
    && $self->_changed() >= $self->num_of_changes_to_store() ) {
    $self->_process_store();
  }
}

sub _process_retrieve
{
  my( $self ) = @_;

  if( $self->_retrieve_processed() ) { return; }

  my $progress_info = new BioMinerva::Base::PhaseProgressInfo();
  $progress_info->set_title( "Reading cache '" . $self->file() . "'" );
  $progress_info->set_phase_attr( "state" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO: try
  {
    my $cache_digest_ids2serialized = eval { 
      retrieve( $self->file() ); 
    };

    if( defined( $cache_digest_ids2serialized ) ) {
      $self->_cache_digest_ids2serialized( $cache_digest_ids2serialized );
      $progress_info->set_phase( "completed" );
    } else {
      $progress_info->set_phase( "failed: $@" );
    }
  }
#TODO: catch
  $info_viewer->pop_info();
  
  $self->_retrieve_processed( 1 );
}

sub _process_store
{
  my( $self ) = @_;

  if( !$self->_changed() ) { return; }

  my $progress_info = new BioMinerva::Base::ProgressInfo();
  $progress_info->set_title( "Writing cache '" . $self->file() . "'" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
#TODO: try
  {
    eval { 
      store( $self->_cache_digest_ids2serialized(), $self->file() ) 
    };
  }
#TODO: catch
  $info_viewer->pop_info();
  
  $self->_changed( 0 );
}

##########################################################################

1;

