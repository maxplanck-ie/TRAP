##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SortedFeatureIterator;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureIterator;
@ISA = qw( BioMinerva::DNALib::FeatureIterator );

use Carp qw( confess carp croak );

##########################################################################
# CONSTRUCTION
##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;
  return $class->SUPER::new();
}

sub clone
{
  my( $self, $clone ) = @_;
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::SortedFeatureIterator();
  }

  $self->SUPER::clone( $clone );
  
  $clone->set_feature_comparator(
    $self->get_feature_comparator()
  );

  return $clone;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='feature_comparator' get_id='' set_id='' link_id='' type='BioMinerva::DNALib::FeatureComparator'>
###---   <auto:comment id="feature_comparator" md5="LbwjppQuNgkwOJvagMy4dw">

=head2 feature_comparator

 Title   : feature_comparator property
 
 Usage   : $object->feature_comparator(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_comparator" md5="iOQfBPMwTm404tWgEESBbg">

sub feature_comparator {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_comparator' } = shift @_;
  }
  return $self->{ 'feature_comparator' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_comparator" md5="l/YhcY9cIncp0tVK2+vACA">

sub get_feature_comparator {
  return shift->{ 'feature_comparator' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_comparator" md5="IRd8+cxEx49NbskreH0TcA">

sub set_feature_comparator {
  my $self = shift @_;
  $self->{ 'feature_comparator' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_comparator" md5="OYEFtGp/IVjeKfWaBOQEHA">

sub link_feature_comparator {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_comparator' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_comparator' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureComparator', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_comparator', $self->get_feature_comparator() );
}

##########################################################################

1;
