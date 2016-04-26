##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StartSortedIndexIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IteratorI;
@ISA = qw( BioMinerva::Base::IteratorI );

use Carp qw( confess );

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

###--- <scalar_property id='feature_factory' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureFactory'>
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

###--- <scalar_property id='index_iterator' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureFactory'>
###---   <auto:comment id="index_iterator" md5="oDGoqFK8L8pwPJU/pclZ1g">

=head2 index_iterator

 Title   : index_iterator property
 
 Usage   : $object->index_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index_iterator" md5="o/ecrvch4lbSIJzJKN1miw">

sub index_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index_iterator' } = shift @_;
  }
  return $self->{ 'index_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index_iterator" md5="f5GDbhhgosjfHQLoB4AKTQ">

sub get_index_iterator {
  return shift->{ 'index_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index_iterator" md5="DI/uEiREc3Z5pwcJI1Yvmw">

sub set_index_iterator {
  my $self = shift @_;
  $self->{ 'index_iterator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_index_iterator" md5="/MJJbWUdR/XWQVzBWAN8eg">

sub link_index_iterator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'index_iterator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'index_iterator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_array' get_id='' set_id=''>
###---   <auto:comment id="_array" md5="DUyTVUTnttsL67GbV/EMyw">

=head2 _array

 Title   : _array property
 
 Usage   : $object->_array(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_array" md5="+q52UOOkfMXZPAlu7csZTQ">

sub _array {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_array' } = shift @_;
  }
  return $self->{ '_array' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_array" md5="k1+WqjOIdQdarEkb6FHkkA">

sub _get_array {
  return shift->{ '_array' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_array" md5="T1t7arsKehPpgvM/xVGxiQ">

sub _set_array {
  my $self = shift @_;
  $self->{ '_array' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_index' get_id='' set_id=''>
###---   <auto:comment id="_index" md5="uxE4qqV8unwT6sK0Ckk9sA">

=head2 _index

 Title   : _index property
 
 Usage   : $object->_index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_index" md5="u6tM2S9FfYYF/VGNu76oDQ">

sub _index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_index' } = shift @_;
  }
  return $self->{ '_index' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_index" md5="CbbS41lnhjt0lfC4zPpFhw">

sub _get_index {
  return shift->{ '_index' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_index" md5="YE+FDFDoSQ3fcJRvZ7KImg">

sub _set_index {
  my $self = shift @_;
  $self->{ '_index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'index_iterator', $self->index_iterator() );
  $target->property( '_index', $self->_get_index() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'index_iterator' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'index_iterator' ) { $self->index_iterator( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
#  $self->link_index_iterator( $registry ); #ill defined XXX
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
  $self->_set_index( 0 );
}

sub valid
{
  my( $self ) = @_;
  return $self->_get_index() < scalar( @{ $self->get_array() || [] } );
}

sub iterate
{
  my( $self ) = @_;
  $self->_set_index( $self->_get_index() + 1 );
}

sub value
{
  my( $self ) = @_;
  my $array = $self->get_array();
  return $array->[ $self->_get_index() ];
}

sub clone
{
  my( $self ) = @_;
  my $iterator = new BioMinerva::DNALib::StartSortedIndexIterator();
  $iterator->set_feature_factory( $self->get_feature_factory() );
  $iterator->set_index_iterator( $self->get_index_iterator() );
  $iterator->_set_array( $self->_get_array() );
  $iterator->_set_index( $self->_get_index() );
  return $iterator;
}

sub size
{
  my( $self ) = @_;
  
  my $index_iterator = $self->get_index_iterator();
  if( !ref( $index_iterator ) ) {
    confess( "Undefined index_iterator in $self" )
  }
  
  return $index_iterator->size();
}

##########################################################################

sub get_array
{
  my( $self ) = @_;

  my $array = $self->_get_array();
  if( !defined( $array ) ) {
    $array = $self->_sorted_indexes();
    $self->_set_array( $array );
  }
  return $array;
}

##########################################################################

sub _sorted_indexes
{
  my( $self ) = @_;

  my $index_iterator = $self->get_index_iterator();
  if( !ref( $index_iterator ) ) {
    confess( "Undefined index_iterator in $self" )
  }
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    confess( "Undefined feature_factory in $self" )
  }
  
  my $start_pack_format = $feature_factory->get_start_pack_format() || 'L';
  my $index_pack_format = $feature_factory->get_index_pack_format() || 'L';
  my $pack_format = $index_pack_format . $start_pack_format;
  
  my @indexes_starts;
  my $primary_sequence_id;
  
  {
    my $counter = 0;
    my $index;
    my $start;
    
    $index_iterator->reset();
    
    if( $index_iterator->valid() ) {
      $index = $index_iterator->value();
      $primary_sequence_id =
        $feature_factory->index2primary_sequence_id( $index );
    }
    
    while( $index_iterator->valid() ) {
      $index = $index_iterator->value();
      $start = $feature_factory->index2start( $index );
      push @indexes_starts, pack( $pack_format, $index, $start );
      
      ++$counter;
      if( !( $counter % 10000 ) ) {
        print STDERR "\r#Preparing to sort (primary_sequence_id='$primary_sequence_id', display_id='"
          . $feature_factory->display_id()
          . "'): $counter done...     ";
      }
      
      $index_iterator->iterate()
    }
    
    if( defined( $primary_sequence_id ) ) {
      print STDERR "\r#Sorting (primary_sequence_id='$primary_sequence_id', display_id='"
        . $feature_factory->display_id()
        . "'): $counter feature(s)"
        . ( " " x 9 ) . "\n";
    }
  }
 
  if( @indexes_starts ) {
    @indexes_starts = 
      sort {
        ( undef, my $a_start ) = unpack( $pack_format, $a );
        ( undef, my $b_start ) = unpack( $pack_format, $b );
        return $a_start <=> $b_start;
      } @indexes_starts;
  }

  my @sorted_indexes = map {
    ( my $index ) = unpack( $pack_format, $_ ); $index;
  } @indexes_starts;

  return \@sorted_indexes;
}

##########################################################################

1;
