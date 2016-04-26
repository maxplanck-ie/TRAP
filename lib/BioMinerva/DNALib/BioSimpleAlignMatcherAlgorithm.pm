##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioSimpleAlignMatcherAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::DNALib::Feature;
use BioMinerva::DNALib::StoreMatchProcessor;
use Carp qw( confess croak carp );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::BioSimpleAlignMatcherAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="bio_simple_align_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::BioSimpleAlignFactory'>
###---   <auto:comment id="bio_simple_align_factory" md5="OGoJPzW3Gzfvh8D3zxhePA">

=head2 bio_simple_align_factory

 Title   : bio_simple_align_factory property
 
 Usage   : $object->bio_simple_align_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bio_simple_align_factory" md5="6cflDfU+lqRXC3joHW1aFg">

sub bio_simple_align_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bio_simple_align_factory' } = shift @_;
  }
  return $self->{ 'bio_simple_align_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bio_simple_align_factory" md5="9dShmshyhVK6r/hjKazx4Q">

sub get_bio_simple_align_factory {
  return shift->{ 'bio_simple_align_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bio_simple_align_factory" md5="1Cvd5dY3AdhvJVBYdsh/Aw">

sub set_bio_simple_align_factory {
  my $self = shift @_;
  $self->{ 'bio_simple_align_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_bio_simple_align_factory" md5="sSlDZS4VHyFDm+wM1KOxoA">

sub link_bio_simple_align_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'bio_simple_align_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'bio_simple_align_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::BioSimpleAlignFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="matcher_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::MatcherFactory'>
###---   <auto:comment id="matcher_factory" md5="C8EbJNksS4TIWg1FXg0EFQ">

=head2 matcher_factory

 Title   : matcher_factory property
 
 Usage   : $object->matcher_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="matcher_factory" md5="WIMM0VSPL4ynPomhY0Wn+g">

sub matcher_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'matcher_factory' } = shift @_;
  }
  return $self->{ 'matcher_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_matcher_factory" md5="NdIYyY2UvcIETYjZz3VWIg">

sub get_matcher_factory {
  return shift->{ 'matcher_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_matcher_factory" md5="ydLtHypxF4cReeEs8/GeiA">

sub set_matcher_factory {
  my $self = shift @_;
  $self->{ 'matcher_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_matcher_factory" md5="zc17RVmw//XC2Hy+FYrCJQ">

sub link_matcher_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'matcher_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'matcher_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::MatcherFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="feature_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="feature_processor" md5="590kX77o/z11rFZiD4wW9A">

=head2 feature_processor

 Title   : feature_processor property
 
 Usage   : $object->feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_processor" md5="PCWVqoFW+WySJGnPwF5OLw">

sub feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_processor' } = shift @_;
  }
  return $self->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_processor" md5="Xk4YITFJR5x4zq3JMOIgnA">

sub get_feature_processor {
  return shift->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_processor" md5="ii7RU2XwXrU8nt4/NS64vw">

sub set_feature_processor {
  my $self = shift @_;
  $self->{ 'feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_processor" md5="7XvZLA/AZW8QrjIHZjyJag">

sub link_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'bio_simple_align_factory', $self->bio_simple_align_factory() );
  $target->property( 'matcher_factory', $self->matcher_factory() );
  $target->property( 'feature_processor', $self->feature_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'bio_simple_align_factory' );
  $target->property( 'matcher_factory' );
  $target->property( 'feature_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'bio_simple_align_factory' ) { $self->bio_simple_align_factory( @values ); }
  elsif( $property eq 'matcher_factory' ) { $self->matcher_factory( @values ); }
  elsif( $property eq 'feature_processor' ) { $self->feature_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_bio_simple_align_factory( $registry );
  $self->link_matcher_factory( $registry );
  $self->link_feature_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $bio_simple_align_factory = $self->get_bio_simple_align_factory();
  if( !ref( $bio_simple_align_factory ) ) {
    croak( "Undefined bio_simple_align_factory in $self" );
  }

  my $matcher_factory = $self->get_matcher_factory();
  if( !ref( $matcher_factory ) ) {
    croak( "Undefined matcher_factory in $self" );
  }

  my $matchers = $matcher_factory->matchers();
  if( !@{ $matchers || [] } ) {
    carp( "No matchers provided in $self" );
  }
 
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }
  
  my $id_counter = 'CVSITE00000000';

  my $index_iterator = $bio_simple_align_factory->index_iterator();
  my $index_iterator_size = $index_iterator->size();
  my $counter = 0;

  print STDERR
    "#Processing alignments: "
    . scalar( @{ $matchers } )
    . " matcher(s) provided\n";

  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $bio_simple_align = 
      $bio_simple_align_factory->index2bio_simple_align( $index );
    my $sequence = new BioMinerva::DNALib::Sequence();
    $sequence->primary_sequence_id( $index );
    $sequence->start( 1 );
    $sequence->end( $bio_simple_align->length() );
    $sequence->strand( +1 );

    ++$counter;
    print STDERR 
      "#Processing alignment: $counter/$index_iterator_size ("
      . "length=" . $bio_simple_align->length()
      . ", seqs=" . $bio_simple_align->no_sequences()
      . ", index=$index"
      . ")               \r";
  
    foreach my $matcher( @{ $matchers || [] } ) 
    {
      my $bio_seq_no2matches = {};

      # ----- matching -----
      for(
        my $bio_seq_no = 1; 
        $bio_seq_no < $bio_simple_align->no_sequences();
        ++$bio_seq_no ) 
      {
        my $match_processor = new BioMinerva::DNALib::StoreMatchProcessor();
        $matcher->process_sequence_seq( 
          $match_processor, 
          $sequence, 
          $bio_simple_align->get_seq_by_pos( $bio_seq_no )->seq()
        );
        $bio_seq_no2matches->{ $bio_seq_no } = $match_processor->matches();
      }
      
      # ----- finding overlapping matches -----
      my $main_matches = delete $bio_seq_no2matches->{ 1 }; #TODO: "1" is a bad concept
      my $main_bio_seq = $bio_simple_align->get_seq_by_pos( 1 );
      my @other_bio_seq_nos = keys %{ $bio_seq_no2matches };
      
      foreach my $main_match( @{ $main_matches || [] } ) {
        my @conservation = ( $main_bio_seq->display_name() );

        foreach my $bio_seq_no( @other_bio_seq_nos ) {
          my $other_matches = $bio_seq_no2matches->{ $bio_seq_no };
          if( $main_match->overlaps_with_any( $other_matches ) ) {
            push @conservation,
              $bio_simple_align->get_seq_by_pos( $bio_seq_no )->display_name();
          }
        } 
        
        # ----- generating features for overlaps -----
        my $feature = new BioMinerva::DNALib::Feature();
        $feature->set_id( ++$id_counter );
        $feature->set_type( 'TF_binding_site' );
        {
          $feature->set_primary_sequence_id( $main_bio_seq->display_name() );
          my $main_match_sequence = $main_match->sequence();
          $feature->set_start(
            $main_bio_seq->location_from_column(
              $main_match_sequence->get_start()
            )->start()
          );
          $feature->set_end(
            $main_bio_seq->location_from_column(
              $main_match_sequence->get_end()
            )->end()
          );
          $feature->set_strand( $main_match_sequence->get_strand() );
        }
        $feature->set_score( scalar( @conservation ) );
        $feature->add_attr( 'matcher', $matcher->get_id() );
        $feature->add_attr( 'index', $index );
        $feature->add_attr( 'seq', $main_match->seq() );
        $feature->add_attr( 'conservation', @conservation );
 
        $feature_processor->process_feature( $feature );
      }
    }
  }
  
  print STDERR
    "\n";
}

##########################################################################

1;
