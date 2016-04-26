##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeaturesViewerAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Bio::Graphics::Feature;
use Bio::Graphics::Panel;
use Bio::SeqFeature::Generic;
use Bio::LocatableSeq;
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
  return new BioMinerva::DNALib::FeaturesViewerAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="feature_factory" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureFactory">
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
###---   <auto:code link_id="link_feature_factory" md5="Q/CRdOmwILlT6wXJxvYYNw">

sub link_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="range_feature_factory" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureFactory">
###---   <auto:comment id="range_feature_factory" md5="EbYb5jQMscd+SKn81kUakw">

=head2 range_feature_factory

 Title   : range_feature_factory property
 
 Usage   : $object->range_feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="range_feature_factory" md5="jQAvhwZVmQ90R8EARc3NIw">

sub range_feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'range_feature_factory' } = shift @_;
  }
  return $self->{ 'range_feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_range_feature_factory" md5="nMCOJWbLgJ1Hsc6ErFnftg">

sub get_range_feature_factory {
  return shift->{ 'range_feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_range_feature_factory" md5="tDLev/R5OaNnPhRj34LR0w">

sub set_range_feature_factory {
  my $self = shift @_;
  $self->{ 'range_feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_range_feature_factory" md5="pfY8cp2mj/VX1XvS2ltDUg">

sub link_range_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'range_feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'range_feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="sequence_factory" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::SequenceFactory">
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

###--- <scalar_property id="width" get_id='' set_id=''>
###---   <auto:comment id="width" md5="mDql+5jJGjYrlr82rNQB6Q">

=head2 width

 Title   : width property
 
 Usage   : $object->width(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="width" md5="ahCe/BYk80llaicft+xFpg">

sub width {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'width' } = shift @_;
  }
  return $self->{ 'width' };
}

###---   </auto:code>
###---   <auto:code get_id="get_width" md5="u6lPVnCeNyIXqyedJXJXlQ">

sub get_width {
  return shift->{ 'width' };
}

###---   </auto:code>
###---   <auto:code set_id="set_width" md5="GM6iQliUtfNyVndf4WK0ZA">

sub set_width {
  my $self = shift @_;
  $self->{ 'width' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pad_left" get_id='' set_id=''>
###---   <auto:comment id="pad_left" md5="CFnNMmUkgYBbVTJdmKFDZw">

=head2 pad_left

 Title   : pad_left property
 
 Usage   : $object->pad_left(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pad_left" md5="a4Pnck/Yec2Qz3M4y2vW5w">

sub pad_left {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pad_left' } = shift @_;
  }
  return $self->{ 'pad_left' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pad_left" md5="+XzOdWY1dgNMzkDrcUjA6A">

sub get_pad_left {
  return shift->{ 'pad_left' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pad_left" md5="JIRv02FcjnIxWnGUmMlh7Q">

sub set_pad_left {
  my $self = shift @_;
  $self->{ 'pad_left' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pad_right" get_id='' set_id=''>
###---   <auto:comment id="pad_right" md5="QX6byHTsNqPlRUn1J1VJeQ">

=head2 pad_right

 Title   : pad_right property
 
 Usage   : $object->pad_right(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pad_right" md5="Fe3/7omAms1Gf2u7Vcot6Q">

sub pad_right {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pad_right' } = shift @_;
  }
  return $self->{ 'pad_right' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pad_right" md5="PkyIFQnjAPv1VafQ1jgYEw">

sub get_pad_right {
  return shift->{ 'pad_right' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pad_right" md5="sotanS/8oD01qK3jn9YlfA">

sub set_pad_right {
  my $self = shift @_;
  $self->{ 'pad_right' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pad_top" get_id='' set_id=''>
###---   <auto:comment id="pad_top" md5="Rhdlz7ZSqARWl0q+erD9Gg">

=head2 pad_top

 Title   : pad_top property
 
 Usage   : $object->pad_top(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pad_top" md5="ylWNhxq3J1KgxCOGC+5VFg">

sub pad_top {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pad_top' } = shift @_;
  }
  return $self->{ 'pad_top' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pad_top" md5="CdADVfodn3ebYTzhg+Ys9g">

sub get_pad_top {
  return shift->{ 'pad_top' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pad_top" md5="SwwtD0jksteDAkmfwls4fw">

sub set_pad_top {
  my $self = shift @_;
  $self->{ 'pad_top' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pad_bottom" get_id='' set_id=''>
###---   <auto:comment id="pad_bottom" md5="A86rX24q8C3TKeHok7Hh+Q">

=head2 pad_bottom

 Title   : pad_bottom property
 
 Usage   : $object->pad_bottom(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pad_bottom" md5="3t/j/F0e+uRyV06IabcX8g">

sub pad_bottom {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pad_bottom' } = shift @_;
  }
  return $self->{ 'pad_bottom' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pad_bottom" md5="zIi9ol0Fseb3EYTCh+HBQQ">

sub get_pad_bottom {
  return shift->{ 'pad_bottom' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pad_bottom" md5="fKcMMFKR26SmPdkEtJwxUA">

sub set_pad_bottom {
  my $self = shift @_;
  $self->{ 'pad_bottom' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="grid" get_id='' set_id=''>
###---   <auto:comment id="grid" md5="Vn1oh6W6zMpBIfmA0O7FJg">

=head2 grid

 Title   : grid property
 
 Usage   : $object->grid(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="grid" md5="iPopAv0RUVoqGcTnORrq8A">

sub grid {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'grid' } = shift @_;
  }
  return $self->{ 'grid' };
}

###---   </auto:code>
###---   <auto:code get_id="get_grid" md5="nX8TgJBmelSmozetVepY8Q">

sub get_grid {
  return shift->{ 'grid' };
}

###---   </auto:code>
###---   <auto:code set_id="set_grid" md5="OG+66AOHJAy2oFhz2ZKZCQ">

sub set_grid {
  my $self = shift @_;
  $self->{ 'grid' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->feature_factory() );
  $target->property( 'range_feature_factory', $self->range_feature_factory() );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'width', $self->width() );
  $target->property( 'pad_left', $self->pad_left() );
  $target->property( 'pad_right', $self->pad_right() );
  $target->property( 'pad_top', $self->pad_top() );
  $target->property( 'pad_bottom', $self->pad_bottom() );
  $target->property( 'grid', $self->grid() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_factory' );
  $target->property( 'range_feature_factory' );
  $target->property( 'sequence_factory' );
  $target->property( 'width' );
  $target->property( 'pad_left' );
  $target->property( 'pad_right' );
  $target->property( 'pad_top' );
  $target->property( 'pad_bottom' );
  $target->property( 'grid' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_factory' ) { $self->feature_factory( @values ); }
  elsif( $property eq 'range_feature_factory' ) { $self->range_feature_factory( @values ); }
  elsif( $property eq 'sequence_factory' ) { $self->sequence_factory( @values ); }
  elsif( $property eq 'width' ) { $self->width( @values ); }
  elsif( $property eq 'pad_left' ) { $self->pad_left( @values ); }
  elsif( $property eq 'pad_right' ) { $self->pad_right( @values ); }
  elsif( $property eq 'pad_top' ) { $self->pad_top( @values ); }
  elsif( $property eq 'pad_bottom' ) { $self->pad_bottom( @values ); }
  elsif( $property eq 'grid' ) { $self->grid( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_factory( $registry );
  $self->link_range_feature_factory( $registry );
  $self->link_sequence_factory( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $range_feature_factory = $self->get_range_feature_factory();
  
  if( ref( $range_feature_factory ) ) {
    $self->_process_range_feature_factory( 
      $range_feature_factory
    );
  } else {
    $self->_process_find_range_feature();
  }
}

sub _process_range_feature_factory
{
  my( $self, $range_feature_factory ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }

  my $filtered_feature_factory =
    $feature_factory->score_in_range_feature_factory( 3, 8 );
  carp( "Warning: score filter applied: " .
    $filtered_feature_factory->display_id() );

  my $index_iterator = $range_feature_factory->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();

    $self->_draw_features( 
      $range_feature_factory->index2sequence( $index ),
      $filtered_feature_factory,
      $range_feature_factory->index2feature_id( $index )
    );
  }
}

sub _process_find_range_feature
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" );
  }

  foreach my $primary_sequence_id( @{ $feature_factory->primary_sequence_ids() } ) {
    my $primary_sequence_id_feature_factory =
      $feature_factory->primary_sequence_id_feature_factory( $primary_sequence_id );
    my $index_iterator = 
      $primary_sequence_id_feature_factory->index_iterator();

    my $range_sequence;
    for(
      $index_iterator->reset();
      $index_iterator->valid();
      $index_iterator->iterate()
    ) {
      my $index = $index_iterator->value();
      my $feature = $feature_factory->index2feature( $index );
      if( !defined( $range_sequence ) ) {
        $range_sequence = $feature;
      } else {
        $range_sequence = 
          $range_sequence->surrounding_sequence( $feature );
      }
    }

    $self->_draw_features( 
      $range_sequence, 
      $feature_factory,
      undef
    );
  }
}

##########################################################################

sub _draw_features
{
  my ( $self, $range_sequence, $feature_factory, $file_name ) = @_;

  print STDERR "#FeaturesViewerAlgorithm: drawing "
    . $range_sequence->location_str()
    . ( defined( $file_name ) ? " ($file_name)" : "" )
    . "\n";

  my $normalized_range_sequence = new BioMinerva::DNALib::Sequence();
  $normalized_range_sequence->set_id( $file_name );
  $normalized_range_sequence->set_primary_sequence_id( $range_sequence->get_primary_sequence_id() );
  $normalized_range_sequence->set_start( $range_sequence->get_start() );
  $normalized_range_sequence->set_end( $range_sequence->get_end() );
  $normalized_range_sequence->set_strand( 1 );
  
  my $gr_range_sequence = new Bio::Graphics::Feature(
    -name => $normalized_range_sequence->get_primary_sequence_id(),
    -start => $normalized_range_sequence->get_start(),
    -end => $normalized_range_sequence->get_end(),
    -strand => $normalized_range_sequence->get_strand()
  );
    
  my $panel = new Bio::Graphics::Panel(
    -segment => $gr_range_sequence,
    -key_style => 'between',
    -width => $self->get_width() || 12000,
    -pad_left => $self->get_pad_left() || 0,
    -pad_right => $self->get_pad_right() || 0,
    -pad_top => $self->get_pad_top() || 0,
    -pad_bottom => $self->get_pad_bottom() || 0,
    -grid => $self->get_grid() || 0
  );

  {
    my $overlapping_feature_factory =
      $feature_factory->overlapping_feature_factory( $range_sequence );

    $self->_add_axis_track(
      $panel, $overlapping_feature_factory, $range_sequence, $gr_range_sequence 
    );
    $self->_add_sequence_track( 
      $panel, $overlapping_feature_factory, $range_sequence, $gr_range_sequence 
    );
    $self->_add_range_track( 
      $panel, $overlapping_feature_factory, $range_sequence, $gr_range_sequence 
    );
    $self->_add_feature_tracks( 
      $panel, $overlapping_feature_factory, $range_sequence, $gr_range_sequence 
    );
  }

  if( defined( $file_name ) ) {
    my $stream;
    open( $stream, ">$file_name.png" );
    print $stream $panel->png();
    close( $stream );
  } else {
    print $panel->png();
  }

  $panel->finished();
}

##########################################################################

sub _add_axis_track
{
  my( $self, $panel, $feature_factory, $range_sequence, $gr_range_sequence ) = @_;
  
  $panel->add_track(
    $gr_range_sequence,
    -glyph => 'arrow',
    -tick    => 2
  );
}

sub _add_range_track
{
  my( $self, $panel, $feature_factory, $range_sequence, $gr_range_sequence ) = @_;
  
  my $gr_feature = new Bio::SeqFeature::Generic(
    -display_name => $range_sequence->location_str(),
    -seq_id => $range_sequence->get_primary_sequence_id(),
    -start => $range_sequence->get_start(),
    -end => $range_sequence->get_end(),
    -strand => $range_sequence->get_strand()
  );
  
  $panel->add_track(
    [ $gr_feature ],
    -glyph => 'segments',
    -label => $range_sequence->location_str(),
    -strand_arrow => 1,
#      -fgcolor => 'black',
#      -double  => 1,
  );
}

sub _add_sequence_track
{
  my( $self, $panel, $feature_factory, $range_sequence, $gr_range_sequence ) = @_;
  
  my $sequence_factory = $self->get_sequence_factory();
  if( ref( $sequence_factory ) ) {
    my $bio_seq_range_sequence = new Bio::Seq(
      -id => $range_sequence->primary_sequence_id(),
#      -start => $range_sequence->start(),
#      -end => $range_sequence->end(),
#      -strand => $range_sequence->strand(),
      -seq => $sequence_factory->sequence2seq( $range_sequence ),
    );

    my $gr_dna_range_sequence = new Bio::SeqFeature::Generic(
      -name => $range_sequence->primary_sequence_id(),
      -start => $range_sequence->start(),
      -end => $range_sequence->end(),
      -strand => $range_sequence->strand()
    );
    $gr_dna_range_sequence->attach_seq( $bio_seq_range_sequence );

    $panel->add_track(
      $gr_dna_range_sequence,
      -glyph => 'dna',
      -label => $range_sequence->location_str(),
      -key => "DNA",
      -strand => 'forward',
#      -height => 20,
#      -fgcolor => 'black',
#      -double  => 1,
    );
  }
}

sub _add_feature_tracks
{
  my( $self, $panel, $feature_factory, $range_sequence, $gr_range_sequence ) = @_;
  
  my $track = 'all';
  my $track2gr_features = {};
  
  my $index_iterator = $feature_factory->index_iterator();
  for(
    $index_iterator->reset();
    $index_iterator->valid();
    $index_iterator->iterate()
  ) {
    my $index = $index_iterator->value();
    my $feature = $feature_factory->index2feature( $index );
    
    my $gr_feature = new Bio::SeqFeature::Generic(
      -display_name => join( ',', @{ $feature->attr( 'matcher' ) || [] } ),
      -seq_id => $feature->get_primary_sequence_id(),
      -start => $feature->get_start(),
      -end => $feature->get_end(),
      -strand => $feature->get_strand(),
      -score => $feature->get_score()
    );
#      my $gr_feature = new Bio::Graphics::Feature(
#        -name => join( ',', @{ $feature->attr( 'cisreg_matcher' ) || [] } ),
#        -start => $feature->start(),
#        -end => $feature->end(),
#        -strand => $feature->strand(),
#        -score => $feature->get_score()
#      );
    $track2gr_features->{ $track } ||= [];
    push @{ $track2gr_features->{ $track } }, $gr_feature;
  }
    
  $panel->add_track( 
    $track2gr_features->{ $track },
    -glyph => 'graded_segments',
    -key => "TFBS(s)",
    -label => 1,
#      -vary_fg => 1,
    -strand_arrow => 1,
    -min_score => 1,
    -max_score => 7,
    -sort_order => 'high_score',
    -bgcolor => 'black',
    -fgcolor => 'gray',
  );
}

##########################################################################

1;
