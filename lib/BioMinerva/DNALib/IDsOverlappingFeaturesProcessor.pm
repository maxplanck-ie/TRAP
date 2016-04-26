##########################################################################

package BioMinerva::DNALib::IDsOverlappingFeaturesProcessor;

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
  return new BioMinerva::DNALib::IDsOverlappingFeaturesProcessor();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="string_processor" get_id='' set_id='' link_id='' type="BioMinerva::Base::StringProcessor">
###---   <auto:comment id="string_processor" md5="Mzglrjukc+I1ce1OFWLEmA">

=head2 string_processor

 Title   : string_processor property
 
 Usage   : $object->string_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="string_processor" md5="ufWxXv2kho9BkxZvNCOnyA">

sub string_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'string_processor' } = shift @_;
  }
  return $self->{ 'string_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_string_processor" md5="Pu1KKRVyUx1dRudiFyvB1w">

sub get_string_processor {
  return shift->{ 'string_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_string_processor" md5="LxsRIP9evTR7Vo1wD4Y7FQ">

sub set_string_processor {
  my $self = shift @_;
  $self->{ 'string_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_string_processor" md5="QYx0d7/IqHDHg72DoLZmEw">

sub link_string_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'string_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'string_processor' } =
      $registry->type_id2object(
        'BioMinerva::Base::StringProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'string_processor', $self->string_processor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'string_processor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'string_processor' ) { $self->string_processor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_string_processor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_overlapping_features
{
  my( $self, $mask_feature, $features ) = @_;
  
  my $string_processor = $self->get_string_processor();
  if( !ref( $string_processor ) ) {
    croak( "No string_processor in $self" );
  }

  my @feature_ids = map { $_->get_id() } @{ $features || [] };
  
  my $string =
    $mask_feature->get_id()
    . "\t"
    . join( ',', @feature_ids );
    
  $string_processor->process_string( $string );
}

##########################################################################

1;
