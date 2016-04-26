##########################################################################

use strict;
use warnings;

##########################################################################

package BioMinerva::Base::Creator;

# for proper versioning
use BioMinerva::Base;
our $VERSION = $BioMinerva::Base::VERSION;

##########################################################################

use vars qw( @ISA );
use BioMinerva::Base::Object;
@ISA = qw( BioMinerva::Base::Object );

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

###--- <scalar_property id='type' get_id='get_type' set_id='set_type' assignable_once='1'>
###---   <auto:comment id="type" md5="XezXTEMbnbJDRq3e1bk7dw">

=head2 type

 Title   : type property
 
 Usage   : $object->type(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="type" md5="p0Cj5KdyYQ7fWlzcEur9vw">

sub type {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'type' } = shift @_;
  }
  return $self->{ 'type' };
}

###---   </auto:code>
###---   <auto:code get_id="get_type" md5="bsqUsOoQFpKYVSsxsj/MGg">

sub get_type {
  return shift->{ 'type' };
}

###---   </auto:code>
###---   <auto:code set_id="set_type" md5="vgQvqMIBCa/6ytBNof6ytA">

sub set_type {
  my $self = shift @_;
  $self->{ 'type' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <scalar_property id='function' get_id='get_function' set_id='set_function' assignable_once='1'>
###---   <auto:comment id="function" md5="98HHl8EyPDYemK+1pzPisQ">

=head2 function

 Title   : function property
 
 Usage   : $object->function(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="function" md5="LFYp16QZ6l+pqz1Ie0d5UA">

sub function {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'function' } = shift @_;
  }
  return $self->{ 'function' };
}

###---   </auto:code>
###---   <auto:code get_id="get_function" md5="380IZeT/lPQ8QKcdkwXTlg">

sub get_function {
  return shift->{ 'function' };
}

###---   </auto:code>
###---   <auto:code set_id="set_function" md5="WwvcXGN9199MAPfWsWxZhg">

sub set_function {
  my $self = shift @_;
  $self->{ 'function' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

###--- <array_property id='category' ids='categories' add_id='add_category'>
###---   <auto:comment id="categories" md5="BXKfl5q+lBmpwMUi+DU6Ow">

=head2 categories

 Title   : categories (array property)
 
 Usage   : C<<< my $categories = $object->categories();
           if( defined( $categories ) ) { 
             foreach my $category( @{ $categories } ) {
               ...
             }
           } >>>
           
           C<<< $object->categories( $categories ); >>>
 
           C<<< $object->categories( undef ); >>>

 Function: Accessor to the array property C<categories>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of categories to be set
           clear-accessor: undef

 Return  : reference to the current array of categories or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="categories" md5="mevx6FaGYxQiWSD/EdfGOw">

sub categories {
  my $self = shift @_;
  if( @_ ) {
    my $categories = shift @_;
    if( defined( $categories ) && ref( $categories ) ne 'ARRAY' ) {
      confess( "Property 'categories' requires an ARRAY argument (now: $categories)." );
    }
    $self->{ 'categories' } = $categories;
  }
  return $self->{ 'categories' };
}

###---   </auto:code>
###---   <auto:comment id="add_category" md5="B8Ngtt64i2xIvcHCfp1+ug">

=head2 add_category

 Title   : add_category (categories property)
 
 Usage   : C<<< $object->add_category( $category, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< categories >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_category" md5="H/QQf8pbACYUIf6d0CH8fQ">

sub add_category {
  my $self = shift @_;
  my @categories = @_;
  $self->{ 'categories' } ||= [];
  push @{ $self->{ 'categories' } }, @categories;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <array_property id='alias' ids='aliases' add_id='add_alias'>
###---   <auto:comment id="aliases" md5="UpJ+f6P8AOWltXXCF+Fw5g">

=head2 aliases

 Title   : aliases (array property)
 
 Usage   : C<<< my $aliases = $object->aliases();
           if( defined( $aliases ) ) { 
             foreach my $alias( @{ $aliases } ) {
               ...
             }
           } >>>
           
           C<<< $object->aliases( $aliases ); >>>
 
           C<<< $object->aliases( undef ); >>>

 Function: Accessor to the array property C<aliases>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of aliases to be set
           clear-accessor: undef

 Return  : reference to the current array of aliases or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="aliases" md5="0eJopK95q6+Ckb7wjH6Kyg">

sub aliases {
  my $self = shift @_;
  if( @_ ) {
    my $aliases = shift @_;
    if( defined( $aliases ) && ref( $aliases ) ne 'ARRAY' ) {
      confess( "Property 'aliases' requires an ARRAY argument (now: $aliases)." );
    }
    $self->{ 'aliases' } = $aliases;
  }
  return $self->{ 'aliases' };
}

###---   </auto:code>
###---   <auto:comment id="add_alias" md5="Ue/kSvGaOdEuT9GItt8tNw">

=head2 add_alias

 Title   : add_alias (aliases property)
 
 Usage   : C<<< $object->add_alias( $alias, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< aliases >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_alias" md5="jCCr98zyLBPJzr4h3bOzkw">

sub add_alias {
  my $self = shift @_;
  my @aliases = @_;
  $self->{ 'aliases' } ||= [];
  push @{ $self->{ 'aliases' } }, @aliases;
  return undef;
}

###---   </auto:code>
###--- </array_property>

###--- <array_property id='subtype_creator' ids='subtype_creators' add_id='add_subtype_creator'>
###---   <auto:comment id="subtype_creators" md5="cSniHVAyDr8Y8vKuI2UAgg">

=head2 subtype_creators

 Title   : subtype_creators (array property)
 
 Usage   : C<<< my $subtype_creators = $object->subtype_creators();
           if( defined( $subtype_creators ) ) { 
             foreach my $subtype_creator( @{ $subtype_creators } ) {
               ...
             }
           } >>>
           
           C<<< $object->subtype_creators( $subtype_creators ); >>>
 
           C<<< $object->subtype_creators( undef ); >>>

 Function: Accessor to the array property C<subtype_creators>.
 
 Default : undef
 
 Args    : get-accessor: empty 
           set-accessor: reference to an array of subtype_creators to be set
           clear-accessor: undef

 Return  : reference to the current array of subtype_creators or 
           undef after clearing given nothing has been set/added yet
 
=cut

###---   </auto:comment>
###---   <auto:code id="subtype_creators" md5="LVwnhPaJe3NKbfsBb7JRzg">

sub subtype_creators {
  my $self = shift @_;
  if( @_ ) {
    my $subtype_creators = shift @_;
    if( defined( $subtype_creators ) && ref( $subtype_creators ) ne 'ARRAY' ) {
      confess( "Property 'subtype_creators' requires an ARRAY argument (now: $subtype_creators)." );
    }
    $self->{ 'subtype_creators' } = $subtype_creators;
  }
  return $self->{ 'subtype_creators' };
}

###---   </auto:code>
###---   <auto:comment id="add_subtype_creator" md5="nXpxZAC3VMdbsKMhFCdYvA">

=head2 add_subtype_creator

 Title   : add_subtype_creator (subtype_creators property)
 
 Usage   : C<<< $object->add_subtype_creator( $subtype_creator, ... ); >>>
 
 Function: Adds one or more element(s) to the array property C<< subtype_creators >>.
 
 Args    : List of elements to be added.

 Return  : undef
 
=cut

###---   </auto:comment>
###---   <auto:code id="add_subtype_creator" md5="71rzoa9nJ+Q6NcSaaKi1xQ">

sub add_subtype_creator {
  my $self = shift @_;
  my @subtype_creators = @_;
  $self->{ 'subtype_creators' } ||= [];
  push @{ $self->{ 'subtype_creators' } }, @subtype_creators;
  return undef;
}

###---   </auto:code>
###--- </array_property>

sub report_state
{
  my( $self, $target ) = @_;

  $self->SUPER::report_state( $target );
  $target->property( 'type', $self->type() );
  $target->property( 'categories', $self->categories() );
  $target->property( 'aliases', $self->aliases() );
  $target->property( 'subtype_creators', $self->subtype_creators() );
}

sub report_conf_properties
{
  my( $self, $target ) = @_;
  
  $self->SUPER::report_conf_properties( $target );
#  $target->property( '' );
}

sub set_conf_property
{
  my( $self, $property, @values ) = @_;
  
#  elsif( $property eq '' ) { $self->( @values ); }
#  else { 
    $self->SUPER::set_conf_property( $property, @values ); 
#  }
}

##########################################################################
# FUNCTIONALITY
##########################################################################

sub get_by_type
{
  my( $self, $type ) = @_;

  if( $type eq $self->type() ) { return $self; }
  foreach my $subtype_creator( @{ $self->subtype_creators() || [] } ) {
    my $creator = $subtype_creator->get_by_type( $type );
    if( ref( $creator ) ) { return $creator; }
  }
  return undef;
}

sub get_by_category
{
  my( $self, $category ) = @_;

  foreach my $c( @{ $self->categories() || [] } ) {
    if( $c eq $category ) { return $self; }
  }
  foreach my $subtype_creator( @{ $self->subtype_creators() || [] } ) {
    my $creator = $subtype_creator->get_by_category( $category );
    if( ref( $creator ) ) { return $creator; }
  }
  return undef;
}

sub get_by_alias
{
  my( $self, $alias ) = @_;

  foreach my $a( @{ $self->aliases() || [] } ) {
    if( $a eq $alias ) { return $self; }
  }
  foreach my $subtype_creator( @{ $self->subtype_creators() || [] } ) {
    my $creator = $subtype_creator->get_by_alias( $alias );
    if( ref( $creator ) ) { return $creator; }
  }
  return undef;
}

sub get_all_categories
{
  my( $self ) = @_;

  my @categories;
  $self->_get_all_categories( \@categories );
  return \@categories;
}

sub _get_all_categories
{
  my( $self, $categories ) = @_;

  push @{ $categories }, @{ $self->categories || [] };
  foreach my $subtype_creator( @{ $self->subtype_creators() || [] } ) {
    my $creator = $subtype_creator->_get_all_categories( $categories );
  }
}

sub get_all_aliases
{
  my( $self ) = @_;

  my @aliases;
  $self->_get_all_aliases( \@aliases );
  return \@aliases;
}

sub _get_all_aliases
{
  my( $self, $aliases ) = @_;

  push @{ $aliases }, @{ $self->aliases || [] };
  foreach my $subtype_creator( @{ $self->subtype_creators() || [] } ) {
    my $creator = $subtype_creator->_get_all_aliases( $aliases );
  }
}

##########################################################################

1;
