##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PssmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess carp croak );
use BioMinerva::DNALib::Pspm;
use BioMinerva::DNALib::Pssm;

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

###--- <array_property id="pssm_id" add_id="_add_pssm_id" ids="pssm_ids">
###---   <auto:comment id="pssm_ids" md5="gtJzLEsA71BIZpD6dQoHmQ">

=head2 pssm_ids

 Title   : pssm_ids (array property)
 
 Usage   : C<<< my $pssm_ids = $object->pssm_ids();
           if( defined( $pssm_ids ) ) { 
             foreach my $pssm_id( @{ $pssm_ids } ) {
               ...
             }
           } >>>
           
           C<<< $object->pssm_ids( $pssm_ids ); >>>
 
           C<<< $object->pssm_ids( undef ); >>>

 Function: Accessor to the array property C<pssm_ids>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of pssm_ids to be set
           clear-accessor: undef

 Return  : reference to the current array of pssm_ids or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="pssm_ids" md5="ZmE9D6F9ALiQ2oJSwZIT8A">

sub pssm_ids {
  my $self = shift @_;
  if( @_ ) {
    my $pssm_ids = shift @_;
    if( defined( $pssm_ids ) && ref( $pssm_ids ) ne 'ARRAY' ) {
      confess( "Property 'pssm_ids' requires an ARRAY argument (now: $pssm_ids)." );
    }
    $self->{ 'pssm_ids' } = $pssm_ids;
  }
  return $self->{ 'pssm_ids' };
}

###---   </auto:code>
###---   <auto:comment id="_add_pssm_id" md5="pSCQqaQTixbnZA39eH57kg">

=head2 _add_pssm_id

 Title   : _add_pssm_id (pssm_ids property)
 
 Usage   : C<<< $object->_add_pssm_id( $pssm_id, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< pssm_ids >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_pssm_id" md5="0jprmN8CpgLzrQXRVYcwBA">

sub _add_pssm_id {
  my $self = shift @_;
  my @pssm_ids = @_;
  $self->{ 'pssm_ids' } ||= [];
  push @{ $self->{ 'pssm_ids' } }, @pssm_ids;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <scalar_property id="pssm_id_regexp">
###---   <auto:comment id="pssm_id_regexp" md5="pqkdhLbauzDndKdM8yNv2Q">

=head2 pssm_id_regexp

 Title   : pssm_id_regexp property
 
 Usage   : $object->pssm_id_regexp(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pssm_id_regexp" md5="RvjXn1r8UdpqEZMmUVMWZQ">

sub pssm_id_regexp {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pssm_id_regexp' } = shift @_;
  }
  return $self->{ 'pssm_id_regexp' };
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='gc' get_id='' set_id=''>
###---   <auto:comment id="gc" md5="xMvLmfQMavEOSVh0ou0Q5A">

=head2 gc

 Title   : gc property
 
 Usage   : $object->gc(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gc" md5="Gt4H2jnZX/pl9vAkXRBAmA">

sub gc {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gc' } = shift @_;
  }
  return $self->{ 'gc' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gc" md5="xlYgkdPXrvv77uxpYwBeqw">

sub get_gc {
  return shift->{ 'gc' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gc" md5="rVQsVklK1F862pOdhvCZdg">

sub set_gc {
  my $self = shift @_;
  $self->{ 'gc' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub add_pssm_id
{
  my( $self, $pssm_id_str ) = @_;

  my @pssm_ids = split( /[,: ]+/, $pssm_id_str );
  $self->_add_pssm_id( @pssm_ids );
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pssm_ids', $self->pssm_ids() );
  $target->property( 'pssm_id_regexp', $self->pssm_id_regexp() );
  $target->property( 'gc', $self->get_gc() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

# PscmFactory
# RefPscmFactory
# FilterRefPscmFactory
# ShuffleRefPscmFactory
# PssmFactory
# PscmFactory2PssmFactory

sub pssms
{
  my( $self ) = @_;

  confess( "Property code not overridden." );
}

sub pssm_id2pssm
{
  my( $self, $pssm_id ) = @_;

  my $pssms = $self->pssms();
  foreach my $pssm( @{ $pssms || [] } ) {
    if( $pssm->id() eq $pssm_id ) {
      return $pssm;
    }
  }
  return undef;
}

sub pscm2pspm
{
  my( $self, $pscm ) = @_;

  my $precision = 0.0001;
  my $cutoff = 1.5;
  
  my $pspm = new BioMinerva::DNALib::Pspm();
  $pspm->pscm( $pscm );
  $pspm->set_id( $pscm->get_id() );
  $pspm->matrix(
    $pscm->pspm_matrix( 
      $pscm->nucleotide_allpos_prob_dist(), #TODO: magic add!
      $precision,
      $cutoff
    )
  );
  my %attrs = %{ $pscm->attrs() || {} };
  $pspm->attrs( \%attrs );
#  $pspm->add_attr( 'pspm_precision', $precision );
#  $pspm->add_attr( 'pspm_cutoff', $cutoff );
 
  return $pspm;
}

sub pspm2pssm
{
  my( $self, $pspm ) = @_;

  my $gc = $self->get_gc();
  if( !defined( $gc ) ) {
    croak( "Undefined gc in $self" );
  }
  
  my $bg_prob_vec = $self->_bg_prob_vec( $gc );
  
  my $pssm = new BioMinerva::DNALib::Pssm();
  $pssm->pspm( $pspm );
  $pssm->set_id( $pspm->get_id() );
  $pssm->set_gc( $gc );
  $pssm->set_bg_prob_vec( $bg_prob_vec );
  $pssm->matrix( 
    $pspm->pssm_matrix( $bg_prob_vec ) 
  );
  my %attrs = %{ $pspm->attrs() || {} };
  $pssm->attrs( \%attrs );
  $pssm->add_attr( 'gc', $gc );
 
  return $pssm;
}

sub pscm2pssm
{
  my( $self, $pscm ) = @_;

  my $pspm = $self->pscm2pspm( $pscm );
  my $pssm = $self->pspm2pssm( $pspm );
  return $pssm;
}

##########################################################################

sub _check_pssm
{
  my( $self, $pssm ) = @_;
  
  my $pssm_id_regexp = $self->pssm_id_regexp();
  my @pssm_ids = @{ $self->pssm_ids() || [] };
  
  my $add = 0;
  
  if( defined( $pssm_id_regexp ) ) {
    if( $pssm->get_id() =~ /$pssm_id_regexp/ )
      { $add = 1; }
  } elsif( @pssm_ids ) {
    foreach my $pssm_id( @pssm_ids ) {
      if( $pssm->get_id() eq $pssm_id )
        { $add = 1; }
    }
  } else {
    $add = 1;
  }

  return $add;
}

sub _bg_prob_vec {
  my( $self, $gc ) = @_;

  my $bg_prob_vec = {
    'A' => ( 1.0 - $gc ) / 2, 
    'C' => $gc / 2, 
    'G' => $gc / 2,
    'T' => ( 1.0 - $gc ) / 2
  };

  return $bg_prob_vec;
}

##########################################################################

1;

