##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3StreamFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::StreamFeatureFactory;
@ISA = qw( BioMinerva::DNALib::StreamFeatureFactory );

use Carp qw( confess carp croak );
use URI::Escape;

use BioMinerva::DNALib::Sequence;
use BioMinerva::DNALib::Feature;
use BioMinerva::Base::ArrayIterator;
use BioMinerva::Base::JoinedIterator;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::GFF3StreamFeatureFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='aggregate' get_id='' set_id=''>
###---   <auto:comment id="aggregate" md5="7fRbGdOvzPna8yuL6dslgg">

=head2 aggregate

 Title   : aggregate property
 
 Usage   : $object->aggregate(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="aggregate" md5="HRvcpl5TlfI4A/AGKZYwbQ">

sub aggregate {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'aggregate' } = shift @_;
  }
  return $self->{ 'aggregate' };
}

###---   </auto:code>
###---   <auto:code get_id="get_aggregate" md5="X1BqhQE/C1jG1M6wdIAjlg">

sub get_aggregate {
  return shift->{ 'aggregate' };
}

###---   </auto:code>
###---   <auto:code set_id="set_aggregate" md5="o10VLH646eOOLohxa7yvNQ">

sub set_aggregate {
  my $self = shift @_;
  $self->{ 'aggregate' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='gff_version' get_id='' set_id=''>
###---   <auto:comment id="gff_version" md5="a3KrfZEjfAxewhzF4/r1HQ">

=head2 gff_version

 Title   : gff_version property
 
 Usage   : $object->gff_version(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gff_version" md5="ceA+WZaUMJ4LH91/ffQX7A">

sub gff_version {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gff_version' } = shift @_;
  }
  return $self->{ 'gff_version' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gff_version" md5="1KiT/lzAexYSCLtqnpTR/g">

sub get_gff_version {
  return shift->{ 'gff_version' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gff_version" md5="Vd2HARYmRipkUhMZnkeDVw">

sub set_gff_version {
  my $self = shift @_;
  $self->{ 'gff_version' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <key2array_property keys2values_id='_primary_sequence_ids2indexes' key2values_id='_primary_sequence_id2indexes' keys_id='_primary_sequence_ids' add_key2value_id='_add_primary_sequence_id2index' values_id='_indexes'>
###---   <auto:comment id="_primary_sequence_ids2indexes" md5="5y/uxxNFdTc98z1AECEkbw">

=head2 _primary_sequence_ids2indexes

 Title   : _primary_sequence_ids2indexes (whole hash accrssor to key2array property _primary_sequence_ids2indexes)
 
 Usage   : C<<< 
           my $_primary_sequence_ids2indexes = $object->_primary_sequence_ids2indexes();
           if( defined( $_primary_sequence_ids2indexes ) ) { 
             foreach my $_primary_sequence_id2indexes( keys %{ $_primary_sequence_ids2indexes } ) {
               my $values = $_primary_sequence_ids2indexes->{ $_primary_sequence_id2indexes };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->_primary_sequence_ids2indexes( $_primary_sequence_ids2indexes ); >>>
 
           C<<< $object->_primary_sequence_ids2indexes( undef ); >>>

 Function: Accessor to the property C<_primary_sequence_ids2indexes> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _primary_sequence_ids2indexes to be set
           clear-accessor: undef

 Return  : reference to the current hash of _primary_sequence_ids2indexes or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_primary_sequence_ids2indexes" md5="FArBsk0+GKkfn9Kox8jU2w">

sub _primary_sequence_ids2indexes {
  my $self = shift @_;
  if( @_ ) {
    my $_primary_sequence_ids2indexes = shift @_;
    if( defined( $_primary_sequence_ids2indexes ) && ref( $_primary_sequence_ids2indexes ) ne 'HASH' ) {
      confess( "Property '_primary_sequence_ids2indexes' requires a HASH argument (now: $_primary_sequence_ids2indexes)." );
    }
    $self->{ '_primary_sequence_ids2indexes' } = $_primary_sequence_ids2indexes;
  }
  return $self->{ '_primary_sequence_ids2indexes' };
}

###---   </auto:code>
###---   <auto:comment id="_primary_sequence_id2indexes" md5="TYe1EQi0bF0R5pD6DRnppw">

=head2 _primary_sequence_id2indexes

 Title   : _primary_sequence_id2indexes (single key accessor to key2array property _primary_sequence_ids2indexes)
 
 Usage   : C<<< 
           my $values = $object->_primary_sequence_id2indexes( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->_primary_sequence_id2indexes( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->_primary_sequence_id2indexes( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_primary_sequence_ids2indexes>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_primary_sequence_id2indexes" md5="MfUXBXHtcw1e8wfDMGJ2Ew">

sub _primary_sequence_id2indexes {
  my $self = shift @_;
  my $_primary_sequence_id2indexes = shift @_;
  if( !defined( $_primary_sequence_id2indexes ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_primary_sequence_ids2indexes'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_primary_sequence_ids2indexes' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $_primary_sequence_id2indexes ) eq 'ARRAY' ) {
        foreach my $i( @{ $_primary_sequence_id2indexes } ) {
          delete $self->{ '_primary_sequence_ids2indexes' }->{ $i };
        }
      } else {
        delete $self->{ '_primary_sequence_ids2indexes' }->{ $_primary_sequence_id2indexes };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $_primary_sequence_id2indexes ) eq 'ARRAY' ) {
        foreach my $i( @{ $_primary_sequence_id2indexes } ) {
          $self->{ '_primary_sequence_ids2indexes' }->{ $i } = $value;
        }
      } else {
        $self->{ '_primary_sequence_ids2indexes' }->{ $_primary_sequence_id2indexes } = $value;
      }
    } else {
      confess( "Property '_primary_sequence_ids2indexes' value for key '$_primary_sequence_id2indexes' must be an ARRAY (now: $value)." );
    }
  }
  return ( $self->{ '_primary_sequence_ids2indexes' } || {} )->{ $_primary_sequence_id2indexes };
}

###---   </auto:code>
###---   <auto:comment id="_add_primary_sequence_id2index" md5="5L3/z3iMd7r5acvVOYNfmQ">

=head2 _add_primary_sequence_id2index

 Title   : _add_primary_sequence_id2index (adds values to a single key of key2array property _primary_sequence_ids2indexes)
 
 Usage   : C<<< $object->_add_primary_sequence_id2index( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< _primary_sequence_ids2indexes >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_primary_sequence_id2index" md5="BsXvccWgRaJ9epFowNt2oA">

sub _add_primary_sequence_id2index {
  my $self = shift @_;
  my $_primary_sequence_id2indexes = shift @_;
  if( !defined( $_primary_sequence_id2indexes ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_primary_sequence_ids2indexes'." 
    );
  }
  $self->{ '_primary_sequence_ids2indexes' } ||= {};  
  $self->{ '_primary_sequence_ids2indexes' }->{ $_primary_sequence_id2indexes } ||= [];
  push @{ $self->{ '_primary_sequence_ids2indexes' }->{ $_primary_sequence_id2indexes } }, @_;
  return undef;
}

###---   </auto:code>
###---   <auto:code id="_primary_sequence_ids" md5="HEwkWGqCkyEKxk/eXX6jlA">

sub _primary_sequence_ids {
  my $self = shift @_;
  my @_primary_sequence_ids = keys %{ $self->{ '_primary_sequence_ids2indexes' } || {} };
  return \@_primary_sequence_ids;
}

###---   </auto:code>
###---   <auto:code id="_indexes" md5="34aYZ9l3hHhzU2ZolzzEMw">

sub _indexes {
  my $self = shift @_;
  my @_indexes = map { @{ $_ } } values %{ $self->{ '_primary_sequence_ids2indexes' } || {} };
  return \@_indexes;
}

###---   </auto:code>
###--- </key2array_property>

###--- <key2scalar_property key2value_id='_feature_id2index' keys2value_id='_feature_ids2index' keys_id='_feature_ids'>
###---   <auto:comment id="_feature_ids2index" md5="kDCkIuF07acxiMRefbrEiw">

=head2 _feature_ids2index

 Title   : _feature_ids2index (whole hash accrssor to key2scalar property _feature_ids2index)
 
 Usage   : C<<< 
           my $_feature_ids2index = $object->_feature_ids2index();
           if( defined( $_feature_ids2index ) ) { 
             foreach my $_feature_id2index( keys %{ $_feature_ids2index } ) {
               my $value = $_feature_ids2index->{ $_feature_id2index };
               if( defined( $value ) ) {
                 ...
               }
             }
           } 
           >>>
           
           C<<< $object->_feature_ids2index( $_feature_ids2index ); >>>
 
           C<<< $object->_feature_ids2index( undef ); >>>

 Function: Accessor to the property C<_feature_ids2index> mapping keys to scalars.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _feature_ids2index to be set
           clear-accessor: undef

 Return  : reference to the current hash of _feature_ids2index or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_feature_ids2index" md5="+IVQK5jX4gP85ayUgXXXWg">

sub _feature_ids2index {
  my $self = shift @_;
  if( @_ ) {
    my $_feature_ids2index = shift @_;
    if( defined( $_feature_ids2index ) && ref( $_feature_ids2index ) ne 'HASH' ) {
      confess( "Property '_feature_ids2index' requires a HASH argument (now: $_feature_ids2index)." );
    }
    $self->{ '_feature_ids2index' } = $_feature_ids2index;
  }
  return $self->{ '_feature_ids2index' };
}

###---   </auto:code>
###---   <auto:comment id="_feature_id2index" md5="5l0LjZZUn5p8qkx0SSWs/Q">

=head2 _feature_id2index

 Title   : _feature_id2index (single key accessor to key2scalar property _feature_ids2index)
 
 Usage   : C<<< 
           my $value = $object->_feature_id2index( "key" );
           if( defined( $values ) ) { 
             ...
           } 
           >>>
           
           C<<< $object->_feature_id2index( "key", 1 ); >>>
 
           C<<< $object->_feature_id2index( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_feature_ids2index>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, a scalar to be assigned to the key
           clear-accessor: key, undef

 Return  : a value of the object assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_feature_id2index" md5="lBybEk4gYwamfzJDA8gJRg">

sub _feature_id2index {
  my $self = shift @_;
  my $_feature_id2index = shift @_;
  if( !defined( $_feature_id2index ) ) {
    confess( 
      "A key must be given to access a single item of key2scalar property '_feature_ids2index'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_feature_ids2index' } ||= {};  
    if( !defined( $value ) ) {
      delete $self->{ '_feature_ids2index' }->{ $_feature_id2index };
    } else {
      $self->{ '_feature_ids2index' }->{ $_feature_id2index } = $value;
    }
  }
  return ( $self->{ '_feature_ids2index' } || {} )->{ $_feature_id2index };
}

###---   </auto:code>
###---   <auto:code id="_feature_ids" md5="Gy5PixbfT13WQTekvWCYBg">

sub _feature_ids {
  my $self = shift @_;
  my @_feature_ids = keys %{ $self->{ '_feature_ids2index' } || {} };
  return \@_feature_ids;
}

###---   </auto:code>
###--- </key2scalar_property>

###--- <key2optimized_array_property key2values_id='_index2part_indexes' keys2values_id='_indexes2part_indexes' add_key2value_id='_add_index2part_index'>
###---   <auto:comment id="_indexes2part_indexes" md5="Qe/sQP2M3wfvt/IbVmZ7oQ">

=head2 _indexes2part_indexes

 Title   : _indexes2part_indexes (whole hash accrssor to key2array property _indexes2part_indexes)
 
 Usage   : C<<< 
           my $_indexes2part_indexes = $object->_indexes2part_indexes();
           if( defined( $_indexes2part_indexes ) ) { 
             foreach my $_index2part_indexes( keys %{ $_indexes2part_indexes } ) {
               my $values = $_indexes2part_indexes->{ $_index2part_indexes };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->_indexes2part_indexes( $_indexes2part_indexes ); >>>
 
           C<<< $object->_indexes2part_indexes( undef ); >>>

 Function: Accessor to the property C<_indexes2part_indexes> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _indexes2part_indexes to be set
           clear-accessor: undef

 Return  : reference to the current hash of _indexes2part_indexes or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_indexes2part_indexes" md5="6qrL37tvKlfwd/BXw860uA">

sub _indexes2part_indexes {
  my $self = shift @_;
  if( @_ ) {
    my $_indexes2part_indexes = shift @_;
    if( defined( $_indexes2part_indexes ) && ref( $_indexes2part_indexes ) ne 'HASH' ) {
      confess( "Property '_indexes2part_indexes' requires a HASH argument (now: $_indexes2part_indexes)." );
    }
    $self->{ '_indexes2part_indexes' } = $_indexes2part_indexes;
  }
  return $self->{ '_indexes2part_indexes' };
}

###---   </auto:code>
###---   <auto:comment id="_index2part_indexes" md5="9/LkU17afiXs8G1eC8KOBA">

=head2 _index2part_indexes

 Title   : _index2part_indexes (single key accessor to key2array property _indexes2part_indexes)
 
 Usage   : C<<< 
           my $values = $object->_index2part_indexes( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->_index2part_indexes( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->_index2part_indexes( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_indexes2part_indexes>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_index2part_indexes" md5="S0tdwqE1cn+1fo2T3+M4Zg">

sub _index2part_indexes {
  my $self = shift @_;
  my $_index2part_indexes = shift @_;
  if( !defined( $_index2part_indexes ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_indexes2part_indexes'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_indexes2part_indexes' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $_index2part_indexes ) eq 'ARRAY' ) {
        foreach my $i( @{ $_index2part_indexes } ) {
          delete $self->{ '_indexes2part_indexes' }->{ $i };
        }
      } else {
        delete $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $_index2part_indexes ) eq 'ARRAY' ) {
        foreach my $i( @{ $_index2part_indexes } ) {
          $self->{ '_indexes2part_indexes' }->{ $i } = $value;
        }
      } else {
        $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes } = $value;
      }
    } else {
      confess( "Property '_indexes2part_indexes' value for key '$_index2part_indexes' must be an ARRAY (now: $value)." );
    }
  }
  if( !exists( ( $self->{ '_indexes2part_indexes' } || {} )->{ $_index2part_indexes } ) ) {
    return undef;
  } else {
    my $ret = $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes };
    if( ref( $ret ) eq 'ARRAY' ) { return $ret; }
    else { return [ $ret ]; }
  }
}

###---   </auto:code>
###---   <auto:comment id="_add_index2part_index" md5="7fMMZhJbA+jKiAA77eDOog">

=head2 _add_index2part_index

 Title   : _add_index2part_index (adds values to a single key of key2array property _indexes2part_indexes)
 
 Usage   : C<<< $object->_add_index2part_index( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< _indexes2part_indexes >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_index2part_index" md5="5kzzceRm1upVl6uCoYbN+Q">

sub _add_index2part_index {
  my $self = shift @_;
  my $_index2part_indexes = shift @_;
  if( !defined( $_index2part_indexes ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_indexes2part_indexes'." 
    );
  }
  $self->{ '_indexes2part_indexes' } ||= {};  
  if( !exists( ( $self->{ '_indexes2part_indexes' } || {} )->{ $_index2part_indexes } ) ) {
    $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes } = shift @_;
  } 
  if( @_ ) {
    my $ret = $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes };
    if( ref( $ret ) eq 'ARRAY' ) { push @{ $ret }, @_; }
    else { $ret = [ $ret, @_ ]; }
    $self->{ '_indexes2part_indexes' }->{ $_index2part_indexes } = $ret;
  }
}

###---   </auto:code>
###--- </key2optimized_array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'aggregate', $self->get_aggregate() );
  $target->property( 'gff_version', $self->get_gff_version() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
#  $target->property( '' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  if( $property eq '' ) { $self->skip_equal( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# INDEX ITERATOR
##########################################################################

sub index_iterator
{
  my( $self ) = @_;

  my $iterator = new BioMinerva::Base::JoinedIterator();
  foreach my $primary_sequence_id( @{ $self->primary_sequence_ids() || [] } ) {
    my $subiterator = new BioMinerva::Base::ArrayIterator();
    $subiterator->set_array(
      $self->_primary_sequence_id2indexes( $primary_sequence_id )
    );
    $iterator->add_iterator( $subiterator );
  }
  return $iterator;
}

##########################################################################
# GENERAL
##########################################################################

sub num_of_features
{
  my( $self ) = @_;
  carp( "Reimplement faster" );
  return $self->SUPER::num_of_features();
}

##########################################################################
# PRIMARY_SEQUENCE_IDS
##########################################################################

sub primary_sequence_ids
{
  my( $self ) = @_;
  $self->_process_primary_sequence_ids2indexes();
  return $self->_primary_sequence_ids();
}

##########################################################################
# DERIVED FACTORIES
##########################################################################

sub primary_sequence_id_feature_factory
{
  my( $self, $primary_sequence_id ) = @_;

  $self->_process_primary_sequence_ids2indexes();
  my $indexes = $self->_primary_sequence_id2indexes( $primary_sequence_id );
  if( !ref( $indexes ) ) { $indexes = []; }

  my $index_iterator = new BioMinerva::Base::ArrayIterator();
  $index_iterator->set_array( $indexes );
  
  return
    $self->index_subset_feature_factory( $index_iterator );
}

sub toplevel_feature_factory
{
  croak( "Not to be used yet" );

#  my( $self ) = @_;

#  $self->_process_indexes2part_indexes();
#  my $rootparent_indexes = $self->_index2part_indexes( -1 ); WRONG
  
#  my $index_iterator = new BioMinerva::Base::ArrayIterator();
#  $index_iterator->set_array( $rootparent_indexes );
  
#  return
#    $self->index_subset_feature_factory( $index_iterator );
}

##########################################################################
# INDEX2FEATURE PROPERTIES ACCESSORS
##########################################################################

sub _gff3line2split_gff3line
{
  my( $self, $gff3line ) = @_;
  
  my @split_gff3line = split( /\t/, $gff3line );
  if( scalar( @split_gff3line ) >= 8 && scalar( @split_gff3line ) <= 9 ) {
    return \@split_gff3line;
  }
  @split_gff3line = split( /[\s]+/, $gff3line );
  if( scalar( @split_gff3line ) >= 8 && scalar( @split_gff3line ) <= 9 ) {
    return \@split_gff3line;
  }
  croak( "Incorrect gff3line, no 9 tab-separated fields '$gff3line' in $self" );
}

sub _split_gff3line2attrs
{
  my( $self, $split_gff3line ) = @_;

  my $gff_version = $self->get_gff_version();

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

  return $attrs;
}

sub _split_gff3line2attr
{
  my( $self, $split_gff3line, $attr_key ) = @_;
  
  my $gff_version = $self->get_gff_version();
  
  my @attr_values;
  
  if( !$gff_version || $gff_version >= 3 ) {
    foreach my $attr( split( /;/, $split_gff3line->[ 8 ] || "" ) ) {
      if( $attr =~ /^$attr_key=(.*)$/ ) {
        my @attr_values = map { uri_unescape( $_ ) } split( /,/, $1 );
        return \@attr_values;
      }
    }
  } else {
    my $attr_str = $split_gff3line->[ 8 ] || "";
    while( $attr_str =~ /\s*([^\s]+)\s+((([^;"]*?)(\s*;|$))|("([^"]+)"\s*(;|$)))/g ) {
      if( $1 ne $attr_key ) { next; }
      my $attr_values_str = $4 || $7 || '1'; #TODO: '1'???
      my @values = map { uri_unescape( $_ ) } split( /,/, $attr_values_str );
      return \@values;
    }
    if( $' ) {
      croak(
        "Incorrect attribute column format '$'' in $self"
      );
    }
  }

  return undef;
}

##########################################################################

sub _index2split_gff3line
{
  my( $self, $index ) = @_;

  my $stream = $self->get_stream();
  if( !$stream ) {
    croak( "Undefined file/stream in $self" );
  }

  if( !seek( $stream, $index, 0 ) ) {
    croak( "Failed to seek the input stream in $self" );
  }
  
  my $gff3line = <$stream>;
  if( !$gff3line ) {
    confess( "GFF3 stream failure (seeking to index '$index') in $self" );
  }
  chomp $gff3line;

  return $self->_gff3line2split_gff3line( $gff3line );
}

##########################################################################

sub _split_gff3line2sequence
{
  my( $self, $split_gff3line, $sequence ) = @_;

  ( my $primary_sequence_id, my $source, my $type, my $start, my $end, undef, my $strand ) =
    @{ $split_gff3line };

  if( $primary_sequence_id eq '.' ) { $primary_sequence_id = undef; }
  if( $start eq '.' ) { $start = undef; }
  if( $end eq '.' ) { $end = undef; }

  if( $strand eq '+' || $strand eq '1' || $strand eq '+1' ) { $strand = +1; }
  elsif( $strand eq '-' || $strand eq '-1' ) { $strand = -1; }
  elsif( $strand eq '?' || $strand eq '.' ) { $strand = undef; }
  elsif( $strand eq '0' ) { $strand = 0; }
  else {
    croak( "Don't know how to handle strand '$strand' in $self" );
  }

  if( defined( $start ) && defined( $end ) && $end < $start ) {
    croak( "GFF format error: end($end)<start($start) in $self" );
  }
  
  $sequence->set_sequence_values( $primary_sequence_id, $start, $end, $strand );
  
  if( defined( $source ) && $source ne '.' ) { $sequence->set_source( $source ); }
  if( defined( $type ) && $type ne '.' ) { $sequence->set_type( $type ); }
}

sub _split_gff3line2feature_id
{
  my( $self, $split_gff3line ) = @_;

  my $ids = $self->_split_gff3line2attr( $split_gff3line, 'ID' );

  if( !defined( $ids ) ) {
    return undef;
  } elsif( scalar( @{ $ids } ) == 1 ) {
    return $ids->[ 0 ];
  } else {
    confess( 
      "Only a single ID attribute allowed, not '"
      . join( ", ", @{ $ids } )
      . "' in $self" 
    );
  }
}

sub _split_gff3line2parent_feature_ids
{
  my( $self, $split_gff3line ) = @_;
  return $self->_split_gff3line2attr( $split_gff3line, 'Parent' );
}

##########################################################################

sub index2primary_sequence_id
{
  my( $self, $index ) = @_;
  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $split_gff3line->[ 0 ];
}

sub index2type
{
  my( $self, $index ) = @_;
  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $split_gff3line->[ 2 ];
}

sub index2start
{
  my( $self, $index ) = @_;
  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $split_gff3line->[ 3 ];
}

sub index2sequence
{
  my( $self, $index, $sequence ) = @_;

  if( !ref( $sequence ) ) { $sequence = new BioMinerva::DNALib::Sequence(); }
  
  my $split_gff3line = $self->_index2split_gff3line( $index );
  $self->_split_gff3line2sequence( $split_gff3line, $sequence );

  return $sequence;
}

sub index2flat_feature
{
  my( $self, $index, $feature ) = @_;

  if( !ref( $feature ) ) { $feature = new BioMinerva::DNALib::Feature(); }
  
  my $split_gff3line = $self->_index2split_gff3line( $index );
  $self->_split_gff3line2sequence( $split_gff3line, $feature );

  my $score = $split_gff3line->[ 5 ];
  my $phase = $split_gff3line->[ 7 ];
  my $attrs_str = $split_gff3line->[ 8 ];

  if( defined( $score ) && $score ne '.' ) 
    { $feature->set_score( $score ); }
  if( defined( $phase ) && $phase ne '.' ) 
    { $feature->add_attr( 'Phase', $phase ); }

  my $attrs = $self->_split_gff3line2attrs( $split_gff3line );
  if( exists( $attrs->{ 'ID' } ) ) {
    if( @{ $attrs->{ 'ID' } } != 1 ) {
      croak(
        "A feature may have only a single ID, not '"
        . join( ",", @{ $attrs->{ 'ID' } } )
        . "' in $self"
      );
    }
    $feature->set_id( $attrs->{ 'ID' }->[ 0 ] );
    delete $attrs->{ 'ID' };
  }

  if( $self->get_aggregate() ) {
    delete $attrs->{ 'Parent' };
  }
  
  if( %{ $attrs } ) {
    $feature->attrs( $attrs );
  }
  
  return $feature;
}

sub index2feature
{
  my( $self, $index, $feature ) = @_;

  $feature = $self->index2flat_feature( $index, $feature );

  my $part_indexes = $self->_index2part_indexes( $index );
  foreach my $part_index( @{ $part_indexes || [] } ) {
    $feature->add_part_feature( $self->index2feature( $part_index ) );
  }
  
  return $feature;
}

sub index2feature_id
{
  my( $self, $index ) = @_;

  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $self->_split_gff3line2feature_id( $split_gff3line );
}

sub index2parent_feature_ids
{
  my( $self, $index ) = @_;

  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $self->_split_gff3line2parent_feature_ids( $split_gff3line );
}

sub index2attr
{
  my( $self, $index, $attr_key ) = @_;

  my $split_gff3line = $self->_index2split_gff3line( $index );
  return $self->_split_gff3line2attr( $split_gff3line, $attr_key );
}

##########################################################################
# ALL FEATURES ARRAY BUILDERS
##########################################################################

sub indexes
{
  my( $self ) = @_;
  $self->_process_primary_sequence_ids2indexes();
  return $self->_indexes();
}

##########################################################################
# SPECIFIC FUNCTIONALITY
##########################################################################

sub _process_primary_sequence_ids2indexes
{
  my( $self ) = @_;
  
  if( defined( $self->_primary_sequence_ids2indexes() ) ) { return; }

  my $aggregate = $self->get_aggregate();

  if( $aggregate ) {
    $self->_process(
      "ID",
      [ 
        \&_build_feature_id2index
      ] 
    );
    $self->_process(
      "Parent/ID,toplevel,primary_sequence_id",
      [ 
        \&_build_index2part_indexes
      ] 
    );
  } else {
    $self->_process( 
      "primary_sequence_id",
      [ 
        \&_build_primary_sequence_id2index
      ] 
    );
  }
}

##########################################################################

sub _process
{
  my( $self, $comment, $functions ) = @_;
  
  my $counter = 0;
  my $stream = $self->get_stream();
  if( !$stream ) {
    croak( "Undefined file/stream in $self" );
  }

  if( !seek( $stream, 0, 0 ) ) {
    croak( "Failed to seek the input stream in $self" );
  }
  
  while( 1 ) {
    my $index = tell( $stream );

    my $gff3line = <$stream>;
    if( !defined( $gff3line ) ) { last; }
    if( $gff3line =~ /^#/ ) {
      if( $gff3line =~ /^##FASTA\s*$/ ) { last; }
      next; 
    }
    if( $gff3line =~ /^\s*$/ ) { next; }
    chomp $gff3line;

    my $split_gff3line = $self->_gff3line2split_gff3line( $gff3line );

    foreach my $function( @{ $functions } ) {
      $function->( $self, $index, $split_gff3line );
    }
    
    ++$counter;
    if( !( $counter % 1000 ) ) {
      print STDERR "#Indexing($comment) (display_id='"
        . $self->display_id()
        . "'): $counter done...     \r";
    }
  }
  
  print STDERR "#Indexed($comment) $counter feature(s) (file='"
    . $self->_get_file()
    . "', display_id='"
    . $self->display_id()
    . "')\n";
}

##########################################################################

sub _build_primary_sequence_id2index
{
  my( $self, $index, $split_gff3line ) = @_;
  $self->_add_primary_sequence_id2index( $split_gff3line->[ 0 ], $index );
}

sub _build_feature_id2index
{
  my( $self, $index, $split_gff3line ) = @_;
  my $feature_id = $self->_split_gff3line2feature_id( $split_gff3line );
  if( defined( $feature_id ) ) {
    if( defined( $self->_feature_id2index( $feature_id ) ) ) {
      $self->_feature_id2index( $feature_id, undef );
    } else {
      $self->_feature_id2index( $feature_id, $index );
    }
  }
}

sub _build_index2part_indexes
{
  my( $self, $index, $split_gff3line ) = @_;
  my $parent_feature_ids = $self->_split_gff3line2parent_feature_ids( $split_gff3line );

  if( @{ $parent_feature_ids || [] } ) {
    foreach my $parent_feature_id( @{ $parent_feature_ids || [] } ) {
      my $parent_index = $self->_feature_id2index( $parent_feature_id );
      if( !defined( $parent_index ) ) {
        croak(
          "Incorret GFF file: Parent='$parent_feature_id' can't be resolved - no ID or non-unique ID in $self"
        );
      }
      $self->_add_index2part_index( $parent_index, $index );
    }
  } else {
    $self->_add_primary_sequence_id2index( $split_gff3line->[ 0 ], $index );
  }
}

sub _build_index2parent_ids
{
  croak( "Not to be used yet" );
  
  my( $self, $index, $split_gff3line ) = @_;
  my $parent_feature_ids = $self->_split_gff3line2parent_feature_ids( $split_gff3line );
  if( defined( $parent_feature_ids ) ) {
    $self->_index2parent_feature_ids( $index, $parent_feature_ids );
  }
}

##########################################################################

1;

