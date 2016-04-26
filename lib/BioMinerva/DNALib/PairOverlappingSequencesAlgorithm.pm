##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PairOverlappingSequencesAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Object;
@ISA = qw( BioMinerva::Base::Object );

use Carp qw( confess carp );

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

###--- <scalar_property id='skip_equal'>
###---   <auto:comment id="skip_equal" md5="QZOWDYbP4gx4za+YA38VHA">

=head2 skip_equal

 Title   : skip_equal property
 
 Usage   : $object->skip_equal(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="skip_equal" md5="98jE26D4cq6JW2J4KGYRuQ">

sub skip_equal {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'skip_equal' } = shift @_;
  }
  return $self->{ 'skip_equal' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='skip_not_contained'>
###---   <auto:comment id="skip_not_contained" md5="KmCT2SBvmqbEJY3oOP8qvQ">

=head2 skip_not_contained

 Title   : skip_not_contained property
 
 Usage   : $object->skip_not_contained(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="skip_not_contained" md5="TZlu0e/SSmG+ecIB6ezdAg">

sub skip_not_contained {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'skip_not_contained' } = shift @_;
  }
  return $self->{ 'skip_not_contained' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='only_with_overlaps'>
###---   <auto:comment id="only_with_overlaps" md5="hgWijJ74zcwZB6PO3+bhEA">

=head2 only_with_overlaps

 Title   : only_with_overlaps property
 
 Usage   : $object->only_with_overlaps(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="only_with_overlaps" md5="xyA1CR/oN3s6XDR9xEfb9A">

sub only_with_overlaps {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'only_with_overlaps' } = shift @_;
  }
  return $self->{ 'only_with_overlaps' };
}

###---   </auto:code>
###--- </scalar_property>

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
  $target->property( 'skip_equal', $self->skip_equal() );
  $target->property( 'skip_not_contained', $self->skip_not_contained() );
  $target->property( 'only_with_overlaps', $self->only_with_overlaps() );
  $target->property( 'target', $self->target() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self, $main_sequences_source, $other_sequences_source ) = @_;
  
  my $target = $self->target();
  if( !ref( $target ) ) {
    confess( "No target defined in $self" );
  }

  my $skip_equal = $self->skip_equal();
  my $skip_not_contained = $self->skip_not_contained();
  my $only_with_overlaps = $self->only_with_overlaps();
  
  my @primary_sequence_ids = sort
    @{ $main_sequences_source->primary_sequence_ids() || [] };

  foreach my $primary_sequence_id( @primary_sequence_ids ) {
    my $main_index_iterator = $main_sequences_source->
      primary_sequence_id_start_sorted_index_iterator( $primary_sequence_id );
    my $other_index_iterator = $other_sequences_source->
      primary_sequence_id_start_sorted_index_iterator( $primary_sequence_id );

    $main_index_iterator->reset();
    $other_index_iterator->reset();

    while( $main_index_iterator->valid() ) {
      my $main_sequence =
        $main_sequences_source->index2sequence( $main_index_iterator->value() );

      # ----- skip whatever is already before -----
      while( $other_index_iterator->valid() ) {
        my $other_sequence =
          $other_sequences_source->index2sequence( $other_index_iterator->value() );
          
        if( !$other_sequence->located_before_start( $main_sequence ) )
          { last; }
        $other_index_iterator->iterate();
      }

      # ----- iterate over overlapping elements -----
      my @other_indexes;
      
      my $other_local_index_iterator = $other_index_iterator->clone();
      while( $other_local_index_iterator->valid() ) {
        my $other_sequence =
          $other_sequences_source->index2sequence( $other_local_index_iterator->value() );

        if( $other_sequence->located_after_end( $main_sequence ) )
          { last; }
        
        if( $other_sequence->overlaps( $main_sequence ) ) {
          if( $skip_equal && $main_sequence->equals( $other_sequence ) ) { 
          } elsif( $skip_not_contained && !$main_sequence->contains( $other_sequence ) ) {
          } else {
            push @other_indexes, $other_local_index_iterator->value();
          }
        }

        $other_local_index_iterator->iterate();
      }

      if( !$only_with_overlaps || @other_indexes ) {
        if( ref( $target ) eq 'CODE' ) {
          $target->(
            $main_index_iterator->value(),
            \@other_indexes
          );
        } else {
          $target->process(
            $main_index_iterator->value(),
            \@other_indexes
          );
        }
      }
      
      $main_index_iterator->iterate();
    }
  }
}

##########################################################################

1;
