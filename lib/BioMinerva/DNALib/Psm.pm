##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Psm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

##########################################################################

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

sub get_type {
  my( $self ) = @_;

  confess( "Not overridden in $self" );
}

sub matrix {
  my( $self, $matrix ) = @_;

  confess( "Not overridden in $self" );
}

sub get_matrix {
  return shift->matrix();
}

sub get_complemented_matrix {
  my( $self ) = @_;
  return $self->_complement_matrix( $self->get_matrix() );
}

sub _complement_matrix
{
  my( $self, $matrix ) = @_;

  my $len = scalar( @{ $matrix } );
  my $complemented_matrix = [];
  for( my $i = 0; $i < $len; ++$i ) {
    my $vals = $matrix->[ $len - 1 - $i ];
    $complemented_matrix->[ $i ] = {
      'A' => $vals->{ 'T' },
      'C' => $vals->{ 'G' },
      'G' => $vals->{ 'C' },
      'T' => $vals->{ 'A' }
    }
  }
  return $complemented_matrix;
}

# Allows to set the matrix from a string (lines separated by | or by end of line)
sub str2matrix {
  my( $self, $str ) = @_;
  
  my $matrix = $self->_str2matrix( $str );
  if( $matrix ) {
    $self->matrix( $matrix );
  }

  return undef;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'type', $self->get_type() );
  $target->property( 'attrs', $self->attrs() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _str2matrix
{
  my( $self, $str ) = @_;
  my @lines = split( /[\n|]/, $str );
  my @matrix = map { $self->_line2acgt( $_ ) } @lines;
  return \@matrix;
}

sub _line2acgt
{
  my( $self, $line ) = @_;
  
  my %m;
  if( $line =~ /^\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s*$/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  elsif( $line =~ /^[^\s]+\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s*$/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  elsif( $line =~ /^\s*([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+([-+\.0-9eE]+)\s+/ )
    { $m{'A'} = $1; $m{'C'} = $2; $m{'G'} = $3; $m{'T'} = $4; }
  else
    { confess "_line2acgt: incorrect line format '$line'."; }
  return \%m;
}

##########################################################################

1;

