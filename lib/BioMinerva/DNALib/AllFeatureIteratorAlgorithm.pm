##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::AllFeatureIteratorAlgorithm;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Algorithm;
@ISA = qw( BioMinerva::Base::Algorithm );

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

###--- <scalar_property id="feature_processor" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::FeatureProcessor'>
###---   <auto:comment id="feature_processor" md5="590kX77o/z11rFZiD4wW9A">

=head2 feature_processor

 Title   : feature_processor property
 
 Usage   : $object->feature_processor(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="feature_processor" md5="PCWVqoFW+WySJGnPwF5OLw">

sub feature_processor {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'feature_processor' } = shift @_;
  }
  return $self->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code get_id="get_feature_processor" md5="Xk4YITFJR5x4zq3JMOIgnA">

sub get_feature_processor {
  return shift->{ 'feature_processor' };
}

###---   </auto:code>
###---   <auto:code set_id="set_feature_processor" md5="ii7RU2XwXrU8nt4/NS64vw">

sub set_feature_processor {
  my $self = shift @_;
  $self->{ 'feature_processor' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_feature_processor" md5="7XvZLA/AZW8QrjIHZjyJag">

sub link_feature_processor {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'feature_processor' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'feature_processor' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::FeatureProcessor', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'feature_iterator', $self->feature_iterator() );
  $target->property( 'feature_processor', $self->feature_processor() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process
{
  my( $self ) = @_;

  my $feature_iterator = $self->get_feature_iterator();
  if( !ref( $feature_iterator ) ) {
    croak( "Undefined feature_iterator in $self" );
  }

  my $feature_processor = $self->get_feature_processor();
  if( !ref( $feature_processor ) ) {
    croak( "Undefined feature_processor in $self" );
  }

  for(
    $feature_iterator->reset();
    $feature_iterator->valid();
    $feature_iterator->iterate()
  ) {
    $feature_processor->process_feature(
      $feature_iterator->value()
    );
  }
}

##########################################################################

1;
