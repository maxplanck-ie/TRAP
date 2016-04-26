##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SurroundingSequenceIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Object;
@ISA = qw( BioMinerva::Base::Object );

use Carp qw( confess carp croak );

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

###--- <scalar_property id='feature_factory' get_id='' set_id=''>
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
###--- </scalar_property>

###--- <scalar_property id='sorted_index_iterator' get_id='' set_id=''>
###---   <auto:comment id="sorted_index_iterator" md5="1ANdFl+PW7e4ja7hGIguoA">

=head2 sorted_index_iterator

 Title   : sorted_index_iterator property
 
 Usage   : $object->sorted_index_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sorted_index_iterator" md5="qpHaMnd4A/nEDZsIehJUBw">

sub sorted_index_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sorted_index_iterator' } = shift @_;
  }
  return $self->{ 'sorted_index_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sorted_index_iterator" md5="WhO5623JZJaGYSjXw4lpnQ">

sub get_sorted_index_iterator {
  return shift->{ 'sorted_index_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sorted_index_iterator" md5="Zl7/bgsVN+sJHuwXl9xrxA">

sub set_sorted_index_iterator {
  my $self = shift @_;
  $self->{ 'sorted_index_iterator' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_value' get_id='' set_id=''>
###---   <auto:comment id="_value" md5="TvkhB7XNSU8gbQ0I4/RMNQ">

=head2 _value

 Title   : _value property
 
 Usage   : $object->_value(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_value" md5="bEb9zWNWAyMHqGNy7jcorA">

sub _value {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_value' } = shift @_;
  }
  return $self->{ '_value' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_value" md5="d0gyXv4wHA6BHA5ppUOk1A">

sub _get_value {
  return shift->{ '_value' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_value" md5="jCkWQadp2CA4DaKdMlnLFw">

sub _set_value {
  my $self = shift @_;
  $self->{ '_value' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
#  $target->property( 'target', $self->target() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;

  $self->get_sorted_index_iterator()->reset();
  $self->iterate();
}

sub valid
{
  my( $self ) = @_;

  my $value = $self->_get_value();
  return ref( $value )
    ? 1
    : 0;
}

sub iterate
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  my $sorted_index_iterator = $self->get_sorted_index_iterator();
  
  my $surrounding_sequence;
  while( $sorted_index_iterator->valid() ) {
    my $sequence =
      $feature_factory->index2sequence( $sorted_index_iterator->value() );

    if( !ref( $surrounding_sequence ) ) {
      $surrounding_sequence = $sequence;
      $sorted_index_iterator->iterate();
    } elsif( $surrounding_sequence->overlaps( $sequence ) ) {
      $surrounding_sequence = 
        $surrounding_sequence->surrounding_sequence( $sequence );
      $sorted_index_iterator->iterate();
    } else {
      last;
    }
  }

  $self->_set_value( $surrounding_sequence );
}

sub value
{
  my( $self ) = @_;

  return $self->_get_value();
}

##########################################################################

1;
