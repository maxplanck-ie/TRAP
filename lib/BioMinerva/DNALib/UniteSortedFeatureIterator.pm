##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::UniteSortedFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::SortedFeatureIterator;
@ISA = qw( BioMinerva::DNALib::SortedFeatureIterator );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::UniteSortedFeatureIterator();
  }

  $self->SUPER::clone( $clone );
  
  $clone->set_first_sorted_feature_iterator(
    $self->get_first_sorted_feature_iterator()
  );
  $clone->set_second_sorted_feature_iterator(
    $self->get_second_sorted_feature_iterator()
  );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='first_sorted_feature_iterator' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::SortedFeatureIterator'>
###---   <auto:comment id="first_sorted_feature_iterator" md5="XJKRM0eHCFZDcdBLAJks+g">

=head2 first_sorted_feature_iterator

 Title   : first_sorted_feature_iterator property
 
 Usage   : $object->first_sorted_feature_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="first_sorted_feature_iterator" md5="PFheJK8Dt+iKi9pchSxzLA">

sub first_sorted_feature_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'first_sorted_feature_iterator' } = shift @_;
  }
  return $self->{ 'first_sorted_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_first_sorted_feature_iterator" md5="w6HIuNEJ2mWDZVztCU7K+Q">

sub get_first_sorted_feature_iterator {
  return shift->{ 'first_sorted_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_first_sorted_feature_iterator" md5="8WyAdau9z4QvoEyvLuNIDw">

sub set_first_sorted_feature_iterator {
  my $self = shift @_;
  $self->{ 'first_sorted_feature_iterator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_first_sorted_feature_iterator" md5="UMhbbHauubf/fpjJhfkNmQ">

sub link_first_sorted_feature_iterator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'first_sorted_feature_iterator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'first_sorted_feature_iterator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SortedFeatureIterator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='second_sorted_feature_iterator' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::SortedFeatureIterator'>
###---   <auto:comment id="second_sorted_feature_iterator" md5="qbUft1FMcuLV0rFL+ywTJw">

=head2 second_sorted_feature_iterator

 Title   : second_sorted_feature_iterator property
 
 Usage   : $object->second_sorted_feature_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="second_sorted_feature_iterator" md5="muArAttA0MMZbpg6Qvl/lA">

sub second_sorted_feature_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'second_sorted_feature_iterator' } = shift @_;
  }
  return $self->{ 'second_sorted_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_second_sorted_feature_iterator" md5="bbSyHDUz7NFAOSV8J+s8IQ">

sub get_second_sorted_feature_iterator {
  return shift->{ 'second_sorted_feature_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_second_sorted_feature_iterator" md5="rgMnCDVv0NuWQPfvnHK+SQ">

sub set_second_sorted_feature_iterator {
  my $self = shift @_;
  $self->{ 'second_sorted_feature_iterator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_second_sorted_feature_iterator" md5="4IbEiYCitGVl/GcyLdP1kg">

sub link_second_sorted_feature_iterator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'second_sorted_feature_iterator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'second_sorted_feature_iterator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SortedFeatureIterator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'first_sorted_feature_iterator', $self->get_first_sorted_feature_iterator() );
  $target->property( 'second_sorted_feature_iterator', $self->get_second_sorted_feature_iterator() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;

  my $first_sorted_feature_iterator = $self->get_first_sorted_feature_iterator();
  if( !ref( $first_sorted_feature_iterator ) ) {
    croak( "Undefined first_sorted_feature_iterator in $self" )
  }
  
  my $second_sorted_feature_iterator = $self->get_second_sorted_feature_iterator();
  if( !ref( $second_sorted_feature_iterator ) ) {
    croak( "Undefined second_sorted_feature_iterator in $self" )
  }

  $first_sorted_feature_iterator->reset();
  $second_sorted_feature_iterator->reset();
}

sub valid
{
  my( $self ) = @_;

  my $first_sorted_feature_iterator = $self->get_first_sorted_feature_iterator();
  if( !ref( $first_sorted_feature_iterator ) ) {
    croak( "Undefined first_sorted_feature_iterator in $self" )
  }
  
  my $second_sorted_feature_iterator = $self->get_second_sorted_feature_iterator();
  if( !ref( $second_sorted_feature_iterator ) ) {
    croak( "Undefined second_sorted_feature_iterator in $self" )
  }

  return
    $first_sorted_feature_iterator->valid()
    || $second_sorted_feature_iterator->valid();
}

sub iterate
{
  my( $self ) = @_;

  my $first_sorted_feature_iterator = $self->get_first_sorted_feature_iterator();
  if( !ref( $first_sorted_feature_iterator ) ) {
    croak( "Undefined first_sorted_feature_iterator in $self" )
  }
  
  my $second_sorted_feature_iterator = $self->get_second_sorted_feature_iterator();
  if( !ref( $second_sorted_feature_iterator ) ) {
    croak( "Undefined second_sorted_feature_iterator in $self" )
  }

  my $feature_comparator = $self->get_feature_comparator();
  if( !ref( $feature_comparator ) ) {
    croak( "Undefined feature_comparator in $self" )
  }
  
  if( !$first_sorted_feature_iterator->valid() ) {
    $second_sorted_feature_iterator->iterate();
  } elsif( !$second_sorted_feature_iterator->valid() ) {
    $first_sorted_feature_iterator->iterate();
  } else {
    my $compare = $feature_comparator->compare( 
      $first_sorted_feature_iterator->value(),
      $second_sorted_feature_iterator->value()
    );
    
    if( $compare < 0 ) {
      $second_sorted_feature_iterator->iterate();
    } else {
      $first_sorted_feature_iterator->iterate();
    }
  }
}

sub value
{
  my( $self ) = @_;

  my $first_sorted_feature_iterator = $self->get_first_sorted_feature_iterator();
  if( !ref( $first_sorted_feature_iterator ) ) {
    croak( "Undefined first_sorted_feature_iterator in $self" )
  }
  
  my $second_sorted_feature_iterator = $self->get_second_sorted_feature_iterator();
  if( !ref( $second_sorted_feature_iterator ) ) {
    croak( "Undefined second_sorted_feature_iterator in $self" )
  }

  my $feature_comparator = $self->get_feature_comparator();
  if( !ref( $feature_comparator ) ) {
    croak( "Undefined feature_comparator in $self" )
  }
  
  if( !$first_sorted_feature_iterator->valid() ) {
    return $second_sorted_feature_iterator->value();
  } elsif( !$second_sorted_feature_iterator->valid() ) {
    return $first_sorted_feature_iterator->value();
  } else {
    my $compare = $feature_comparator->compare( 
      $first_sorted_feature_iterator->value(),
      $second_sorted_feature_iterator->value()
    );
    
    if( $compare < 0 ) {
      return $second_sorted_feature_iterator->value();
    } else {
      return $first_sorted_feature_iterator->value();
    }
  }
  
}

sub size
{
  my( $self ) = @_;

  my $first_sorted_feature_iterator = $self->get_first_sorted_feature_iterator();
  if( !ref( $first_sorted_feature_iterator ) ) {
    croak( "Undefined first_sorted_feature_iterator in $self" )
  }
  
  my $second_sorted_feature_iterator = $self->get_second_sorted_feature_iterator();
  if( !ref( $second_sorted_feature_iterator ) ) {
    croak( "Undefined second_sorted_feature_iterator in $self" )
  }
  
  return 
    $first_sorted_feature_iterator->size()
    + $second_sorted_feature_iterator->size();
}

##########################################################################

1;
