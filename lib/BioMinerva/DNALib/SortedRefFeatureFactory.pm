##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::SortedRefFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::RefFeatureFactory;
@ISA = qw( BioMinerva::DNALib::RefFeatureFactory );

use Carp qw( confess carp croak );
use BioMinerva::Base::ProgressInfo;

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
  confess( "Not overridden in $self" );
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

sub operator_display_id
{
  my( $self ) = @_;

  my $feature_comparator = $self->get_feature_comparator();

  return 'sort['
    . ( ref( $feature_comparator )
      ? $feature_comparator->display_id()
      : "<undef feature_comparator>"
    )
    . ']';
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  my $feature_comparator = $self->get_feature_comparator();
  $digest->add( ref( $feature_comparator ) ? $feature_comparator->digest_id() : '' );
  
  return $digest;
}

sub features_digest
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  my $feature_comparator = $self->get_feature_comparator();

  if( 
    ref( $feature_factory )
    && ref( $feature_comparator )
    && ref( $feature_factory->feature_comparator() )
    && (
      $feature_comparator->digest_id()
      eq $feature_factory->feature_comparator()->digest_id() 
    )
  ) {
    return $feature_factory->features_digest();
  }

  my $digest = $feature_factory->features_digest();
  $digest->add( ref( $feature_factory ) ? $feature_factory->digest_id() : '' );
  $digest->add( ref( $feature_comparator ) ? $feature_comparator->digest_id() : '' );
  
  return $digest;
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->feature_index2feature( $feature_index );
}

sub feature_index_iterator
{
  my( $self ) = @_;

  if( $self->_feature_comparator_equal() ) {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }

    return $feature_factory->feature_index_iterator();
  }

  return $self->_feature_indexes2feature_index_iterator(
    $self->feature_indexes()
  );
}

sub feature_iterator
{
  my( $self ) = @_;

  if( $self->_feature_comparator_equal() ) {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }

    return $feature_factory->feature_iterator();
  }

  return $self->_feature_indexes2feature_iterator(
    $self->feature_indexes()
  );
}

sub feature_indexes
{
  my( $self ) = @_;

  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  if( $self->_feature_comparator_equal() ) {
    return $feature_factory->feature_indexes();
  }

  my $feature_comparator = $self->get_feature_comparator();
  if( !ref( $feature_comparator ) ) {
    croak( "Undefined feature_comparator in $self" )
  }

  my $feature_indexes = $feature_factory->feature_indexes();

#<debug>
#  foreach my $feature_index( @{ $feature_indexes || [] } ) {
#    if( !defined( $feature_index ) ) {
#      confess( "Feature inconsistency, undef feature_index in $self" );
#    }
#  }
#</debug>
 
  my $progress_info = new BioMinerva::Base::ProgressInfo();
  $progress_info->set_title( 
    'Sorting (' 
    . $self->display_id()
    . ')'
  );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );

#TODO: try
  my @ret_feature_indexes = sort {
    $feature_comparator->compare(
      $feature_factory->feature_index2feature( $a ),
      $feature_factory->feature_index2feature( $b )
    )
  } @{ $feature_indexes || [] };
#TODO: catch
  $info_viewer->pop_info();

  return \@ret_feature_indexes;
}

sub features
{
  my( $self ) = @_;

  if( $self->_feature_comparator_equal() ) {
    my $feature_factory = $self->get_feature_factory();
    if( !ref( $feature_factory ) ) {
      croak( "Undefined feature_factory in $self" )
    }

    return $feature_factory->features();
  }

  return $self->_feature_indexes2features(
    $self->feature_indexes()
  );
}

sub num_of_features
{
  my( $self ) = @_;
  
  my $feature_factory = $self->get_feature_factory();
  if( !ref( $feature_factory ) ) {
    croak( "Undefined feature_factory in $self" )
  }

  return $feature_factory->num_of_features();
}

##########################################################################

sub _feature_comparator_equal
{
  my( $self ) = @_;

  return 0; #TODO
}

##########################################################################

1;
