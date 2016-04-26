##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::JoiningOverlappingIndexesIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::IteratorI;
@ISA = qw( BioMinerva::DNALib::IteratorI );

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

###--- <scalar_property id='sorted_index_iterator' get_id='get_sorted_index_iterator' set_id='set_sorted_index_iterator'>
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

###--- <scalar_property id='gff3_stream_parser' get_id='get_gff3_stream_parser' set_id='set_gff3_stream_parser'>
###---   <auto:comment id="gff3_stream_parser" md5="x/02arTdZwtMhpsXXuP1cA">

=head2 gff3_stream_parser

 Title   : gff3_stream_parser property
 
 Usage   : $object->gff3_stream_parser(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gff3_stream_parser" md5="oMARPFFeJU++8Doj3HfBWQ">

sub gff3_stream_parser {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gff3_stream_parser' } = shift @_;
  }
  return $self->{ 'gff3_stream_parser' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gff3_stream_parser" md5="T9IVT9R79E/J39JHmqDAIg">

sub get_gff3_stream_parser {
  return shift->{ 'gff3_stream_parser' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gff3_stream_parser" md5="Flun/jgPTBlfwXpbqIhiWA">

sub set_gff3_stream_parser {
  my $self = shift @_;
  $self->{ 'gff3_stream_parser' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='surrounding_sequence' get_id='get_surrounding_sequence' set_id='set_surrounding_sequence'>
###---   <auto:comment id="surrounding_sequence" md5="wiBfGnI+FziBYvQOm6vkKg">

=head2 surrounding_sequence

 Title   : surrounding_sequence property
 
 Usage   : $object->surrounding_sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="surrounding_sequence" md5="LnFtAc+KSMXy3NfNCu4CiA">

sub surrounding_sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'surrounding_sequence' } = shift @_;
  }
  return $self->{ 'surrounding_sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="get_surrounding_sequence" md5="QYDth5uPCWkmTAKB4N7mmA">

sub get_surrounding_sequence {
  return shift->{ 'surrounding_sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="set_surrounding_sequence" md5="vd0W6REAvpgKdBGQmcHoww">

sub set_surrounding_sequence {
  my $self = shift @_;
  $self->{ 'surrounding_sequence' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='overlapping_indexes' get_id='get_overlapping_indexes' set_id='set_overlapping_indexes'>
###---   <auto:comment id="overlapping_indexes" md5="HVkMHVo4AVgLre4iLnC/+Q">

=head2 overlapping_indexes

 Title   : overlapping_indexes property
 
 Usage   : $object->overlapping_indexes(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="overlapping_indexes" md5="26TH9VlxYsM7IGnYZiAVeA">

sub overlapping_indexes {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'overlapping_indexes' } = shift @_;
  }
  return $self->{ 'overlapping_indexes' };
}

###---   </auto:code>
###---   <auto:code get_id="get_overlapping_indexes" md5="67+9sWv7c13K/H9Os3PKRg">

sub get_overlapping_indexes {
  return shift->{ 'overlapping_indexes' };
}

###---   </auto:code>
###---   <auto:code set_id="set_overlapping_indexes" md5="HhBjKAN+rkevryXzpOF3Qg">

sub set_overlapping_indexes {
  my $self = shift @_;
  $self->{ 'overlapping_indexes' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
#  $target->property( 'iterators', $self->iterators() );
#  $target->property( 'index', $self->index() );
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

  $self->set_surrounding_sequence( undef );
  $self->set_overlapping_indexes( undef );

  my $sorted_index_iterator = $self->get_sorted_index_iterator();
  if( ref( $sorted_index_iterator ) ) {
    $sorted_index_iterator->reset();
    $self->_iterate_to_next();
  }
}

sub valid
{
  my( $self ) = @_;
  my $surrounding_sequence = $self->get_surrounding_sequence();
  return ref( $surrounding_sequence ) ? 1 : 0;
}

sub iterate
{
  my( $self ) = @_;

  $self->_iterate_to_next();  
}

sub value
{
  my( $self ) = @_;
  if( !ref( $self->get_surrounding_sequence() ) ) {
    confess( "valid() not tested before value() in $self" );
  }
  return [
    $self->get_surrounding_sequence(),
    $self->get_overlapping_indexes()
  ];
}

sub surrounding_sequence_value
{
  my( $self ) = @_;
  if( !ref( $self->get_surrounding_sequence() ) ) {
    confess( "valid() not tested before value() in $self" );
  }
  return $self->get_surrounding_sequence();
}

sub overlapping_indexes_value
{
  my( $self ) = @_;
  if( !ref( $self->get_surrounding_sequence() ) ) {
    confess( "valid() not tested before value() in $self" );
  }
  return $self->get_overlapping_indexes();
}

##########################################################################

sub _iterate_to_next
{
  my( $self ) = @_;
  
  my $sorted_index_iterator = $self->get_sorted_index_iterator();
  my $gff3_stream_parser = $self->get_gff3_stream_parser();

  my $surrounding_sequence;
  my @overlapping_indexes;
  
  while( $sorted_index_iterator->valid() ) 
  {
    my $index = $sorted_index_iterator->value();
    my $sequence = $gff3_stream_parser->index2sequence( $index );

    if( !ref( $surrounding_sequence ) ) {
      $surrounding_sequence = $sequence;
      @overlapping_indexes = ( $index );
    } elsif( $surrounding_sequence->overlaps( $sequence ) ) {
      $surrounding_sequence = $surrounding_sequence->union_sequence( $sequence );
      push @overlapping_indexes, $index;
    } else {
      last;
    }

    $sorted_index_iterator->iterate();
  }

  $self->set_surrounding_sequence( $surrounding_sequence );
  $self->set_overlapping_indexes( \@overlapping_indexes );
}

##########################################################################

1;
