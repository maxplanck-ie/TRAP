##########################################################################

package BioMinerva::DNALib::FeatureOfMatchProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatchProcessor;
@ISA = qw( BioMinerva::DNALib::MatchProcessor );

use Carp qw( confess croak carp );
use POSIX qw( floor );
use BioMinerva::DNALib::Feature;

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::FeatureOfMatchProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

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

###--- <scalar_property id="p_value_attr" get_id="" set_id="">
###---   <auto:comment id="p_value_attr" md5="sX/YAbKmccgyQs+tMwP8ow">

=head2 p_value_attr

 Title   : p_value_attr property
 
 Usage   : $object->p_value_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="p_value_attr" md5="KNjNJjRNat48PqpOjiku9g">

sub p_value_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'p_value_attr' } = shift @_;
  }
  return $self->{ 'p_value_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_p_value_attr" md5="XqDFK+SbS5LPcGG4Sl1Jkg">

sub get_p_value_attr {
  return shift->{ 'p_value_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_p_value_attr" md5="3/wmY67WOy6UcR/TitB9NA">

sub set_p_value_attr {
  my $self = shift @_;
  $self->{ 'p_value_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="seq_attr" get_id="" set_id="">
###---   <auto:comment id="seq_attr" md5="yF3KzsGb0RZu5GF0yPWO6w">

=head2 seq_attr

 Title   : seq_attr property
 
 Usage   : $object->seq_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="seq_attr" md5="eTz7pD7O4pO0YtprG/yl1g">

sub seq_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'seq_attr' } = shift @_;
  }
  return $self->{ 'seq_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_seq_attr" md5="IZlDzI9R9vUJfInmdrLMsw">

sub get_seq_attr {
  return shift->{ 'seq_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_seq_attr" md5="pJPO5WL98BR4GDo0o6t4Bw">

sub set_seq_attr {
  my $self = shift @_;
  $self->{ 'seq_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_processor', $self->feature_processor() );
  $target->property( 'p_value_attr', $self->p_value_attr() );
  $target->property( 'seq_attr', $self->seq_attr() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'feature_processor' );
  $target->property( 'p_value_attr' );
  $target->property( 'seq_attr' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'feature_processor' ) { $self->feature_processor( @values ); }
  elsif( $property eq 'p_value_attr' ) { $self->p_value_attr( @values ); }
  elsif( $property eq 'seq_attr' ) { $self->seq_attr( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_feature_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

our $id_counter = 'SITE00000000';

sub process_match
{
  my( $self, $match ) = @_;

  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }

  my $p_value_attr = $self->get_p_value_attr();

  my $seq_attr = $self->get_seq_attr();

  my $feature = new BioMinerva::DNALib::Feature();
  $feature->set_id( ++$id_counter );
  $feature->set_type( 'TF_binding_site' );
  $feature->set_sequence( $match->sequence() );

  my $score = $match->get_score();
  if( defined( $score ) ) {
    $feature->set_score(
      POSIX::floor( $score * 1000.0 + 0.5 ) / 1000.0
    );
  }
  
  $feature->add_attr( 'matcher', $match->get_matcher()->get_id() );
  if( $seq_attr ) {
    $feature->add_attr( $seq_attr, $match->seq() );
  }
  if( $p_value_attr ) {
    my $p_value = $match->p_value();
    if( defined( $p_value ) ) {
      $feature->add_attr( $p_value_attr, $p_value );
    }
  }
  
  $feature_processor->process_feature( $feature );
}

##########################################################################

1;
