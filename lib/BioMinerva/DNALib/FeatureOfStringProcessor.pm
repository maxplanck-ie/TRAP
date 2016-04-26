##########################################################################

package BioMinerva::DNALib::FeatureOfStringProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::StringProcessor;
@ISA = qw( BioMinerva::Base::StringProcessor );

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
  return new BioMinerva::DNALib::FeatureOfStringProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_factory' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureFactory'>
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

###--- <scalar_property id="ignore_missing_features" get_id='' set_id=''>
###---   <auto:comment id="ignore_missing_features" md5="uSfYO9oYZxAZm+5MpyRNZQ">

=head2 ignore_missing_features

 Title   : ignore_missing_features property
 
 Usage   : $object->ignore_missing_features(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ignore_missing_features" md5="iR091ATOygoxG8NTq4gmlw">

sub ignore_missing_features {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ignore_missing_features' } = shift @_;
  }
  return $self->{ 'ignore_missing_features' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ignore_missing_features" md5="r2RHE854ADYL9aYefM7m6Q">

sub get_ignore_missing_features {
  return shift->{ 'ignore_missing_features' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ignore_missing_features" md5="6ohfYtR/u84OedTlzu9MYg">

sub set_ignore_missing_features {
  my $self = shift @_;
  $self->{ 'ignore_missing_features' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_factory', $self->get_feature_factory() );
  $target->property( 'feature_processor', $self->get_feature_processor() );
  $target->property( 'ignore_missing_features', $self->get_ignore_missing_features() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_string
{
  my( $self, $string ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    carp( "Undefined feature_factory in $self" );
  }
  
  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    carp( "Undefined feature_processor in $self" );
  }
  
  my $feature = $feature_factory->feature_id2feature( $string );
  if( !ref( $feature ) ) {
    if( $self->get_ignore_missing_features() ) {
      return;
    } else {
      carp( "Don't know how to map a string '$string' to a feature in $self" );
    }
  }

  $feature_processor->process_feature( $feature );
}

##########################################################################

1;
