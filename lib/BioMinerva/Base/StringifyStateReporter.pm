##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::StringifyStateReporter;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;

  my $self = {};
  bless( $self, $class );
  return $self;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='class'>
###---   <auto:comment id="class" md5="QnmzhT3xRH8zGI+5o8sV3A">

=head2 class

 Title   : class property
 
 Usage   : $object->class(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="class" md5="bqZPQSTldJZ6uT7lUCF74A">

sub class {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'class' } = shift @_;
  }
  return $self->{ 'class' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id='_str' ids='_strs' add_id='_add_str'>
###---   <auto:comment id="_strs" md5="DeTiFjMF+HRyau4OqrNKpw">

=head2 _strs

 Title   : _strs (array property)
 
 Usage   : C<<< my $_strs = $object->_strs();
           if( defined( $_strs ) ) { 
             foreach my $_str( @{ $_strs } ) {
               ...
             }
           } >>>
           
           C<<< $object->_strs( $_strs ); >>>
 
           C<<< $object->_strs( undef ); >>>

 Function: Accessor to the array property C<_strs>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of _strs to be set
           clear-accessor: undef

 Return  : reference to the current array of _strs or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_strs" md5="y3h/38enrkRbxz4eTpjuRw">

sub _strs {
  my $self = shift @_;
  if( @_ ) {
    my $_strs = shift @_;
    if( defined( $_strs ) && ref( $_strs ) ne 'ARRAY' ) {
      confess( "Property '_strs' requires an ARRAY argument (now: $_strs)." );
    }
    $self->{ '_strs' } = $_strs;
  }
  return $self->{ '_strs' };
}

###---   </auto:code>
###---   <auto:comment id="_add_str" md5="WFNq0WO1vJXb7EX1ZwqUIw">

=head2 _add_str

 Title   : _add_str (_strs property)
 
 Usage   : C<<< $object->_add_str( $_str, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< _strs >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_str" md5="10MLLrfnHrkJKBXs1XIW5g">

sub _add_str {
  my $self = shift @_;
  my @_strs = @_;
  $self->{ '_strs' } ||= [];
  push @{ $self->{ '_strs' } }, @_strs;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub property
{
  my( $self, $property, $value ) = @_;

  $self->_add_str(
    $property
    . "="
    . $self->_value2str( $value )
  );
}

sub str
{
  my( $self ) = @_;

  return
    ( $self->class() || 'undef' )
    . '('
    . join( ',', @{ $self->_strs() || [] } )
    . ')';
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _value2str
{
  my( $self, $value ) = @_;

  if( !ref( $value ) ) { 
    return defined( $value ) ? "'$value'" : "undef"; 
  } elsif( ref( $value ) eq 'ARRAY' ) {
    return 
      "[" 
      . join( 
        ",", 
        map { $self->_value2str( $_ ) } @{ $value } 
      ) 
      . "]";
  } elsif( ref( $value ) eq 'HASH' ) {
    my @a;
    foreach my $k( keys %{ $value } ) {
      push @a, $k . "->" . $self->_value2str( $value->{ $k } );
    }
    return 
      "{" 
      . join( ",", @a )
      . "}";
  } else {
    return "$value";
  }

  return $value;
}

##########################################################################

1;
