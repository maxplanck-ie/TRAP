##########################################################################

package BioMinerva::DNALib::FeatureOfFeatureProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureProcessor;
@ISA = qw( BioMinerva::DNALib::FeatureProcessor );

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
  return new BioMinerva::DNALib::FeatureOfFeatureProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_processor' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
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

###--- <scalar_property id='primary_sequence_factory' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::SequenceFactory'>
###---   <auto:comment id="primary_sequence_factory" md5="iJJIHNL7YFnrqWa1oQI8jw">

=head2 primary_sequence_factory

 Title   : primary_sequence_factory property
 
 Usage   : $object->primary_sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="primary_sequence_factory" md5="VP0grPnyAdo9WnWzWG4a2w">

sub primary_sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'primary_sequence_factory' } = shift @_;
  }
  return $self->{ 'primary_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_primary_sequence_factory" md5="28FByL8GldDDdMiew523uQ">

sub get_primary_sequence_factory {
  return shift->{ 'primary_sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_primary_sequence_factory" md5="QIiArSf/+mQy8AICR3QvXg">

sub set_primary_sequence_factory {
  my $self = shift @_;
  $self->{ 'primary_sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_primary_sequence_factory" md5="K64+nUmusP3D3NuYk+x/Jw">

sub link_primary_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'primary_sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'primary_sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id='_attr' ids='attrs' add_id='add_attr'>
###---   <auto:comment id="attrs" md5="hHNzYNDCoCUcnvC5x2Yg6Q">

=head2 attrs

 Title   : attrs (array property)
 
 Usage   : C<<< my $attrs = $object->attrs();
           if( defined( $attrs ) ) { 
             foreach my $_attr( @{ $attrs } ) {
               ...
             }
           } >>>
           
           C<<< $object->attrs( $attrs ); >>>
 
           C<<< $object->attrs( undef ); >>>

 Function: Accessor to the array property C<attrs>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of attrs to be set
           clear-accessor: undef

 Return  : reference to the current array of attrs or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="attrs" md5="mK+46rOsOLQrj2569D9xLQ">

sub attrs {
  my $self = shift @_;
  if( @_ ) {
    my $attrs = shift @_;
    if( defined( $attrs ) && ref( $attrs ) ne 'ARRAY' ) {
      confess( "Property 'attrs' requires an ARRAY argument (now: $attrs)." );
    }
    $self->{ 'attrs' } = $attrs;
  }
  return $self->{ 'attrs' };
}

###---   </auto:code>
###---   <auto:comment id="add_attr" md5="ePN0pEluXmKQYDIFR9UR+Q">

=head2 add_attr

 Title   : add_attr (attrs property)
 
 Usage   : C<<< $object->add_attr( $_attr, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< attrs >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_attr" md5="kEp+Lc3vz4e4/CgvT5QxVw">

sub add_attr {
  my $self = shift @_;
  my @attrs = @_;
  $self->{ 'attrs' } ||= [];
  push @{ $self->{ 'attrs' } }, @attrs;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_processor', $self->get_feature_processor() );
  $target->property( 'primary_sequence_factory', $self->get_primary_sequence_factory() );
  $target->property( 'attrs', $self->attrs() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _create_linked_feature
{
  my( $self, $type, $source_feature ) = @_;

  if( !ref( $source_feature ) ) {
    confess( "Called with an undefined source_feature in $self" );
  }

  my $feature = new BioMinerva::DNALib::Feature();

  my $attrs = $self->attrs();
  foreach my $attr( @{ $attrs || [] } ) {
    my $source_attr = $attr;
    my $destination_attr = $attr;
    
    if( $attr =~ /(.+)->(.+)/ ) {
      $source_attr = $1;
      $destination_attr = $2;
    }

    my $value = $source_feature->get_by_key_attr( $source_attr );
    if( defined( $value ) && $value ne '' ) {
      $feature->set_by_key_attr(
        $destination_attr,
        $value
      );
    }
  }
  
  $feature->set_type( $type );

  return $feature;
}

sub _primary_sequence_factory_feature_trim
{
  my( $self, $feature ) = @_;

  my $primary_sequence_factory = $self->get_primary_sequence_factory();
  if( ref( $primary_sequence_factory ) ) {
    my $primary_sequence = $primary_sequence_factory->sequence_id2sequence(
      $feature->get_primary_sequence_id()
    );
    if( !$feature->overlaps( $primary_sequence ) ) { return 0; }
    $feature->trim( $primary_sequence );
    return 1;
  }

  return 1;
}

##########################################################################

1;
