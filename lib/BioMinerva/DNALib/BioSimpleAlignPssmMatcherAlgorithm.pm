##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BioSimpleAlignPssmMatcherAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use BioMinerva::DNALib::Feature;
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
  return new BioMinerva::DNALib::BioSimpleAlignPssmMatcherAlgorithm();
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

###--- <scalar_property id="cisreg_matcher_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::DNALibMatcherFactory'>
###---   <auto:comment id="cisreg_matcher_factory" md5="3S8YNBNVLeJAkxq8SMOb2w">

=head2 cisreg_matcher_factory

 Title   : cisreg_matcher_factory property
 
 Usage   : $object->cisreg_matcher_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="cisreg_matcher_factory" md5="GFSMdldPHCxFzT7sVjPjKw">

sub cisreg_matcher_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'cisreg_matcher_factory' } = shift @_;
  }
  return $self->{ 'cisreg_matcher_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_cisreg_matcher_factory" md5="p4ajwhz+rlszoGpKPIPoBw">

sub get_cisreg_matcher_factory {
  return shift->{ 'cisreg_matcher_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_cisreg_matcher_factory" md5="C/3Hm/4s7wV91fIqodyX0A">

sub set_cisreg_matcher_factory {
  my $self = shift @_;
  $self->{ 'cisreg_matcher_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_cisreg_matcher_factory" md5="cK9Pi216/gXxqPBWRfUXtw">

sub link_cisreg_matcher_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'cisreg_matcher_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'cisreg_matcher_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::DNALibMatcherFactory', $ref
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
  $target->property( 'cisreg_matcher_factory', $self->cisreg_matcher_factory() );
  $target->property( 'feature_processor', $self->feature_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'bio_simple_align_factory' );
  $target->property( 'cisreg_matcher_factory' );
  $target->property( 'feature_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'bio_simple_align_factory' ) { $self->bio_simple_align_factory( @values ); }
  elsif( $property eq 'cisreg_matcher_factory' ) { $self->cisreg_matcher_factory( @values ); }
  elsif( $property eq 'feature_processor' ) { $self->feature_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_bio_simple_align_factory( $registry );
  $self->link_cisreg_matcher_factory( $registry );
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

  my $cisreg_matcher_factory = $self->get_cisreg_matcher_factory();
  if( !ref( $cisreg_matcher_factory ) ) {
    croak( "Undefined cisreg_matcher_factory in $self" );
  }

  my $cisreg_matchers = $cisreg_matcher_factory->cisreg_matchers();
  if( !@{ $cisreg_matchers || [] } ) {
    carp( "No cisreg_matchers provided in $self" );
  }
 
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }

  $self->_process_alignments( 
    $bio_simple_align_factory, 
    $cisreg_matchers,
    $feature_processor 
  );
}

sub _process_alignments
{
  my( $self, $bio_simple_align_factory, $cisreg_matchers, $feature_processor ) = @_;

  my $index_iterator = $bio_simple_align_factory->index_iterator();
  my $index_iterator_size = $index_iterator->size();
  my $counter = 0;

  print STDERR
    "#Processing alignments: "
    . scalar( @{ $cisreg_matchers } )
    . " cisreg_matcher(s) provided\n";

  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $bio_simple_align = 
      $bio_simple_align_factory->index2bio_simple_align( $index );

    ++$counter;
    print STDERR 
      "#Processing alignment: $counter/$index_iterator_size ("
      . "length=" . $bio_simple_align->length()
      . ", seqs=" . $bio_simple_align->no_sequences()
      . ")          \r";
  
    foreach my $cisreg_matcher( @{ $cisreg_matchers } ) 
    {
      my $bio_seq_no2features = {};

      my $sequence = new BioMinerva::DNALib::Sequence();
      $sequence->primary_sequence_id( $index );
      $sequence->start( 1 );
      $sequence->end( $bio_simple_align->length() );
      $sequence->strand( +1 );
      
      for(
        my $bio_seq_no = 1; 
        $bio_seq_no < $bio_simple_align->no_sequences();
        ++$bio_seq_no ) 
      {
        my $bio_seq = $bio_simple_align->get_seq_by_pos( $bio_seq_no );

        $bio_seq_no2features->{ $bio_seq_no } =
#          $self->_match_matcher_sequence( $cisreg_matcher, $sequence, $bio_seq->seq() );
          $cisreg_matcher->sequence_seq2features( $sequence, $bio_seq->seq() );
#          $cisreg_matcher->sequence_seq2sequences( $sequence, $bio_seq->seq() );
      }
      
      my $main_features = delete $bio_seq_no2features->{ 1 };
      my @other_features_es = values %{ $bio_seq_no2features };

      foreach my $main_feature( @{ $main_features || [] } ) {
        my @conservation = (
          $bio_simple_align->get_seq_by_pos( 1 )->display_name()
        );

        foreach my $bio_seq_no( keys %{ $bio_seq_no2features } ) {
          my $other_features = $bio_seq_no2features->{ $bio_seq_no };
          if( $main_feature->overlaps_with_any( $other_features ) ) {
            push @conservation,
              $bio_simple_align->get_seq_by_pos( $bio_seq_no )->display_name();
          }
        } 
        
        my $mf = new BioMinerva::DNALib::Feature();
        $mf->set_type( 'TF_binding_site' );
        $mf->set_id( $main_feature->get_id() );
        my $bio_seq = $bio_simple_align->get_seq_by_pos( 1 );
        $mf->set_primary_sequence_id( $bio_seq->display_name() );
        $mf->set_start(
          $bio_seq->location_from_column(
            $main_feature->get_start()
          )->start()
        );
        $mf->set_end(
          $bio_seq->location_from_column(
            $main_feature->get_end()
          )->end()
        );
        $mf->set_strand( $main_feature->get_strand() );

        $mf->add_attr( 'index', $index );
        $mf->add_attr( 'conservation', @conservation );
        $mf->set_score( scalar( @conservation ) );
        $mf->add_attr( 'cisreg_matcher', $cisreg_matcher->get_id() );

        $feature_processor->process_feature( $mf );
      }
    }
  }
  
  print STDERR
    "\n";
}

our $id_counter = 'SITE000001';

sub _match_matcher_sequence
{
  my( $self, $cisreg_matcher, $sequence, $seq ) = @_;
 
  my @features;
  
  for( my $seq_pos = 0; $seq_pos < length( $seq ); $seq_pos++ ) 
  {
# ----- match here? -----
    my $match = $cisreg_matcher->score_seq( \$seq, $seq_pos );
    if( !$match ) { next; }
    my( $seq_end_pos, $score ) = @{ $match };
    if( $score < $cisreg_matcher->cutoff() ) { next; }

# ----- feature -----
    my $feature = new BioMinerva::DNALib::Feature();
    $feature->set_id( $id_counter++ );
    $feature->set_type( 'TF_binding_site' );
    $feature->set_sequence(
      $sequence->relative_sequence( 
        $seq_pos, 
        $seq_end_pos, 
        ( $cisreg_matcher->strand() < 0 ) ? 1 : 0 
      )
    );

    $feature->set_score( $score );
    $feature->add_attr( 
      'seq', 
      substr( $seq, $seq_pos, $seq_end_pos - $seq_pos + 1 ) 
    );
    $feature->add_attr( 'cisreg_matcher', $cisreg_matcher->get_id() );

    push @features, $feature;
  }

  return \@features;
}

sub _match_matcher_sequence_new
{
  my( $self, $cisreg_matcher, $sequence, $seq ) = @_;
 
  return $cisreg_matcher->sequence_seq2features( $sequence, $seq );
}

##########################################################################

1;
