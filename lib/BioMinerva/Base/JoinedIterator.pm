##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::JoinedIterator;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IteratorI;
@ISA = qw( BioMinerva::Base::IteratorI );

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

###--- <array_property id='iterator' ids='iterators' add_id='add_iterator'>
###---   <auto:comment id="iterators" md5="eEhVoba812pOLOzN8mv9Kg">

=head2 iterators

 Title   : iterators (array property)
 
 Usage   : C<<< my $iterators = $object->iterators();
           if( defined( $iterators ) ) { 
             foreach my $iterator( @{ $iterators } ) {
               ...
             }
           } >>>
           
           C<<< $object->iterators( $iterators ); >>>
 
           C<<< $object->iterators( undef ); >>>

 Function: Accessor to the array property C<iterators>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of iterators to be set
           clear-accessor: undef

 Return  : reference to the current array of iterators or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="iterators" md5="RznMDA1qXQmPeHXB2S0OuQ">

sub iterators {
  my $self = shift @_;
  if( @_ ) {
    my $iterators = shift @_;
    if( defined( $iterators ) && ref( $iterators ) ne 'ARRAY' ) {
      confess( "Property 'iterators' requires an ARRAY argument (now: $iterators)." );
    }
    $self->{ 'iterators' } = $iterators;
  }
  return $self->{ 'iterators' };
}

###---   </auto:code>
###---   <auto:comment id="add_iterator" md5="bW6nieVXxVFkDwbj2Km8fA">

=head2 add_iterator

 Title   : add_iterator (iterators property)
 
 Usage   : C<<< $object->add_iterator( $iterator, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< iterators >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_iterator" md5="kMwwwzS/BNg2ZVxMLgDcJA">

sub add_iterator {
  my $self = shift @_;
  my @iterators = @_;
  $self->{ 'iterators' } ||= [];
  push @{ $self->{ 'iterators' } }, @iterators;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <scalar_property id='index' get_id='get_index' set_id='set_index'>
###---   <auto:comment id="index" md5="aMJMKGFZg4HDWb8/1cfHiA">

=head2 index

 Title   : index property
 
 Usage   : $object->index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index" md5="7BAnGPK4NgFDGMFKVWXqTg">

sub index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index' } = shift @_;
  }
  return $self->{ 'index' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index" md5="7Lq+jJug+kSPckjiQV6D2A">

sub get_index {
  return shift->{ 'index' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index" md5="uBZWh3Xod+gC3juCQuhrzg">

sub set_index {
  my $self = shift @_;
  $self->{ 'index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'iterators', $self->iterators() );
  $target->property( 'index', $self->index() );
#  $target->property( '', $self->() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
#  $target->property( '' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  elsif( $property eq '' ) { $self->( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub reset
{
  my( $self ) = @_;
  
  my $iterators = $self->iterators() || [];
  foreach my $iterator( @{ $iterators } ) {
    $iterator->reset();
  }

  my $index = 0;
  while( $index < scalar( @{ $iterators } ) ) {
    if( $iterators->[ $index ]->valid() ) {
      $self->set_index( $index );
      return; 
    }

    ++$index;
  }
  $self->set_index( undef );
}

sub valid
{
  my( $self ) = @_;
  return defined( $self->get_index() );
}

sub iterate
{
  my( $self ) = @_;
  my $index = $self->get_index();
  if( !defined( $index ) ) { 
    confess( "Iterator not initialized properly in $self" );
  }

  my $iterators = $self->iterators();
  my $iterate = 1;
  while( 1 ) {
    my $iterator = $iterators->[ $index ];
    if( $iterate ) { $iterator->iterate(); }
    if( $iterator->valid() ) { return; }

    if( ++$index >= scalar( @{ $iterators } ) ) {
      $self->set_index( undef );
      return;
    }
    $self->set_index( $index );
    $iterate = 0;
  }
}

sub value
{
  my( $self ) = @_;
  my $index = $self->get_index();
  if( !defined( $index ) ) {
    confess( "No sub-iterators defined in $self" );
  }
  return $self->iterators()->[ $index ]->value();
}

sub size
{
  my( $self ) = @_;
  
  my $iterators = $self->iterators();
  if( !defined( $iterators ) ) { return undef; }
  
  my $size = 0;
  foreach my $iterator( @{ $iterators } ) {
    $size += $iterator->size();
  }

  return $size;
}

##########################################################################

1;
