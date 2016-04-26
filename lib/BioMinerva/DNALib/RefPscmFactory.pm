##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::RefPscmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PscmFactory;
@ISA = qw( BioMinerva::DNALib::PscmFactory );

use Carp qw( confess carp croak );

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

###--- <scalar_property id="pscm_factory" get_id='' set_id='' type='BioMinerva::DNALib::PscmFactory'>
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
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm_factory', $self->get_pscm_factory() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;

