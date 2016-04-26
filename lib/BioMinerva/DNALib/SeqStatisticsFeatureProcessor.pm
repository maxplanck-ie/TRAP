##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SeqStatisticsFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureOfFeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureOfFeatureProcessor );

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

###--- <scalar_property id="sequence_factory" get_id="" set_id="" link_id="" type="BioMinerva::DNALib::SequenceFactory">
###---   <auto:comment id="sequence_factory" md5="nSsQ+7ZMHzvX2Yo/bOKPhw">

=head2 sequence_factory

 Title   : sequence_factory property
 
 Usage   : $object->sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_factory" md5="oJ1dV8kpNuTSxqy5ho2NUQ">

sub sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_factory' } = shift @_;
  }
  return $self->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_factory" md5="6kU+ambkFItqJliIgotJGw">

sub get_sequence_factory {
  return shift->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_factory" md5="ISTcxJ9LtZL/YpCByaB1CA">

sub set_sequence_factory {
  my $self = shift @_;
  $self->{ 'sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_sequence_factory" md5="g4SZ0RvMuykyQ2/p+m3Kwg">

sub link_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="length_attr" get_id="" set_id="">
###---   <auto:comment id="length_attr" md5="dRRYUnsWOg0uSNQY6vWsCg">

=head2 length_attr

 Title   : length_attr property
 
 Usage   : $object->length_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="length_attr" md5="CphMaztb8cp1KuvzXB3pPg">

sub length_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'length_attr' } = shift @_;
  }
  return $self->{ 'length_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_length_attr" md5="K0rUJ8wIx3+dDo2Z8oTbJA">

sub get_length_attr {
  return shift->{ 'length_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_length_attr" md5="sxwiJdULb7eJENmQ2N9C6A">

sub set_length_attr {
  my $self = shift @_;
  $self->{ 'length_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="gc_ratio_attr" get_id="" set_id="">
###---   <auto:comment id="gc_ratio_attr" md5="cL0eyadzrBwSKGk4kUy8kg">

=head2 gc_ratio_attr

 Title   : gc_ratio_attr property
 
 Usage   : $object->gc_ratio_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gc_ratio_attr" md5="8q5zOX5LbruWSYugjPh9aA">

sub gc_ratio_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gc_ratio_attr' } = shift @_;
  }
  return $self->{ 'gc_ratio_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gc_ratio_attr" md5="btt4sKv381GXy2OQX/us2w">

sub get_gc_ratio_attr {
  return shift->{ 'gc_ratio_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gc_ratio_attr" md5="LyLQkEI5J6cmcDGkLTBWRA">

sub set_gc_ratio_attr {
  my $self = shift @_;
  $self->{ 'gc_ratio_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->get_sequence_factory() );
  $target->property( 'length_attr', $self->get_length_attr() );
  $target->property( 'gc_ratio_attr', $self->get_gc_ratio_attr() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature {
  my( $self, $feature ) = @_;

  $feature = $feature->feature();

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) {
    croak( "Undefined sequence_factory in $self" );
  }
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }
  
  my $length_attr = $self->get_length_attr();
  if( defined( $length_attr ) ) {
    $feature->add_attr( $length_attr, $feature->length() );
  }
  
  my $gc_ratio_attr = $self->get_gc_ratio_attr();
  if( defined( $gc_ratio_attr ) ) {
    my $seq = $sequence_factory->sequence2seq( $feature );
    if( !defined( $seq ) ) {
      carp( "Sequence for $feature is not provided by the sequence_factory in $self; output skipped" );
      return;
    }

    $feature->add_attr( $gc_ratio_attr, $self->_gc_ratio( $seq ) );
  }

  $feature_processor->process_feature( $feature );
}

##########################################################################

sub _gc_ratio
{
  my( $self, $seq ) = @_;

  my $c2count = $self->_c2count( $seq );

  my $all_valid_count = 
    ( $c2count->{ 'A' } || 0 ) 
    + ( $c2count->{ 'C' } || 0 ) 
    + ( $c2count->{ 'G' } || 0 ) 
    + ( $c2count->{ 'T' } || 0 );
  my $gc_count = 
    ( $c2count->{ 'C' } || 0 ) 
    + ( $c2count->{ 'G' } || 0 );
  
  return $all_valid_count
    ? $gc_count / $all_valid_count
    : undef;
}

sub _c2count
{
  my( $self, $seq ) = @_;

  my $c2count = {};
  
  my @seq_array = split( //, $seq );
  foreach my $c( @seq_array ) {
    ++$c2count->{ uc( $c ) };
  }

  return $c2count;
}

##########################################################################

1;
