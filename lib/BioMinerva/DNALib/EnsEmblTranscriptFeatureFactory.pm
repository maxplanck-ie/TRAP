##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::EnsEmblTranscriptFeatureFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::EnsEmblFeatureFactory;
@ISA = qw( BioMinerva::DNALib::EnsEmblFeatureFactory );

use BioMinerva::DNALib::Feature;
use BioMinerva::DNALib::EnsEmblExonFeatureFactory;
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

###--- <scalar_property id="ensembl_exon_feature_factory" get_id="" set_id="" link_id='' type='BioMinerva::Base::EnsEmblExonFeatureFactory'>
###---   <auto:comment id="ensembl_exon_feature_factory" md5="56vfLEGRxoPAQWC34thmGA">

=head2 ensembl_exon_feature_factory

 Title   : ensembl_exon_feature_factory property
 
 Usage   : $object->ensembl_exon_feature_factory(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="ensembl_exon_feature_factory" md5="zgpppOjXEbKdlt+87pLyWQ">

sub ensembl_exon_feature_factory {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'ensembl_exon_feature_factory' } = shift @_;
  }
  return $self->{ 'ensembl_exon_feature_factory' };
}

###---   </auto:code>
###---   <auto:code get_id="get_ensembl_exon_feature_factory" md5="yZNpQ9lXvCimWYct+NKuag">

sub get_ensembl_exon_feature_factory {
  return shift->{ 'ensembl_exon_feature_factory' };
}

###---   </auto:code>
###---   <auto:code set_id="set_ensembl_exon_feature_factory" md5="j49t32OxAzCtocIFoKsERg">

sub set_ensembl_exon_feature_factory {
  my $self = shift @_;
  $self->{ 'ensembl_exon_feature_factory' } = shift @_;
}

###---   </auto:code>
###---   <auto:code link_id="link_ensembl_exon_feature_factory" md5="+m8yIFTgE423lgN8siU9HQ">

sub link_ensembl_exon_feature_factory {
  my $self = shift @_;
  my $registry = shift @_;
  my $ref = $self->{ 'ensembl_exon_feature_factory' };
  if( defined( $ref ) && !ref( $ref ) ) {
    $self->{ 'ensembl_exon_feature_factory' } =
      $registry->type_id2object(
        'BioMinerva::Base::EnsEmblExonFeatureFactory', $ref
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

###--- <scalar_property id="coding_region_start_attr" get_id="" set_id="">
###---   <auto:comment id="coding_region_start_attr" md5="OSnpxoNxlqIMgSTnhs7nVA">

=head2 coding_region_start_attr

 Title   : coding_region_start_attr property
 
 Usage   : $object->coding_region_start_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="coding_region_start_attr" md5="HkfH8OubNsQAZRozaIyNhw">

sub coding_region_start_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'coding_region_start_attr' } = shift @_;
  }
  return $self->{ 'coding_region_start_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_coding_region_start_attr" md5="+kswa77YQVyWyQuboCglLg">

sub get_coding_region_start_attr {
  return shift->{ 'coding_region_start_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_coding_region_start_attr" md5="FdMZFm3REx9KNTBKPqkmcw">

sub set_coding_region_start_attr {
  my $self = shift @_;
  $self->{ 'coding_region_start_attr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="coding_region_end_attr" get_id="" set_id="">
###---   <auto:comment id="coding_region_end_attr" md5="Kt2c8no+TYX/AroNXmNhsA">

=head2 coding_region_end_attr

 Title   : coding_region_end_attr property
 
 Usage   : $object->coding_region_end_attr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="coding_region_end_attr" md5="cXxyN/0kFbtSfjrQyA4oiw">

sub coding_region_end_attr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'coding_region_end_attr' } = shift @_;
  }
  return $self->{ 'coding_region_end_attr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_coding_region_end_attr" md5="/MwD3HmQ2jIH7Zy01U/efw">

sub get_coding_region_end_attr {
  return shift->{ 'coding_region_end_attr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_coding_region_end_attr" md5="pApwH20aGyH+/tNBhaLVPw">

sub set_coding_region_end_attr {
  my $self = shift @_;
  $self->{ 'coding_region_end_attr' } = shift @_;
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

###--- <scalar_property id="generate_cds" get_id="" set_id="">
###---   <auto:comment id="generate_cds" md5="2o21U4Hfo1DoNLR5gkVLRw">

=head2 generate_cds

 Title   : generate_cds property
 
 Usage   : $object->generate_cds(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="generate_cds" md5="+X7WRzW2Un5cyI7xuK5wRQ">

sub generate_cds {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'generate_cds' } = shift @_;
  }
  return $self->{ 'generate_cds' };
}

###---   </auto:code>
###---   <auto:code get_id="get_generate_cds" md5="a4SAZb9UBGGwu7yndkXkoQ">

sub get_generate_cds {
  return shift->{ 'generate_cds' };
}

###---   </auto:code>
###---   <auto:code set_id="set_generate_cds" md5="vj6LbVR+MhnNL9pDjC2g2A">

sub set_generate_cds {
  my $self = shift @_;
  $self->{ 'generate_cds' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="generate_five_utr" get_id="" set_id="">
###---   <auto:comment id="generate_five_utr" md5="CnvskFg6G7J1nQg7dLKXKA">

=head2 generate_five_utr

 Title   : generate_five_utr property
 
 Usage   : $object->generate_five_utr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="generate_five_utr" md5="/G8G8/Wp2eHjlQ2pWF43fw">

sub generate_five_utr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'generate_five_utr' } = shift @_;
  }
  return $self->{ 'generate_five_utr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_generate_five_utr" md5="aF11r4IBksJNXJudEBu4RQ">

sub get_generate_five_utr {
  return shift->{ 'generate_five_utr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_generate_five_utr" md5="PT2I4nRm1HJy2WCufp4ZKQ">

sub set_generate_five_utr {
  my $self = shift @_;
  $self->{ 'generate_five_utr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id="generate_three_utr" get_id="" set_id="">
###---   <auto:comment id="generate_three_utr" md5="IOAcnLMRpXPwVBjoSPXxIQ">

=head2 generate_three_utr

 Title   : generate_three_utr property
 
 Usage   : $object->generate_three_utr(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="generate_three_utr" md5="8S/+1f+EaEYV0p/5mOsGaQ">

sub generate_three_utr {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'generate_three_utr' } = shift @_;
  }
  return $self->{ 'generate_three_utr' };
}

###---   </auto:code>
###---   <auto:code get_id="get_generate_three_utr" md5="Po+i0MdbHgLzxlAjAhvPbw">

sub get_generate_three_utr {
  return shift->{ 'generate_three_utr' };
}

###---   </auto:code>
###---   <auto:code set_id="set_generate_three_utr" md5="PItTI9NYgMeoteOb0PGQHw">

sub set_generate_three_utr {
  my $self = shift @_;
  $self->{ 'generate_three_utr' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='_database_processed' get_id='' set_id=''>
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
  $target->property( 'ensembl_exon_feature_factory', $self->get_ensembl_exon_feature_factory() );
  $target->property( 'ensembl_id_attr', $self->ensembl_id_attr() );
  $target->property( 'ensembl_external_name_attr', $self->ensembl_external_name_attr() );
  $target->property( 'ensembl_description_attr', $self->ensembl_description_attr() );
  $target->property( 'string_attr', $self->string_attr() );
  $target->property( 'coding_region_start_attr', $self->get_coding_region_start_attr() );
  $target->property( 'coding_region_end_attr', $self->get_coding_region_end_attr() );
  $target->property( 'use_id', $self->use_id() );
  $target->property( 'generate_cds', $self->get_generate_cds() );
  $target->property( 'generate_five_utr', $self->get_generate_five_utr() );
  $target->property( 'generate_three_utr', $self->get_generate_three_utr() );  
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub create_ensembl_exon_feature_factory
{
  my( $self, $feature_factory ) = @_;

  if( !ref( $feature_factory ) ) {
    $feature_factory = new BioMinerva::DNALib::EnsEmblExonFeatureFactory();
  }

  $self->SUPER::create_ensembl_feature_factory( $feature_factory );
  
  if( $self->get_ensembl_id_attr() ) {
    $feature_factory->set_ensembl_id_attr( $self->get_ensembl_id_attr() );
  }
  if( $self->get_string_attr() ) {
    $feature_factory->set_string_attr( $self->get_string_attr() );
  }
  $feature_factory->set_use_id( 'ensembl' );

  return $feature_factory;
}

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
    $self->_process_database_all_transcripts();
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
    
    my $transcripts = $slice->get_all_Transcripts();
    $self->_process_transcripts( $transcripts, undef )
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
  my $transcript_adaptor = $db_adaptor->get_TranscriptAdaptor()
    || confess( "Cannot get EnsEMBL TranscriptAdaptor in $self" );
  
  my $counter = 0;
  my $strings = $string_factory->strings() || [];
  my $strings_size = scalar( @{ $strings } );
  
  foreach my $string( @{ $strings } ) {
    ++$counter;
    print STDERR "\r#Retrieving EnsEMBL($source) transcript '$string': $counter/$strings_size done...     ";

    my @transcripts;

    {
      my $transcript = $transcript_adaptor->fetch_by_stable_id( $string );
      if( $transcript ) { @transcripts = ( $transcript ); }
    }
      
    if( !@transcripts ) {
      @transcripts = @{ $transcript_adaptor->fetch_all_by_external_name( $string ) };
    }
    
    $self->_process_transcripts( \@transcripts, $string );
  }

  print STDERR "\r#Retrieved $counter EnsEMBL($source) transcripts"
    . ( " " x 40 ) . "\n";

  return 1;
}

##########################################################################

sub _process_database_all_transcripts
{
  my( $self ) = @_;
  
  my $sequence_factory = new BioMinerva::DNALib::EnsEmblSequenceFactory();
  $sequence_factory->set_database_name( $self->get_database_name() );
  $sequence_factory->set_top_level_sequence_type( $self->get_top_level_sequence_type() );
 
  $self->_process_database_by_sequence_factory( $sequence_factory );
}

##########################################################################

sub _process_transcripts
{
  my( $self, $transcripts, $string ) = @_;

  my $num = 1;
  my $string_num;
  
  my $exon_id2exon_feature = {};
  my $cds_id2cds_feature = {};
  my $five_utr_id2five_utr_feature = {};
  my $three_utr_id2three_utr_feature = {};
  
  foreach my $transcript( @{ $transcripts } ) {
    my $string_num = ( scalar( @{ $transcripts } ) > 1 )
      ? "$string:$num"
      : $string;
    
    my $feature = $self->_transcript2feature( 
      $transcript, 
      $string, 
      $string_num, 
      $exon_id2exon_feature,
      $cds_id2cds_feature,
      $five_utr_id2five_utr_feature,
      $three_utr_id2three_utr_feature
    );
    if( ref( $feature ) ) {
      $self->_add_feature( $feature );
    }

    ++$num;
  }
}

##########################################################################

sub _transcript2feature
{
  my( $self, $transcript, $string, $string_num, 
    $exon_id2exon_feature,
    $cds_id2cds_feature,
    $five_utr_id2five_utr_feature,
    $three_utr_id2three_utr_feature
  ) = @_;
  
  my $use_id = $self->get_use_id();
  my $string_attr = $self->get_string_attr();
  my $ensembl_id_attr = $self->get_ensembl_id_attr();
  my $ensembl_external_name_attr = $self->get_ensembl_external_name_attr();
  my $ensembl_description_attr = $self->get_ensembl_description_attr();
  my $coding_region_start_attr = $self->get_coding_region_start_attr();
  my $coding_region_end_attr = $self->get_coding_region_end_attr();
  my $ensembl_exon_feature_factory = $self->get_ensembl_exon_feature_factory();

  my $ensembl_id = $transcript->stable_id();
  my $ensembl_external_name = $transcript->external_name();
  
  my $feature = $self->_create_feature( 'mRNA' );
  
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
  
  $feature->set_primary_sequence_id( $transcript->slice()->seq_region_name() );
  $feature->set_start( $transcript->start() );
  $feature->set_end( $transcript->end() );
  $feature->set_strand( $transcript->strand() );
  
  if( $string_attr && $string ) {
    $feature->add_attr( $string_attr, $string );
  }
  if( $ensembl_id_attr ) {
    $feature->add_attr( $ensembl_id_attr, $ensembl_id );
  }
  if( $ensembl_external_name_attr && $ensembl_external_name ) {
    $feature->add_attr( $ensembl_external_name_attr, $ensembl_external_name );
  }
  if( $ensembl_description_attr && $transcript->description() ) {
    $feature->add_attr( $ensembl_description_attr, $transcript->description() );
  }

  my $coding_region_start = $transcript->coding_region_start();
  my $coding_region_end = $transcript->coding_region_end();
  
  my $coding_feature;
  if( defined( $coding_region_start ) && defined( $coding_region_end ) ) {
    $coding_feature = new BioMinerva::DNALib::Feature();
    $coding_feature->set_primary_sequence_id( $feature->get_primary_sequence_id() );
    $coding_feature->set_start( $coding_region_start );
    $coding_feature->set_end( $coding_region_end );
    $coding_feature->set_strand( $feature->get_strand() );
  }
  
  if( defined( $coding_region_start_attr ) ) {
    if( defined( $coding_region_start ) ) {
      $feature->add_attr( $coding_region_start_attr, $coding_region_start );
    }
  }
  if( defined( $coding_region_end_attr ) ) {
    if( defined( $coding_region_end ) ) {
      $feature->add_attr( $coding_region_end_attr, $coding_region_end );
    }
  }
  
  if( ref( $ensembl_exon_feature_factory ) ) {
    my $exons = $transcript->get_all_Exons();
    
    $exon_id2exon_feature ||= {};
    foreach my $exon( @{ $exons || [] } ) {
      if( !exists( $exon_id2exon_feature->{ $exon->display_id() } ) ) {
        $exon_id2exon_feature->{ $exon->display_id() } =
          $ensembl_exon_feature_factory->_exon2feature( $exon );
      }

      my $exon_feature = $exon_id2exon_feature->{ $exon->display_id() };
      if( defined( $exon_feature ) ) {
        $feature->add_part_feature( $exon_feature );
        
        if( $self->get_generate_cds() && ref( $coding_feature ) ) {
          $cds_id2cds_feature ||= {};

          if( $exon_feature->overlaps( $coding_feature ) ) {
            my $cds_sequence = $exon_feature->intersection_sequence( $coding_feature );
            my $id = $cds_sequence->location_str();
            if( !exists( $cds_id2cds_feature->{ $id } ) ) {
              my $cds_feature = $self->_create_feature( 'CDS' );
              $cds_feature->set_sequence( $cds_sequence );
              $cds_feature->set_strand( $feature->get_strand() );
              if( defined( $exon_feature->attr( 'Phase' ) ) ) {
                $cds_feature->add_attr( 'Phase',
                  @{ $exon_feature->attr( 'Phase' ) }
                );
              }
              $cds_id2cds_feature->{ $id } = $cds_feature;
            }
            $feature->add_part_feature( $cds_id2cds_feature->{ $id } );
          }
        }
        
        if( $self->get_generate_five_utr() && ref( $coding_feature ) ) {
          $five_utr_id2five_utr_feature ||= {};

          my $five_utr_sequence = $exon_feature->upstream_fragment_sequence( $coding_feature );
          if( ref( $five_utr_sequence ) ) {
            my $id = $five_utr_sequence->location_str();
            if( !exists( $five_utr_id2five_utr_feature->{ $id } ) ) {
              my $five_utr_feature = $self->_create_feature( '5\'-UTR' );
              $five_utr_feature->set_sequence( $five_utr_sequence );
              $five_utr_feature->set_strand( $feature->get_strand() );
              $five_utr_id2five_utr_feature->{ $id } = $five_utr_feature;
            }
            $feature->add_part_feature( $five_utr_id2five_utr_feature->{ $id } );
          }
        }

        if( $self->get_generate_three_utr() && ref( $coding_feature ) ) {
          $three_utr_id2three_utr_feature ||= {};

          my $three_utr_sequence = $exon_feature->downstream_fragment_sequence( $coding_feature );
          if( ref( $three_utr_sequence ) ) {
            my $id = $three_utr_sequence->location_str();
            if( !exists( $three_utr_id2three_utr_feature->{ $id } ) ) {
              my $three_utr_feature = $self->_create_feature( '3\'-UTR' );
              $three_utr_feature->set_sequence( $three_utr_sequence );
              $three_utr_feature->set_strand( $feature->get_strand() );
              $three_utr_id2three_utr_feature->{ $id } = $three_utr_feature;
            }
            $feature->add_part_feature( $three_utr_id2three_utr_feature->{ $id } );
          }
        }
      }
    }
  }

  return $feature;
}

##########################################################################

1;

