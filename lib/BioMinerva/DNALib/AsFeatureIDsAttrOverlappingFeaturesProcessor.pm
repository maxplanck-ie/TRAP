##########################################################################

package BioMinerva::DNALib::AsFeatureIDsAttrOverlappingFeaturesProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::OverlappingFeaturesProcessor;
@ISA = qw( BioMinerva::DNALib::OverlappingFeaturesProcessor );

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
  return new BioMinerva::DNALib::AsFeatureIDsAttrOverlappingFeaturesProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="feature_processor" get_id='' set_id='' link_id='' type="BioMinerva::DNALib::FeatureProcessor">
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

###--- <scalar_property id='feature_ids_attr' get_id='' set_id=''>
###---   <auto:comment id="feature_ids_attr" md5="JLtCUZCCLo3gMB7lMpnzfA">

=head2 feature_ids_attr

 Title   : feature_ids_attr property
 
 Usage   : $object->feature_ids_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_ids_attr" md5="eCUmUAVx+U6j82hKVpO0kg">

sub feature_ids_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_ids_attr' } = shift @_;
  }
  return $self->{ 'feature_ids_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_ids_attr" md5="EpIsBUx19xFvBe6y4QAUNw">

sub get_feature_ids_attr {
  return shift->{ 'feature_ids_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_ids_attr" md5="rcJqU13yKEoYMD7s0co5Fg">

sub set_feature_ids_attr {
  my $self = shift @_;
  $self->{ 'feature_ids_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='coverage_length_attr' get_id='' set_id=''>
###---   <auto:comment id="coverage_length_attr" md5="7Hgbbv3qvnLlzbxMxTwVjw">

=head2 coverage_length_attr

 Title   : coverage_length_attr property
 
 Usage   : $object->coverage_length_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="coverage_length_attr" md5="KUk5mXuCuFrHy+bT5WShxg">

sub coverage_length_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'coverage_length_attr' } = shift @_;
  }
  return $self->{ 'coverage_length_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_coverage_length_attr" md5="BmZ+Hp8ZHR+6N4jELq1/0g">

sub get_coverage_length_attr {
  return shift->{ 'coverage_length_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_coverage_length_attr" md5="MpwTrj0cm2w2y9emKCRrpg">

sub set_coverage_length_attr {
  my $self = shift @_;
  $self->{ 'coverage_length_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='coverage_ratio_attr' get_id='' set_id=''>
###---   <auto:comment id="coverage_ratio_attr" md5="EdVI0el3hSs3f/zv1530jg">

=head2 coverage_ratio_attr

 Title   : coverage_ratio_attr property
 
 Usage   : $object->coverage_ratio_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="coverage_ratio_attr" md5="cJD59LZbt8qjfGPMkfHUmw">

sub coverage_ratio_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'coverage_ratio_attr' } = shift @_;
  }
  return $self->{ 'coverage_ratio_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_coverage_ratio_attr" md5="SccoABlm1B/sFslHoAUefA">

sub get_coverage_ratio_attr {
  return shift->{ 'coverage_ratio_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_coverage_ratio_attr" md5="ZCX0I5uZncNDuW+FkPQ2dA">

sub set_coverage_ratio_attr {
  my $self = shift @_;
  $self->{ 'coverage_ratio_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_processor', $self->get_feature_processor() );
  $target->property( 'feature_ids_attr', $self->get_feature_ids_attr() );
  $target->property( 'coverage_length_attr', $self->get_coverage_length_attr() );
  $target->property( 'coverage_ratio_attr', $self->get_coverage_ratio_attr() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "No feature_processor in $self" );
  }

  my $feature_ids_attr = $self->get_feature_ids_attr();
  if( defined( $feature_ids_attr ) ) {
    foreach my $feature( @{ $features || [] } ) {
      $mask_feature->add_attr(
        $feature_ids_attr,
        $feature->get_id()
      );
    }
  }

  my $coverage_length_attr = $self->get_coverage_length_attr();
  my $coverage_ratio_attr = $self->get_coverage_ratio_attr();
  
  if( defined( $coverage_length_attr ) || defined( $coverage_ratio_attr ) ) {
    my $coverage_length = $mask_feature->subsequences_covered_length(
      $features
    );
    if( defined( $coverage_length_attr ) ) {
      $mask_feature->add_attr( $coverage_length_attr, $coverage_length );
    }
    if( defined( $coverage_ratio_attr ) ) {
      $mask_feature->add_attr( $coverage_ratio_attr,
        $mask_feature->length()
          ? sprintf( "%6.4g", $coverage_length / $mask_feature->length() )
          : "NAN"
      );
    }
  }

  $feature_processor->process_feature( $mask_feature );
}

##########################################################################

1;
