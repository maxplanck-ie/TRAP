##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ObjectRegistry;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use BioMinerva::Base::Object;
use Carp qw( confess carp croak );

##########################################################################

use vars qw( @ISA );
@ISA = qw( BioMinerva::Base::Object );

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

###--- <scalar_property id='id' get_id='get_id' set_id='set_id' assignable_once="1">
###---   <auto:comment id="id" md5="zxaBjSV/khNAMDPqA3gl5Q">

=head2 id

 Title   : id property
 
 Usage   : $object->id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="id" md5="LcWD/ucgl2d171/x5P3ZKQ">

sub id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'id' } = shift @_;
  }
  return $self->{ 'id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_id" md5="zcd/oK6+Sze9f1NNcA7alg">

sub get_id {
  return shift->{ 'id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_id" md5="yGe3HI3i9d0pAoYdAFa8Jw">

sub set_id {
  my $self = shift @_;
  $self->{ 'id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <key2array_property key2values_id='_category2objects' keys2values_id='_categories2objects' add_key2value_id='_add_category2object' keys_id='_categories' values_id='_objects'>
###---   <auto:comment id="_categories2objects" md5="8r47qM/S17e/iIl5NcYcLw">

=head2 _categories2objects

 Title   : _categories2objects (whole hash accrssor to key2array property _categories2objects)
 
 Usage   : C<<< 
           my $_categories2objects = $object->_categories2objects();
           if( defined( $_categories2objects ) ) { 
             foreach my $_category2objects( keys %{ $_categories2objects } ) {
               my $values = $_categories2objects->{ $_category2objects };
               if( defined( $values ) ) {
                 foreach my $value( @{ $values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $object->_categories2objects( $_categories2objects ); >>>
 
           C<<< $object->_categories2objects( undef ); >>>

 Function: Accessor to the property C<_categories2objects> mapping keys to array
           references.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of _categories2objects to be set
           clear-accessor: undef

 Return  : reference to the current hash of _categories2objects or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_categories2objects" md5="f2Oe9EZnhAU8T0b88pIGng">

sub _categories2objects {
  my $self = shift @_;
  if( @_ ) {
    my $_categories2objects = shift @_;
    if( defined( $_categories2objects ) && ref( $_categories2objects ) ne 'HASH' ) {
      confess( "Property '_categories2objects' requires a HASH argument (now: $_categories2objects)." );
    }
    $self->{ '_categories2objects' } = $_categories2objects;
  }
  return $self->{ '_categories2objects' };
}

###---   </auto:code>
###---   <auto:comment id="_category2objects" md5="oF5EX74P2Vp831y2w1c1bA">

=head2 _category2objects

 Title   : _category2objects (single key accessor to key2array property _categories2objects)
 
 Usage   : C<<< 
           my $values = $object->_category2objects( "key" );
           if( defined( $values ) ) { 
             foreach my $value( @{ $values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $object->_category2objects( "key", [ 1, 2, 3 ] ); >>>
 
           C<<< $object->_category2objects( "key", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<_categories2objects>.
 
 Default : undef
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_category2objects" md5="GGJWUulKYMkvFXuGSVdnpw">

sub _category2objects {
  my $self = shift @_;
  my $_category2objects = shift @_;
  if( !defined( $_category2objects ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_categories2objects'." 
    );
  }
  if( @_ ) {
    my $value = shift @_;
    
    $self->{ '_categories2objects' } ||= {};  
    if( !defined( $value ) ) {
      if( ref( $_category2objects ) eq 'ARRAY' ) {
        foreach my $i( @{ $_category2objects } ) {
          delete $self->{ '_categories2objects' }->{ $i };
        }
      } else {
        delete $self->{ '_categories2objects' }->{ $_category2objects };
      }
    } elsif( ref( $value ) eq 'ARRAY' ) {
      if( ref( $_category2objects ) eq 'ARRAY' ) {
        foreach my $i( @{ $_category2objects } ) {
          $self->{ '_categories2objects' }->{ $i } = $value;
        }
      } else {
        $self->{ '_categories2objects' }->{ $_category2objects } = $value;
      }
    } else {
      confess( "Property '_categories2objects' value for key '$_category2objects' must be an ARRAY (now: $value)." );
    }
  }
  return ( $self->{ '_categories2objects' } || {} )->{ $_category2objects };
}

###---   </auto:code>
###---   <auto:comment id="_add_category2object" md5="LLFZDr3J6F0Louuoscw9nw">

=head2 _add_category2object

 Title   : _add_category2object (adds values to a single key of key2array property _categories2objects)
 
 Usage   : C<<< $object->_add_category2object( "key", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< _categories2objects >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_category2object" md5="zUku8YgMsmExEAETv5ENAg">

sub _add_category2object {
  my $self = shift @_;
  my $_category2objects = shift @_;
  if( !defined( $_category2objects ) ) {
    confess( 
      "A key must be given to access a single item of key2array property '_categories2objects'." 
    );
  }
  $self->{ '_categories2objects' } ||= {};  
  $self->{ '_categories2objects' }->{ $_category2objects } ||= [];
  push @{ $self->{ '_categories2objects' }->{ $_category2objects } }, @_;
  return undef;
}

###---   </auto:code>
###---   <auto:code id="_categories" md5="WNEf47AqmXUpMcIi8D11qg">

sub _categories {
  my $self = shift @_;
  my @_categories = keys %{ $self->{ '_categories2objects' } || {} };
  return \@_categories;
}

###---   </auto:code>
###---   <auto:code id="_objects" md5="KQSiJnLxRe+xpb/onPAcJw">

sub _objects {
  my $self = shift @_;
  my @_objects = map { @{ $_ } } values %{ $self->{ '_categories2objects' } || {} };
  return \@_objects;
}

###---   </auto:code>
###--- </key2array_property>

###--- <array_property id='object' ids='objects' add_id='add_object'>
###---   <auto:comment id="objects" md5="jXJo8L5XIfzNbHgA3WRxVg">

=head2 objects

 Title   : objects (array property)
 
 Usage   : C<<< my $objects = $object->objects();
           if( defined( $objects ) ) { 
             foreach my $object( @{ $objects } ) {
               ...
             }
           } >>>
           
           C<<< $object->objects( $objects ); >>>
 
           C<<< $object->objects( undef ); >>>

 Function: Accessor to the array property C<objects>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of objects to be set
           clear-accessor: undef

 Return  : reference to the current array of objects or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="objects" md5="xV5ug0KF5MuQa/NQL3taGg">

sub objects {
  my $self = shift @_;
  if( @_ ) {
    my $objects = shift @_;
    if( defined( $objects ) && ref( $objects ) ne 'ARRAY' ) {
      confess( "Property 'objects' requires an ARRAY argument (now: $objects)." );
    }
    $self->{ 'objects' } = $objects;
  }
  return $self->{ 'objects' };
}

###---   </auto:code>
###---   <auto:comment id="add_object" md5="bx9daLnz5M7l2V8d+xkFbQ">

=head2 add_object

 Title   : add_object (objects property)
 
 Usage   : C<<< $object->add_object( $object, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< objects >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_object" md5="dXQXI6S9nF11mdFKiIlEhw">

sub add_object {
  my $self = shift @_;
  my @objects = @_;
  $self->{ 'objects' } ||= [];
  push @{ $self->{ 'objects' } }, @objects;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
#  $target->property( '_categories2objects', $self->_categories2objects() );
  $target->property( 'objects', $self->objects() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub link_references
{
  my( $self ) = @_;

  my @objects = @{ $self->objects() || [] };
  foreach my $object( @objects ) {
    $object->link_references( $self );
  }
}

##########################################################################

sub register
{
  my( $self, $category, $object ) = @_;

  if( !$category ) {
    confess( "Category must be given for $object in $self" );
  }
  if( !ref( $object ) ) {
    confess( "Can not register an undef object in $self" );
  }
  
#  $self->_add_category2object( $category, $object );
  $self->add_object( $object );
}

=for nothing
sub category_id2object
{
  confess( "Obsoleted" );
  
  my( $self, $category, $id ) = @_;

  if( !$category ) {
    confess( "A category must be given" );
  }
  
  my @objects = @{ $self->_category2objects( $category ) || [] };
  if( !@objects ) {
    confess( "No object for a category '$category' registered in $self" );
  }

  if( !defined( $id ) ) { $id = ''; }

  my @ret_objects;
  
  foreach my $object( @objects ) {
    my $object_id = $object->id();
    if( !defined( $object_id ) ) { $object_id = ''; }
    if( $object_id eq $id ) { push @ret_objects, $object; }
  }

  if( !@ret_objects ) {
    croak( "No object of a category '$category' with an id '$id' registered in $self" );
  } elsif( scalar( @ret_objects ) > 1 ) {
    croak( "Multiple objects of a category '$category' with an id '$id' registered in $self" );
  } else {
    return $ret_objects[ 0 ];
  }
}

sub category2object
{
  confess( "Obsoleted" );

  my( $self, $category ) = @_;

  return $self->category_id2object( $category, undef );
}
=cut

sub type_id2object
{
  my( $self, $type, $id ) = @_;

  if( !$type ) {
    confess( "A type must be given" );
  }
  
  my @objects = @{ $self->objects() || [] };

  if( !defined( $id ) ) { $id = ''; }

  my @ret_objects;
  
  foreach my $object( @objects ) {
    if( !UNIVERSAL::isa( $object, $type ) ) { next; }
    
    my $object_id = $object->id();
    if( !defined( $object_id ) ) { $object_id = ''; }
    if( $object_id eq $id ) { push @ret_objects, $object; }
  }

  if( !@ret_objects && $id eq '' ) {
    return undef;
  } elsif( !@ret_objects ) {
    croak( "No objects of type '$type' with an id '$id' registered in $self" );
  } elsif( scalar( @ret_objects ) > 1 ) {
    croak( "Multiple objects of type '$type' with an id '$id' registered in $self" );
  } else {
    return $ret_objects[ 0 ];
  }
}

sub type2object
{
  my( $self, $type ) = @_;

  return $self->type_id2object( $type, undef );
}

##########################################################################

1;

