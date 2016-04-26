##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StrandedRange;

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
  
  if( !ref( $clone ) ) {
    $clone = new BioMinerva::DNALib::StrandedRange();
  }
  $self->SUPER::clone( $clone );

  $clone->set_primary_sequence_id( $self->get_primary_sequence_id() );
  $clone->set_start( $self->get_start() );
  $clone->set_end( $self->get_end() );
  $clone->set_strand( $self->get_strand() );
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <scalar_property id='primary_sequence_id' get_id='' set_id=''>
###---   <auto:comment id="primary_sequence_id" md5="biAKCpTbLEYDB0Z7cVYOTA">

=head2 primary_sequence_id

 Title   : primary_sequence_id property
 
 Usage   : $object->primary_sequence_id(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="primary_sequence_id" md5="JgJrMRpWKFUbftQpSmnO0A">

sub primary_sequence_id {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'primary_sequence_id' } = shift @_;
  }
  return $self->{ 'primary_sequence_id' };
}

###---   </auto:code>
###---   <auto:code get_id="get_primary_sequence_id" md5="GY24CkWQyyYV5XIuQ8+jyA">

sub get_primary_sequence_id {
  return shift->{ 'primary_sequence_id' };
}

###---   </auto:code>
###---   <auto:code set_id="set_primary_sequence_id" md5="u0w5JJgYEXxeT/MCXwh+aA">

sub set_primary_sequence_id {
  my $self = shift @_;
  $self->{ 'primary_sequence_id' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='start' get_id='' set_id=''>
###---   <auto:comment id="start" md5="rtgE5hpjDPYbB3zOjUgdxw">

=head2 start

 Title   : start property
 
 Usage   : $object->start(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="start" md5="RVAr90N5wffq0NH9+zHtRQ">

sub start {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'start' } = shift @_;
  }
  return $self->{ 'start' };
}

###---   </auto:code>
###---   <auto:code get_id="get_start" md5="uSgYqeLElTjiJI3pUWLVKw">

sub get_start {
  return shift->{ 'start' };
}

###---   </auto:code>
###---   <auto:code set_id="set_start" md5="ubikrgIYK+BjWHFdSBEt0g">

sub set_start {
  my $self = shift @_;
  $self->{ 'start' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='end' get_id='' set_id=''>
###---   <auto:comment id="end" md5="fBc36U+ODaCEyKOLIDq+Dg">

=head2 end

 Title   : end property
 
 Usage   : $object->end(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="end" md5="xOKYiYHMVHyd/7HMjs4SIA">

sub end {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'end' } = shift @_;
  }
  return $self->{ 'end' };
}

###---   </auto:code>
###---   <auto:code get_id="get_end" md5="8uIzaZ3LsZOmtzSy50VKuw">

sub get_end {
  return shift->{ 'end' };
}

###---   </auto:code>
###---   <auto:code set_id="set_end" md5="TFB8n8tVItphYJZk3Cj2fA">

sub set_end {
  my $self = shift @_;
  $self->{ 'end' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='strand' get_id='' set_id=''>
###---   <auto:comment id="strand" md5="kkvZgFPTmrr83REcDOEIxg">

=head2 strand

 Title   : strand property
 
 Usage   : $object->strand(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="strand" md5="1SGYxSZ2vPeP2im+HZdwTg">

sub strand {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'strand' } = shift @_;
  }
  return $self->{ 'strand' };
}

###---   </auto:code>
###---   <auto:code get_id="get_strand" md5="fcgHF0aMAE1nMqxqDRMGMg">

sub get_strand {
  return shift->{ 'strand' };
}

###---   </auto:code>
###---   <auto:code set_id="set_strand" md5="OA071DuJkk9Bk0B1qh1sGw">

sub set_strand {
  my $self = shift @_;
  $self->{ 'strand' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

sub digest
{
  my( $self ) = @_;
  
  my $digest = $self->SUPER::digest();
  
  $digest->add( $self->get_primary_sequence_id() || '' );
  $digest->add( $self->get_start() || '' );
  $digest->add( $self->get_end() || '' );
  $digest->add( $self->get_strand() || '' );

  return $digest;
}

sub display_id
{
  my( $self ) = @_;
  
  my $display_id = $self->SUPER::display_id();
  if( $display_id ) { return $display_id; }

  return $self->location_str();
}

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'primary_sequence_id', $self->get_primary_sequence_id() );
  $target->property( 'start', $self->get_start() );
  $target->property( 'end', $self->get_end() );
  $target->property( 'strand', $self->get_strand() );
  $target->property( 'length', $self->length() );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub empty
{
  my( $self ) = @_;

  return 0;
}

sub length
{
  my( $self ) = @_;

  return $self->get_end() - $self->get_start() + 1;
}

sub location_str
{
  my( $self ) = @_;

  return 
    $self->get_primary_sequence_id()
    . ":"
    . $self->get_start()
    . ".."
    . $self->get_end()
    . ( defined( $self->get_strand() )
      ? ( ":" . $self->get_strand() )
      : ""
    );
}

##########################################################################
# Equality and containment
##########################################################################

sub equals
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) { return 0; }
  if( $self->get_start() != $sequence->get_start() ) { return 0; }
  if( $self->get_end() != $sequence->get_end() ) { return 0; }
  if( $self->get_strand() != $sequence->get_strand() ) { return 0; }

  return 1;
}

sub contains
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) { return 0; }
  if( $self->get_start() <= $sequence->get_start() && $self->get_end() >= $sequence->get_end() ) { return 1; }

  return 0;
}

sub overlaps
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) { return 0; }
  if( $self->get_start() > $sequence->get_end() ) { return 0; }
  if( $self->get_end() < $sequence->get_start() ) { return 0; }

  return 1;
}

sub overlaps_with_any
{
  my( $self, $sequences ) = @_;

  foreach my $sequence( @{ $sequences || [] } ) {
    if( $self->overlaps( $sequence ) ) {
      return 1;
    }
  }

  return 0;
}

##########################################################################
# Relative location functions
##########################################################################

sub located_before_start
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow determination of located_before_start of $self and $sequence" );
  }

  return $self->get_end() < $sequence->get_start();
}

sub located_up_to_end
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow determination of located_up_to_end of $self and $sequence" );
  }

  return $self->get_end() <= $sequence->get_end();
}

sub located_after_end
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    confess( "Different primary_sequences disallow determination of located_after_end of $self and $sequence" );
  }

  return $self->get_start() > $sequence->get_end();
}

##########################################################################
# SELF MODIFIERS
##########################################################################

sub trim
{
  my( $self, $sequence ) = @_;

  if( !$self->overlaps( $sequence ) ) {
    confess( "Can not trim to nonoverlapping sequences in $self to $sequence" );
  }

  if( $self->get_start() < $sequence->get_start() )
    { $self->set_start( $sequence->get_start() ); }
  if( $self->get_end() > $sequence->get_end() )
    { $self->set_end( $sequence->get_end() ); }
}

sub complement
{
  my( $self ) = @_;

  if( !$self->get_strand() ) {
    confess( "Can not complement a sequence with no/zero strand as in $self" );
  } else {
    $self->set_strand( $self->get_strand() * -1 );
  }
}

#NOTE: this procedure must throw if no valid result can be obtained; use
#      union_sequence for non-throwing behaviour
sub union
{
  my( $self, $sequence ) = @_;
  
  if( 
    $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() 
    || $self->get_start() > $sequence->get_end() 
    || $self->get_end() < $sequence->get_start() 
  ) {
    confess( "Cannot union nonoverlapping sequences $self and $sequence" );
  }

  if( $self->get_start() > $sequence->get_start() ) {
    $self->set_start( $sequence->get_start() );
  }

  if( $self->get_end() < $sequence->get_end() ) {
    $self->set_end( $sequence->get_end() );
  }
}

#NOTE: this procedure must throw if no valid result can be obtained; use
#      intersect_sequence for non-throwing behaviour
sub intersect
{
  my( $self, $sequence ) = @_;
  
  if( 
    $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() 
    || $self->get_start() > $sequence->get_end() 
    || $self->get_end() < $sequence->get_start() 
  ) {
    confess( "Cannot intersect nonoverlapping sequences $self and $sequence" );
  }

  if( $self->get_start() < $sequence->get_start() ) {
    $self->set_start( $sequence->get_start() );
  }

  if( $self->get_end() > $sequence->get_end() ) {
    $self->set_end( $sequence->get_end() );
  }
}

##########################################################################
# UTILS
##########################################################################

sub relative_location_symbol
{
  my( $self, $sequence ) = @_;

  if( $self->get_primary_sequence_id() ne $sequence->get_primary_sequence_id() ) {
    return 'xx';
  }
  
  my $ret;
  
  if( $self->get_start() < $sequence->get_start() ) { $ret .= '<'; }
  elsif( $self->get_start() <= $sequence->get_end() ) { $ret .= '|'; }
  else { $ret .= '>'; }
  
  if( $self->get_end() < $sequence->get_start() ) { $ret .= '<'; }
  elsif( $self->get_end() <= $sequence->get_end() ) { $ret .= '|'; }
  else { $ret .= '>'; }

  return $ret;
}

##########################################################################

1;

