##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::FeatureIteratorProgressInfo;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::ProgressInfo;
@ISA = qw( BioMinerva::Base::ProgressInfo );

use Carp qw( confess croak carp );

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

###--- <scalar_property id="feature_iterator" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureIterator'>
###---   <auto:comment id="feature_iterator" md5="s1l2kfG0cJcoF8Occz+big">

=head2 feature_iterator

 Title   : feature_iterator property
 
 Usage   : $object->feature_iterator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_iterator" md5="VePVqqYpUaDG7ssbpCnRVQ">

sub feature_iterator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_iterator' } = shift @_;
  }
  return $self->{ 'feature_iterator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_iterator" md5="50r/sbpD6+Uo2q0hHiCbPQ">

sub get_feature_iterator {
  return shift->{ 'feature_iterator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_iterator" md5="J2fkrnbD1aMko3u3RKmYDA">

sub set_feature_iterator {
  my $self = shift @_;
  $self->{ 'feature_iterator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_iterator" md5="Zu5ER5D0wydnjzzdVgsvuw">

sub link_feature_iterator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_iterator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_iterator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureIterator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_iterator', $self->get_feature_iterator() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub get_count
{
  my( $self ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    return undef;
  }

  return $feature_iterator->count();
}

sub get_size
{
  my( $self ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    return undef;
  }

  return $feature_iterator->size();
}

sub progress
{
  my( $self ) = @_;
  
  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    return undef;
  }

  my $progress = $feature_iterator->progress();
  if( defined( $progress ) ) {
    return $progress;
  }

  return $self->SUPER::progress();
}

##########################################################################

1;
