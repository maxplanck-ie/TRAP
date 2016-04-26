##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EnsEmblGeneFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::EnsEmblFeatureFactory;
@ISA = qw( BioMinerva::DNALib::EnsEmblFeatureFactory );

use BioMinerva::DNALib::Feature;
use BioMinerva::DNALib::EnsEmblTranscriptFeatureFactory;
use BioMinerva::DNALib::EnsEmblSequenceFactory;
use BioMinerva::Base::InfoViewer;
use BioMinerva::Base::CounterProgressInfo;
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

###--- <scalar_property id="ensembl_transcript_feature_factory" get_id="" set_id="" link_id='' type='BioMinerva::Base::EnsEmblTranscriptFeatureFactory'>
###---   <auto:comment id="ensembl_transcript_feature_factory" md5="4sWLSWqs7v3lnOG3JaF7AQ">

=head2 ensembl_transcript_feature_factory

 Title   : ensembl_transcript_feature_factory property
 
 Usage   : $object->ensembl_transcript_feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ensembl_transcript_feature_factory" md5="iBiyrXZHizz0chjAvOBp5g">

sub ensembl_transcript_feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ensembl_transcript_feature_factory' } = shift @_;
  }
  return $self->{ 'ensembl_transcript_feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ensembl_transcript_feature_factory" md5="NhWr2fgV0YzNM7raR2mD5A">

sub get_ensembl_transcript_feature_factory {
  return shift->{ 'ensembl_transcript_feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ensembl_transcript_feature_factory" md5="6l3HRwghWbgW6s9Yh7TkbQ">

sub set_ensembl_transcript_feature_factory {
  my $self = shift @_;
  $self->{ 'ensembl_transcript_feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_ensembl_transcript_feature_factory" md5="6TdbcykKQlJ+/LQGFZtFZg">

sub link_ensembl_transcript_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'ensembl_transcript_feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'ensembl_transcript_feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::Base::EnsEmblTranscriptFeatureFactory', $ref
      );
  }
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="skip_noncoding" get_id="" set_id="">
###---   <auto:comment id="skip_noncoding" md5="z5G1FrEumHWAvYP7zkvh1Q">

=head2 skip_noncoding

 Title   : skip_noncoding property
 
 Usage   : $object->skip_noncoding(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="skip_noncoding" md5="L9eupeYli9FCluxppNciqg">

sub skip_noncoding {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'skip_noncoding' } = shift @_;
  }
  return $self->{ 'skip_noncoding' };
}

###---   </auto:code>
###---   <auto:code get_id="get_skip_noncoding" md5="ZmRZ6liD63i36AVUmrBgkQ">

sub get_skip_noncoding {
  return shift->{ 'skip_noncoding' };
}

###---   </auto:code>
###---   <auto:code set_id="set_skip_noncoding" md5="1fBZFsqDH9TDkhjKntmGag">

sub set_skip_noncoding {
  my $self = shift @_;
  $self->{ 'skip_noncoding' } = shift @_;
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

###--- <scalar_property id="ensembl_external_name_attr" get_id="" set_id="">
###---   <auto:comment id="ensembl_external_name_attr" md5="1SZVh6yRoLej/TSyCNmVrQ">

=head2 ensembl_external_name_attr

 Title   : ensembl_external_name_attr property
 
 Usage   : $object->ensembl_external_name_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ensembl_external_name_attr" md5="Odj/bRZj8W4tJAckf7LZ3g">

sub ensembl_external_name_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ensembl_external_name_attr' } = shift @_;
  }
  return $self->{ 'ensembl_external_name_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ensembl_external_name_attr" md5="yXHhfNTHPFPNsFIeQN0Kug">

sub get_ensembl_external_name_attr {
  return shift->{ 'ensembl_external_name_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ensembl_external_name_attr" md5="I57XG8lDFw1fkQ7swgjsXA">

sub set_ensembl_external_name_attr {
  my $self = shift @_;
  $self->{ 'ensembl_external_name_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="ensembl_description_attr" get_id="" set_id="">
###---   <auto:comment id="ensembl_description_attr" md5="5Ra7796aUsB4xcfFKk3MgQ">

=head2 ensembl_description_attr

 Title   : ensembl_description_attr property
 
 Usage   : $object->ensembl_description_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ensembl_description_attr" md5="m0RSx0MNARhTYLY+PSIcug">

sub ensembl_description_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ensembl_description_attr' } = shift @_;
  }
  return $self->{ 'ensembl_description_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ensembl_description_attr" md5="m5GuSBNF7n1BnccZQknSsQ">

sub get_ensembl_description_attr {
  return shift->{ 'ensembl_description_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ensembl_description_attr" md5="5EIPeW962Bh7F7hSNS4XmA">

sub set_ensembl_description_attr {
  my $self = shift @_;
  $self->{ 'ensembl_description_attr' } = shift @_;
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
  $target->property( 'sequence_factory', $self->get_sequence_factory() );
  $target->property( 'string_factory', $self->get_string_factory() );
  $target->property( 'ensembl_transcript_feature_factory', $self->get_ensembl_transcript_feature_factory() );
  $target->property( 'skip_noncoding', $self->get_skip_noncoding() );
  $target->property( 'ensembl_id_attr', $self->get_ensembl_id_attr() );
  $target->property( 'ensembl_external_name_attr', $self->get_ensembl_external_name_attr() );
  $target->property( 'ensembl_description_attr', $self->get_ensembl_description_attr() );
  $target->property( 'string_attr', $self->get_string_attr() );
  $target->property( 'use_id', $self->get_use_id() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub create_ensembl_transcript_feature_factory
{
  my( $self, $feature_factory ) = @_;

  if( !ref( $feature_factory ) ) {
    $feature_factory = new BioMinerva::DNALib::EnsEmblTranscriptFeatureFactory();
  }

  $self->SUPER::create_ensembl_feature_factory( $feature_factory );
  
  if( $self->get_ensembl_id_attr() ) {
    $feature_factory->set_ensembl_id_attr( $self->get_ensembl_id_attr() );
  }
  if( $self->get_ensembl_external_name_attr() ) {
    $feature_factory->set_ensembl_external_name_attr( $self->get_ensembl_external_name_attr() );
  }
  if( $self->get_ensembl_description_attr() ) {
    $feature_factory->set_ensembl_description_attr( $self->get_ensembl_description_attr() );
  }
  if( $self->get_string_attr() ) {
    $feature_factory->set_string_attr( $self->get_string_attr() );
  }
  $feature_factory->set_use_id( 'ensembl' );

  return $feature_factory;
}

sub _process_features
{
  my( $self ) = @_;
  
  # ----- single shot -----
  if( $self->_get_database_processed() ) { return; }

  # ----- processing -----
  if( $self->_process_database_by_string_factory() ) {
  } elsif( $self->_process_database_by_sequence_factory() ) {
  } else { 
    $self->_process_database_all_genes();
  }

  # ----- single shot -----
  $self->_set_database_processed( 1 );
}

##########################################################################

sub _process_database_by_sequence_factory
{
  my( $self, $sequence_factory ) = @_;

  if( !ref( $sequence_factory ) ) {
    $sequence_factory = $self->get_sequence_factory();
  }

  if( !ref( $sequence_factory ) ) { return 0; }

  my $source = $self->source();

  my $load_transcripts = 
    ref( $self->get_ensembl_transcript_feature_factory() ) ? 1 : 0;
  
  my $sequences = $sequence_factory->sequences();
  
  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "EnsEMBL($source) genes" );
  $progress_info->set_size( scalar( @{ $sequences || [] } ) );
  $progress_info->set_count_attr( "sequence" );
  $progress_info->set_phase_attr( "sequence_id" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO:  try
  my $counter = 0;
  foreach my $sequence( @{ $sequences || [] } ) {
    $progress_info->set_count( $counter++ );
    $progress_info->set_phase( $sequence->location_str() );
    
    my $slice = $self->_sequence2slice( $sequence );
    
    my $genes = $slice->get_all_Genes( undef, undef, $load_transcripts );
    $self->_process_genes( $genes, "" )
  }
  $progress_info->set_count( $counter );
  $progress_info->set_phase( undef );
#TODO: catch:
  $info_viewer->pop_info();

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
  my $gene_adaptor = $db_adaptor->get_GeneAdaptor()
    || confess( "Cannot get EnsEMBL GeneAdaptor in $self" );
  
  my $strings = $string_factory->strings() || [];
  my $strings_size = scalar( @{ $strings } );
  
  my $progress_info = new BioMinerva::Base::CounterProgressInfo();
  $progress_info->set_title( "EnsEMBL($source) genes" );
  $progress_info->set_size( $strings_size );
  $progress_info->set_count_attr( "sequence" );
  $progress_info->set_phase_attr( "string" );

  my $info_viewer = BioMinerva::Base::InfoViewer::global();
  $info_viewer->push_info( $progress_info );
  
#TODO:  try
  my $counter = 0;
  foreach my $string( @{ $strings } ) {
    $progress_info->set_count( $counter++ );
    $progress_info->set_phase( $string );

    my @genes;

    {
      my $gene = $gene_adaptor->fetch_by_stable_id( $string );
      if( $gene ) { @genes = ( $gene ); }
    }
      
    if( !@genes ) {
      @genes = @{ $gene_adaptor->fetch_all_by_external_name( $string ) };
    }

    if( !@genes ) {
      carp( "Can not retrieve a gene for string='$string' from EnsEMBL($source) in $self" );
    }
    
    $self->_process_genes( \@genes, $string );
  }
  $progress_info->set_count( $counter );
  $progress_info->set_phase( undef );
#TODO: catch:
  $info_viewer->pop_info();

  return 1;
}

##########################################################################

sub _process_database_all_genes
{
  my( $self ) = @_;
  
  my $sequence_factory = new BioMinerva::DNALib::EnsEmblSequenceFactory();
  $sequence_factory->set_database_name( $self->get_database_name() );
  $sequence_factory->set_top_level_sequence_type( $self->get_top_level_sequence_type() );
 
  $self->_process_database_by_sequence_factory( $sequence_factory );
}

##########################################################################

sub _process_genes
{
  my( $self, $genes, $string ) = @_;

  my $num = 1;
  my $string_num;
  
  foreach my $gene( @{ $genes } ) {
    my $string_num = ( scalar( @{ $genes } ) > 1 )
      ? "$string:$num"
      : $string;
    
    my $feature = $self->_gene2feature( $gene, $string, $string_num );
    if( ref( $feature ) ) {
      $self->_add_feature( $feature );
    }

    ++$num;
  }
}

##########################################################################

sub _gene2feature
{
  my( $self, $gene, $string, $string_num ) = @_;

  my $ensembl_transcript_feature_factory = $self->get_ensembl_transcript_feature_factory();
  my $use_id = $self->get_use_id();
  my $string_attr = $self->get_string_attr();
  my $ensembl_id_attr = $self->get_ensembl_id_attr();
  my $ensembl_external_name_attr = $self->get_ensembl_external_name_attr();
  my $ensembl_description_attr = $self->get_ensembl_description_attr();

  if( $self->get_skip_noncoding() ) {
    my $transcripts = $gene->get_all_Transcripts();
    my $coding = 0;
    foreach my $transcript( @{ $transcripts || [] } ) { 
      if( $transcript->cdna_coding_start() ) {
        $coding = 1;
        last;
      }
    }
    if( !$coding ) { return undef; }
  }

  my $ensembl_id = $gene->stable_id();
  my $ensembl_external_name = $gene->external_name() || $ensembl_id;
  
  my $feature = $self->_create_feature( 'gene' );
  
  if( !defined( $use_id ) ) {
    $feature->set_id( $ensembl_id );
  } elsif( $use_id eq 'string' ) {
    $feature->set_id( $string );
  } elsif( $use_id eq 'string_num' ) {
    $feature->set_id( $string_num );
  } elsif( $use_id eq 'ensembl_external_name' ) {
    $feature->set_id( $ensembl_external_name );
  } elsif( $use_id eq 'ensembl' ) {
    $feature->set_id( $ensembl_id );
  } else {
    croak( "Incorrect use_id '$use_id'. "
      . "Use one of: string, string_num, ensembl_external_name, ensembl" );
  }
  
  $feature->set_primary_sequence_id( $gene->slice()->seq_region_name() );
  $feature->set_start( $gene->start() );
  $feature->set_end( $gene->end() );
  $feature->set_strand( $gene->strand() );
  
  if( $string_attr && $string ) {
    $feature->add_attr( $string_attr, $string );
  }
  if( $ensembl_id_attr ) {
    $feature->add_attr( $ensembl_id_attr, $ensembl_id );
  }
  if( $ensembl_external_name_attr ) {
    $feature->add_attr( $ensembl_external_name_attr, $ensembl_external_name );
  }
  if( $ensembl_description_attr && $gene->description() ) {
    $feature->add_attr( $ensembl_description_attr, $gene->description() );
  }

  my $exon_id2exon_feature = {};
  my $cds_id2cds_feature = {};
  my $five_utr2five_utr_feature = {};
  my $three_utr2three_utr_feature = {};
  
  if( ref( $ensembl_transcript_feature_factory ) ) {
    my $transcripts = $gene->get_all_Transcripts();
    foreach my $transcript( @{ $transcripts || [] } ) { 
      my $transcript_feature =
        $ensembl_transcript_feature_factory->_transcript2feature(
          $transcript, 
          "", 
          "", 
          $exon_id2exon_feature,
          $cds_id2cds_feature,
          $five_utr2five_utr_feature,
          $three_utr2three_utr_feature
        );
      if( ref( $transcript_feature ) ) {
        $feature->add_part_feature( $transcript_feature );
      }
    }
  }
  
  return $feature;
}

##########################################################################

1;

