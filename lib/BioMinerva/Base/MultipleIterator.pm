##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::MultipleIterator;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'iterators', $self->iterators() );
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

  foreach my $iterator( @{ $self->iterators() || [] } ) { 
    $iterator->reset(); 
  }
}

sub valid
{
  my( $self ) = @_;
  
  foreach my $iterator( @{ $self->iterators() || [] } ) { 
    if( !$iterator->valid() ) { 
      return 0; 
    }
  }
  
  return 1;
}

sub iterate
{
  my( $self ) = @_;

  my $iterators = $self->iterators() || [];
  my $i = scalar( @{ $iterators } );
  while( --$i >= 0 ) {
    my $iterator = $iterators->[ $i ];
    $iterator->iterate();
    if( $iterator->valid() ) { 
      last; 
    }
    if( $i > 0 ) {
      $iterator->reset();
    }
  }
}

sub value
{
  my( $self ) = @_;

  my $value = [];
  foreach my $iterator( @{ $self->iterators() || [] } ) { 
    push @{ $value }, $iterator->value(); #TODO: cache
  }
    
  return $value;
}

##########################################################################

1;
