##########################################################################

use strict;
use warnings;

use BioMinerva::Base::CreatorRegistry;
use BioMinerva::Base::Creator;

##########################################################################

my $root_creator = BioMinerva::Base::CreatorRegistry::root_creator();

##########################################################################
# BioMinerva::Base::Object
##########################################################################

{
  eval {
    require BioMinerva::Base::Algorithm;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::Algorithm' );
    $creator->add_category( 'algorithm' );
    $creator->add_category( 'algo' );
    $root_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

{
  eval {
    require BioMinerva::Base::ObjectProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::ObjectProcessor' );
    $root_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

my $cache_creator;

{
  eval {
    require BioMinerva::Base::Cache;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::Cache' );
    $creator->add_category( 'cache' );
    $root_creator->add_subtype_creator( $creator );
    $cache_creator = $creator;
  } else {
    carp( $@ );
  }
}

if( ref( $cache_creator ) )
{
  eval {
    require BioMinerva::Base::FileCache;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::FileCache' );
    $creator->add_alias( 'file_cache' );
    $creator->function( \&BioMinerva::Base::FileCache::create );
    $cache_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

{
  eval {
    require BioMinerva::Base::DBAdaptor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::DBAdaptor' );
    $creator->add_alias( 'dbadaptor' );
    $creator->add_alias( 'db' );
    $root_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

my $string_factory_creator;

{
  eval {
    require BioMinerva::Base::StringFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::StringFactory' );
    $creator->add_category( 'string_factory' );
    $root_creator->add_subtype_creator( $creator );
    $string_factory_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::Base::FileStringFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::FileStringFactory' );
    $creator->add_alias( 'file' );
    $creator->function( \&BioMinerva::Base::FileStringFactory::create );
    $string_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

my $string_processor_creator;

{
  eval {
    require BioMinerva::Base::StringProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::StringProcessor' );
    $creator->add_category( 'string_processor' );
    $root_creator->add_subtype_creator( $creator );
    $string_processor_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::Base::FileWriterStringProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::Base::FileWriterStringProcessor' );
    $creator->add_alias( 'file' );
    $creator->function( \&BioMinerva::Base::FileWriterStringProcessor::create );
    $string_processor_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
}

##########################################################################

1;

