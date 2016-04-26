##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::ConfPropertiesReporter;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

sub new {
  my( $caller ) = @_;
  my $class = ref( $caller ) || $caller;

  my $self = {};
  bless( $self, $class );
  return $self;
}

##########################################################################
# PROPERTIES
##########################################################################

###--- <array_property id='_property' ids='properties' add_id='property'>
###---   <auto:comment id="properties" md5="EEhSqzBluNnW+F7cSmsQBw">

=head2 properties

 Title   : properties (array property)
 
 Usage   : C<<< my $properties = $object->properties();
           if( defined( $properties ) ) { 
             foreach my $_property( @{ $properties } ) {
               ...
             }
           } >>>
           
           C<<< $object->properties( $properties ); >>>
 
           C<<< $object->properties( undef ); >>>

 Function: Accessor to the array property C<properties>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of properties to be set
           clear-accessor: undef

 Return  : reference to the current array of properties or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="properties" md5="zloTHKcFRvJu2FL0aRRUlQ">

sub properties {
  my $self = shift @_;
  if( @_ ) {
    my $properties = shift @_;
    if( defined( $properties ) && ref( $properties ) ne 'ARRAY' ) {
      confess( "Property 'properties' requires an ARRAY argument (now: $properties)." );
    }
    $self->{ 'properties' } = $properties;
  }
  return $self->{ 'properties' };
}

###---   </auto:code>
###---   <auto:comment id="property" md5="yOugr21oDX1Q2F8dHQeHHA">

=head2 property

 Title   : property (properties property)
 
 Usage   : C<<< $object->property( $_property, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< properties >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="property" md5="0DGnrBikHL88xQIqCCLOZw">

sub property {
  my $self = shift @_;
  my @properties = @_;
  $self->{ 'properties' } ||= [];
  push @{ $self->{ 'properties' } }, @properties;
  return undef;
}

###---   </auto:code>
###--- </array_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

##########################################################################

1;
