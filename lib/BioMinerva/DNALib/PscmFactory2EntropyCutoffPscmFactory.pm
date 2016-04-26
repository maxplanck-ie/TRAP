##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::PscmFactory2EntropyCutoffPscmFactory;

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

###--- <scalar_property id='pscm_factory' get_id='' set_id='' type='BioMinerva::DNALib::PscmFactory'>
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

sub pscms
{
  my( $self ) = @_;

  my $pscm_factory = $self->get_pscm_factory();
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }
  
  my $ref_pscms = $pscm_factory->pscms();
  
  my @pscms;
  foreach my $ref_pscm( @{ $ref_pscms || [] } ) {
    push @pscms, $self->_pscm2entropy_cutoff_pscm( $ref_pscm );
  }

  return \@pscms;
}

sub pscm_id2pscm
{
  my( $self, $pscm_id ) = @_;

  my $pscm_factory = $self->get_pscm_factory();
  if( !ref( $pscm_factory ) ) {
    croak( "Undefined pscm_factory in $self" );
  }

  my $pscm = $pscm_factory->pscm_id2pscm( $pscm_id );
  if( !ref( $pscm ) ) { return undef; }

  return $self->_pscm2entropy_cutoff_pscm( $pscm );
}

##########################################################################

sub _pscm2entropy_cutoff_pscm
{
  my( $self, $pscm ) = @_;

  my $entropy_cutoff_pscm = new BioMinerva::DNALib::Pscm();
  $entropy_cutoff_pscm->set_id( $pscm->get_id() );
  $entropy_cutoff_pscm->matrix(
    $self->_pscm_matrix2entropy_cutoff_pscm_matrix( $pscm->matrix() )
  );

  my %attrs = %{ $pscm->attrs() || {} };
  $entropy_cutoff_pscm->attrs( \%attrs );
  $entropy_cutoff_pscm->add_attr( 'entropy_cutoff', 'applied' );

  return $entropy_cutoff_pscm;
}

sub _pscm_matrix2entropy_cutoff_pscm_matrix
{
  my( $self, $pscm_matrix ) = @_;

  my $max_count = -1;

  for( my $pos = 0; $pos < scalar( @{ $pscm_matrix } ); ++$pos ) {
    foreach my $nucleotide( qw( A C G T ) ) {
      if( $max_count < $pscm_matrix->[ $pos ]->{ $nucleotide } ) {
        $max_count = $pscm_matrix->[ $pos ]->{ $nucleotide };
      }
    }
  }

  my $pos2entropy = [];
  my $pos2row_sum = [];

  for( my $pos = 0; $pos < scalar( @{ $pscm_matrix } ); ++$pos ) {
    my $row_sum = 0;
    foreach my $nucleotide( qw( A C G T ) ) {
      $row_sum += $pscm_matrix->[ $pos ]->{ $nucleotide };
    }
    $pos2row_sum->[ $pos ] = $row_sum;

    my $pseudocount = $max_count / $row_sum;
  
    foreach my $nucleotide( qw( A C G T ) ) {
      my $weight = ( $pscm_matrix->[ $pos ]->{ $nucleotide } + $pseudocount ) / 
        ( $row_sum + 4.0 * $pseudocount );
      my $entropy = $weight * log( $weight * 4.0 ) / log( 2.0 );
      $pos2entropy->[ $pos ] = $entropy;
    }
  }

  my $entropy_cutoff_pscm_matrix = [];

  for( my $pos = 0; $pos < scalar( @{ $pscm_matrix } ); ++$pos ) {
    my $previous_entropy = ( $pos == 0 )
      ? 0.0 
      : $pos2entropy->[ $pos - 1 ];
    my $next_entropy = ( $pos == ( scalar( @{ $pscm_matrix } ) - 1 ) )
      ? 0.0
      : $pos2entropy->[ $pos + 1 ];
    my $entropy = $pos2entropy->[ $pos ];

    if( $previous_entropy < 0.15 && $next_entropy < 0.15 ) {
      if( $entropy < 0.2 ) {
        foreach my $nucleotide( qw( A C G T ) ) {
          $entropy_cutoff_pscm_matrix->[ $pos ]->{ $nucleotide } = 
            $pos2row_sum->[ $pos ] / 4.0;
        }
      } else {
        foreach my $nucleotide( qw( A C G T ) ) {
          $entropy_cutoff_pscm_matrix->[ $pos ]->{ $nucleotide } = 
            $pscm_matrix->[ $pos ]->{ $nucleotide };
        }
#        ++$effective_length;
      }
    } else {
      if( $entropy < 0.1 ) {
        foreach my $nucleotide( qw( A C G T ) ) {
          $entropy_cutoff_pscm_matrix->[ $pos ]->{ $nucleotide } = 
            $pos2row_sum->[ $pos ] / 4.0;
        }
      } else {
        foreach my $nucleotide( qw( A C G T ) ) {
          $entropy_cutoff_pscm_matrix->[ $pos ]->{ $nucleotide } = 
            $pscm_matrix->[ $pos ]->{ $nucleotide };
        }
#        ++$effective_length;
      }
    }
  }

  return $entropy_cutoff_pscm_matrix;
}

##########################################################################

1;

