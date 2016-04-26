##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioSimpleAlign2FeatureAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::DNALib::Feature;
use BioMinerva::Base::CounterProgressInfo;
use BioMinerva::Base::InfoViewer;
use Carp qw( confess croak carp );

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

###--- <scalar_property id="bio_simple_align_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::BioSimpleAlignFactory'>
###---   <auto:comment id="bio_simple_align_factory" md5="OGoJPzW3Gzfvh8D3zxhePA">

=head2 bio_simple_align_factory

 Title   : bio_simple_align_factory property
 
 Usage   : $object->bio_simple_align_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bio_simple_align_factory" md5="6cflDfU+lqRXC3joHW1aFg">

sub bio_simple_align_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bio_simple_align_factory' } = shift @_;
  }
  return $self->{ 'bio_simple_align_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bio_simple_align_factory" md5="9dShmshyhVK6r/hjKazx4Q">

sub get_bio_simple_align_factory {
  return shift->{ 'bio_simple_align_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bio_simple_align_factory" md5="1Cvd5dY3AdhvJVBYdsh/Aw">

sub set_bio_simple_align_factory {
  my $self = shift @_;
  $self->{ 'bio_simple_align_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_bio_simple_align_factory" md5="sSlDZS4VHyFDm+wM1KOxoA">

sub link_bio_simple_align_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'bio_simple_align_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'bio_simple_align_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::BioSimpleAlignFactory', $ref
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
  $target->property( 'bio_simple_align_factory', $self->bio_simple_align_factory() );
  $target->property( 'feature_processor', $self->feature_processor() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;
  
  my $bio_simple_align_factory = $self->get_bio_simple_align_factory();
  if( !ref( $bio_simple_align_factory ) ) {
    croak( "Undefined bio_simple_align_factory in $self" );
  }
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor )  ) {
    croak( "Undefined feature_processor in $self" );
  }

  my $index_iterator = $bio_simple_align_factory->index_iterator();

  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "Alignments" );
  $progress_info->set_count_attr( "count" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO: try
  my $count = 0;
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    $progress_info->set_count( $count++ );

    my $index = $index_iterator->value();
    my $feature = 
      $bio_simple_align_factory->index_bio_seq_no2feature( $index, 1 );
    $feature_processor->process_feature( $feature );
  }
  $progress_info->set_count( $count );
#TODO: catch:
  $info_viewer->pop_info();
}

##########################################################################

1;
