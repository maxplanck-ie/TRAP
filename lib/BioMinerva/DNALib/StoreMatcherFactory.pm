##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::DNALib::StoreMatcherFactory;

# for proper versioning
use BioMinerva::DNALib;
our $VERSION = $BioMinerva::DNALib::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::DNALib::MatcherFactory;
@ISA = qw( BioMinerva::DNALib::MatcherFactory );

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

###--- <array_property id='matcher' ids='matchers' add_id='add_matcher'>
###---   <auto:comment id="matchers" md5="6tCKd6QnGip1uGvArJ/Hbg">

=head2 matchers

 Title   : matchers (array property)
 
 Usage   : C<<< my $matchers = $object->matchers();
           if( defined( $matchers ) ) { 
             foreach my $matcher( @{ $matchers } ) {
               ...
             }
           } >>>
           
           C<<< $object->matchers( $matchers ); >>>
 
           C<<< $object->matchers( undef ); >>>

 Function: Accessor to the array property C<matchers>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of matchers to be set
           clear-accessor: undef

 Return  : reference to the current array of matchers or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="matchers" md5="oqr8ZKGWt7WtJ8skj835RA">

sub matchers {
  my $self = shift @_;
  if( @_ ) {
    my $matchers = shift @_;
    if( defined( $matchers ) && ref( $matchers ) ne 'ARRAY' ) {
      confess( "Property 'matchers' requires an ARRAY argument (now: $matchers)." );
    }
    $self->{ 'matchers' } = $matchers;
  }
  return $self->{ 'matchers' };
}

###---   </auto:code>
###---   <auto:comment id="add_matcher" md5="xwAag0bvXxr9g5vdmi/lNg">

=head2 add_matcher

 Title   : add_matcher (matchers property)
 
 Usage   : C<<< $object->add_matcher( $matcher, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< matchers >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_matcher" md5="ojqlm3sDHY4cGOtr7pJryg">

sub add_matcher {
  my $self = shift @_;
  my @matchers = @_;
  $self->{ 'matchers' } ||= [];
  push @{ $self->{ 'matchers' } }, @matchers;
  return undef;
}

###---   </auto:code>
###--- </array_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;

