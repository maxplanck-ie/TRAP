##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::Feature;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::Sequence;
@ISA = qw( BioMinerva::DNALib::Sequence );

use Carp qw( confess );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone {
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::Feature();
  }
  $self->SUPER::clone( $clone );

  $clone->set_index( $self->get_index() );
  $clone->set_score( $self->get_score() );

  my $part_features = $self->part_features();
  foreach my $part_feature( @{ $part_features } ) {
    $clone->add_part_feature( $part_feature->clone() );
  }

  return $clone;
}

sub clone_without_part_features {
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::Feature();
  }
  $self->SUPER::clone( $clone );
  
  $clone->set_index( $self->get_index() );
  $clone->set_score( $self->get_score() );

  return $clone;
}

sub feature {
  my( $self ) = @_;
  
  my $feature = new BioMinerva::DNALib::Feature();

  $feature->set_sequence( $self );

  $feature->set_index( $self->get_index() );
  $feature->set_score( $self->get_score() );

  my $part_features = $self->part_features();
  foreach my $part_feature( @{ $part_features } ) {
    $feature->add_part_feature( $part_feature->feature() );
  }

  return $feature;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='index' get_id='' set_id=''>
###---   <auto:comment id="index" md5="aMJMKGFZg4HDWb8/1cfHiA">

=head2 index

 Title   : index property
 
 Usage   : $object->index(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="index" md5="7BAnGPK4NgFDGMFKVWXqTg">

sub index {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'index' } = shift @_;
  }
  return $self->{ 'index' };
}

###---   </auto:code>
###---   <auto:code get_id="get_index" md5="7Lq+jJug+kSPckjiQV6D2A">

sub get_index {
  return shift->{ 'index' };
}

###---   </auto:code>
###---   <auto:code set_id="set_index" md5="uBZWh3Xod+gC3juCQuhrzg">

sub set_index {
  my $self = shift @_;
  $self->{ 'index' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='score' get_id='' set_id=''>
###---   <auto:comment id="score" md5="exAYSJKyOxD3I73XTtAFSw">

=head2 score

 Title   : score property
 
 Usage   : $object->score(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="score" md5="HCG1sDgbdQCrNIeKS4B29Q">

sub score {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'score' } = shift @_;
  }
  return $self->{ 'score' };
}

###---   </auto:code>
###---   <auto:code get_id="get_score" md5="APdYZo5eMFi/rdwrLQuhYw">

sub get_score {
  return shift->{ 'score' };
}

###---   </auto:code>
###---   <auto:code set_id="set_score" md5="Rnc+CeD/TTvz8K20COQOXw">

sub set_score {
  my $self = shift @_;
  $self->{ 'score' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id="part_feature" ids="part_features" add_id="add_part_feature">
###---   <auto:comment id="part_features" md5="+dxrHpC/MC7f3UEnjLe+AQ">

=head2 part_features

 Title   : part_features (array property)
 
 Usage   : C<<< my $part_features = $object->part_features();
           if( defined( $part_features ) ) { 
             foreach my $part_feature( @{ $part_features } ) {
               ...
             }
           } >>>
           
           C<<< $object->part_features( $part_features ); >>>
 
           C<<< $object->part_features( undef ); >>>

 Function: Accessor to the array property C<part_features>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of part_features to be set
           clear-accessor: undef

 Return  : reference to the current array of part_features or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="part_features" md5="5zT5odTOsZRI13bxQPPMag">

sub part_features {
  my $self = shift @_;
  if( @_ ) {
    my $part_features = shift @_;
    if( defined( $part_features ) && ref( $part_features ) ne 'ARRAY' ) {
      confess( "Property 'part_features' requires an ARRAY argument (now: $part_features)." );
    }
    $self->{ 'part_features' } = $part_features;
  }
  return $self->{ 'part_features' };
}

###---   </auto:code>
###---   <auto:comment id="add_part_feature" md5="1AJ5oR4YgEetcR+jf3AWEA">

=head2 add_part_feature

 Title   : add_part_feature (part_features property)
 
 Usage   : C<<< $object->add_part_feature( $part_feature, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< part_features >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_part_feature" md5="nQx1xyUns15zkAJ5w2KJ8w">

sub add_part_feature {
  my $self = shift @_;
  my @part_features = @_;
  $self->{ 'part_features' } ||= [];
  push @{ $self->{ 'part_features' } }, @part_features;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();

  $digest->add( $self->get_index() || '' );
  $digest->add( $self->get_score() || '' );
  
  return $digest;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'index', $self->get_index() );
  $target->property( 'score', $self->get_score() );
  $target->property( 'part_features', $self->part_features() );
}

sub set_feature
{
  my $self = shift @_;

  carp( "This function will become obsolete..." );

  $self->set_id( shift @_ );
  $self->set_primary_sequence_id( shift @_ );
  $self->set_start( shift @_ );
  $self->set_end( shift @_ );
  $self->set_strand( shift @_ );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub get_by_key_attr
{
  my( $self, $key ) = @_;

  if( $key eq 'index' ) { return $self->get_index(); }
  elsif( $key eq 'score' ) { return $self->get_score(); }
  else { return $self->SUPER::get_by_key_attr( $key ); }
}

sub set_by_key_attr
{
  my( $self, $key, $value ) = @_;

  if( $key eq 'index' ) { $self->set_index( $value ); }
  elsif( $key eq 'score' ) { $self->set_score( $value ); }
  else { return $self->SUPER::set_by_key_attr( $key, $value ); }
}

##########################################################################

1;
