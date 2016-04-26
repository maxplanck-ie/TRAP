##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::TRegDBPssmFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::PssmFactory;
@ISA = qw( BioMinerva::DNALib::PssmFactory );

##########################################################################

use BioMinerva::DNALib::Pscm;
use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub create
{
  return new BioMinerva::DNALib::TRegDBPssmFactory();
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id="db_adaptor" get_id="" set_id="" link_id="" type="BioMinerva::Base::DBAdaptor">
###---   <auto:comment id="db_adaptor" md5="cyblf8v1jEFnxludDGvYlQ">

=head2 db_adaptor

 Title   : db_adaptor property
 
 Usage   : $object->db_adaptor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="db_adaptor" md5="PcmAP1yBs1mYdL32aq508A">

sub db_adaptor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'db_adaptor' } = shift @_;
  }
  return $self->{ 'db_adaptor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_db_adaptor" md5="MNUbjF97+SVbIVZeP6q/LA">

sub get_db_adaptor {
  return shift->{ 'db_adaptor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_db_adaptor" md5="Ku8aosU3t45zc7tDB0RAgA">

sub set_db_adaptor {
  my $self = shift @_;
  $self->{ 'db_adaptor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_db_adaptor" md5="7MiyUMuCyKZTXN1H5SqzRQ">

sub link_db_adaptor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'db_adaptor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'db_adaptor' } =
      $registry->type_id2object(
        'BioMinerva::Base::DBAdaptor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id="pssm" ids="_pssms" add_id="_add_pssm" type="BioMinerva::DNALib::Pssm">
###---   <auto:comment id="_pssms" md5="HHYRe4C/oObIPY8LQoVqzA">

=head2 _pssms

 Title   : _pssms (array property)
 
 Usage   : C<<< my $_pssms = $object->_pssms();
           if( defined( $_pssms ) ) { 
             foreach my $pssm( @{ $_pssms } ) {
               ...
             }
           } >>>
           
           C<<< $object->_pssms( $_pssms ); >>>
 
           C<<< $object->_pssms( undef ); >>>

 Function: Accessor to the array property C<_pssms>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of _pssms to be set
           clear-accessor: undef

 Return  : reference to the current array of _pssms or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="_pssms" md5="8Pby4zsTeza65tf5WuaErQ">

sub _pssms {
  my $self = shift @_;
  if( @_ ) {
    my $_pssms = shift @_;
    if( defined( $_pssms ) && ref( $_pssms ) ne 'ARRAY' ) {
      confess( "Property '_pssms' requires an ARRAY argument (now: $_pssms)." );
    }
    $self->{ '_pssms' } = $_pssms;
  }
  return $self->{ '_pssms' };
}

###---   </auto:code>
###---   <auto:comment id="_add_pssm" md5="GIly677AsOASulWHDbWZtw">

=head2 _add_pssm

 Title   : _add_pssm (_pssms property)
 
 Usage   : C<<< $object->_add_pssm( $pssm, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< _pssms >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="_add_pssm" md5="4OeIWNsMbAjWFVsXSHmQEA">

sub _add_pssm {
  my $self = shift @_;
  my @_pssms = @_;
  $self->{ '_pssms' } ||= [];
  push @{ $self->{ '_pssms' } }, @_pssms;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <scalar_property id='_db_processed' get_id='' set_id=''>
###---   <auto:comment id="_db_processed" md5="UlYMERf2bsgZiMk1vLAXoA">

=head2 _db_processed

 Title   : _db_processed property
 
 Usage   : $object->_db_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_db_processed" md5="PzhD+ZeRxKJ6+1nSc+zbow">

sub _db_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_db_processed' } = shift @_;
  }
  return $self->{ '_db_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_db_processed" md5="SfJd4RxlBKeqMNeOCmoNXw">

sub _get_db_processed {
  return shift->{ '_db_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_db_processed" md5="QQ79Y+yPgYbmEN37Urs7qQ">

sub _set_db_processed {
  my $self = shift @_;
  $self->{ '_db_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'db_adaptor', $self->db_adaptor() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
  $target->property( 'db_adaptor' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
  if( $property eq 'db_adaptor' ) { $self->db_adaptor( @values ); }
  else { $self->SUPER::set_conf_property( $property, @values ); }
}

sub link_references
{
  my( $self, $registry ) = @_;

  $self->SUPER::link_references( $registry );
  $self->link_db_adaptor( $registry );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub pssms
{
  my( $self, @args ) = @_;
  $self->_process_pssms();
  return $self->_pssms();
}

##########################################################################

sub _process_pssms
{
  my( $self ) = @_;
  
  if( $self->_get_db_processed() ) { return; }
    
  my @pscms = @{ $self->_db2pscms() || [] };
  
  foreach my $pscm( @pscms ) {
    my $pssm = $self->pscm2pssm( $pscm );
    if( $self->_check_pssm( $pssm ) ) {
      $self->_add_pssm( $pssm );
    }
  }

  $self->_set_db_processed( 1 );
}  

sub _db2pscms
{
  my( $self ) = @_;

  my $db_adaptor = $self->get_db_adaptor();
  if( !ref( $db_adaptor ) ) {
    croak( "No db_adaptor in $self" );
  }

  my $db_handle = $self->db_adaptor->db_handle();

  # ----- retrieving ids from the database -----
  my @pssm_ids;
  
  {
    my $sql = "
      select id
      from binding_spec 
      where upper(type) = 'PFM';
    ";
    
    my $query = $db_handle->prepare( $sql );
    $query->execute();
    
    while( my $row = $query->fetchrow_hashref() ) {
      push @pssm_ids, $row->{ 'id' };
    }
    
    $query->finish();
  }
  
  # ----- retrieving matrices from the database -----
  my @pscms;
  
  foreach my $pssm_id( @pssm_ids ) {
    my @matrix;

    {
      my $sql = "
        select pos, a_count, c_count, g_count, t_count 
        from pwm
        where binding_spec_id = ?
        order by pos;
      ";
      
      my $query = $db_handle->prepare( $sql );
      $query->execute( $pssm_id );

      my $min_pos = undef;
      while( my $row = $query->fetchrow_hashref() ) {
        my $pos = $row->{ 'pos' };
        if( !defined( $min_pos ) ) { $min_pos = $pos; }
        $pos -= $min_pos; #not unified offset in the database
        $matrix[ $pos ] = {};
        $matrix[ $pos ]->{ 'A' } = $row->{ 'a_count' };
        $matrix[ $pos ]->{ 'C' } = $row->{ 'c_count' };
        $matrix[ $pos ]->{ 'G' } = $row->{ 'g_count' };
        $matrix[ $pos ]->{ 'T' } = $row->{ 't_count' };
      }
      $query->finish();
    }

    my $pscm = new BioMinerva::DNALib::Pscm();
    $pscm->id( $pssm_id );
    $pscm->matrix( \@matrix );

    push @pscms, $pscm;
  }
  
  return \@pscms;
}

##########################################################################

1;

