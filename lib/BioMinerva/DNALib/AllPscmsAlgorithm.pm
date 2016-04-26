##########################################################################

package BioMinerva::DNALib::AllPscmsAlgorithm;

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

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="pscm_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::PscmFactory'>
###---   <auto:comment id="pscm_factory" md5="eyMNJtNWrZ6cTfZI/AyGxg">

=head2 pscm_factory

 Title   : pscm_factory property
 
 Usage   : $object->pscm_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pscm_factory" md5="Cwh8NCoaZKYRUM+KT49zRw">

sub pscm_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pscm_factory' } = shift @_;
  }
  return $self->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_pscm_factory" md5="2njW0KLi9cGbCsEKY4+cXA">

sub get_pscm_factory {
  return shift->{ 'pscm_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_pscm_factory" md5="Jh/KXKRV9iiZIJ/iSKAxnA">

sub set_pscm_factory {
  my $self = shift @_;
  $self->{ 'pscm_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_pscm_factory" md5="j30XX4NdakVzRw/WhuvSDg">

sub link_pscm_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'pscm_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'pscm_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::PscmFactory', $ref
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

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm_factory', $self->get_pscm_factory() );
  $target->property( 'psm_processor', $self->get_psm_processor() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $pscm_factory = $self->get_pscm_factory();
  my $psm_processor = $self->get_psm_processor();
  
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }

  if( !ref( $psm_processor ) ) {
    croak( "Undefined psm_processor in $self" );
  }

  foreach my $pscm( @{ $pscm_factory->pscms() || [] } ) {
    $psm_processor->process_psm( $pscm );
  }
}

##########################################################################

1;
