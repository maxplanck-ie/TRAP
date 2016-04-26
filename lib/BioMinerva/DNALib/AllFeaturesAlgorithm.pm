##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::AllFeaturesAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Carp qw( confess croak carp );
use BioMinerva::DNALib::Feature;
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

###--- <scalar_property id="feature_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="feature_processor" md5="590kX77o/z11rFZiD4wW9A">

=head2 feature_processor

 Title   : feature_processor property
 
 Usage   : $object->feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_processor" md5="PCWVqoFW+WySJGnPwF5OLw">

sub feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_processor' } = shift @_;
  }
  return $self->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_processor" md5="Xk4YITFJR5x4zq3JMOIgnA">

sub get_feature_processor {
  return shift->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_processor" md5="ii7RU2XwXrU8nt4/NS64vw">

sub set_feature_processor {
  my $self = shift @_;
  $self->{ 'feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_processor" md5="7XvZLA/AZW8QrjIHZjyJag">

sub link_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'feature_processor', $self->feature_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'feature_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'feature_processor' ) { $self->feature_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
  $self->link_feature_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  my $feature_processor = $self->get_feature_processor();

  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }

  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }

  my $feature_iterator;
  eval {
    $feature_iterator = $feature_factory->feature_iterator();
  };
  if( $@ ) {
    carp( $@ );
    #XXX: WORKAROUND BELOW
  }
  
  if( ref( $feature_iterator ) ) 
  {
    my $progress_info = new BioMinerva::DNALib::FeatureIteratorProgressInfo();
    $progress_info->set_title( 
      $self->display_id() 
      || ( "Processing " . $feature_iterator->display_id() ) 
    );
    $progress_info->set_feature_iterator( $feature_iterator );

    my $info_viewer = BioMinerva::Base::InfoViewer::global();
    $info_viewer->push_info( $progress_info );
   
  #TODO:  try
    for(
      $feature_iterator->reset();
      $feature_iterator->valid();
      $feature_iterator->iterate()
    ) {
      $feature_processor->process_feature( $feature_iterator->feature() );
    } 
    
  #TODO: catch:
    $info_viewer->pop_info();
  } 
  else 
  {
    carp( "WARNING: Using obsoleted (but still supported!) access through index_iterator() to feature_factory" );
    
    my $index_iterator = $feature_factory->index_iterator();
    if( !ref( $index_iterator ) ) {
      croak( "Undefined index_iterator in $self" );
    }

    for(
      $index_iterator->reset();
      $index_iterator->valid();
      $index_iterator->iterate()
    ) {
      my $feature = $feature_factory->index2feature(
        $index_iterator->value()
      );
      $feature_processor->process_feature(
        $feature
      );
    }
  }
}

##########################################################################

1;
