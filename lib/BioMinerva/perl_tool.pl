#!/usr/bin/perl
# Author:	kielbasa
# Purpose:	«enter here»
# Created:	Thu 20 Oct 2005 05:52:51 PM CEST

use Digest::MD5;
#use strict;

##########################################################################
# MODULE_HEADER
##########################################################################

sub text_module_header
{
  my( $tag, $attrs, $text ) = @_;

  my $package = $attrs->{ 'package' };
  my $author = $attrs->{ 'author' };
  my $author_email = $attrs->{ 'author_email' };

  return (
#############################
    'comment', { 'id' => 'module_header' },
#############################
"
##########################################################################

[=]head1 NAME

C<$package> is ...

[=]head1 SYNOPSIS

  use $package;

[=]head1 DESCRIPTION

...

[=]head1 AUTHOR

$author_email

[=]head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by $author.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

[=]cut

##########################################################################
"
#############################
  );
}

##########################################################################
# SCALAR_PROPERTY
##########################################################################

sub text_scalar_property
{
  my( $tag, $attrs, $text ) = @_;

  my $id = $attrs->{ 'id' };
  my $get_id;
  if( exists( $attrs->{ 'get_id' } ) ) {
    $get_id = $attrs->{ 'get_id' };
    if( !defined( $get_id ) ) {
      $get_id = ( $id =~ /^_/ ) ? "_get$id" : "get_$id";
    }
  }
  my $set_id;
  if( exists( $attrs->{ 'set_id' } ) ) {
    $set_id = $attrs->{ 'set_id' };
    if( !defined( $set_id ) ) {
      $set_id = ( $id =~ /^_/ ) ? "_set$id" : "set_$id";
    }
  }
  my $class = $attrs->{ 'class' } || "\$object";
  my $default = $attrs->{ 'default' };
  my $args = $attrs->{ 'args' };
  my $link_id;
  if( exists( $attrs->{ 'link_id' } ) ) {
    $link_id = $attrs->{ 'link_id' };
    if( !defined( $link_id ) ) {
      $link_id = ( $id =~ /^_/ ) ? "_link$id" : "link_$id";
    }
  }
  my $type = $attrs->{ 'type' };

  return (
#############################
    'comment', { 'id' => $id },
#############################
"
[=]head2 $id

 Title   : $id property
 
 Usage   : $class->$id( $args );
 
 Function: 
 
 Default : $default
 
 Args    : Scalar.

[=]cut

",
#############################
    'code', { 'id' => $id },
#############################
"
sub $id {
  my \$self = shift \@_;
  if( \@_ ) {
    \$self->{ \'$id\' } = shift \@_;
  }
  return \$self->{ \'$id\' };
}

",
#############################
  !defined( $get_id ) ? () : (
    'code', { 'get_id' => $get_id },
#############################
"
sub $get_id {
  return shift->{ \'$id\' };
}

"),
#############################
  !defined( $set_id ) ? () : (
    'code', { 'set_id' => $set_id },
#############################
"
sub $set_id {
  my \$self = shift \@_;
  \$self->{ \'$id\' } = shift \@_;
}

"),
#############################
  (!defined( $link_id ) || !defined( $type )) ? () : (
    'code', { 'link_id' => $link_id },
#############################
"
sub $link_id {
  my \$self = shift \@_;
  my \$registry = shift \@_;
  my \$ref = \$self->{ \'$id\' };
  if( defined( \$ref ) && !ref( \$ref ) ) {
    \$self->{ \'$id\' } =
      \$registry->type_id2object(
        '$type', \$ref
      );
  }
}

")
#############################
  );
}

##########################################################################
# ARRAY_PROPERTY
##########################################################################

sub text_array_property
{
  my( $tag, $attrs, $text ) = @_;

  my $id = $attrs->{ 'id' };
  my $ids = $attrs->{ 'ids' } || ( $id . "s" );
  my $add_id = $attrs->{ 'add_id' } || ( "add_$id" );
  my $class = $attrs->{ 'class' } || "\$object";
  my $default = $attrs->{ 'default' } || "undef";
  my $args = $attrs->{ 'args' };
  my $add_args = $attrs->{ 'add_args' } || "\$$id, ...";

  return (
#############################
    'comment', { 'id' => $ids },
#############################
"
[=]head2 $ids

 Title   : $ids (array property)
 
 Usage   : C<<< my \$$ids = $class->$ids();
           if( defined( \$$ids ) ) { 
             foreach my \$$id( \@{ \$$ids } ) {
               ...
             }
           } >>>
           
           C<<< $class->$ids( \$$ids ); >>>
 
           C<<< $class->$ids( undef ); >>>

 Function: Accessor to the array property C<$ids>.
 
 Default : $default
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of $ids to be set
           clear-accessor: undef

 Return  : reference to the current array of $ids or 
           undef after clearing given nothing has been set/added yet
 
[=]cut

",
  'code', { 'id' => $ids },
"
sub $ids {
  my \$self = shift \@_;
  if( \@_ ) {
    my \$$ids = shift \@_;
    if( defined( \$$ids ) && ref( \$$ids ) ne 'ARRAY' ) {
      confess( \"Property '$ids' requires an ARRAY argument (now: \$$ids).\" );
    }
    \$self->{ \'$ids\' } = \$$ids;
  }
  return \$self->{ \'$ids\' };
}

",
#############################
    'comment', { 'id' => "$add_id" },
#############################
"
[=]head2 $add_id

 Title   : $add_id ($ids property)
 
 Usage   : C<<< $class->$add_id( $add_args ); >>>
 
 Function: Adds one or more element(s) to the array property C<< $ids >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
[=]cut

",
#############################
    'code', { 'id' => "$add_id" },
#############################
"
sub $add_id {
  my \$self = shift \@_;
  my \@$ids = \@_;
  \$self->{ \'$ids\' } ||= [];
  push \@{ \$self->{ \'$ids\' } }, \@$ids;
  return undef;
}

"
#############################
  );
}

##########################################################################
# KEY2SCALAR_PROPERTY
##########################################################################

sub text_key2scalar_property
{
  my( $tag, $attrs, $text ) = @_;

  my $id = $attrs->{ 'id' } || $attrs->{ 'key2value_id' };
  my $ids = $attrs->{ 'ids' }  || $attrs->{ 'keys2value_id' } || ( $id . "s" );
  my $keys_id = $attrs->{ 'keys_id' };
  my $values_id = $attrs->{ 'values_id' };
  my $class = $attrs->{ 'class' } || "\$object";
  my $default = $attrs->{ 'default' } || "undef";
  my $args = $attrs->{ 'args' };
  my $add_args = $attrs->{ 'add_args' } || "\$$id, ...";

  my @ret;
  
  push @ret, (
#############################
    'comment', { 'id' => $ids },
#############################
"
[=]head2 $ids

 Title   : $ids (whole hash accrssor to key2scalar property $ids)
 
 Usage   : C<<< 
           my \$$ids = $class->$ids();
           if( defined( \$$ids ) ) { 
             foreach my \$$id( keys \%{ \$$ids } ) {
               my \$value = \$$ids"."->{ \$$id };
               if( defined( \$value ) ) {
                 ...
               }
             }
           } 
           >>>
           
           C<<< $class->$ids( \$$ids ); >>>
 
           C<<< $class->$ids( undef ); >>>

 Function: Accessor to the property C<$ids> mapping keys to scalars.
 
 Default : $default
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of $ids to be set
           clear-accessor: undef

 Return  : reference to the current hash of $ids or 
           undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $ids },
#############################
"
sub $ids {
  my \$self = shift \@_;
  if( \@_ ) {
    my \$$ids = shift \@_;
    if( defined( \$$ids ) && ref( \$$ids ) ne 'HASH' ) {
      confess( \"Property '$ids' requires a HASH argument (now: \$$ids).\" );
    }
    \$self->{ \'$ids\' } = \$$ids;
  }
  return \$self->{ \'$ids\' };
}

"
#############################
  );
  
  push @ret, (
#############################
    'comment', { 'id' => $id },
#############################
"
[=]head2 $id

 Title   : $id (single key accessor to key2scalar property $ids)
 
 Usage   : C<<< 
           my \$value = $class->$id( \"key\" );
           if( defined( \$values ) ) { 
             ...
           } 
           >>>
           
           C<<< $class->$id( \"key\", 1 ); >>>
 
           C<<< $class->$id( \"key\", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<$ids>.
 
 Default : $default
 
 Args    : get-accessor: key 
           set-accessor: key, a scalar to be assigned to the key
           clear-accessor: key, undef

 Return  : a value of the object assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $id },
#############################
"
sub $id {
  my \$self = shift \@_;
  my \$$id = shift \@_;
  if( !defined( \$$id ) ) {
    confess( 
      \"A key must be given to access a single item of key2scalar property '$ids'.\" 
    );
  }
  if( \@_ ) {
    my \$value = shift \@_;
    
    \$self->{ \'$ids\' } ||= {};  
    if( !defined( \$value ) ) {
      delete \$self->{ \'$ids\' }->{ \$$id };
    } else {
      \$self->{ \'$ids\' }->{ \$$id } = \$value;
    }
  }
  return ( \$self->{ \'$ids\' } || {} )->{ \$$id };
}

"
#############################
  );
  
  if( $keys_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$keys_id" },
#############################
"
sub $keys_id {
  my \$self = shift \@_;
  my \@$keys_id = keys %{ \$self->{ \'$ids\' } || {} };
  return \\\@$keys_id;
}

"
#############################
    );
  }

  if( $values_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$values_id" },
#############################
"
sub $values_id {
  my \$self = shift \@_;
  my \@$values_id = values %{ \$self->{ \'$ids\' } || {} };
  return \\\@$values_id;
}

"
#############################
    );
  }

  return @ret;
}

##########################################################################
# KEY2OPTIMIZED_ARRAY_PROPERTY
##########################################################################

sub text_key2optimized_array_property
{
  my( $tag, $attrs, $text ) = @_;

  my $id = $attrs->{ 'id' } || $attrs->{ 'key2values_id' };
  my $ids = $attrs->{ 'ids' } || $attrs->{ 'keys2values_id' } || ( $id . "s" );
  my $add_id = $attrs->{ 'add_id' } || $attrs->{ 'add_key2value_id' } || ( "add_$id" );
  my $keys_id = $attrs->{ 'keys_id' };
  my $values_id = $attrs->{ 'values_id' };
  my $class = $attrs->{ 'class' } || "\$object";
  my $default = $attrs->{ 'default' } || "undef";
  my $args = $attrs->{ 'args' };
  my $add_args = $attrs->{ 'add_args' } || "\$$id, ...";

  my @ret;
  
  push @ret, (
#############################
    'comment', { 'id' => $ids },
#############################
"
[=]head2 $ids

 Title   : $ids (whole hash accrssor to key2array property $ids)
 
 Usage   : C<<< 
           my \$$ids = $class->$ids();
           if( defined( \$$ids ) ) { 
             foreach my \$$id( keys \%{ \$$ids } ) {
               my \$values = \$$ids"."->{ \$$id };
               if( defined( \$values ) ) {
                 foreach my \$value( \@{ \$values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $class->$ids( \$$ids ); >>>
 
           C<<< $class->$ids( undef ); >>>

 Function: Accessor to the property C<$ids> mapping keys to array
           references.
 
 Default : $default
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of $ids to be set
           clear-accessor: undef

 Return  : reference to the current hash of $ids or 
           undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $ids },
#############################
"
sub $ids {
  my \$self = shift \@_;
  if( \@_ ) {
    my \$$ids = shift \@_;
    if( defined( \$$ids ) && ref( \$$ids ) ne 'HASH' ) {
      confess( \"Property '$ids' requires a HASH argument (now: \$$ids).\" );
    }
    \$self->{ \'$ids\' } = \$$ids;
  }
  return \$self->{ \'$ids\' };
}

"
#############################
  );
  
  push @ret, (
#############################
    'comment', { 'id' => $id },
#############################
"
[=]head2 $id

 Title   : $id (single key accessor to key2array property $ids)
 
 Usage   : C<<< 
           my \$values = $class->$id( \"key\" );
           if( defined( \$values ) ) { 
             foreach my \$value( \@{ \$values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $class->$id( \"key\", [ 1, 2, 3 ] ); >>>
 
           C<<< $class->$id( \"key\", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<$ids>.
 
 Default : $default
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $id },
#############################
"
sub $id {
  my \$self = shift \@_;
  my \$$id = shift \@_;
  if( !defined( \$$id ) ) {
    confess( 
      \"A key must be given to access a single item of key2array property '$ids'.\" 
    );
  }
  if( \@_ ) {
    my \$value = shift \@_;
    
    \$self->{ \'$ids\' } ||= {};  
    if( !defined( \$value ) ) {
      if( ref( \$$id ) eq 'ARRAY' ) {
        foreach my \$i( \@{ \$$id } ) {
          delete \$self->{ \'$ids\' }->{ \$i };
        }
      } else {
        delete \$self->{ \'$ids\' }->{ \$$id };
      }
    } elsif( ref( \$value ) eq 'ARRAY' ) {
      if( ref( \$$id ) eq 'ARRAY' ) {
        foreach my \$i( \@{ \$$id } ) {
          \$self->{ \'$ids\' }->{ \$i } = \$value;
        }
      } else {
        \$self->{ \'$ids\' }->{ \$$id } = \$value;
      }
    } else {
      confess( \"Property '$ids' value for key '\$$id' must be an ARRAY (now: \$value).\" );
    }
  }
  if( !exists( ( \$self->{ \'$ids\' } || {} )->{ \$$id } ) ) {
    return undef;
  } else {
    my \$ret = \$self->{ \'$ids\' }->{ \$$id };
    if( ref( \$ret ) eq 'ARRAY' ) { return \$ret; }
    else { return [ \$ret ]; }
  }
}

"
#############################
  );
  
  push @ret, (
#############################
    'comment', { 'id' => "$add_id" },
#############################
"
[=]head2 $add_id

 Title   : $add_id (adds values to a single key of key2array property $ids)
 
 Usage   : C<<< $class->$add_id( \"key\", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< $ids >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => "$add_id" },
#############################
"
sub $add_id {
  my \$self = shift \@_;
  my \$$id = shift \@_;
  if( !defined( \$$id ) ) {
    confess( 
      \"A key must be given to access a single item of key2array property '$ids'.\" 
    );
  }
  \$self->{ \'$ids\' } ||= {};  
  if( !exists( ( \$self->{ \'$ids\' } || {} )->{ \$$id } ) ) {
    \$self->{ \'$ids\' }->{ \$$id } = shift \@_;
  } 
  if( \@_ ) {
    my \$ret = \$self->{ \'$ids\' }->{ \$$id };
    if( ref( \$ret ) eq 'ARRAY' ) { push \@{ \$ret }, \@_; }
    else { \$ret = [ \$ret, \@_ ]; }
    \$self->{ \'$ids\' }->{ \$$id } = \$ret;
  }
}

"
#############################
  );

  if( $keys_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$keys_id" },
#############################
"
sub $keys_id {
  my \$self = shift \@_;
  my \@$keys_id = keys %{ \$self->{ \'$ids\' } || {} };
  return \\\@$keys_id;
}

"
#############################
    );
  }

  if( $values_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$values_id" },
#############################
"
sub $values_id {
  my \$self = shift \@_;
  my \@$values_id = values %{ \$self->{ \'$ids\' } || {} };
  return \\\@$values_id;
}

"
#############################
    );
  }

  return @ret;
}

##########################################################################
# KEY2ARRAY_PROPERTY
##########################################################################

sub text_key2array_property
{
  my( $tag, $attrs, $text ) = @_;

  my $id = $attrs->{ 'id' } || $attrs->{ 'key2values_id' };
  my $ids = $attrs->{ 'ids' } || $attrs->{ 'keys2values_id' } || ( $id . "s" );
  my $add_id = $attrs->{ 'add_id' } || $attrs->{ 'add_key2value_id' } || ( "add_$id" );
  my $keys_id = $attrs->{ 'keys_id' };
  my $values_id = $attrs->{ 'values_id' };
  my $class = $attrs->{ 'class' } || "\$object";
  my $default = $attrs->{ 'default' } || "undef";
  my $args = $attrs->{ 'args' };
  my $add_args = $attrs->{ 'add_args' } || "\$$id, ...";

  my @ret;
  
  push @ret, (
#############################
    'comment', { 'id' => $ids },
#############################
"
[=]head2 $ids

 Title   : $ids (whole hash accrssor to key2array property $ids)
 
 Usage   : C<<< 
           my \$$ids = $class->$ids();
           if( defined( \$$ids ) ) { 
             foreach my \$$id( keys \%{ \$$ids } ) {
               my \$values = \$$ids"."->{ \$$id };
               if( defined( \$values ) ) {
                 foreach my \$value( \@{ \$values } ) {
                   ...
                 }
               }
             }
           } 
           >>>
           
           C<<< $class->$ids( \$$ids ); >>>
 
           C<<< $class->$ids( undef ); >>>

 Function: Accessor to the property C<$ids> mapping keys to array
           references.
 
 Default : $default
 
 Args    : get-accessor: empty 
           set-accessor: reference to a hash of $ids to be set
           clear-accessor: undef

 Return  : reference to the current hash of $ids or 
           undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $ids },
#############################
"
sub $ids {
  my \$self = shift \@_;
  if( \@_ ) {
    my \$$ids = shift \@_;
    if( defined( \$$ids ) && ref( \$$ids ) ne 'HASH' ) {
      confess( \"Property '$ids' requires a HASH argument (now: \$$ids).\" );
    }
    \$self->{ \'$ids\' } = \$$ids;
  }
  return \$self->{ \'$ids\' };
}

"
#############################
  );
  
  push @ret, (
#############################
    'comment', { 'id' => $id },
#############################
"
[=]head2 $id

 Title   : $id (single key accessor to key2array property $ids)
 
 Usage   : C<<< 
           my \$values = $class->$id( \"key\" );
           if( defined( \$values ) ) { 
             foreach my \$value( \@{ \$values } ) {
               ...
             }
           } 
           >>>
           
           C<<< $class->$id( \"key\", [ 1, 2, 3 ] ); >>>
 
           C<<< $class->$id( \"key\", undef ); >>>

 Function: Accessor to a reference of array of values assigned to a single
           key in the property C<$ids>.
 
 Default : $default
 
 Args    : get-accessor: key 
           set-accessor: key, reference to an array to be assigned to the key
           clear-accessor: key, undef

 Return  : reference to the current array assigned to the given key
           or undef after clearing given nothing has been set/added yet
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => $id },
#############################
"
sub $id {
  my \$self = shift \@_;
  my \$$id = shift \@_;
  if( !defined( \$$id ) ) {
    confess( 
      \"A key must be given to access a single item of key2array property '$ids'.\" 
    );
  }
  if( \@_ ) {
    my \$value = shift \@_;
    
    \$self->{ \'$ids\' } ||= {};  
    if( !defined( \$value ) ) {
      if( ref( \$$id ) eq 'ARRAY' ) {
        foreach my \$i( \@{ \$$id } ) {
          delete \$self->{ \'$ids\' }->{ \$i };
        }
      } else {
        delete \$self->{ \'$ids\' }->{ \$$id };
      }
    } elsif( ref( \$value ) eq 'ARRAY' ) {
      if( ref( \$$id ) eq 'ARRAY' ) {
        foreach my \$i( \@{ \$$id } ) {
          \$self->{ \'$ids\' }->{ \$i } = \$value;
        }
      } else {
        \$self->{ \'$ids\' }->{ \$$id } = \$value;
      }
    } else {
      confess( \"Property '$ids' value for key '\$$id' must be an ARRAY (now: \$value).\" );
    }
  }
  return ( \$self->{ \'$ids\' } || {} )->{ \$$id };
}

"
#############################
  );
  
  push @ret, (
#############################
    'comment', { 'id' => "$add_id" },
#############################
"
[=]head2 $add_id

 Title   : $add_id (adds values to a single key of key2array property $ids)
 
 Usage   : C<<< $class->$add_id( \"key\", 1, ... ); >>>
 
 Function: Adds one or more element(s) to the array assigned
           to the given key in property C<< $ids >>.
 
 Args    : key, list of elements to be added.

 Return  : undef
 
[=]cut

"
#############################
  );
  
  push @ret, (
#############################
    'code', { 'id' => "$add_id" },
#############################
"
sub $add_id {
  my \$self = shift \@_;
  my \$$id = shift \@_;
  if( !defined( \$$id ) ) {
    confess( 
      \"A key must be given to access a single item of key2array property '$ids'.\" 
    );
  }
  \$self->{ \'$ids\' } ||= {};  
  \$self->{ \'$ids\' }->{ \$$id } ||= [];
  push \@{ \$self->{ \'$ids\' }->{ \$$id } }, \@_;
  return undef;
}

"
#############################
  );

  if( $keys_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$keys_id" },
#############################
"
sub $keys_id {
  my \$self = shift \@_;
  my \@$keys_id = keys %{ \$self->{ \'$ids\' } || {} };
  return \\\@$keys_id;
}

"
#############################
    );
  }

  if( $values_id ) {
    push @ret, (
#############################
    'code', { 'id' => "$values_id" },
#############################
"
sub $values_id {
  my \$self = shift \@_;
  my \@$values_id = map { \@{ \$_ } } values %{ \$self->{ \'$ids\' } || {} };
  return \\\@$values_id;
}

"
#############################
    );
  }

  return @ret;
}

##########################################################################
# PARSER
##########################################################################

sub contract_str
{
  my( $attrs, $parsed_line_prefix, $str ) = @_;

  my $regexp =
    '(^|[\n\r])' . $parsed_line_prefix . '\s*<([a-zA-Z_][a-zA-Z0-9_]*)(|\s+([^\/>]*))>\s*[\n\r]' .
    '(.*?)' .
    '([\n\r])' . $parsed_line_prefix . '\s*</\2\s*>\s*[\n\r]'
  ;

  while( $str =~ /$regexp/gs ) {
    print "\n\n\n\n\n#######################\n";
    print "$&\n";
    print "#######################\n";
    pos( $str ) = pos( $str ) - 1;
  }
}

sub expand_str
{
  my( $attrs, $parsed_line_prefix, $str ) = @_;

  # ----- expand -----
  my $subst_pos = 0;
  my $subst_file_str = "";

  while( $str =~ 
    /^$parsed_line_prefix\s*<([a-zA-Z_][a-zA-Z0-9_]*)(|\s+([^\/>]*))\/>\s*$/gm 
  ) {
    my $match = $&;
    my $tag = $1;
    my $attrs_str = $3;
   
    my %local_attrs = %{ $attrs };
    foreach my $attr( split( /\s+/, $attrs_str ) ) {
      if( $attr eq '' ) { next; }
      if( $attr !~ /^\s*([a-zA-Z_][a-zA-Z0-9_]*)(\s*|="(.*)"\s*|=\'(.*)\'\s*|=(.*))$/ ) {
        die "Failed to decode key=\"value\" attributes of tag '$tag'";
      }
      $local_attrs{ $1 } = $3 || $4 || $5;
    }
    
    my $fun = "text_$tag";
    my @parts = $fun->( $tag, \%local_attrs, undef ); 
    my $parts_str;
    while( @parts ) {
      my $block_tag = "auto:" . shift @parts;
      my $block_attrs = shift @parts;
      my $text = shift @parts;
      $text =~ s/^\[=\]/=/gm;
      my $md5 = new Digest::MD5();
      $md5->add( $text );
      $block_attrs->{ 'md5' } = $md5->b64digest();
      my $block_attrs_str = "";
      foreach my $key( keys %{ $block_attrs } )
        { $block_attrs_str .= " $key=\"" . $block_attrs->{ $key } . "\""; }
        
      $parts_str .=
        "$parsed_line_prefix   <$block_tag$block_attrs_str>\n"
        . $text
        . "$parsed_line_prefix   </$block_tag>\n";
    }
    $subst_file_str .=
      substr( $str, $subst_pos, 
        pos( $str ) - length( $match ) - $subst_pos )
      . "$parsed_line_prefix <$tag"
        . ( $attrs_str ? " $attrs_str" : "" )
        .">\n"
      . $parts_str
      . "$parsed_line_prefix </$tag>\n";
    $subst_pos = pos( $str );
  }

  $subst_file_str .=
    substr( $str, $subst_pos );

  return $subst_file_str;
}

sub parse_str
{
  my( $attrs, $parsed_line_prefix, $str ) = @_;

  # ----- local_attrs -----
  my %local_attrs = %{ $attrs };
  
  if( $str =~ /^\s*package\s+([\w:]+);/m )
    { $local_attrs{ 'package' } = $1; }

  return
    expand_str( \%local_attrs, $parsed_line_prefix, $str );
#    contract_str( \%local_attrs, $parsed_line_prefix, $str );
}    

sub parse_file
{
  my( $attrs, $parsed_line_prefix, $file_name ) = @_;
  
  # ----- read the file -----
  my $file_stream;
  if( !open( $file_stream, $file_name ) ) {
    die "Cannot open input file stream at '$file_name': $@";
  }
  
  my $file_str = join( "", <$file_stream> );
  close( $file_stream );

  # ----- file attributes -----
  my %local_attrs = %{ $attrs };
  $local_attrs{ 'file_name' } = $file_name;
  
  return 
    parse_str( \%local_attrs, $parsed_line_prefix, $file_str );
}

sub parse_files
{
  my( $attrs, $parsed_line_prefix, $file_names ) = @_;

  foreach my $file_name( @{ $file_names } ) {
    print
      parse_file( $attrs, $parsed_line_prefix, $file_name );
  }
}

##########################################################################

parse_files( 
  {
    'author' => "Szymon M. Kielbasa",
    'author_email' 
      => "Szymon M. Kielbasa, E<lt>szymon.kielbasa(at)molgen.mpg.deE<gt>"
  },
  "###---",
  \@ARGV
);

##########################################################################


