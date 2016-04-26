##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EnsEmblExonFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::EnsEmblFeatureFactory;
@ISA = qw( BioMinerva::DNALib::EnsEmblFeatureFactory );

use BioMinerva::DNALib::Feature;
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

###--- <scalar_property id="sequence_factory" get_id="" set_id="" link_id='' type='BioMinerva::DNALib::SequenceFactory'>
###---   <auto:comment id="sequence_factory" md5="nSsQ+7ZMHzvX2Yo/bOKPhw">

=head2 sequence_factory

 Title   : sequence_factory property
 
 Usage   : $object->sequence_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sequence_factory" md5="oJ1dV8kpNuTSxqy5ho2NUQ">

sub sequence_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sequence_factory' } = shift @_;
  }
  return $self->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sequence_factory" md5="6kU+ambkFItqJliIgotJGw">

sub get_sequence_factory {
  return shift->{ 'sequence_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sequence_factory" md5="ISTcxJ9LtZL/YpCByaB1CA">

sub set_sequence_factory {
  my $self = shift @_;
  $self->{ 'sequence_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_sequence_factory" md5="g4SZ0RvMuykyQ2/p+m3Kwg">

sub link_sequence_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'sequence_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'sequence_factory' } =
      $registry->type_id2object(
        'BioMinerva::DNALib::SequenceFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="string_factory" get_id="" set_id="" link_id='' type='BioMinerva::Base::StringFactory'>
###---   <auto:comment id="string_factory" md5="37J6sbsgSF1ETbt90HdFtA">

=head2 string_factory

 Title   : string_factory property
 
 Usage   : $object->string_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="string_factory" md5="6Q8Vz0T1uEsBd2IaOWETAw">

sub string_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'string_factory' } = shift @_;
  }
  return $self->{ 'string_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_string_factory" md5="1Q+5fZ31Vv7hxew1/OGqwg">

sub get_string_factory {
  return shift->{ 'string_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_string_factory" md5="u1VcxN05lSND/2w1g7mjww">

sub set_string_factory {
  my $self = shift @_;
  $self->{ 'string_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_string_factory" md5="qp79MOuML7BYxE/gtTsRRA">

sub link_string_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'string_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'string_factory' } =
      $registry->type_id2object(
        'BioMinerva::Base::StringFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="ensembl_id_attr" get_id="" set_id="">
###---   <auto:comment id="ensembl_id_attr" md5="wExLlXmIYEML8YBPSA9K3A">

=head2 ensembl_id_attr

 Title   : ensembl_id_attr property
 
 Usage   : $object->ensembl_id_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ensembl_id_attr" md5="ZxYccGhbJxbez97pZJS1Vg">

sub ensembl_id_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ensembl_id_attr' } = shift @_;
  }
  return $self->{ 'ensembl_id_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ensembl_id_attr" md5="GyWDZrTpK5oqgsywqN4aNQ">

sub get_ensembl_id_attr {
  return shift->{ 'ensembl_id_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ensembl_id_attr" md5="aOyU84HN1xX0riB+2dpE1A">

sub set_ensembl_id_attr {
  my $self = shift @_;
  $self->{ 'ensembl_id_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="string_attr" get_id="" set_id="">
###---   <auto:comment id="string_attr" md5="JgZSGAb2KhcQ54EoSvRF1Q">

=head2 string_attr

 Title   : string_attr property
 
 Usage   : $object->string_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="string_attr" md5="UcIReaox8W5PlYKBg6vTeg">

sub string_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'string_attr' } = shift @_;
  }
  return $self->{ 'string_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_string_attr" md5="iYz19+TrHvIPAwIKuTpxtA">

sub get_string_attr {
  return shift->{ 'string_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_string_attr" md5="Pghedpd6mGGr9Rqd89OrTw">

sub set_string_attr {
  my $self = shift @_;
  $self->{ 'string_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="use_id" get_id="" set_id="">
###---   <auto:comment id="use_id" md5="0oBtrg+5XYPdcajyiXyILA">

=head2 use_id

 Title   : use_id property
 
 Usage   : $object->use_id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="use_id" md5="IcH+D/AI8BcNHEfD2FXB3g">

sub use_id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'use_id' } = shift @_;
  }
  return $self->{ 'use_id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_use_id" md5="hEaqoo8/fSmVXNBHQbVlSA">

sub get_use_id {
  return shift->{ 'use_id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_use_id" md5="RdIJuKq0bAnZaXB0LrDMRQ">

sub set_use_id {
  my $self = shift @_;
  $self->{ 'use_id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_database_processed' get_id='_get_database_processed' set_id='_set_database_processed'>
###---   <auto:comment id="_database_processed" md5="FDqbYuVDCncDwoDzBlrYPQ">

=head2 _database_processed

 Title   : _database_processed property
 
 Usage   : $object->_database_processed(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="_database_processed" md5="1gmpqV8GaBWgLLkqN3NmGQ">

sub _database_processed {
  my $self = shift @_;
  if( @_ ) {
    $self->{ '_database_processed' } = shift @_;
  }
  return $self->{ '_database_processed' };
}

###---   </auto:code>
###---   <auto:code get_id="_get_database_processed" md5="VhxmJrps16H9EEvDyZ3NZA">

sub _get_database_processed {
  return shift->{ '_database_processed' };
}

###---   </auto:code>
###---   <auto:code set_id="_set_database_processed" md5="jEsklABQlsTJwEjMSOJfmw">

sub _set_database_processed {
  my $self = shift @_;
  $self->{ '_database_processed' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'sequence_factory', $self->sequence_factory() );
  $target->property( 'string_factory', $self->string_factory() );
  $target->property( 'ensembl_id_attr', $self->ensembl_id_attr() );
  $target->property( 'string_attr', $self->string_attr() );
  $target->property( 'use_id', $self->use_id() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub _process_features
{
  my( $self ) = @_;
  
  # ----- single shot -----
  if( $self->_get_database_processed() ) { return; }

  # ----- processing -----
  if( $self->_process_database_by_string_factory() ) {
  } elsif( $self->_process_database_by_sequence_factory() ) {
  } else { 
    $self->_process_database_all_exons();
  }

  # ----- single shot -----
  $self->_set_database_processed( 1 );
}

##########################################################################

sub _process_database_by_sequence_factory
{
  my( $self ) = @_;

  my $sequence_factory = $self->get_sequence_factory();
  if( !ref( $sequence_factory ) ) { return 0; }

  my $sequences = $sequence_factory->sequences();
  foreach my $sequence( @{ $sequences || [] } ) {
    my $slice = $self->_sequence2slice( $sequence );
    
    my $exons = $slice->get_all_Exons();
    $self->_process_exons( $exons, undef )
  }

  return 1;
}

##########################################################################

sub _process_database_by_string_factory
{
  my( $self ) = @_;

  my $source = $self->source();
  
  my $string_factory = $self->get_string_factory();
  if( !ref( $string_factory ) ) { 
    return 0; 
  }

  my $db_adaptor = $self->_db_adaptor();
  my $exon_adaptor = $db_adaptor->get_ExonAdaptor()
    || confess( "Cannot get EnsEMBL ExonAdaptor in $self" );
  
  my $counter = 0;
  my $strings = $string_factory->strings() || [];
  my $strings_size = scalar( @{ $strings } );
  
  foreach my $string( @{ $strings } ) {
    ++$counter;
    print STDERR "\r#Retrieving EnsEMBL($source) exon '$string': $counter/$strings_size done...     ";

    my @exons;

    {
      my $exon = $exon_adaptor->fetch_by_stable_id( $string );
      if( $exon ) { @exons = ( $exon ); }
    }
      
    $self->_process_exons( \@exons, $string );
  }

  print STDERR "\r#Retrieved $counter EnsEMBL($source) exons"
    . ( " " x 40 ) . "\n";

  return 1;
}

##########################################################################

sub _process_database_all_exons
{
  my( $self ) = @_;
  
  my $sequence_factory = new BioMinerva::DNALib::EnsEmblSequenceFactory();
  $sequence_factory->set_database_name( $self->get_database_name() );
  $sequence_factory->set_top_level_sequence_type( $self->get_top_level_sequence_type() );
 
  $self->_process_database_by_sequence_factory( $sequence_factory );
}

##########################################################################

sub _process_exons
{
  my( $self, $exons, $string ) = @_;

  my $num = 1;
  my $string_num;
  
  foreach my $exon( @{ $exons } ) {
    my $string_num = ( scalar( @{ $exons } ) > 1 )
      ? "$string:$num"
      : $string;
    
    my $feature = $self->_exon2feature( $exon, $string, $string_num );
    if( ref( $feature ) ) {
      $self->_add_feature( $feature );
    }

    ++$num;
  }
}

##########################################################################

sub _exon2feature
{
  my( $self, $exon, $string, $string_num ) = @_;
  
  my $use_id = $self->get_use_id();
  my $string_attr = $self->get_string_attr();
  my $ensembl_id_attr = $self->get_ensembl_id_attr();

  my $ensembl_id = $exon->stable_id();
  
  my $feature = $self->_create_feature( 'exon' );
  
  if( !defined( $use_id ) ) {
    $feature->set_id( $ensembl_id );
  } elsif( $use_id eq 'string' ) {
    $feature->set_id( $string );
  } elsif( $use_id eq 'string_num' ) {
    $feature->set_id( $string_num );
  } elsif( $use_id eq 'ensembl' ) {
    $feature->set_id( $ensembl_id );
  } else {
    croak( "Incorrect use_id '$use_id'. "
      . "Use one of: string, string_num, ensembl" );
  }
  
  $feature->set_primary_sequence_id( $exon->slice()->seq_region_name() );
  $feature->set_start( $exon->start() );
  $feature->set_end( $exon->end() );
  $feature->set_strand( $exon->strand() );
  if( $exon->phase() >= 0 ) {
    $feature->add_attr( 'Phase', $exon->phase() );
  }
  
  if( $string_attr && $string ) {
    $feature->add_attr( $string_attr, $string );
  }
  if( $ensembl_id_attr ) {
    $feature->add_attr( $ensembl_id_attr, $ensembl_id );
  }

  return $feature;
}

##########################################################################

1;

