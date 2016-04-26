##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Sequence;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::StrandedRange;
@ISA = qw( BioMinerva::DNALib::StrandedRange );

use Carp qw( confess croak carp );

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
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::Sequence();
  }
  $self->SUPER::clone( $clone );

  $clone->set_type( $self->get_type() );
  $clone->set_source( $self->get_source() );
  $clone->attrs( $self->_clone_attrs( $self->attrs() ) ); 
}

sub sequence {
  my( $self, @args ) = @_;

  if( @args ) {
    carp( "Interface change, use absolute_sequence instead!" );

    return $self->absolute_sequence( @args );
  }
  
  my $sequence = new BioMinerva::DNALib::Sequence();

  $sequence->set_id( $self->get_id() );
  $sequence->set_type( $self->get_type() );
  $sequence->set_source( $self->get_source() );
  $sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $sequence->set_start( $self->get_start() );
  $sequence->set_end( $self->get_end() );
  $sequence->set_strand( $self->get_strand() );
  $sequence->attrs( $self->_clone_attrs( $self->attrs() ) );

  return $sequence;
}

sub _location_sequence {
  my( $self ) = @_;

  my $sequence = new BioMinerva::DNALib::Sequence();

  $sequence->set_source( $self->get_source() );
  $sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $sequence->set_start( $self->get_start() );
  $sequence->set_end( $self->get_end() );
  $sequence->set_strand( $self->get_strand() );

  return $sequence;
}

sub _clone_attrs
{
  my( $self, $attrs ) = @_;

  my %new_attrs;
  foreach my $key( keys %{ $attrs || {} } ) {
    my @value = @{ $attrs->{ $key } || [] };
    $new_attrs{ $key } = \@value;
  }

  return \%new_attrs;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='type' get_id='' set_id=''>
###---   <auto:comment id="type" md5="XezXTEMbnbJDRq3e1bk7dw">

=head2 type

 Title   : type property
 
 Usage   : $object->type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="type" md5="p0Cj5KdyYQ7fWlzcEur9vw">

sub type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'type' } = shift @_;
  }
  return $self->{ 'type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_type" md5="bsqUsOoQFpKYVSsxsj/MGg">

sub get_type {
  return shift->{ 'type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_type" md5="vgQvqMIBCa/6ytBNof6ytA">

sub set_type {
  my $self = shift @_;
  $self->{ 'type' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='source' get_id='' set_id=''>
###---   <auto:comment id="source" md5="Xpydye2MQSd4U2S/zyOBXw">

=head2 source

 Title   : source property
 
 Usage   : $object->source(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="source" md5="WaMSVvGpQkc9/hGj6i5MKg">

sub source {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'source' } = shift @_;
  }
  return $self->{ 'source' };
}

###---   </auto:code>
###---   <auto:code get_id="get_source" md5="IHLbTZ3P8FkkNGNoHgAgNA">

sub get_source {
  return shift->{ 'source' };
}

###---   </auto:code>
###---   <auto:code set_id="set_source" md5="jOTtPYsz3fJFWMi0RoEvzw">

sub set_source {
  my $self = shift @_;
  $self->{ 'source' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <key2array_property id="attr" ids="attrs" keys_id="attr_ids">
###---   <auto:comment id="attrs" md5="NAJHCP8yFCgbAyQXxNcUOw">

=head2 attrs

 Title   : attrs (whole hash accrssor to key2array property attrs)
 
 Usage   : C<<< 
           my $attrs = $object->attrs();
           if( defined( $attrs ) ) { 
             foreach my $attr( keys %{ $attrs } ) {
               my $values = $attrs->{ $attr };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->attrs( $attrs ); >>>
 
           C<<< $object->attrs( undef ); >>>

 Function: Accessor to the property C<attrs> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of attrs to be set
           clear-accessor: undef

 Return  : reference to the current hash of attrs or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="attrs" md5="8IDCX2cI6xa3M+jt/oYy1Q">

sub attrs {
  my $self = shift @_;
  if( @_ ) {
    my $attrs = shift @_;
    if( defined( $attrs ) && ref( $attrs ) ne 'HASH' ) {
      confess( "Property 'attrs' requires a HASH argument (now: $attrs)." );
    }
    $self->{ 'attrs' } = $attrs;
  }
  return $self->{ 'attrs' };
}

###---   </auto:code>
###---   <auto:comment id="attr" md5="UXp2nNdmfkm+JlrmmBubbA">

=head2 attr

 Title   : attr (single key accessor to key2array property attrs)
 
 Usage   : C<<< 
           my $values = $object->attr( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->attr( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->attr( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<attrs>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="attr" md5="DdpaXJ0NOVtuSefxavzSJQ">

sub attr {
  my $self = shift @_;
  my $attr = shift @_;
  if( !defined( $attr ) ) {
    confess( 
      "A key must be given to access a single item of key2array property 'attrs'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ 'attrs' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $attr ) eq 'ARRAY' ) {
        foreach my $i( @{ $attr } ) {
          delete $self->{ 'attrs' }->{ $i };
        }
      } else {
        delete $self->{ 'attrs' }->{ $attr };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $attr ) eq 'ARRAY' ) {
        foreach my $i( @{ $attr } ) {
          $self->{ 'attrs' }->{ $i } = $value;
        }
      } else {
        $self->{ 'attrs' }->{ $attr } = $value;
      }
    } else {
      confess( "Property 'attrs' value for key '$attr' must be an ARRAY (now: $value)." );
    }
  }
  return ( $self->{ 'attrs' } || {} )->{ $attr };
}

###---   </auto:code>
###---   <auto:comment id="add_attr" md5="WHPjt675n+aV313xgeh8Xg">

=head2 add_attr

 Title   : add_attr (adds values to a single key of key2array property attrs)
 
 Usage   : C<<< $object->add_attr( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< attrs >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_attr" md5="ITcfFAk7NwRmvr64y3Eifw">

sub add_attr {
  my $self = shift @_;
  my $attr = shift @_;
  if( !defined( $attr ) ) {
    confess( 
      "A key must be given to access a single item of key2array property 'attrs'." 
    );
  }
  $self->{ 'attrs' } ||= {};  
  $self->{ 'attrs' }->{ $attr } ||= [];
  push @{ $self->{ 'attrs' }->{ $attr } }, @_;
  return undef;
}

###---   </auto:code>
###---   <auto:code id="attr_ids" md5="jpMsXNZzXM2mgGEfORF+Fw">

sub attr_ids {
  my $self = shift @_;
  my @attr_ids = keys %{ $self->{ 'attrs' } || {} };
  return \@attr_ids;
}

###---   </auto:code>
###--- </key2array_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  $digest->add( $self->get_type() || '' );
  $digest->add( $self->get_source() || '' );
  $digest->add( $self->attrs() || '' );

  return $digest;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'type', $self->get_type() );
  $target->property( 'source', $self->get_source() );
  $target->property( 'attrs', $self->attrs() );
}

sub set_sequence
{
  my( $self, $sequence ) = @_;

  $self->set_id( $sequence->get_id() );
  
#  $self->set_type( $sequence->get_type() ); 
  $self->set_source( $sequence->get_source() );
  $self->set_primary_sequence_id( $sequence->get_primary_sequence_id() );
  $self->set_start( $sequence->get_start() );
  $self->set_end( $sequence->get_end() );
  $self->set_strand( $sequence->get_strand() );

  my $attrs = $self->_clone_attrs( $sequence->attrs() );
  foreach my $attr( keys %{ $attrs } ) {
    $self->add_attr( $attr, @{ $attrs->{ $attr } } ); #TODO: rethink
  }
}

##########################################################################

sub set_id_sequence_values
{
  my $self = shift @_;
  $self->set_id( shift @_ );
  $self->set_primary_sequence_id( shift @_ );
  $self->set_start( shift @_ );
  $self->set_end( shift @_ );
  $self->set_strand( shift @_ );
}

sub set_sequence_values
{
  my $self = shift @_;
  $self->set_primary_sequence_id( shift @_ );
  $self->set_start( shift @_ );
  $self->set_end( shift @_ );
  $self->set_strand( shift @_ );
}

sub get_by_key_attr
{
  my( $self, $key ) = @_;

  if( $key eq 'ID' ) { return $self->get_id(); }
  elsif( $key eq 'type' ) { return $self->get_type(); }
  elsif( $key eq 'source' ) { return $self->get_source(); }
  elsif( $key eq 'Source' ) { return $self->get_source(); }
  else { return join( ':', @{ $self->attr( $key ) || [] } ); }
}

sub set_by_key_attr
{
  my( $self, $key, $value ) = @_;

  if( $key eq 'ID' ) { $self->set_id( $value ); }
  elsif( $key eq 'type' ) { $self->set_type( $value ); }
  elsif( $key eq 'source' ) { $self->set_source( $value ); }
  elsif( $key eq 'Source' ) { $self->set_source( $value ); }
  else { $self->add_attr( $key, $value ); }
}

sub set_by_key_attrs
{
  my( $self, $attrs ) = @_;

  foreach my $attr( keys %{ $attrs } ) {
    $self->set_by_key_attr( $attr, $attrs->{ $attr } );
  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub attrs_str
{
  my( $self ) = @_;

  my $attrs = $self->attrs();
  return
    join( 
      ';',
      map { $_ . "=" . join( ',', @{ $attrs->{ $_ } } ) }
        keys %{ $attrs || {} }
    );
}

##########################################################################
# Equality and containment
##########################################################################

sub equals
{
  my( $self, $sequence ) = @_;

  if( !$self->SUPER::equals( $sequence ) ) { return 0; }
  if( $self->get_type() ne $sequence->get_type() ) { return 0; }

  return 1;
}

##########################################################################
# RETURNS A NEW SEQUENCE
##########################################################################

sub absolute_sequence
{
  my( $self, $start, $end, $strand ) = @_;
  
  my $sequence = new BioMinerva::DNALib::Sequence();

  $sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $sequence->set_start( $start );
  $sequence->set_end( $end );
  $sequence->set_strand( $strand );
  $sequence->set_source( $self->get_source() );

  return $sequence;
}

#this works in coordinates of returned seq
sub relative_sequence
{
  my( $self, $rel_start, $rel_end, $opposite_strand ) = @_;

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_strand( $self->get_strand() );
  $ret_sequence->set_source( $self->get_source() );
  
  if( !$self->get_strand() || $self->get_strand() >= 0 ) {
    $ret_sequence->set_start( $self->get_start() + $rel_start );
    $ret_sequence->set_end( $self->get_start() + $rel_end );
  } else {
    $ret_sequence->set_start( $self->get_end() - $rel_end );
    $ret_sequence->set_end( $self->get_end() - $rel_start );
  }
  
  if( $opposite_strand ) { 
    $ret_sequence->complement(); 
  }

  return $ret_sequence;
}

sub intersection_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) { return undef; }
  if( $self->get_start() > $sequence->get_end() ) { return undef; }
  if( $self->get_end() < $sequence->get_start() ) { return undef; }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() > $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() < $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );
  $ret_sequence->set_source( $self->get_source() );

  return $ret_sequence;
}

sub union_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow union_sequence of $self and $sequence" );
  }
  if( $self->get_start() > $sequence->get_end() ) { return undef; }
  if( $self->get_end() < $sequence->get_start() ) { return undef; }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() < $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() > $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );
  $ret_sequence->set_source( $self->get_source() );

  return $ret_sequence;
}

sub surrounding_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow surrounding_sequence of $self and $sequence" );
  }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() < $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() > $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );
  $ret_sequence->set_source( $self->get_source() );

  return $ret_sequence;
}

sub upstream_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    -$upstream_length, 
    $downstream_length - 1, 
    0 
  );
}

sub downstream_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    $self->length() - $upstream_length, 
    $self->length() - 1 + $downstream_length,
    0 
  );
}

sub expanded_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    -$upstream_length, 
    $self->length() - 1 + $downstream_length,
    0 
  );
}

#the piece of $self which lies upstream of $ref_sequence is returned
#throws if "upstreamity" can not be determined (other primary sequence of no
#strand in $ref_sequence)
sub upstream_fragment_sequence
{
  my( $self, $ref_sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $ref_sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow upstream_fragment_sequence of $self and $ref_sequence" );
  }
  
  #.......................RR>>>>RRR..............
  #..........SSSSSSSS............................
  #...............SSSSSSSSsss....................
  #.....................SSsssssssssss............
  #.........................sssss................
  #.............................sssssssss........
  #....................................sssssssss.
  if( !$ref_sequence->get_strand() ) {
    confess( "Can not upstream_fragment_sequence when no strand given in $ref_sequence" );
  } elsif( $ref_sequence->get_strand() > 0 ) {
    if( $self->get_end() < $ref_sequence->get_start() ) {
      return $self->_location_sequence();
    } elsif( $self->get_start() < $ref_sequence->get_start() ) {
      my $ret_sequence = $self->_location_sequence();
      $ret_sequence->set_end( $ref_sequence->get_start() - 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } else {
    if( $self->get_start() > $ref_sequence->get_end() ) {
      return $self->_location_sequence();
    } elsif( $self->get_end() > $ref_sequence->get_end() ) {
      my $ret_sequence = $self->_location_sequence();
      $ret_sequence->set_start( $ref_sequence->get_end() + 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  }
}

#the piece of $self which lies downstream of $ref_sequence is returned
#throws if "downstreamity" can not be determined (other primary sequence of no
#strand in $ref_sequence)
sub downstream_fragment_sequence
{
  my( $self, $ref_sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $ref_sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow downstream_fragment_sequence of $self and $ref_sequence" );
  }
  
  #.......................RR>>>>RRR..............
  #..........ssssssss............................
  #...............sssssssssss....................
  #.....................sssssssssssSS............
  #.........................sssss................
  #.............................sssSSSSSS........
  #....................................SSSSSSSSS.
  if( !$ref_sequence->get_strand() ) {
    confess( "Can not downstream_fragment_sequence when no strand given in $ref_sequence" );
  } elsif( $ref_sequence->get_strand() < 0 ) {
    if( $self->get_end() < $ref_sequence->get_start() ) {
      return $self->_location_sequence();
    } elsif( $self->get_start() < $ref_sequence->get_start() ) {
      my $ret_sequence = $self->_location_sequence();
      $ret_sequence->set_end( $ref_sequence->get_start() - 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } else {
    if( $self->get_start() > $ref_sequence->get_end() ) {
      return $self->_location_sequence();
    } elsif( $self->get_end() > $ref_sequence->get_end() ) {
      my $ret_sequence = $self->_location_sequence();
      $ret_sequence->set_start( $ref_sequence->get_end() + 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  }
}

sub temp_upstream_trim_sequence
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return 1;
  }

  if( $self->get_strand() > 0 ) {
    if( $sequence->get_end() < $self->get_start() ) {
      return $self->sequence();
    } elsif( $sequence->get_end() < $self->get_end() ) {
      my $ret_sequence = $self->sequence();
      $ret_sequence->set_start( $sequence->get_end() + 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } elsif( $self->get_strand() < 0 ) {
    if( $sequence->get_start() > $self->get_end() ) {
      return $self->sequence();
    } elsif( $sequence->get_start() > $self->get_start() ) {
      my $ret_sequence = $self->sequence();
      $ret_sequence->set_end( $sequence->get_start() - 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } else {
    confess( "Can not upstream_trim sequences with undefined strand in $self to $sequence" );
  }
}

#warning, will be undefined on circular chromosomes!
sub spacer_sequence
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return undef;
  }

  my $start;
  my $end;

  if( $self->get_end() + 1 < $sequence->get_start() ) {
    $start = $self->get_end() + 1;
    $end = $sequence->get_start() - 1;
  } elsif( $sequence->get_end() + 1 < $self->get_start() ) {
    $start = $sequence->get_end() + 1;
    $end = $self->get_start() - 1;
  } else {
    return undef;
  }
  
  my $ret_sequence = new BioMinerva::DNALib::Sequence();

  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_strand( undef );
  $ret_sequence->set_start( $start );
  $ret_sequence->set_end( $end );

  return $ret_sequence;
}

#warning, will be undefined on circular chromosomes!
sub from_to_spacer_sequence
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return undef;
  }

  my $start;
  my $end;

  if( $self->get_end() + 1 < $sequence->get_start() ) {
    $start = $self->get_end() + 1;
    $end = $sequence->get_start() - 1;
  } else {
    return undef;
  }
  
  my $ret_sequence = new BioMinerva::DNALib::Sequence();

  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_strand( undef );
  $ret_sequence->set_start( $start );
  $ret_sequence->set_end( $end );

  return $ret_sequence;
}

##########################################################################

sub contained_subsequences_surrounding_sequences
{
  my( $self, $subsequences ) = @_;

  my @ordered_subsequences = sort {
    $a->get_start() <=> $b->get_start() 
  } @{ $subsequences || [] };

  my $unified_sequence;
  my @unified_sequences;

  foreach my $subsequence( @ordered_subsequences ) {
    if( !ref( $unified_sequence ) ) {
      $unified_sequence = $subsequence->sequence();
    } elsif( $unified_sequence->overlaps( $subsequence ) ) {
      $unified_sequence = 
        $unified_sequence->union_sequence( $subsequence );
    } else {
      $unified_sequence = 
        $self->intersection_sequence( $unified_sequence );
      $unified_sequence->set_strand( $self->get_strand() );
      push @unified_sequences, $unified_sequence;
      $unified_sequence = $subsequence->sequence();
    }
  }

  if( ref( $unified_sequence ) ) {
    $unified_sequence = 
      $self->intersection_sequence( $unified_sequence );
    $unified_sequence->set_strand( $self->get_strand() );
    push @unified_sequences, $unified_sequence;
  }

  if( ( $self->get_strand() || 0 ) < 0 ) {
    @unified_sequences = reverse @unified_sequences;
  }
  
  return \@unified_sequences;
}

sub unified_subsequences_and_spacer_sequence_elements
{
  my( $self, $subsequences ) = @_;

  my @unified_subsequences_sequences = 
    @{ $self->contained_subsequences_surrounding_sequences( $subsequences ) };
  
  my @elements;
  
  # ----- no elements -----
  if( !scalar( @unified_subsequences_sequences ) ) {
    push @elements, {
      'type' => 'spacer',
      'sequence' => $self->sequence()
    };
  
    return \@elements;
  }
  
  # ----- upstream element -----
  {
    my $upstream_sequence = 
      $self->intersection_sequence(
        $unified_subsequences_sequences[ 0 ]->upstream_sequence( $self->length(), 0 )
      );
    if( ref( $upstream_sequence ) ) {
      push @elements, {
        'type' => 'upstream_spacer',
        'sequence' => $upstream_sequence
      };
    }
  }

  # ----- subsequences & spacer elements -----
  my $last_subfeature_sequence;
  while( my $subfeature_sequence = shift @unified_subsequences_sequences ) {
    if( ref( $last_subfeature_sequence ) ) {
      my $start;
      my $end;
      
      if( ( $self->get_strand() || 0 ) < 0 ) {
        $start = $subfeature_sequence->get_end() + 1;
        $end = $last_subfeature_sequence->get_start() - 1;
      } else {
        $start = $last_subfeature_sequence->get_end() + 1;
        $end = $subfeature_sequence->get_start() - 1;
      }
      
      if( $start <= $end ) {
        my $spacer_sequence = $self->absolute_sequence( 
          $start, $end, $self->get_strand()
        );
        
        push @elements, {
          'type' => 'spacer',
          'sequence' => $spacer_sequence
        };
      }
    }
    $last_subfeature_sequence = $subfeature_sequence;
    
    push @elements, {
      'type' => 'subfeature',
      'sequence' => $subfeature_sequence
    };
  }

  # ----- downstream element -----
  if( ref( $last_subfeature_sequence ) ) {
    my $downstream_sequence = 
      $self->intersection_sequence(
        $last_subfeature_sequence->downstream_sequence( 0, $self->length() )
      );
    if( ref( $downstream_sequence ) ) {
      push @elements, {
        'type' => 'downstream_spacer',
        'sequence' => $downstream_sequence
      };
    }
  }

  return \@elements;
}

sub spacer_subsequences_surrounding_sequences
{
  my( $self, $subsequences ) = @_;

  my @unified_subsequences_sequences = 
    @{ $self->contained_subsequences_surrounding_sequences( $subsequences ) };
  
  my @spacer_sequences;
  
  # ----- no elements -----
  if( !scalar( @unified_subsequences_sequences ) ) {
    push @spacer_sequences, $self->sequence();
    return \@spacer_sequences;
  }
  
  # ----- upstream element -----
  {
    my $upstream_sequence = 
      $self->intersection_sequence(
        $unified_subsequences_sequences[ 0 ]->upstream_sequence( $self->length(), 0 )
      );
    if( ref( $upstream_sequence ) ) {
      push @spacer_sequences, $upstream_sequence;
    }
  }

  # ----- subsequences & spacer elements -----
  my $last_subfeature_sequence;
  while( my $subfeature_sequence = shift @unified_subsequences_sequences ) {
    if( ref( $last_subfeature_sequence ) ) {
      my $start;
      my $end;
      
      if( ( $self->get_strand() || 0 ) < 0 ) {
        $start = $subfeature_sequence->get_end() + 1;
        $end = $last_subfeature_sequence->get_start() - 1;
      } else {
        $start = $last_subfeature_sequence->get_end() + 1;
        $end = $subfeature_sequence->get_start() - 1;
      }
      
      if( $start <= $end ) {
        my $spacer_sequence = $self->absolute_sequence( 
          $start, $end, $self->get_strand()
        );
        
        push @spacer_sequences, $spacer_sequence;
      }
    }
    $last_subfeature_sequence = $subfeature_sequence;
  }

  # ----- downstream element -----
  if( ref( $last_subfeature_sequence ) ) {
    my $downstream_sequence = 
      $self->intersection_sequence(
        $last_subfeature_sequence->downstream_sequence( 0, $self->length() )
      );
    if( ref( $downstream_sequence ) ) {
      push @spacer_sequences, $downstream_sequence;
    }
  }

  return \@spacer_sequences;
}


sub subsequences_covered_length
{
  my( $self, $subsequences ) = @_;

  my @ordered_subsequences = sort { 
    $a->get_start() <=> $b->get_start() 
  } @{ $subsequences || [] };

  my $unified_sequence;
  my $covered_length = 0;

  foreach my $subsequence( @ordered_subsequences ) {
    if( !ref( $unified_sequence ) ) {
      $unified_sequence = $subsequence->sequence();
    } elsif( $unified_sequence->overlaps( $subsequence ) ) {
      $unified_sequence = 
        $unified_sequence->union_sequence( $subsequence );
    } else {
      $unified_sequence = 
        $self->intersection_sequence( $unified_sequence );
      $covered_length += $unified_sequence->length();
      $unified_sequence = $subsequence->sequence();
    }
  }

  if( ref( $unified_sequence ) ) {
    $unified_sequence = 
      $self->intersection_sequence( $unified_sequence );
    $covered_length += $unified_sequence->length();
  }

  return $covered_length;
}

##########################################################################

1;

