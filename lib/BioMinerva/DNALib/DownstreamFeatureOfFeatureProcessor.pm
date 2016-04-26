##########################################################################

package BioMinerva::DNALib::DownstreamFeatureOfFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureOfFeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureOfFeatureProcessor );

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
  return new BioMinerva::DNALib::DownstreamFeatureOfFeatureProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='upstream_length' get_id='' set_id=''>
###---   <auto:comment id="upstream_length" md5="uFJT3P8QDmZQUOj1ssrOyQ">

=head2 upstream_length

 Title   : upstream_length property
 
 Usage   : $object->upstream_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="upstream_length" md5="rpxnVsbvlMRlcUggMEdKLA">

sub upstream_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'upstream_length' } = shift @_;
  }
  return $self->{ 'upstream_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_upstream_length" md5="NbCjOsKIjmC7ajx2ay3SZg">

sub get_upstream_length {
  return shift->{ 'upstream_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_upstream_length" md5="8GYNByl8UCkvQqHwJjO+rw">

sub set_upstream_length {
  my $self = shift @_;
  $self->{ 'upstream_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='downstream_length' get_id='' set_id=''>
###---   <auto:comment id="downstream_length" md5="L7Eo5dbbHtCHOeiOCoY/4w">

=head2 downstream_length

 Title   : downstream_length property
 
 Usage   : $object->downstream_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="downstream_length" md5="pcz5NSx/XHeNfzBY9LhxTg">

sub downstream_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'downstream_length' } = shift @_;
  }
  return $self->{ 'downstream_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_downstream_length" md5="i0NRwxfz2waRCVBlU1G3Mg">

sub get_downstream_length {
  return shift->{ 'downstream_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_downstream_length" md5="89TO1BSFGtkpgiMqDkAyVw">

sub set_downstream_length {
  my $self = shift @_;
  $self->{ 'downstream_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='feature_id_attr' get_id='' set_id=''>
###---   <auto:comment id="feature_id_attr" md5="B0nFL8VCnfkM9au7qjJlAw">

=head2 feature_id_attr

 Title   : feature_id_attr property
 
 Usage   : $object->feature_id_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_id_attr" md5="+s8wqprT59WqU+K5oZWpbQ">

sub feature_id_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_id_attr' } = shift @_;
  }
  return $self->{ 'feature_id_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_id_attr" md5="9CL3AW/eN/VXgC+kuwnT/w">

sub get_feature_id_attr {
  return shift->{ 'feature_id_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_id_attr" md5="c0jvZ90JBuutq4tEY80/Mg">

sub set_feature_id_attr {
  my $self = shift @_;
  $self->{ 'feature_id_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'upstream_length', $self->upstream_length() );
  $target->property( 'downstream_length', $self->downstream_length() );
  $target->property( 'feature_id_attr', $self->feature_id_attr() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'upstream_length' );
  $target->property( 'downstream_length' );
  $target->property( 'feature_id_attr' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'upstream_length' ) { $self->upstream_length( @values ); }
  elsif( $property eq 'downstream_length' ) { $self->downstream_length( @values ); }
  elsif( $property eq 'feature_id_attr' ) { $self->feature_id_attr( @values ); }
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

sub process_feature
{
  my( $self, $feature ) = @_;

  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    carp( "Undefined $feature_processor in $self" );
  }
  
  my $target_feature = $self->_create_linked_feature( 'region', $feature );
  $target_feature->set_sequence(
    $feature->downstream_sequence(
      $self->get_upstream_length() || 0,
      $self->get_downstream_length() || 0
    )
  );

  my $feature_id_attr = $self->get_feature_id_attr();
  if( !defined( $feature_id_attr ) ) {
    $target_feature->set_id( 
      "downstream(" . $feature->get_id() . ")"
    );
  } elsif( $feature_id_attr eq 'ignore' ) {
  } elsif( $feature_id_attr eq 'ID' ) {
    $target_feature->set_id(
      $feature->get_id()
    );
  } else {
    $target_feature->set_id( 
      "downstream(" . $feature->get_id() . ")"
    );
    $target_feature->add_attr(
      $feature_id_attr, 
      $feature->get_id() 
    );
  }
  
  if( $self->_primary_sequence_factory_feature_trim( $target_feature ) ) {
    $feature_processor->process_feature( $target_feature );
  }
}

##########################################################################

1;
