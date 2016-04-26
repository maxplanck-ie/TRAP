##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioSimpleAlignFilterAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::DNALib::Feature;
use Bio::AlignIO;
use Carp qw( confess croak carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::BioSimpleAlignFilterAlgorithm();
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

###--- <scalar_property id="mask_feature_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureFactory'>
###---   <auto:comment id="mask_feature_factory" md5="VVPGJxWITCqJVbMHxdSKmw">

=head2 mask_feature_factory

 Title   : mask_feature_factory property
 
 Usage   : $object->mask_feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="mask_feature_factory" md5="dqscNXKU+z5T7lMlUsWdDA">

sub mask_feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'mask_feature_factory' } = shift @_;
  }
  return $self->{ 'mask_feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_mask_feature_factory" md5="gaawQlQDubpQjJsNKCBXjw">

sub get_mask_feature_factory {
  return shift->{ 'mask_feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_mask_feature_factory" md5="+oKx2t/wy9zTOSsEdEwmDw">

sub set_mask_feature_factory {
  my $self = shift @_;
  $self->{ 'mask_feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_mask_feature_factory" md5="PmKs+G9g/06PfNWqFNte9g">

sub link_mask_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'mask_feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'mask_feature_factory' } =
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

###--- <scalar_property id="bio_simple_align_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::BioSimpleAlignProcessor'>
###---   <auto:comment id="bio_simple_align_processor" md5="lKXhXS4reEqeHjG5DTjWSA">

=head2 bio_simple_align_processor

 Title   : bio_simple_align_processor property
 
 Usage   : $object->bio_simple_align_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bio_simple_align_processor" md5="eNi7i/h7nMQqTQzqHm+jRQ">

sub bio_simple_align_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bio_simple_align_processor' } = shift @_;
  }
  return $self->{ 'bio_simple_align_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bio_simple_align_processor" md5="qtln+o2LAzyn7wMUfvqn0w">

sub get_bio_simple_align_processor {
  return shift->{ 'bio_simple_align_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bio_simple_align_processor" md5="gFvJbLSeCRmj1aot59rpXA">

sub set_bio_simple_align_processor {
  my $self = shift @_;
  $self->{ 'bio_simple_align_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_bio_simple_align_processor" md5="QG1NpTWmdn0Dx0ltgSpeqw">

sub link_bio_simple_align_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'bio_simple_align_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'bio_simple_align_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::BioSimpleAlignProcessor', $ref
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
  $target->property( 'mask_feature_factory', $self->mask_feature_factory() );
  $target->property( 'feature_processor', $self->feature_processor() );
  $target->property( 'bio_simple_align_processor', $self->bio_simple_align_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'bio_simple_align_factory' );
  $target->property( 'mask_feature_factory' );
  $target->property( 'feature_processor' );
  $target->property( 'bio_simple_align_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'bio_simple_align_factory' ) { $self->bio_simple_align_factory( @values ); }
  elsif( $property eq 'mask_feature_factory' ) { $self->mask_feature_factory( @values ); }
  elsif( $property eq 'feature_processor' ) { $self->feature_processor( @values ); }
  elsif( $property eq 'bio_simple_align_processor' ) { $self->bio_simple_align_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_bio_simple_align_factory( $registry );
  $self->link_mask_feature_factory( $registry );
  $self->link_feature_processor( $registry );
  $self->link_bio_simple_align_processor( $registry );
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
  
  my $mask_feature_factory = $self->get_mask_feature_factory();
  if( !ref( $mask_feature_factory ) ) {
    croak( "Undefined mask_feature_factory in $self" );
  }

  my $mask_features = $mask_feature_factory->features();
  if( !@{ $mask_features } ) {
    croak( "Empty set of mask features in $self" );
  }
  
  my $feature_processor = $self->get_feature_processor();
  my $bio_simple_align_processor = $self->get_bio_simple_align_processor();
  if( !ref( $feature_processor ) && !ref( $bio_simple_align_processor ) ) {
    croak( "Undefined both feature_processor and bio_simple_align_processor in $self" );
  }

  my $index_iterator = $bio_simple_align_factory->index_iterator();

  my $counter = 0;
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $bio_simple_align = 
      $bio_simple_align_factory->index2bio_simple_align( $index );

    my $bio_seq = $bio_simple_align->get_seq_by_pos( 1 );
    my $feature = new BioMinerva::DNALib::Feature();
    $feature->set_primary_sequence_id( $bio_seq->display_name() );
    $feature->set_start( $bio_seq->start() );
    $feature->set_end( $bio_seq->end() );
    my $strand = $bio_seq->strand();
    if( $strand eq '+' ) { $strand = +1; }
    elsif( $strand eq '-' ) { $strand = -1; }
    $feature->set_strand( $strand );

    if( $feature->overlaps_with_any( $mask_features ) ) {
      $feature->set_id( $index );

      if( ref( $feature_processor ) ) {
        $feature_processor->process_feature( $feature );
      }

      if( ref( $bio_simple_align_processor ) ) {
        $bio_simple_align_processor->process_bio_simple_align( $bio_simple_align );
      }
    }
    
    ++$counter;
    if( !( $counter % 100 ) ) {
      print STDERR "\r#Processing bio_simple_alignments: $counter done";
    }
  }
  
  print STDERR "\r#Processed $counter bio_simple_alignment(s)"
    . ( " " x 20 ) . "\n";
}

##########################################################################

1;
