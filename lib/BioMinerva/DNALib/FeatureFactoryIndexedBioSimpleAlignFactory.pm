##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureFactoryIndexedBioSimpleAlignFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::BioSimpleAlignFactory;
@ISA = qw( BioMinerva::DNALib::BioSimpleAlignFactory );

use BioMinerva::Base::Cache;
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
  return new BioMinerva::DNALib::FeatureFactoryIndexedBioSimpleAlignFactory();
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

###--- <scalar_property id="_indexes_processed" get_id="" set_id=''>
###---   <auto:comment id="_indexes_processed" md5="FiETyTn/Y7kOUfLDdFn5aQ">

=head2 _indexes_processed

 Title   : _indexes_processed property
 
 Usage   : $object->_indexes_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_indexes_processed" md5="Wzgxocm5PKbJAMWADnMNlQ">

sub _indexes_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_indexes_processed' } = shift @_;
  }
  return $self->{ '_indexes_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_indexes_processed" md5="f+gJPu0gAY5M/z78bDE/lQ">

sub _get_indexes_processed {
  return shift->{ '_indexes_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_indexes_processed" md5="SjzSJ1PuTUpdebOk/FDoQA">

sub _set_indexes_processed {
  my $self = shift @_;
  $self->{ '_indexes_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_indexes" get_id="" set_id=''>
###---   <auto:comment id="_indexes" md5="K+rRhlFpAGuwiQUnJf7y/g">

=head2 _indexes

 Title   : _indexes property
 
 Usage   : $object->_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_indexes" md5="HL7/73caqO40xg0fieJjYw">

sub _indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_indexes' } = shift @_;
  }
  return $self->{ '_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_indexes" md5="vTWVazy3G0AJZqQzzLtgzg">

sub _get_indexes {
  return shift->{ '_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_indexes" md5="qvfANu0/OFxG78PYg3QpaA">

sub _set_indexes {
  my $self = shift @_;
  $self->{ '_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'bio_simple_align_factory', $self->bio_simple_align_factory() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'bio_simple_align_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'bio_simple_align_factory' ) { $self->bio_simple_align_factory( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
  $self->link_bio_simple_align_factory( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub indexes
{
  my( $self ) = @_;

  $self->_process_indexes();
  return $self->_get_indexes();
}

##########################################################################

sub index_iterator
{
  my( $self ) = @_;

  my $indexes = $self->indexes();

  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $indexes );
  
  return $iterator;
}

##########################################################################

sub index2bio_simple_align
{
  my( $self, $index ) = @_;
  
  my $bio_simple_align_factory = $self->get_bio_simple_align_factory();
  if( !ref( $bio_simple_align_factory ) ) {
    croak( "Undefined bio_simple_align_factory in $self" );
  }
  
  my $bio_simple_align = 
    $bio_simple_align_factory->index2bio_simple_align(
      $index
    );

  return $bio_simple_align;
}

##########################################################################

sub _process_indexes
{
  my( $self ) = @_;
  
  if( $self->_get_indexes_processed() ) {
    return;
  }

  my $feature_factory = $self->get_feature_factory();
  if( !defined( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }
  
  my $indexes = [];
  
  my $feature_index_iterator = $feature_factory->index_iterator();
  for(
    $feature_index_iterator->reset();
    $feature_index_iterator->valid();
    $feature_index_iterator->iterate()
  ) {
    my $feature_index = $feature_index_iterator->value();
    my $feature = $feature_factory->index2flat_feature( $feature_index );

    my $index = $feature->id();
    push @{ $indexes }, $index;
  }

  $self->_set_indexes( $indexes );

  $self->_set_indexes_processed( 1 );
}

##########################################################################

1;
