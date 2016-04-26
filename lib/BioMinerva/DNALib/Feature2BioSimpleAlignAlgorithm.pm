##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Feature2BioSimpleAlignAlgorithm;

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
  return new BioMinerva::DNALib::Feature2BioSimpleAlignAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="feature_factory" get_id="" set_id="" link_id="" type="BioMinerva::DNALib::FeatureFactory">
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
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'bio_simple_align_factory', $self->bio_simple_align_factory() );
  $target->property( 'bio_simple_align_processor', $self->bio_simple_align_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'bio_simple_align_factory' );
  $target->property( 'bio_simple_align_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'bio_simple_align_factory' ) { $self->bio_simple_align_factory( @values ); }
  elsif( $property eq 'bio_simple_align_processor' ) { $self->bio_simple_align_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
  $self->link_bio_simple_align_factory( $registry );
  $self->link_bio_simple_align_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !defined( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }
  
  my $bio_simple_align_factory = $self->get_bio_simple_align_factory();
  if( !ref( $bio_simple_align_factory ) ) {
    croak( "Undefined bio_simple_align_factory in $self" );
  }

  my $bio_simple_align_processor = $self->get_bio_simple_align_processor();
  if( !ref( $bio_simple_align_processor ) ) {
    croak( "Undefined bio_simple_align_processor in $self" );
  }

  my $index_iterator = $feature_factory->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $feature = $feature_factory->index2flat_feature( $index );

    my $bio_simple_align_index = $feature->attr( 'ID' )->[ 0 ];
    my $bio_simple_align = 
      $bio_simple_align_factory->index2bio_simple_align(
        $bio_simple_align_index
      );

    $bio_simple_align_processor->process_bio_simple_align(
      $bio_simple_align
    );
  }
}

##########################################################################

1;
