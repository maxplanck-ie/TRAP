##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::CreatorRegistry;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use Carp qw( confess carp croak );
use BioMinerva::Base::Creator;
use BioMinerva::Base::ObjectRegistry;

##########################################################################
# FUNCTIONALITY
##########################################################################

sub root_creator 
{
  our $root_creator;
  if( !ref( $root_creator ) ) {
    $root_creator = new BioMinerva::Base::Creator();
    $root_creator->type( 'BioMinerva::Base::Object' );
  }
  return $root_creator;
}

sub object_registry
{
  our $object_registry;
  if( !ref( $object_registry ) ) {
    $object_registry = new BioMinerva::Base::ObjectRegistry();
  }
  return $object_registry;
}

##########################################################################

sub process_argv
{
  my( $argv ) = @_;

  my $free_arg_object;
  
  foreach my $arg( @{ $argv || [] } ) {
    if( $arg =~ /^--([^=]+)=(.*)$/ || $arg =~ /^-([^=]+)=(.*)$/ ) {
      my $category = $1;
      my $alias = $2;
      
      my $root_creator = root_creator();
      my $category_creator = $root_creator->get_by_category( $category );
      if( !ref( $category_creator ) ) {
        croak( 
          "Unknown category '$category' (known are: " 
          . join( ", ", @{ $root_creator->get_all_categories() || [] } )
          . ")"
        );
      }
      
      my $creator = $category_creator->get_by_alias( $alias );
      if( !ref( $creator ) ) {
        croak(
          "Unknown creator alias '$alias' in category '$category' (known are: " 
          . join( ", ", @{ $category_creator->get_all_aliases() || [] } )
          . ")"
        );
     }
      
      my $function = $creator->function();
      if( ref( $function ) ne 'CODE' ) {
        confess( "CODE (=a function reference) must be provided to create "
          . "an object with creator $creator" 
        );
      }
      
      my $object = $function->();
      if( !ref( $object ) ) {
        confess( "Failed to create an object with creator $creator" );
      }

      my $main_category = $category_creator->categories()->[ 0 ];
      object_registry()->register( $main_category, $object );
      
      $free_arg_object = $object;
    } elsif( $arg =~ /^([^=]+)=(.*)$/ ) {
      my $key = $1;
      my $value = $2;
      
      if( !ref( $free_arg_object ) ) {
        croak( "Invalid free argument '$arg'. No object to set it in" );
      }
      $free_arg_object->set_conf_property( $key, $value );
    } else {
      croak( 
        "Incorrect argument format. Use: "
          . "--category=type prop1=val1 prop2=val2 ..." );
    }
  }
}

##########################################################################

my $get_options_free_arg_object;

sub get_options_free_arg
{
  my( $arg ) = @_;
  if( !ref( $get_options_free_arg_object ) ) {
    croak( "Invalid free argument '$arg'. No object to set it in" );
  }
  if( $arg =~ /^([^=]+)=(.*)$/ ) {
    $get_options_free_arg_object->set_conf_property( $1, $2 );
  } else {
    $get_options_free_arg_object->set_conf_property( $arg );
  }
  return 1;
}

sub get_options_process_arg
{
  my( $category, $alias ) = @_;

  my $root_creator = root_creator();
  my $category_creator = $root_creator->get_by_category( $category );
  if( !ref( $category_creator ) ) {
    croak( 
      "Unknown category '$category' (known are: " 
      . join( ", ", @{ $root_creator->get_all_categories() || [] } )
      . ")"
    );
  }
  
  my $creator = $category_creator->get_by_alias( $alias );
  if( !ref( $creator ) ) {
    croak(
      "Unknown creator alias '$alias' in category '$category' (known are: " 
      . join( ", ", @{ $category_creator->get_all_aliases() || [] } )
      . ")"
    );
 }
  
  my $function = $creator->function();
  if( ref( $function ) ne 'CODE' ) {
    confess( "CODE (=a function reference) must be provided to create "
      . "an object with creator $creator" 
    );
  }
  my $object = $function->();
  if( !ref( $object ) ) {
    confess( "Failed to create an object with creator $creator" );
  }

  my $main_category = $category_creator->categories()->[ 0 ];
  object_registry()->register( $main_category, $object );
  $get_options_free_arg_object = $object;
  return 1;
}

sub get_options_hash
{
  my @get_options_hash;

  my @categories = @{ root_creator()->get_all_categories() || [] };
  foreach my $category( @categories ) {
    push @get_options_hash, "$category=s", \&get_options_process_arg;
  }
  push @get_options_hash, "<>", \&get_options_free_arg;

  return @get_options_hash;
}

##########################################################################

1;

