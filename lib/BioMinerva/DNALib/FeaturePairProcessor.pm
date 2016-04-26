##########################################################################

package BioMinerva::DNALib::FeaturePairProcessor;

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

##########################################################################
# PROPERTIES
##########################################################################

##########################################################################
# FUNCTIONALITY
##########################################################################

sub process_feature_pair
{
  my( $self, $first_feature, $second_feature ) = @_;

#  print STDERR
#    $first_feature, "\n",
#    $second_feature, "\n",
#    "---", "\n";
#  return;
  confess( "Not overridden yet in $self" );
}

##########################################################################

1;
