##########################################################################

package BioMinerva::DNALib::StoreMatchProcessor;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatchProcessor;
@ISA = qw( BioMinerva::DNALib::MatchProcessor );

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

###--- <array_property id="match" ids="matches" add_id="add_match">
###---   <auto:comment id="matches" md5="bjgzKZ4d0Ei8XzyBfoWIxQ">

=head2 matches

 Title   : matches (array property)
 
 Usage   : C<<< my $matches = $object->matches();
           if( defined( $matches ) ) { 
             foreach my $match( @{ $matches } ) {
               ...
             }
           } >>>
           
           C<<< $object->matches( $matches ); >>>
 
           C<<< $object->matches( undef ); >>>

 Function: Accessor to the array property C<matches>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of matches to be set
           clear-accessor: undef

 Return  : reference to the current array of matches or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="matches" md5="37xCK6YLEyO5rTkkQp9z1w">

sub matches {
  my $self = shift @_;
  if( @_ ) {
    my $matches = shift @_;
    if( defined( $matches ) && ref( $matches ) ne 'ARRAY' ) {
      confess( "Property 'matches' requires an ARRAY argument (now: $matches)." );
    }
    $self->{ 'matches' } = $matches;
  }
  return $self->{ 'matches' };
}

###---   </auto:code>
###---   <auto:comment id="add_match" md5="dgykxwQvW0SM8K1ni60Maw">

=head2 add_match

 Title   : add_match (matches property)
 
 Usage   : C<<< $object->add_match( $match, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< matches >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_match" md5="q0pbmVzDNcBAPKf1Dlfv9w">

sub add_match {
  my $self = shift @_;
  my @matches = @_;
  $self->{ 'matches' } ||= [];
  push @{ $self->{ 'matches' } }, @matches;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_match
{
  my( $self, $match ) = @_;

  $self->add_match( $match );
}

##########################################################################

1;
