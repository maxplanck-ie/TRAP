##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::BlastPairwiseAlignment;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::IdObject;
@ISA = qw( BioMinerva::Base::IdObject );

use Carp qw( confess croak carp );

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

###--- <scalar_property id='query_sequence' get_id='' set_id='' type_id='BioMinerva::DNALib::Sequence'>
###---   <auto:comment id="query_sequence" md5="qlgcIUgl2LX2WfyUdvELzA">

=head2 query_sequence

 Title   : query_sequence property
 
 Usage   : $object->query_sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="query_sequence" md5="xt3KS8tTOah85x3IbuQRxQ">

sub query_sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'query_sequence' } = shift @_;
  }
  return $self->{ 'query_sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="get_query_sequence" md5="tvjGmq5KYCXpRU4PoxxvEw">

sub get_query_sequence {
  return shift->{ 'query_sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="set_query_sequence" md5="6DkMxazBDHLgu0HAweWwfg">

sub set_query_sequence {
  my $self = shift @_;
  $self->{ 'query_sequence' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='target_sequence' get_id='' set_id='' type_id='BioMinerva::DNALib::Sequence'>
###---   <auto:comment id="target_sequence" md5="n0Y8iIFEzSLz5jeb6YVFRw">

=head2 target_sequence

 Title   : target_sequence property
 
 Usage   : $object->target_sequence(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="target_sequence" md5="1iQot3ufF7TVCnl6Eh4T1Q">

sub target_sequence {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'target_sequence' } = shift @_;
  }
  return $self->{ 'target_sequence' };
}

###---   </auto:code>
###---   <auto:code get_id="get_target_sequence" md5="t7fnE4i/Mr0ZYNcK8tGkzw">

sub get_target_sequence {
  return shift->{ 'target_sequence' };
}

###---   </auto:code>
###---   <auto:code set_id="set_target_sequence" md5="17/oaybRfkEjwOT9n3zh3g">

sub set_target_sequence {
  my $self = shift @_;
  $self->{ 'target_sequence' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='identity' get_id='' set_id=''>
###---   <auto:comment id="identity" md5="fqCOeSvOQAPucI3mqoohFw">

=head2 identity

 Title   : identity property
 
 Usage   : $object->identity(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="identity" md5="lwHzM1CtaksXCIoPZ43VDQ">

sub identity {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'identity' } = shift @_;
  }
  return $self->{ 'identity' };
}

###---   </auto:code>
###---   <auto:code get_id="get_identity" md5="OihB5FNobmoBSGjnEBfhKA">

sub get_identity {
  return shift->{ 'identity' };
}

###---   </auto:code>
###---   <auto:code set_id="set_identity" md5="XXFrMGG5PIglRVXhn1OTjw">

sub set_identity {
  my $self = shift @_;
  $self->{ 'identity' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='alignment_length' get_id='' set_id=''>
###---   <auto:comment id="alignment_length" md5="X2LD0y1gnVh6K/zpB0vh7Q">

=head2 alignment_length

 Title   : alignment_length property
 
 Usage   : $object->alignment_length(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="alignment_length" md5="a3NPs1l+fYxurrR5bxLe1g">

sub alignment_length {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'alignment_length' } = shift @_;
  }
  return $self->{ 'alignment_length' };
}

###---   </auto:code>
###---   <auto:code get_id="get_alignment_length" md5="HSjkgqPDX+9oUqO003yH7Q">

sub get_alignment_length {
  return shift->{ 'alignment_length' };
}

###---   </auto:code>
###---   <auto:code set_id="set_alignment_length" md5="cmE4lJygJcFyfEIWUPINsw">

sub set_alignment_length {
  my $self = shift @_;
  $self->{ 'alignment_length' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='mismatches' get_id='' set_id=''>
###---   <auto:comment id="mismatches" md5="fKYgme6thmOYZPXi3xFMFQ">

=head2 mismatches

 Title   : mismatches property
 
 Usage   : $object->mismatches(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="mismatches" md5="agLc28W2FM4MAPlDCt75Dg">

sub mismatches {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'mismatches' } = shift @_;
  }
  return $self->{ 'mismatches' };
}

###---   </auto:code>
###---   <auto:code get_id="get_mismatches" md5="tUjzjdo57aravnFteeQOKg">

sub get_mismatches {
  return shift->{ 'mismatches' };
}

###---   </auto:code>
###---   <auto:code set_id="set_mismatches" md5="u3jeO2TLJP44B4ho1MkRHg">

sub set_mismatches {
  my $self = shift @_;
  $self->{ 'mismatches' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='gaps' get_id='' set_id=''>
###---   <auto:comment id="gaps" md5="9dTnqkImEmGNJ27pGMYd+w">

=head2 gaps

 Title   : gaps property
 
 Usage   : $object->gaps(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="gaps" md5="QkX+69X/WjrvGIwcypUQOw">

sub gaps {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'gaps' } = shift @_;
  }
  return $self->{ 'gaps' };
}

###---   </auto:code>
###---   <auto:code get_id="get_gaps" md5="37w/p7kdtRdZL9/SqcLSJw">

sub get_gaps {
  return shift->{ 'gaps' };
}

###---   </auto:code>
###---   <auto:code set_id="set_gaps" md5="vjgrx93KOo4miHz3brnT0g">

sub set_gaps {
  my $self = shift @_;
  $self->{ 'gaps' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='e_value' get_id='' set_id=''>
###---   <auto:comment id="e_value" md5="hqU0MXJ9Fd8Z+ddW2TqXjQ">

=head2 e_value

 Title   : e_value property
 
 Usage   : $object->e_value(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="e_value" md5="VJtOvkVuNMBFbqvgPgFCRw">

sub e_value {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'e_value' } = shift @_;
  }
  return $self->{ 'e_value' };
}

###---   </auto:code>
###---   <auto:code get_id="get_e_value" md5="TcBndBtCW9i6FLg4E8QxJw">

sub get_e_value {
  return shift->{ 'e_value' };
}

###---   </auto:code>
###---   <auto:code set_id="set_e_value" md5="JSJ+BXYXhKanihzty5q76Q">

sub set_e_value {
  my $self = shift @_;
  $self->{ 'e_value' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='bit_score' get_id='' set_id=''>
###---   <auto:comment id="bit_score" md5="QrQc0ZKQySHSPve+YA1djg">

=head2 bit_score

 Title   : bit_score property
 
 Usage   : $object->bit_score(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="bit_score" md5="FFpwTBzvVc8384jOzhHiZg">

sub bit_score {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'bit_score' } = shift @_;
  }
  return $self->{ 'bit_score' };
}

###---   </auto:code>
###---   <auto:code get_id="get_bit_score" md5="O54chQhVu2ZKlaCTMQ4+NA">

sub get_bit_score {
  return shift->{ 'bit_score' };
}

###---   </auto:code>
###---   <auto:code set_id="set_bit_score" md5="VczXjm9gzDJfZ+mHx4TIzQ">

sub set_bit_score {
  my $self = shift @_;
  $self->{ 'bit_score' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();

  confess( "Not overridden in $self" );
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'query_sequence', $self->get_query_sequence() );
  $target->property( 'target_sequence', $self->get_target_sequence() );
  $target->property( 'identity', $self->get_identity() );
  $target->property( 'alignment_length', $self->get_alignment_length() );
  $target->property( 'mismatches', $self->get_mismatches() );
  $target->property( 'gaps', $self->get_gaps() );
  $target->property( 'e_value', $self->get_e_value() );
  $target->property( 'bit_score', $self->get_bit_score() );
}

##########################################################################

1;

