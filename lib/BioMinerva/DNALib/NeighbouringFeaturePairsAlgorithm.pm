##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::NeighbouringFeaturePairsAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Carp qw( confess croak carp );
use BioMinerva::DNALib::Feature;
use BioMinerva::DNALib::SortedRefFeatureFactory;
use BioMinerva::DNALib::CmpFeatureComparator;
use BioMinerva::DNALib::FeatureIteratorProgressInfo;
use BioMinerva::Base::InfoViewer;

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

###--- <scalar_property id="feature_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureFactory'>
###---   <auto:comment id="feature_factory" md5="ajfRK5nKeu8O1iAMQUh8Hg">

=head2 feature_factory

 Title   : feature_factory property
 
 Usage   : $object->feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_factory" md5="1X/+SXk6hoj/gvrPj2ir9w">

sub feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_factory' } = shift @_;
  }
  return $self->{ 'feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_factory" md5="KUEdoE5I+frNv9fsYx8oFA">

sub get_feature_factory {
  return shift->{ 'feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_factory" md5="jrjTav7/QBvc/b/fShcnBQ">

sub set_feature_factory {
  my $self = shift @_;
  $self->{ 'feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_factory" md5="Q/CRdOmwILlT6wXJxvYYNw">

sub link_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="feature_pair_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeaturePairProcessor'>
###---   <auto:comment id="feature_pair_processor" md5="RRclvFznzmB3nR0uTtrDnQ">

=head2 feature_pair_processor

 Title   : feature_pair_processor property
 
 Usage   : $object->feature_pair_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_pair_processor" md5="V3qd+rRUOgkDMhpm6foexg">

sub feature_pair_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_pair_processor' } = shift @_;
  }
  return $self->{ 'feature_pair_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_pair_processor" md5="VNaKOiAFjSduIHtjtt+pSQ">

sub get_feature_pair_processor {
  return shift->{ 'feature_pair_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_pair_processor" md5="OXA6DmalOw5O7kiUyjXACQ">

sub set_feature_pair_processor {
  my $self = shift @_;
  $self->{ 'feature_pair_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_pair_processor" md5="RDz0fkMpyWkeIJl5XaXL6A">

sub link_feature_pair_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_pair_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_pair_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeaturePairProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->get_feature_factory() );
  $target->property( 'feature_pair_processor', $self->get_feature_pair_processor() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  my $feature_pair_processor = $self->get_feature_pair_processor();

  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }

  if( !ref( $feature_pair_processor ) ) {
    croak( "Undefined feature_pair_processor in $self" );
  }

  my $feature_comparator = new BioMinerva::DNALib::CmpFeatureComparator();
  
  my $sorted_feature_factory = new BioMinerva::DNALib::SortedRefFeatureFactory();
  $sorted_feature_factory->set_feature_factory( $feature_factory );
  $sorted_feature_factory->set_feature_comparator( $feature_comparator );

  my $feature_iterator = $sorted_feature_factory->feature_iterator();
  
  my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
  $progress_info->set_title( 
    $self->display_id() 
    || ( "Processing " . $feature_iterator->display_id() ) 
  );
  $progress_info->set_feature_iterator( $feature_iterator );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
 
#TODO: try
  my $prev_feature = undef;
  for(
    $feature_iterator->reset();
    $feature_iterator->valid();
    $feature_iterator->iterate()
  ) {
    my $feature = $feature_iterator->feature();
    
    if( !ref( $prev_feature ) ) {
    } elsif( $prev_feature->get_primary_sequence_id() ne $feature->get_primary_sequence_id() ) {
    } else {
      $feature_pair_processor->process_feature_pair( $prev_feature, $feature );
    }
    $prev_feature = $feature;
  }
#TODO: catch
  $info_viewer->pop_info();
}

##########################################################################

1;
