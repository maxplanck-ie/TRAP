##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::CachedFilteredFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::LinkedFeatureFactory;
@ISA = qw( BioMinerva::DNALib::LinkedFeatureFactory );

use BioMinerva::Base::ArrayIterator;
use BioMinerva::Base::ConditionalIterator;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::CachedFilteredFeatureFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_index_condition' set_id='' get_id='' link_id='' type='BioMinerva::DNALib::FeatureIndexCondition'>
###---   <auto:comment id="feature_index_condition" md5="bwmYmLKd2APlM+0+4GF2Nw">

=head2 feature_index_condition

 Title   : feature_index_condition property
 
 Usage   : $object->feature_index_condition(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_index_condition" md5="JXxqT1EFdmYuGFeMvjJ/5Q">

sub feature_index_condition {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_index_condition' } = shift @_;
  }
  return $self->{ 'feature_index_condition' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_index_condition" md5="CT00K7WXqyWX4m/WTT0S4A">

sub get_feature_index_condition {
  return shift->{ 'feature_index_condition' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_index_condition" md5="wGzGKAEs5Rv/kP7bpNSZ3Q">

sub set_feature_index_condition {
  my $self = shift @_;
  $self->{ 'feature_index_condition' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_index_condition" md5="7LbR5zzczpvBWDCvEjM70g">

sub link_feature_index_condition {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_index_condition' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_index_condition' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureIndexCondition', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_indexes' set_id='' get_id=''>
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

sub display_id
{
  my( $self ) = @_;
  
  my $feature_index_condition = $self->get_feature_index_condition();
  if( !ref( $feature_index_condition ) ) {
    confess( "Undefined feature_index_condition in $self" )
  }
    
  return
    $self->SUPER::display_id()
    . "|"
    . $feature_index_condition->display_id();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_index_condition', $self->feature_index_condition() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_index_condition' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_index_condition' ) { $self->feature_index_condition( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_index_condition( $registry );
}

##########################################################################
# INDEX ITERATOR
##########################################################################

sub index_iterator
{
  my( $self ) = @_;
  my $iterator = new BioMinerva::Base::ArrayIterator();
  $iterator->set_array( $self->indexes() );
  return $iterator;
}

##########################################################################
# ALL FEATURES ARRAY BUILDERS
##########################################################################

sub indexes
{
  my( $self ) = @_;
  $self->_process_indexes();
  return $self->_get_indexes();
}

##########################################################################
# SPECIFIC FUNCTIONALITY
##########################################################################

sub _process_indexes
{
  my( $self ) = @_;
  
  if( defined( $self->_get_indexes() ) ) { return; }

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    confess( "Undefined feature_factory in $self" )
  }

  my $feature_index_condition = $self->get_feature_index_condition();
  if( !ref( $feature_index_condition ) ) {
    confess( "Undefined feature_index_condition in $self" )
  }
  
  my $counter = 0;
  my $filtered_counter = 0;
  my @indexes;
  my $index_iterator = $feature_factory->index_iterator();

  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    ++$counter;
    if( !( $counter % 10000 ) ) {
      print STDERR "\r#Filtering features (display_id='"
        . $self->display_id()
        . "'): $counter done...     ";
    }
    
    my $index = $index_iterator->value();
    if( $feature_index_condition->test( $index ) ) {
      ++$filtered_counter;
      push @indexes, $index;
    }
  }

  $self->_set_indexes( \@indexes );
  
  print STDERR "\r#Filtered $filtered_counter of $counter feature(s) (display_id='"
    . $self->display_id()
    . "')"
    . ( " " x 20 ) . "\n";
}

##########################################################################

1;

