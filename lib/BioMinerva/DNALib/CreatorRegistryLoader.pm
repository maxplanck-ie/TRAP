##########################################################################

use strict;
use warnings;

use BioMinerva::Base::CreatorRegistry;
use BioMinerva::Base::Creator;
use Carp qw( confess carp carp );

##########################################################################

my $root_creator = BioMinerva::Base::CreatorRegistry::root_creator();
my $algorithm_creator = $root_creator->get_by_type( 'BioMinerva::Base::Algorithm' );

##########################################################################
# BioMinerva::Base::Object
##########################################################################

my $pscm_factory_creator;
my $pssm_factory_creator;
my $matcher_factory_creator;
my $match_processor_creator;
my $psm_processor_creator;
my $pssm_score_dist_factory_creator;

{
  eval {
    require BioMinerva::DNALib::PscmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::PscmFactory' );
    $creator->add_category( 'pscm_factory' );
    $root_creator->add_subtype_creator( $creator );
    $pscm_factory_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::DNALib::PssmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::PssmFactory' );
    $creator->add_category( 'pssm_factory' );
    $root_creator->add_subtype_creator( $creator );
    $pssm_factory_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::DNALib::MatcherFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::MatcherFactory' );
    $creator->add_category( 'matcher_factory' );
    $root_creator->add_subtype_creator( $creator );
    $matcher_factory_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::DNALib::MatchProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::MatchProcessor' );
    $creator->add_category( 'match_processor' );
    $root_creator->add_subtype_creator( $creator );
    $match_processor_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::DNALib::PsmProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::PsmProcessor' );
    $creator->add_category( 'psm_processor' );
    $root_creator->add_subtype_creator( $creator );
    $psm_processor_creator = $creator;
  } else {
    carp( $@ );
  }
}

{
  eval {
    require BioMinerva::DNALib::PssmScoreDistFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::PssmScoreDistFactory' );
    $creator->function( \&BioMinerva::DNALib::PssmScoreDistFactory::create );
    $creator->add_category( 'pssm_score_dist_factory' );
    $creator->add_alias( 'pssm_score_dist_factory' );
    $root_creator->add_subtype_creator( $creator );
    $pssm_score_dist_factory_creator = $creator;
  } else {
    carp( $@ );
  }
}

##########################################################################
# BioMinerva::Base::Algorithm
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::AllPssmsAlgorithm;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::AllPssmsAlgorithm' );
    $creator->function( \&BioMinerva::DNALib::AllPssmsAlgorithm::create );
    $creator->add_alias( 'all_pssms' );
    $algorithm_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################
# BioMinerva::DNALib::PscmFactory
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::TransfacFilePscmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::TransfacFilePscmFactory' );
    $creator->function( \&BioMinerva::DNALib::TransfacFilePscmFactory::create );
    $creator->add_alias( 'transfac_file_pscm_factory' );
    $creator->add_alias( 'transfac' );
    $pscm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::FastaFilePscmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::FastaFilePscmFactory' );
    $creator->function( \&BioMinerva::DNALib::FastaFilePscmFactory::create );
    $creator->add_alias( 'fasta' );
    $creator->add_alias( 'fa' );
    $pscm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::TRegDBPscmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::TRegDBPscmFactory' );
    $creator->function( \&BioMinerva::DNALib::TRegDBPscmFactory::create );
    $creator->add_alias( 'treg_db_pscm_factory' );
    $creator->add_alias( 'treg' );
    $pscm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################
# BioMinerva::DNALib::PssmFactory
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::TransfacFilePssmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::TransfacFilePssmFactory' );
    $creator->function( \&BioMinerva::DNALib::TransfacFilePssmFactory::create );
    $creator->add_alias( 'transfac_file_pssm_factory' );
    $creator->add_alias( 'transfac' );
    $pssm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::FastaFilePssmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::FastaFilePssmFactory' );
    $creator->function( \&BioMinerva::DNALib::FastaFilePssmFactory::create );
    $creator->add_alias( 'fasta' );
    $creator->add_alias( 'fa' );
    $pssm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::TRegDBPssmFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::TRegDBPssmFactory' );
    $creator->function( \&BioMinerva::DNALib::TRegDBPssmFactory::create );
    $creator->add_alias( 'treg_db_pssm_factory' );
    $creator->add_alias( 'treg' );
    $pssm_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################
# BioMinerva::DNALib::MatcherFactory
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::PssmMatcherFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::PssmMatcherFactory' );
    $creator->function( \&BioMinerva::DNALib::PssmMatcherFactory::create );
    $creator->add_alias( 'pssm_matcher_factory' );
    $matcher_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::TrapMatcherFactory;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::TrapMatcherFactory' );
    $creator->function( \&BioMinerva::DNALib::TrapMatcherFactory::create );
    $creator->add_alias( 'trap_matcher_factory' );
    $matcher_factory_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################
# BioMinerva::DNALib::MatchProcessor
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::FeatureOfMatchProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::FeatureOfMatchProcessor' );
    $creator->function( \&BioMinerva::DNALib::FeatureOfMatchProcessor::create );
    $creator->add_alias( 'feature_of_match_processor' );
    $match_processor_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

{ 
  eval {
    require BioMinerva::DNALib::StoreMatchProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::StoreMatchProcessor' );
    $creator->function( \&BioMinerva::DNALib::StoreMatchProcessor::create );
    $creator->add_alias( 'store_match_processor' );
    $match_processor_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################
# BioMinerva::DNALib::PsmProcessor
##########################################################################

{ 
  eval {
    require BioMinerva::DNALib::FastaWriterPsmProcessor;
  };
  if( !$@ ) {
    my $creator = new BioMinerva::Base::Creator();
    $creator->type( 'BioMinerva::DNALib::FastaWriterPsmProcessor' );
    $creator->function( \&BioMinerva::DNALib::FastaWriterPsmProcessor::create );
    $creator->add_alias( 'fasta' );
    $psm_processor_creator->add_subtype_creator( $creator );
  } else {
    carp( $@ );
  }
};

##########################################################################

1;
