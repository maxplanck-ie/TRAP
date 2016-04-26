##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::RegionFeatureAlgebra;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess croak carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone {
  my( $self, $clone ) = @_;
  
  croak( "Not implemented yet in $self" );
}

##########################################################################
# PROPERTIES
##########################################################################

sub digest
{
  my( $self ) = @_;
  
  croak( "Not implemented yet in $self" );
  my $digest = $self->SUPER::digest();
  $digest->add( $self->get_primary_sequence_id() || '' );
  $digest->add( $self->get_start() || '' );
  $digest->add( $self->get_end() || '' );
  $digest->add( $self->get_strand() || '' );

  return $digest;
}

sub display_id
{
  my( $self ) = @_;
  
  croak( "Not implemented yet in $self" );
  my $display_id = $self->SUPER::display_id();
  if( $display_id ) { return $display_id; }

  return $self->location_str();
}

sub report_state
{
  my( $self, $target ) = @_;

  croak( "Not implemented yet in $self" );
  $self->SUPER::report_state( $target );
  $target->property( 'primary_sequence_id', $self->get_primary_sequence_id() );
  $target->property( 'start', $self->get_start() );
  $target->property( 'end', $self->get_end() );
  $target->property( 'strand', $self->get_strand() );
  $target->property( 'length', $self->length() );
}

##########################################################################
# FEATURE INFORMATION
##########################################################################

sub valid
{
  my( $self, $feature ) = @_;

  croak( "Not implemented yet in $self" );
}

sub length
{
  my( $self, $feature ) = @_;

  return $feature->get_end() - $feature->get_start() + 1;
}

sub location_str
{
  my( $self, $feature ) = @_;

  return 
    . $feature->get_start()
    . ".."
    . $feature->get_end();
}

##########################################################################
# COMPARISON OF FEATURES
##########################################################################

sub equals
{
  my( $self, $first_feature, $second_feature ) = @_;

  if( $first_feature->get_start() != $second_feature->get_start() ) { return 0; }
  if( $first_feature->get_end() != $second_feature->get_end() ) { return 0; }

  return 1;
}

sub contains
{
  my( $self, $first_feature, $second_feature ) = @_;

  if( $first_feature->get_start() <= $second_feature->get_start() 
    && $first_feature->get_end() >= $second_feature->get_end() 
  ) { 
    return 1;
  }

  return 0;
}

sub overlaps
{
  my( $self, $first_feature, $second_feature ) = @_;

  if( $first_feature->get_start() > $second_feature->get_end() ) { return 0; }
  if( $first_feature->get_end() < $second_feature->get_start() ) { return 0; }

  return 1;
}

##########################################################################
# MODIFIERS
##########################################################################

sub complement
{
  my( $self, $feature ) = @_;

  if( !$feature->get_strand() ) {
    confess( "Can not complement a zero/no-strand feature $feature in $self" );
  } else {
    $feature->set_strand( $feature->get_strand() * -1 );
  }
}

#NOTE: this procedure must throw if no valid result can be obtained; use
#      union_sequence for non-throwing behaviour
sub unite
{
  my( $self, $feature, $other_feature ) = @_;
  
  if( !$self->overlaps( $feature, $other_feature ) ) {
    confess( "Can not unite $feature with nonoverlapping feature $other_feature in $self" );
  }

  if( $feature->get_start() > $other_feature->get_start() ) {
    $feature->set_start( $other_feature->get_start() );
  }

  if( $feature->get_end() < $other_feature->get_end() ) {
    $feature->set_end( $other_feature->get_end() );
  }
}

#NOTE: this procedure must throw if no valid result can be obtained; use
#      intersect_sequence for non-throwing behaviour
sub intersect
{
  my( $self, $feature, $other_feature ) = @_;
  
  if( !$self->overlaps( $feature, $other_feature ) ) {
    confess( "Can not intersect $feature with nonoverlapping feature $other_feature in $self" );
  }

  if( $feature->get_start() < $other_feature->get_start() ) {
    $feature->set_start( $other_feature->get_start() );
  }

  if( $feature->get_end() > $other_feature->get_end() ) {
    $feature->set_end( $other_feature->get_end() );
  }
}

sub upstream
{
  my( $self, $feature, $ref_feature, $upstream_length, $downstream_length ) = @_;

  if( !$ref_feature->get_strand() || $ref_feature->get_strand() == 0 ) {
    confess( "No/zero strand in $ref_feature for upstream in $self" );
  } elsif( $ref_feature->get_strand() > 0 ) {
    $feature->set_start( $ref_feature->get_start() - $upstream_length );
    $feature->set_end( $ref_feature->get_start() - 1 + $downstream_length );
    $feature->set_strand( $ref_feature->get_strand() );
  } else {
    $feature->set_start( $ref_feature->get_end() + 1 - $downstream_length );
    $feature->set_end( $ref_feature->get_end() + $upstream_length );
    $feature->set_strand( $ref_feature->get_strand() );
  }
}

sub relative_sequence
{
  my( $self, $feature, $other_feature, $rel_start, $rel_end, $opposite_strand ) = @_;

  if( !$other_feature->get_strand() || $other_feature->get_strand() == 0 ) {
    confess( "Can not calc relative_sequence with no strand in $other_feature" );
  } elsif( $other_feature->get_strand() > 0 ) {
    $feature->set_start( $other_feature->get_start() + $rel_start );
    $feature->set_end( $other_feature->get_start() + $rel_end );
    $feature->set_strand( $other_feature->get_strand() );
  } else {
    $feature->set_start( $other_feature->get_end() - $rel_end );
    $feature->set_end( $other_feature->get_end() - $rel_start );
    $feature->set_strand( $other_feature->get_strand() );
  }
  
  if( $opposite_strand ) { 
    $self->complement( $feature ); 
  }
}

##########################################################################
# RETURNS A NEW SEQUENCE
##########################################################################

sub absolute_sequence
{
  my( $self, $feature, $start, $end, $strand ) = @_;

  $feature->set_start( $start );
  $feature->set_end( $end );
  $feature->set_strand( $strand );
}

sub relative_sequence
{
  my( $self, $feature, $other_feature, $rel_start, $rel_end, $opposite_strand ) = @_;

  my $feature = new BioMinerva::DNALib::Sequence();
  $feature->set_primary_sequence_id( $other_feature->get_primary_sequence_id() );
  
  if( !$other_feature->get_strand() || $other_feature->get_strand() == 0 ) {
    confess( "Can not calc relative_sequence with no strand in $other_feature" );
  } elsif( $other_feature->get_strand() > 0 ) {
    $feature->set_start( $other_feature->get_start() + $rel_start );
    $feature->set_end( $other_feature->get_start() + $rel_end );
    $feature->set_strand( $other_feature->get_strand() );
  } else {
    $feature->set_start( $other_feature->get_end() - $rel_end );
    $feature->set_end( $other_feature->get_end() - $rel_start );
    $feature->set_strand( $other_feature->get_strand() );
  }
  
  if( $opposite_strand ) { 
    $feature->complement(); 
  }

  return $feature;
}

sub intersection_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) { return undef; }
  if( $self->get_start() > $sequence->get_end() ) { return undef; }
  if( $self->get_end() < $sequence->get_start() ) { return undef; }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() > $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() < $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );

  return $ret_sequence;
}

sub union_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow union_sequence of $self and $sequence" );
  }
  if( $self->get_start() > $sequence->get_end() ) { return undef; }
  if( $self->get_end() < $sequence->get_start() ) { return undef; }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() < $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() > $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );

  return $ret_sequence;
}

sub surrounding_sequence
{
  my( $self, $sequence ) = @_;
  
  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow surrounding_sequence of $self and $sequence" );
  }

  my $ret_sequence = new BioMinerva::DNALib::Sequence();
  $ret_sequence->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $ret_sequence->set_start( 
    ( $self->get_start() < $sequence->get_start() )
      ? $self->get_start()
      : $sequence->get_start()
  );
  $ret_sequence->set_end(
    ( $self->get_end() > $sequence->get_end() )
      ? $self->get_end()
      : $sequence->get_end()
  );

  return $ret_sequence;
}

sub upstream_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    -$upstream_length, 
    $downstream_length - 1, 
    0 
  );
}

sub downstream_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    $self->length() - $upstream_length, 
    $self->length() - 1 + $downstream_length,
    0 
  );
}

sub expanded_sequence
{
  my( $self, $upstream_length, $downstream_length ) = @_;

  return $self->relative_sequence( 
    -$upstream_length, 
    $self->length() - 1 + $downstream_length,
    0 
  );
}

sub upstream_trim_sequence
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return 1;
  }

  if( $self->get_strand() > 0 ) {
    if( $sequence->get_end() < $self->get_start() ) {
      return $self->sequence();
    } elsif( $sequence->get_end() < $self->get_end() ) {
      my $ret_sequence = $self->sequence();
      $ret_sequence->set_start( $sequence->get_end() + 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } elsif( $self->get_strand() < 0 ) {
    if( $sequence->get_start() > $self->get_end() ) {
      return $self->sequence();
    } elsif( $sequence->get_start() > $self->get_start() ) {
      my $ret_sequence = $self->sequence();
      $ret_sequence->set_end( $sequence->get_start() - 1 );
      return $ret_sequence;
    } else {
      return undef;
    }
  } else {
    confess( "Can not upstream_trim sequences with undefined strand in $self to $sequence" );
  }
}

##########################################################################

sub contained_subsequences_surrounding_sequences
{
  my( $self, $subsequences ) = @_;

  my @ordered_subsequences = sort {
    $a->get_start() <=> $b->get_start() 
  } @{ $subsequences || [] };

  my $unified_sequence;
  my @unified_sequences;

  foreach my $subsequence( @ordered_subsequences ) {
    if( !ref( $unified_sequence ) ) {
      $unified_sequence = $subsequence->sequence();
    } elsif( $unified_sequence->overlaps( $subsequence ) ) {
      $unified_sequence = 
        $unified_sequence->union_sequence( $subsequence );
    } else {
      $unified_sequence = 
        $self->intersection_sequence( $unified_sequence );
      $unified_sequence->set_strand( $self->get_strand() );
      push @unified_sequences, $unified_sequence;
      $unified_sequence = $subsequence->sequence();
    }
  }

  if( ref( $unified_sequence ) ) {
    $unified_sequence = 
      $self->intersection_sequence( $unified_sequence );
    $unified_sequence->set_strand( $self->get_strand() );
    push @unified_sequences, $unified_sequence;
  }

  if( ( $self->get_strand() || 0 ) < 0 ) {
    @unified_sequences = reverse @unified_sequences;
  }
  
  return \@unified_sequences;
}

sub unified_subsequences_and_spacer_sequence_elements
{
  my( $self, $subsequences ) = @_;

  my @unified_subsequences_sequences = 
    @{ $self->contained_subsequences_surrounding_sequences( $subsequences ) };
  
  my @elements;
  
  # ----- no elements -----
  if( !scalar( @unified_subsequences_sequences ) ) {
    push @elements, {
      'type' => 'spacer',
      'sequence' => $self->sequence()
    };
  
    return \@elements;
  }
  
  # ----- upstream element -----
  {
    my $upstream_sequence = 
      $self->intersection_sequence(
        $unified_subsequences_sequences[ 0 ]->upstream_sequence( $self->length(), 0 )
      );
    if( ref( $upstream_sequence ) ) {
      push @elements, {
        'type' => 'upstream_spacer',
        'sequence' => $upstream_sequence
      };
    }
  }

  # ----- subsequences & spacer elements -----
  my $last_subfeature_sequence;
  while( my $subfeature_sequence = shift @unified_subsequences_sequences ) {
    if( ref( $last_subfeature_sequence ) ) {
      my $start;
      my $end;
      
      if( ( $self->get_strand() || 0 ) < 0 ) {
        $start = $subfeature_sequence->get_end() + 1;
        $end = $last_subfeature_sequence->get_start() - 1;
      } else {
        $start = $last_subfeature_sequence->get_end() + 1;
        $end = $subfeature_sequence->get_start() - 1;
      }
      
      if( $start <= $end ) {
        my $spacer_sequence = $self->absolute_sequence( 
          $start, $end, $self->get_strand()
        );
        
        push @elements, {
          'type' => 'spacer',
          'sequence' => $spacer_sequence
        };
      }
    }
    $last_subfeature_sequence = $subfeature_sequence;
    
    push @elements, {
      'type' => 'subfeature',
      'sequence' => $subfeature_sequence
    };
  }

  # ----- downstream element -----
  if( ref( $last_subfeature_sequence ) ) {
    my $downstream_sequence = 
      $self->intersection_sequence(
        $last_subfeature_sequence->downstream_sequence( 0, $self->length() )
      );
    if( ref( $downstream_sequence ) ) {
      push @elements, {
        'type' => 'downstream_spacer',
        'sequence' => $downstream_sequence
      };
    }
  }

  return \@elements;
}

sub spacer_subsequences_surrounding_sequences
{
  my( $self, $subsequences ) = @_;

  my @unified_subsequences_sequences = 
    @{ $self->contained_subsequences_surrounding_sequences( $subsequences ) };
  
  my @spacer_sequences;
  
  # ----- no elements -----
  if( !scalar( @unified_subsequences_sequences ) ) {
    push @spacer_sequences, $self->sequence();
    return \@spacer_sequences;
  }
  
  # ----- upstream element -----
  {
    my $upstream_sequence = 
      $self->intersection_sequence(
        $unified_subsequences_sequences[ 0 ]->upstream_sequence( $self->length(), 0 )
      );
    if( ref( $upstream_sequence ) ) {
      push @spacer_sequences, $upstream_sequence;
    }
  }

  # ----- subsequences & spacer elements -----
  my $last_subfeature_sequence;
  while( my $subfeature_sequence = shift @unified_subsequences_sequences ) {
    if( ref( $last_subfeature_sequence ) ) {
      my $start;
      my $end;
      
      if( ( $self->get_strand() || 0 ) < 0 ) {
        $start = $subfeature_sequence->get_end() + 1;
        $end = $last_subfeature_sequence->get_start() - 1;
      } else {
        $start = $last_subfeature_sequence->get_end() + 1;
        $end = $subfeature_sequence->get_start() - 1;
      }
      
      if( $start <= $end ) {
        my $spacer_sequence = $self->absolute_sequence( 
          $start, $end, $self->get_strand()
        );
        
        push @spacer_sequences, $spacer_sequence;
      }
    }
    $last_subfeature_sequence = $subfeature_sequence;
  }

  # ----- downstream element -----
  if( ref( $last_subfeature_sequence ) ) {
    my $downstream_sequence = 
      $self->intersection_sequence(
        $last_subfeature_sequence->downstream_sequence( 0, $self->length() )
      );
    if( ref( $downstream_sequence ) ) {
      push @spacer_sequences, $downstream_sequence;
    }
  }

  return \@spacer_sequences;
}


sub subsequences_covered_length
{
  my( $self, $subsequences ) = @_;

  my @ordered_subsequences = sort { 
    $a->get_start() <=> $b->get_start() 
  } @{ $subsequences || [] };

  my $unified_sequence;
  my $covered_length = 0;

  foreach my $subsequence( @ordered_subsequences ) {
    if( !ref( $unified_sequence ) ) {
      $unified_sequence = $subsequence->sequence();
    } elsif( $unified_sequence->overlaps( $subsequence ) ) {
      $unified_sequence = 
        $unified_sequence->union_sequence( $subsequence );
    } else {
      $unified_sequence = 
        $self->intersection_sequence( $unified_sequence );
      $covered_length += $unified_sequence->length();
      $unified_sequence = $subsequence->sequence();
    }
  }

  if( ref( $unified_sequence ) ) {
    $unified_sequence = 
      $self->intersection_sequence( $unified_sequence );
    $covered_length += $unified_sequence->length();
  }

  return $covered_length;
}

##########################################################################

sub relative_location_symbol
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return 'xx';
  }
  
  my $ret;
  
  if( $self->get_start() < $sequence->get_start() ) { $ret .= '<'; }
  elsif( $self->get_start() <= $sequence->get_end() ) { $ret .= '|'; }
  else { $ret .= '>'; }
  
  if( $self->get_end() < $sequence->get_start() ) { $ret .= '<'; }
  elsif( $self->get_end() <= $sequence->get_end() ) { $ret .= '|'; }
  else { $ret .= '>'; }

  return $ret;
}

##########################################################################

1;

