##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::GFF3FeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::FeatureFactory;
@ISA = qw( BioMinerva::DNALib::FeatureFactory );

use BioMinerva::DNALib::GFF3FeatureIterator;
use BioMinerva::Base::DirCache;
use BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory;
use Carp qw( confess carp croak );

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
    $clone = new BioMinerva::GFF3FeatureFactory();
  }
  $self->SUPER::clone( $clone );

  #TODO: dup stream!

  croak( "Not to be used yet" );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='gff_version' get_id='' set_id=''>
###---   <auto:comment id="gff_version" md5="a3KrfZEjfAxewhzF4/r1HQ">

=head2 gff_version

 Title   : gff_version property
 
 Usage   : $object->gff_version(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gff_version" md5="ceA+WZaUMJ4LH91/ffQX7A">

sub gff_version {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gff_version' } = shift @_;
  }
  return $self->{ 'gff_version' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gff_version" md5="1KiT/lzAexYSCLtqnpTR/g">

sub get_gff_version {
  return shift->{ 'gff_version' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gff_version" md5="Vd2HARYmRipkUhMZnkeDVw">

sub set_gff_version {
  my $self = shift @_;
  $self->{ 'gff_version' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="stream" get_id="" set_id="">
###---   <auto:comment id="stream" md5="H6hzT/7G5mCXwM+REmq6IA">

=head2 stream

 Title   : stream property
 
 Usage   : $object->stream(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="stream" md5="i4uMDEyX9WGQ5XoyyLMTlg">

sub stream {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'stream' } = shift @_;
  }
  return $self->{ 'stream' };
}

###---   </auto:code>
###---   <auto:code get_id="get_stream" md5="bD009lh9OIXcCI37D32baw">

sub get_stream {
  return shift->{ 'stream' };
}

###---   </auto:code>
###---   <auto:code set_id="set_stream" md5="TYyMhVo+VpOJV0sbWiIl2w">

sub set_stream {
  my $self = shift @_;
  $self->{ 'stream' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="_file" get_id="" set_id="">
###---   <auto:comment id="_file" md5="31QhDSRdKIjbSGenoUh5gA">

=head2 _file

 Title   : _file property
 
 Usage   : $object->_file(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_file" md5="Pkx48YqrB5WSopEKKiwC1g">

sub _file {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_file' } = shift @_;
  }
  return $self->{ '_file' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_file" md5="h8Licw6bBVnBpl/X7HLhPw">

sub _get_file {
  return shift->{ '_file' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_file" md5="vGZXr/E1Zatez320A+AdcQ">

sub _set_file {
  my $self = shift @_;
  $self->{ '_file' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub file
{
  my( $self, $file ) = @_;

  if( defined( $file ) ) {
    my $stream;
    if( !open( $stream, $file ) ) {
      croak( "Can not open '$file' for reading (system: '$!')" );
    }

    $self->_set_file( $file );
    $self->set_stream( $stream );
  } else {
    return $self->_get_file();
  }
}

sub display_id
{
  my( $self ) = @_;

  my $display_id = $self->SUPER::display_id();
  if( !defined( $display_id ) ) { 
    $display_id = $self->_get_file();
  }
  return $display_id;
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'gff_version', $self->get_gff_version() );
  $target->property( 'file', $self->_get_file() );
}

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  $digest->add( $self->get_gff_version() || '' );
  $digest->add( BioMinerva::Base::Cache::file_digest_id( $self->_get_file() ) || '' );
  
  return $digest;
}

sub features_digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::features_digest();
  
  $digest->add( $self->get_gff_version() || '' );
  $digest->add( BioMinerva::Base::Cache::file_digest_id( $self->_get_file() ) || '' );

  return $digest;
}

sub feature_comparator
{
  my( $self ) = @_;

  return undef; #TODO: what can be assumed about initial file sort!
}

sub cached_feature_factory
{
  my( $self ) = @_;

  my $cache = BioMinerva::Base::DirCache::file2default_cache( $self->_get_file() );
  if( ref( $cache ) ) {
    my $feature_factory = new BioMinerva::DNALib::CachingFeatureIndexesRefFeatureFactory();
    $feature_factory->set_cache( $cache );
    $feature_factory->set_feature_factory( $self );
    return $feature_factory;
  } else {
    return $self->SUPER::cached_feature_factory();
  }
}

##########################################################################
# GENERAL
##########################################################################

sub feature_index2feature
{
  my( $self, $feature_index ) = @_;

  my $stream = $self->get_stream();
  if( !$stream ) {
    croak( "Undefined stream in $self" );
  }

  if( !defined( $feature_index ) ) {
    confess( "Undefined feature_index in $self" );
  }

  if( !seek( $stream, $feature_index, 0 ) ) {
    croak( "Failed to seek($feature_index) the input stream in $self" );
  }
  
  my $gff3line = <$stream>;
  if( !defined( $gff3line ) ) {
    croak( "Failed to read a GFF3 line at pos $feature_index in $self" );
  }
  
  my $feature = new BioMinerva::DNALib::GFF3Feature();
  $feature->set_index( $feature_index );
  $feature->set_gff3line( $gff3line );
  
  return $feature;
}

sub feature_index_iterator
{
  my( $self ) = @_;
  
  return $self->_feature_iterator2feature_index_iterator(
    $self->feature_iterator()
  );
}

sub feature_iterator
{
  my( $self ) = @_;

  my $feature_iterator = new BioMinerva::DNALib::GFF3FeatureIterator();
  $feature_iterator->set_feature_factory( $self );
  $feature_iterator->set_stream( $self->get_stream() ); #TODO: dup stream!

  return $feature_iterator;
}

sub feature_indexes
{
  my( $self ) = @_;

  return $self->_feature_iterator2feature_indexes(
    $self->feature_iterator()
  );
}

sub features
{
  my( $self ) = @_;

  return $self->_feature_iterator2features(
    $self->feature_iterator()
  );
}

sub num_of_features
{
  my( $self ) = @_;

  return $self->_feature_iterator2num_of_features(
    $self->feature_iterator()
  );
}

##########################################################################

1;
