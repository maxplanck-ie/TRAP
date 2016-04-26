##########################################################################

package BioMinerva::DNALib::AllPssmsAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

use Carp qw( confess croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create {
  return new BioMinerva::DNALib::AllPssmsAlgorithm();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pssm_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PssmFactory'>
###---   <auto:comment id="pssm_factory" md5="awwO6csVHX/Nl5YmALt/CQ">

=head2 pssm_factory

 Title   : pssm_factory property
 
 Usage   : $object->pssm_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_factory" md5="T104AFB28a2j+ZEoIfsh4g">

sub pssm_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_factory' } = shift @_;
  }
  return $self->{ 'pssm_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm_factory" md5="Tgn2lJkJ6Lw8ORDx/yegTQ">

sub get_pssm_factory {
  return shift->{ 'pssm_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm_factory" md5="aJGXuKNb6WRdG/Eb0RituA">

sub set_pssm_factory {
  my $self = shift @_;
  $self->{ 'pssm_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pssm_factory" md5="/rbQr9V+BN68aLi1nARm6g">

sub link_pssm_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pssm_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pssm_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PssmFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="psm_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PsmProcessor'>
###---   <auto:comment id="psm_processor" md5="kEVRFBOs7PcIloeRTPtVog">

=head2 psm_processor

 Title   : psm_processor property
 
 Usage   : $object->psm_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="psm_processor" md5="crgPlcX67WPOOqrjGhnCmQ">

sub psm_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'psm_processor' } = shift @_;
  }
  return $self->{ 'psm_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_psm_processor" md5="Fc2Y9KwmykVh1+/ob2YIqg">

sub get_psm_processor {
  return shift->{ 'psm_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_psm_processor" md5="xAc9NIL4+HJEHmwisHP0nA">

sub set_psm_processor {
  my $self = shift @_;
  $self->{ 'psm_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_psm_processor" md5="2FtQFG2IQWprlOnFwr+zVQ">

sub link_psm_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'psm_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'psm_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PsmProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="pssm_score_dist_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PssmScoreDistFactory'>
###---   <auto:comment id="pssm_score_dist_factory" md5="276vBpGLOIbOfPAdXEjbmQ">

=head2 pssm_score_dist_factory

 Title   : pssm_score_dist_factory property
 
 Usage   : $object->pssm_score_dist_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_score_dist_factory" md5="bboTX/MjbN2fJjhqtyLn3Q">

sub pssm_score_dist_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_score_dist_factory' } = shift @_;
  }
  return $self->{ 'pssm_score_dist_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pssm_score_dist_factory" md5="NL6K7pBaXGqPQ7Jxcgi9Tw">

sub get_pssm_score_dist_factory {
  return shift->{ 'pssm_score_dist_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pssm_score_dist_factory" md5="cbylCTyTlufj+8/woJuMKA">

sub set_pssm_score_dist_factory {
  my $self = shift @_;
  $self->{ 'pssm_score_dist_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pssm_score_dist_factory" md5="Xk3DRa7iPBivlfxf0TD0jg">

sub link_pssm_score_dist_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pssm_score_dist_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pssm_score_dist_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PssmScoreDistFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pssm_factory', $self->pssm_factory() );
  $target->property( 'psm_processor', $self->psm_processor() );
  $target->property( 'pssm_score_dist_factory', $self->pssm_score_dist_factory() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'pssm_factory' );
  $target->property( 'psm_processor' );
  $target->property( 'pssm_score_dist_factory' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'pssm_factory' ) { $self->pssm_factory( @values ); }
  elsif( $property eq 'psm_processor' ) { $self->psm_processor( @values ); }
  elsif( $property eq 'pssm_score_dist_factory' ) { $self->pssm_score_dist_factory( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_pssm_factory( $registry );
  $self->link_psm_processor( $registry );
  $self->link_pssm_score_dist_factory( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $pssm_factory = $self->get_pssm_factory();
  my $psm_processor = $self->get_psm_processor();
  my $pssm_score_dist_factory = $self->get_pssm_score_dist_factory();
  
  if( !ref( $pssm_factory ) ) {
    croak( "Undefined pssm_factory in $self" );
  }

  if( !ref( $psm_processor ) ) {
    croak( "Undefined psm_processor in $self" );
  }

  foreach my $pssm( @{ $pssm_factory->pssms() || [] } ) {
    if( ref( $pssm_score_dist_factory ) ) {
      my $cutoff = $pssm_score_dist_factory->cutoff( $pssm, $pssm->get_pspm() );
      $pssm->add_attr( 'cutoff', $cutoff );
      $pssm->add_attr( 'cutoff_name', $pssm_score_dist_factory->get_cutoff_name() );
    }
    
    $psm_processor->process_psm( $pssm );
  }
}

##########################################################################

1;
