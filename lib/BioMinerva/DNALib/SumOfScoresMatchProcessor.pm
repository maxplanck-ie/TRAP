##########################################################################

package BioMinerva::DNALib::SumOfScoresMatchProcessor;

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

###--- <scalar_property id="sum_of_scores" get_id="" set_id="">
###---   <auto:comment id="sum_of_scores" md5="/2djcj7aUEU7w6qlgSMjKg">

=head2 sum_of_scores

 Title   : sum_of_scores property
 
 Usage   : $object->sum_of_scores(  );
 
 Function: 
 
 Default : 
 
 Args    : Scalar.

=cut

###---   </auto:comment>
###---   <auto:code id="sum_of_scores" md5="6Mzfzf5CkuxlJrO4ZwQ8fQ">

sub sum_of_scores {
  my $self = shift @_;
  if( @_ ) {
    $self->{ 'sum_of_scores' } = shift @_;
  }
  return $self->{ 'sum_of_scores' };
}

###---   </auto:code>
###---   <auto:code get_id="get_sum_of_scores" md5="GjwYt4GVEJLorZpWXDd5Ng">

sub get_sum_of_scores {
  return shift->{ 'sum_of_scores' };
}

###---   </auto:code>
###---   <auto:code set_id="set_sum_of_scores" md5="CdgjUPh9JjFqKTc3Ne9NeQ">

sub set_sum_of_scores {
  my $self = shift @_;
  $self->{ 'sum_of_scores' } = shift @_;
}

###---   </auto:code>
###--- </scalar_property>

##########################################################################
# FUNCTIONALITY
##########################################################################

sub sum_of_scores
{
  my( $self ) = @_;

  return $self->get_sum_of_scores();
}

sub process_match
{
  my( $self, $match ) = @_;

  $self->set_sum_of_scores(
    ( $self->get_sum_of_scores() || 0 ) + $match->get_score()
  );
}

##########################################################################

1;
