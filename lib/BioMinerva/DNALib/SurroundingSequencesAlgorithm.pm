##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SurroundingSequencesAlgorithm;

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

###--- <scalar_property id='target'>
###---   <auto:comment id="target" md5="0KOuDvyTa4uTEuGM4tkO8g">

=head2 target

 Title   : target property
 
 Usage   : $object->target(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="target" md5="8BWJcEF//xBWDz4uNugh4A">

sub target {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'target' } = shift @_;
  }
  return $self->{ 'target' };
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'target', $self->target() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self, $sequence_factory ) = @_;
  
  my $target = $self->target();
  if( !ref( $target ) ) {
    confess( "No target defined in $self" );
  }

  my @primary_sequence_ids = sort
    @{ $sequence_factory->primary_sequence_ids() || [] };

  foreach my $primary_sequence_id( @primary_sequence_ids ) {
    my $index_iterator = $sequence_factory->
      primary_sequence_id_start_sorted_index_iterator( $primary_sequence_id );

    my $surrounding_sequence;
    
    for(
      $index_iterator->reset();
      $index_iterator->valid();
      $index_iterator->iterate()
    ) {
      my $sequence =
        $sequence_factory->index2sequence( $index_iterator->value() );

      if( !ref( $surrounding_sequence ) ) {
        $surrounding_sequence = $sequence;
      } elsif( $surrounding_sequence->overlaps( $sequence ) ) {
        $surrounding_sequence = 
          $surrounding_sequence->surrounding_sequence( $sequence );
      } else {
        if( ref( $target ) eq 'CODE' ) {
          $target->( $surrounding_sequence );
        } else {
          $target->process( $surrounding_sequence );
        }
        $surrounding_sequence = $sequence;
      }
    }

    if( ref( $surrounding_sequence ) ) {
      if( ref( $target ) eq 'CODE' ) {
        $target->( $surrounding_sequence );
      } else {
        $target->process( $surrounding_sequence );
      }
    }
  }
}

##########################################################################

1;
