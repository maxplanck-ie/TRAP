##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PscmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess carp croak );
use BioMinerva::DNALib::Pscm;

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

###--- <array_property id="pscm_id" add_id="_add_pscm_id" ids="pscm_ids">
###---   <auto:comment id="pscm_ids" md5="naoiBhBqLfE9Gs7jBlaCCA">

=head2 pscm_ids

 Title   : pscm_ids (array property)
 
 Usage   : C<<< my $pscm_ids = $object->pscm_ids();
           if( defined( $pscm_ids ) ) { 
             foreach my $pscm_id( @{ $pscm_ids } ) {
               ...
             }
           } >>>
           
           C<<< $object->pscm_ids( $pscm_ids ); >>>
 
           C<<< $object->pscm_ids( undef ); >>>

 Function: Accessor to the array property C<pscm_ids>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of pscm_ids to be set
           clear-accessor: undef

 Return  : reference to the current array of pscm_ids or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="pscm_ids" md5="JbR3PzYQAo2l49bvtT9Eow">

sub pscm_ids {
  my $self = shift @_;
  if( @_ ) {
    my $pscm_ids = shift @_;
    if( defined( $pscm_ids ) && ref( $pscm_ids ) ne 'ARRAY' ) {
      confess( "Property 'pscm_ids' requires an ARRAY argument (now: $pscm_ids)." );
    }
    $self->{ 'pscm_ids' } = $pscm_ids;
  }
  return $self->{ 'pscm_ids' };
}

###---   </auto:code>
###---   <auto:comment id="_add_pscm_id" md5="7BrDE00loVibLbSnMDsSpw">

=head2 _add_pscm_id

 Title   : _add_pscm_id (pscm_ids property)
 
 Usage   : C<<< $object->_add_pscm_id( $pscm_id, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< pscm_ids >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_pscm_id" md5="7K+Alp/bo43ag5CEipyyJw">

sub _add_pscm_id {
  my $self = shift @_;
  my @pscm_ids = @_;
  $self->{ 'pscm_ids' } ||= [];
  push @{ $self->{ 'pscm_ids' } }, @pscm_ids;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <scalar_property id="pscm_id_regexp">
###---   <auto:comment id="pscm_id_regexp" md5="1oJ+FCMq5ocGnnbzv/So2A">

=head2 pscm_id_regexp

 Title   : pscm_id_regexp property
 
 Usage   : $object->pscm_id_regexp(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="pscm_id_regexp" md5="hvKjJjuHf4bfSY4LDZ8Mzw">

sub pscm_id_regexp {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'pscm_id_regexp' } = shift @_;
  }
  return $self->{ 'pscm_id_regexp' };
}

###---   </auto:code>
###--- </scalar_property>

sub add_pscm_id
{
  my( $self, $pscm_id_str ) = @_;

  my @pscm_ids = split( /[,: ]+/, $pscm_id_str );
  $self->_add_pscm_id( @pscm_ids );
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'pscm_ids', $self->pscm_ids() );
  $target->property( 'pscm_id_regexp', $self->pscm_id_regexp() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pscms
{
  my( $self ) = @_;

  confess( "Property code not overridden." );
}

sub pscm_id2pscm
{
  my( $self, $pscm_id ) = @_;

  my $pscms = $self->pscms();
  foreach my $pscm( @{ $pscms || [] } ) {
    if( $pscm->id() eq $pscm_id ) {
      return $pscm;
    }
  }
  return undef;
}

##########################################################################

sub _check_pscm
{
  my( $self, $pscm ) = @_;
  
  my $pscm_id_regexp = $self->pscm_id_regexp();
  my @pscm_ids = @{ $self->pscm_ids() || [] };
  
  my $add = 0;
  
  if( defined( $pscm_id_regexp ) ) {
    carp( "Use IdFilteredRefPscmFactory instead of pscm_id_regexp" );
    if( $pscm->id() =~ /$pscm_id_regexp/ )
      { $add = 1; }
  } elsif( @pscm_ids ) {
    carp( "Use IdFilteredRefPscmFactory instead of pscm_ids" );
    foreach my $pscm_id( @pscm_ids ) {
      if( $pscm->id() eq $pscm_id )
        { $add = 1; }
    }
  } else {
    $add = 1;
  }

  return $add;
}

##########################################################################

1;

