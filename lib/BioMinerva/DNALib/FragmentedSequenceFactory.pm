##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FragmentedSequenceFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SequenceFactory;
@ISA = qw( BioMinerva::DNALib::SequenceFactory );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="ignore_duplicates" get_id='' set_id=''>
###---   <auto:comment id="ignore_duplicates" md5="oSlz9fxPf13JNwgAjrQcRQ">

=head2 ignore_duplicates

 Title   : ignore_duplicates property
 
 Usage   : $object->ignore_duplicates(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ignore_duplicates" md5="RkR1sICKRTsn6/sz7j5YDQ">

sub ignore_duplicates {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ignore_duplicates' } = shift @_;
  }
  return $self->{ 'ignore_duplicates' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ignore_duplicates" md5="19VjSKkI+gTfIDdH8ulvVw">

sub get_ignore_duplicates {
  return shift->{ 'ignore_duplicates' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ignore_duplicates" md5="mRu8HvbdGVNjWzL7mh480w">

sub set_ignore_duplicates {
  my $self = shift @_;
  $self->{ 'ignore_duplicates' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id="_stored_sequence" ids="_stored_sequences" add_id="_add_stored_sequence">
###---   <auto:comment id="_stored_sequences" md5="EK6xoLD8cckdBYQ6zxgGBA">

=head2 _stored_sequences

 Title   : _stored_sequences (array property)
 
 Usage   : C<<< my $_stored_sequences = $object->_stored_sequences();
           if( defined( $_stored_sequences ) ) { 
             foreach my $_stored_sequence( @{ $_stored_sequences } ) {
               ...
             }
           } >>>
           
           C<<< $object->_stored_sequences( $_stored_sequences ); >>>
 
           C<<< $object->_stored_sequences( undef ); >>>

 Function: Accessor to the array property C<_stored_sequences>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of _stored_sequences to be set
           clear-accessor: undef

 Return  : reference to the current array of _stored_sequences or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_stored_sequences" md5="Y1AfoLL6wojYRH6zm8va5g">

sub _stored_sequences {
  my $self = shift @_;
  if( @_ ) {
    my $_stored_sequences = shift @_;
    if( defined( $_stored_sequences ) && ref( $_stored_sequences ) ne 'ARRAY' ) {
      confess( "Property '_stored_sequences' requires an ARRAY argument (now: $_stored_sequences)." );
    }
    $self->{ '_stored_sequences' } = $_stored_sequences;
  }
  return $self->{ '_stored_sequences' };
}

###---   </auto:code>
###---   <auto:comment id="_add_stored_sequence" md5="J4ZwtDfZ2+GKTIF42n4HcQ">

=head2 _add_stored_sequence

 Title   : _add_stored_sequence (_stored_sequences property)
 
 Usage   : C<<< $object->_add_stored_sequence( $_stored_sequence, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< _stored_sequences >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_stored_sequence" md5="5EdWcg+pjJhH06/neSLYmQ">

sub _add_stored_sequence {
  my $self = shift @_;
  my @_stored_sequences = @_;
  $self->{ '_stored_sequences' } ||= [];
  push @{ $self->{ '_stored_sequences' } }, @_stored_sequences;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <key2array_property id="_sequence_id2stored_sequences" ids="_sequence_ids2stored_sequences" add_id="_add_sequence_id2stored_sequence">
###---   <auto:comment id="_sequence_ids2stored_sequences" md5="8GAV7iONAsYe9ND1PGUKoQ">

=head2 _sequence_ids2stored_sequences

 Title   : _sequence_ids2stored_sequences (whole hash accrssor to key2array property _sequence_ids2stored_sequences)
 
 Usage   : C<<< 
           my $_sequence_ids2stored_sequences = $object->_sequence_ids2stored_sequences();
           if( defined( $_sequence_ids2stored_sequences ) ) { 
             foreach my $_sequence_id2stored_sequences( keys %{ $_sequence_ids2stored_sequences } ) {
               my $values = $_sequence_ids2stored_sequences->{ $_sequence_id2stored_sequences };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->_sequence_ids2stored_sequences( $_sequence_ids2stored_sequences ); >>>
 
           C<<< $object->_sequence_ids2stored_sequences( undef ); >>>

 Function: Accessor to the property C<_sequence_ids2stored_sequences> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _sequence_ids2stored_sequences to be set
           clear-accessor: undef

 Return  : reference to the current hash of _sequence_ids2stored_sequences or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_sequence_ids2stored_sequences" md5="jk4gpXa4vgNjmmehtZi6Uw">

sub _sequence_ids2stored_sequences {
  my $self = shift @_;
  if( @_ ) {
    my $_sequence_ids2stored_sequences = shift @_;
    if( defined( $_sequence_ids2stored_sequences ) && ref( $_sequence_ids2stored_sequences ) ne 'HASH' ) {
      confess( "Property '_sequence_ids2stored_sequences' requires a HASH argument (now: $_sequence_ids2stored_sequences)." );
    }
    $self->{ '_sequence_ids2stored_sequences' } = $_sequence_ids2stored_sequences;
  }
  return $self->{ '_sequence_ids2stored_sequences' };
}

###---   </auto:code>
###---   <auto:comment id="_sequence_id2stored_sequences" md5="qSTHdeA7dSuZzqcDIq8NrQ">

=head2 _sequence_id2stored_sequences

 Title   : _sequence_id2stored_sequences (single key accessor to key2array property _sequence_ids2stored_sequences)
 
 Usage   : C<<< 
           my $values = $object->_sequence_id2stored_sequences( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->_sequence_id2stored_sequences( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->_sequence_id2stored_sequences( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_sequence_ids2stored_sequences>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_sequence_id2stored_sequences" md5="YQ7c+Vcx8KRHftDhpCX85A">

sub _sequence_id2stored_sequences {
  my $self = shift @_;
  my $_sequence_id2stored_sequences = shift @_;
  if( !defined( $_sequence_id2stored_sequences ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_sequence_ids2stored_sequences'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_sequence_ids2stored_sequences' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $_sequence_id2stored_sequences ) eq 'ARRAY' ) {
        foreach my $i( @{ $_sequence_id2stored_sequences } ) {
          delete $self->{ '_sequence_ids2stored_sequences' }->{ $i };
        }
      } else {
        delete $self->{ '_sequence_ids2stored_sequences' }->{ $_sequence_id2stored_sequences };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $_sequence_id2stored_sequences ) eq 'ARRAY' ) {
        foreach my $i( @{ $_sequence_id2stored_sequences } ) {
          $self->{ '_sequence_ids2stored_sequences' }->{ $i } = $value;
        }
      } else {
        $self->{ '_sequence_ids2stored_sequences' }->{ $_sequence_id2stored_sequences } = $value;
      }
    } else {
      confess( "Property '_sequence_ids2stored_sequences' value for key '$_sequence_id2stored_sequences' must be an ARRAY (now: $value)." );
    }
  }
  return ( $self->{ '_sequence_ids2stored_sequences' } || {} )->{ $_sequence_id2stored_sequences };
}

###---   </auto:code>
###---   <auto:comment id="_add_sequence_id2stored_sequence" md5="hg0yTIiBHToZnZrUQ06lng">

=head2 _add_sequence_id2stored_sequence

 Title   : _add_sequence_id2stored_sequence (adds values to a single key of key2array property _sequence_ids2stored_sequences)
 
 Usage   : C<<< $object->_add_sequence_id2stored_sequence( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< _sequence_ids2stored_sequences >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_sequence_id2stored_sequence" md5="kaJEs+KlwHC2XdGOJVLTRw">

sub _add_sequence_id2stored_sequence {
  my $self = shift @_;
  my $_sequence_id2stored_sequences = shift @_;
  if( !defined( $_sequence_id2stored_sequences ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_sequence_ids2stored_sequences'." 
    );
  }
  $self->{ '_sequence_ids2stored_sequences' } ||= {};  
  $self->{ '_sequence_ids2stored_sequences' }->{ $_sequence_id2stored_sequences } ||= [];
  push @{ $self->{ '_sequence_ids2stored_sequences' }->{ $_sequence_id2stored_sequences } }, @_;
  return undef;
}

###---   </auto:code>
###--- </key2array_property>

###--- <key2array_property id="_primary_sequence_id2stored_sequences" ids="_primary_sequence_ids2stored_sequences" add_id="_add_primary_sequence_id2stored_sequence">
###---   <auto:comment id="_primary_sequence_ids2stored_sequences" md5="zQVZlxJp4jjS7dbMfyq3Eg">

=head2 _primary_sequence_ids2stored_sequences

 Title   : _primary_sequence_ids2stored_sequences (whole hash accrssor to key2array property _primary_sequence_ids2stored_sequences)
 
 Usage   : C<<< 
           my $_primary_sequence_ids2stored_sequences = $object->_primary_sequence_ids2stored_sequences();
           if( defined( $_primary_sequence_ids2stored_sequences ) ) { 
             foreach my $_primary_sequence_id2stored_sequences( keys %{ $_primary_sequence_ids2stored_sequences } ) {
               my $values = $_primary_sequence_ids2stored_sequences->{ $_primary_sequence_id2stored_sequences };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->_primary_sequence_ids2stored_sequences( $_primary_sequence_ids2stored_sequences ); >>>
 
           C<<< $object->_primary_sequence_ids2stored_sequences( undef ); >>>

 Function: Accessor to the property C<_primary_sequence_ids2stored_sequences> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _primary_sequence_ids2stored_sequences to be set
           clear-accessor: undef

 Return  : reference to the current hash of _primary_sequence_ids2stored_sequences or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_primary_sequence_ids2stored_sequences" md5="tr6oT3v7sVjGkcInuBgv4g">

sub _primary_sequence_ids2stored_sequences {
  my $self = shift @_;
  if( @_ ) {
    my $_primary_sequence_ids2stored_sequences = shift @_;
    if( defined( $_primary_sequence_ids2stored_sequences ) && ref( $_primary_sequence_ids2stored_sequences ) ne 'HASH' ) {
      confess( "Property '_primary_sequence_ids2stored_sequences' requires a HASH argument (now: $_primary_sequence_ids2stored_sequences)." );
    }
    $self->{ '_primary_sequence_ids2stored_sequences' } = $_primary_sequence_ids2stored_sequences;
  }
  return $self->{ '_primary_sequence_ids2stored_sequences' };
}

###---   </auto:code>
###---   <auto:comment id="_primary_sequence_id2stored_sequences" md5="ZrDacFDXod/Mc4/T0TdaoQ">

=head2 _primary_sequence_id2stored_sequences

 Title   : _primary_sequence_id2stored_sequences (single key accessor to key2array property _primary_sequence_ids2stored_sequences)
 
 Usage   : C<<< 
           my $values = $object->_primary_sequence_id2stored_sequences( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->_primary_sequence_id2stored_sequences( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->_primary_sequence_id2stored_sequences( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_primary_sequence_ids2stored_sequences>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_primary_sequence_id2stored_sequences" md5="NM7hEBFskxyUce2nzbf6+g">

sub _primary_sequence_id2stored_sequences {
  my $self = shift @_;
  my $_primary_sequence_id2stored_sequences = shift @_;
  if( !defined( $_primary_sequence_id2stored_sequences ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_primary_sequence_ids2stored_sequences'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_primary_sequence_ids2stored_sequences' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $_primary_sequence_id2stored_sequences ) eq 'ARRAY' ) {
        foreach my $i( @{ $_primary_sequence_id2stored_sequences } ) {
          delete $self->{ '_primary_sequence_ids2stored_sequences' }->{ $i };
        }
      } else {
        delete $self->{ '_primary_sequence_ids2stored_sequences' }->{ $_primary_sequence_id2stored_sequences };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $_primary_sequence_id2stored_sequences ) eq 'ARRAY' ) {
        foreach my $i( @{ $_primary_sequence_id2stored_sequences } ) {
          $self->{ '_primary_sequence_ids2stored_sequences' }->{ $i } = $value;
        }
      } else {
        $self->{ '_primary_sequence_ids2stored_sequences' }->{ $_primary_sequence_id2stored_sequences } = $value;
      }
    } else {
      confess( "Property '_primary_sequence_ids2stored_sequences' value for key '$_primary_sequence_id2stored_sequences' must be an ARRAY (now: $value)." );
    }
  }
  return ( $self->{ '_primary_sequence_ids2stored_sequences' } || {} )->{ $_primary_sequence_id2stored_sequences };
}

###---   </auto:code>
###---   <auto:comment id="_add_primary_sequence_id2stored_sequence" md5="CV7ypOBG3bjCIkQ7gwv9Jw">

=head2 _add_primary_sequence_id2stored_sequence

 Title   : _add_primary_sequence_id2stored_sequence (adds values to a single key of key2array property _primary_sequence_ids2stored_sequences)
 
 Usage   : C<<< $object->_add_primary_sequence_id2stored_sequence( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< _primary_sequence_ids2stored_sequences >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_primary_sequence_id2stored_sequence" md5="SZfJqlQggRrMV1XFb6z6Qg">

sub _add_primary_sequence_id2stored_sequence {
  my $self = shift @_;
  my $_primary_sequence_id2stored_sequences = shift @_;
  if( !defined( $_primary_sequence_id2stored_sequences ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_primary_sequence_ids2stored_sequences'." 
    );
  }
  $self->{ '_primary_sequence_ids2stored_sequences' } ||= {};  
  $self->{ '_primary_sequence_ids2stored_sequences' }->{ $_primary_sequence_id2stored_sequences } ||= [];
  push @{ $self->{ '_primary_sequence_ids2stored_sequences' }->{ $_primary_sequence_id2stored_sequences } }, @_;
  return undef;
}

###---   </auto:code>
###--- </key2array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'ignore_duplicates', $self->get_ignore_duplicates() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub sequence_ids
{
  # ----- this is to keep the same order of sequences as in the file -----
  my( $self ) = @_;
  my @sequence_ids = map { $_->id() } @{ $self->sequences() || [] };
  return \@sequence_ids;
}

sub sequences
{
  # ----- this is to keep the same order of sequences as in the file -----
  my( $self ) = @_;
  $self->_process_sequences();
  return $self->_stored_sequences();
}

sub sequence_id2sequence
{
  my( $self, $sequence_id ) = @_;
  
  $self->_process_sequences();

  my $stored_sequences = $self->_sequence_id2stored_sequences( $sequence_id );
  my $size = scalar( @{ $stored_sequences || [] } );
  if( !$size ) {
    return undef;
  } elsif( $size > 1 ) {
    if( $self->get_ignore_duplicates() ) {
      carp( "Taking first and ignoring duplicate sequence id '$sequence_id' in $self" );
      return $stored_sequences->[ 0 ];
    } else {
      croak( "Duplicate sequence id '$sequence_id' in $self" );
    }
  } else {
    return $stored_sequences->[ 0 ];
  }
}

sub sequence2seq
{
  my( $self, $sequence ) = @_;

  $self->_process_sequences();

  my $stored_sequences =
    $self->_primary_sequence_id2stored_sequences( $sequence->get_primary_sequence_id() );
  if( !scalar( @{ $stored_sequences || [] } ) ) { 
    return undef; 
  }

  my $seq = $self->SUPER::sequence2seq( $sequence );
  
  foreach my $stored_sequence( @{ $stored_sequences } ) {
    $self->_fill_seq( $stored_sequence, $sequence, \$seq );
  }
  
  if( length( $seq ) != $sequence->length() ) {
    confess( "Wrong length " . length( $seq ) . " of seq instead of requested "
      . $sequence->length() );
  }

  return $seq;
}

##########################################################################
# INTERNALS
##########################################################################

sub _process_sequences
{
  my( $self ) = @_;
}

##########################################################################
 
sub _add_sequence
{
  my( $self, $stored_sequence, $primary_sequence_id, $sequence_id ) = @_;

  $self->_add_stored_sequence( $stored_sequence );
  $self->_add_sequence_id2stored_sequence( $sequence_id, $stored_sequence );
  $self->_add_primary_sequence_id2stored_sequence( $primary_sequence_id, $stored_sequence );
}

##########################################################################
# Coords in $seq:                      s_start                s_end
# seq_feature:                         |NNNNNNNNNNNNNNNNNNNNNN|
# Coords in $stored_seq:     f_start                 f_end
# stored_feature             |-----------------------|
#
# d_start                   |<---------|
# d_end                                             |<--------|

# stored_sequence  sequence  complement
#       +            +          -
#       +            -          +
#       -            +          +
#       -            -          -

sub _fill_seq
{
  my( $self, $stored_sequence, $sequence, $seq_ref ) = @_;

  my $intersection_sequence = $sequence->intersection_sequence( $stored_sequence );
  if( !ref( $intersection_sequence ) ) { return; }

  # ----- calculation of relative locations of stored and seq -----
  my $complement = 0;
  if( ( $stored_sequence->get_strand() || 0 ) >= 0 && ( $sequence->get_strand() || 0 ) < 0 ) {
    $complement = 1;
  } elsif( ( $stored_sequence->get_strand() || 0 ) < 0 && ( $sequence->get_strand() || 0 ) >= 0 ) {
    $complement = 1;
  }
  
  my $copy_length = $intersection_sequence->length();

  my $s_offs = $intersection_sequence->get_start() - $sequence->get_start();
  if( ( $sequence->get_strand() || 0 ) < 0 ) {
    $s_offs = $sequence->length() - $s_offs - $copy_length;
  }
  if( $complement ) {
    $s_offs += $copy_length;
  }
  
  my $f_offs = $intersection_sequence->get_start() - $stored_sequence->get_start();
  if( ( $stored_sequence->get_strand() || 0 ) < 0 ) {
    $f_offs = $stored_sequence->length() - $f_offs - $copy_length;
  }

  $self->_do_seek_seq( $stored_sequence, $f_offs );

  while( $copy_length > 0 )
  {
    my $line = $self->_do_get_seq( $stored_sequence, $f_offs, $copy_length );

    my $length = length( $line );
    if( $length > $copy_length ) { 
      $length = $copy_length; 
      $line = substr( $line, 0, $length );
    }

    if( $complement ) {
      $line = reverse $line;
      $line =~ tr/ACGTWRKSYMBHDVNacgtwrksymbhdvn/TGCAWYMSRKVDHBNtgcawymsrkvdhbn/;
      $s_offs -= $length;
      if( $s_offs < 0 ) {
        carp( "s_offs=$s_offs < 0???" );
      } elsif( $s_offs + $length > length( ${ $seq_ref } ) ) {
        carp( "s_offs+length > length???" );
      }
      substr( ${ $seq_ref }, $s_offs, $length ) = $line;
    } else {
      substr( ${ $seq_ref }, $s_offs, $length ) = $line;
      $s_offs += $length;
    }

    $copy_length -= $length;
    $f_offs += $length;
  }
}

sub _do_seek_seq
{
  my( $self, $stored_sequence, $f_offs ) = @_;
}

sub _do_get_seq
{
  my( $self, $stored_sequence, $f_offs, $copy_length ) = @_;

  confess( "Not overridden in $self" );
}

##########################################################################

1;

