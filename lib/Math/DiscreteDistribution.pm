# $Id: DiscreteDistribution.pm,v 1.4 2006/06/30 13:35:52 kielbasa Exp $
#
# Perl module for Math::DiscreteDistribution
#
# Cared for by Steffen Grossmann <grossman@molgen.mpg.de>
#
# Copyright Steffen Grossmann
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Math::DiscreteDistribution - A probability distribution living on a
finite set of integers.

=head1 SYNOPSIS

    use Math::DiscreteDistribution;

a distribution living on (-10, -9, -8, -7, -6, -5)

    my $dist1 = Math::DiscreteDistribution->new
                 (-values => [-10, -9, -8, -7, -6, -5],
                  -weights => [0.25, 0.1, 0.3, 0.1, 0.2, 0.05]);
    
'pwf' stands for 'probability weight function'

    my $w = $dist1->pwf(-8);  # should be 0.3

'pdf' stands for 'probability distribution function'

    my $s = $dist1->pdf(-8);  # should be 0.65

a fair coin on (-1, 1)

    my $dist2 = Math::DiscreteDistribution->new
                 (-values => [-1, 1],
                  -weights => [0.5, 0.5]);

and the convolution of the two

    my $dist3 = $dist1->convolute($dist2);

code like

    my $dist4 = Math::DiscreteDistribution->new
                 (-values => [-1, 1, -1],
                  -weights => [0.25, 0.5, 0.25]);

should also be allowed and should yield the same result as above!

=head1 DESCRIPTION

A class respresenting discrete distributions on ranges of integers. The basic
functionality which is needed is the convolution, hence we restrict the set of
allowed values to the integers.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
BioMinerva modules. Your participation is much appreciated.

=head1 AUTHOR - Steffen Grossmann

Email grossman@molgen.mpg.de

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Math::DiscreteDistribution;
use vars qw(@ISA);
use strict;

use Carp qw( confess );
our $VERSION = 0.01;

=head2 new

 Title   : new
 Usage   : my $dist = Math::DiscreteDistribution->new
                         (-values  => $valsref,
                          -weights => $weightsref);
 Function: Builds a new Math::DiscreteDistribution object
 Returns : an instance of Math::DiscreteDistribution
 Args    : values  :  A reference to an array holding the values on which
                      the distribution lives.
           weights :  A reference to an array holding the weights of the
                      distribution.

=cut

sub new {
    my( $caller, @args ) = @_;
    my $class = ref( $caller ) || $caller;
    
    my $self = {};
    bless( $self, $class );

    my %argshash = @args;


    confess("You have to specify '-values' and '-weights'!")
	unless (exists($argshash{'-values'}) && $argshash{'-weights'});
  

    $self->set_values($argshash{'-values'});
    $self->set_weights($argshash{'-weights'});
    $self->_consistency_check;

    return $self;
}


=head2 set_values

 Title   : set_values
 Usage   : $dist->set_values($newvals)
 Function: Sets the value set on which the distribution lives.
 Example : 
 Returns : Nothing
 Args    : A reference to an array holding the value set on which the
           distribution lives
=cut

sub set_values {
    my $self = shift;

    if (@_) {
	$self->_flag_for_recalc();
	$self->{'values'} = shift;
    }

    return;
}

=head2 get_values

 Title   : get_values
 Usage   : my $vals = $dist->get_values()
 Function: Gets the value set on which the distribution lives.
 Example : 
 Returns : A reference to an array holding the value set on which the
           distribution lives
 Args    : None
=cut

sub get_values {
    my $self = shift;

    $self->_consistency_check();
    return $self->{'values'};
}

=head2 set_weights

 Title   : set_weights
 Usage   : $dist->set_weights($newweights)
 Function: Sets the weights of the distribution.
 Example : 
 Returns : Nothing
 Args    : A reference to an array holding the weights of the distribution.
=cut

sub set_weights {
    my $self = shift;

    if (@_) {
	$self->_flag_for_recalc();
	$self->{'weights'} = shift;
    }

    return;
}

=head2 get_weights

 Title   : get_weights
 Usage   : my $weights = $dist->get_weights()
 Function: Gets the weights of the distribution.
 Example : 
 Returns : A reference to an array holding the weights of the distribution.
 Args    : None
=cut

sub get_weights {
    my $self = shift;

    $self->_consistency_check();
    return $self->{'weights'};
}

=head2 pwf

 Title   : pwf
 Usage   : my $w = $dist->pwf(-5)
 Function: Gets the pwf at a given value. 'pwf' stands for
           'probability weight function' and it gives the weight for
           the specifed value.
 Example :
 Returns : A number between 0 and 1.
 Args    : An integer value.

=cut

sub pwf {
    my $self = shift;

    return 0 unless @_;

    my $v = shift;

    return 0 unless (exists($self->{_value_hash}->{$v}));

    return $self->{weights}->[$self->{_value_hash}->{$v}];
}

=head2 pdf

 Title   : pdf
 Usage   : my $w = $dist->pdf(-5)
 Function: Gets the pdf at a given value. 'pdf' stands for
           'probability distribution function' and is the probability
           of getting a value <= the specified value.
 Example :
 Returns : A number between 0 and 1.
 Args    : An integer value.

=cut

sub pdf {
    my $self = shift;

    return 0 unless @_;

    my $v = shift;
    my @values = @{$self->get_values()};

    if (exists($self->{_value_hash}->{$v})) {
	# $v is a value for which we have something
	return $self->{pdfweights}->[$self->{_value_hash}->{$v}];
    } elsif ($v < $values[0]) {
	# $v is smaller than range
	return 0;
    } elsif ($v > $values[ $#values ]) {
	# $v is larger than range
	return 1;
    } else {
	# $v is in range, but we have to search for the next smallest value
	$v--;
	until (exists($self->{_value_hash}->{$v})) {
	    $v--;
	}
	return $self->{pdfweights}->[$self->{_value_hash}->{$v}];
    }
}


=head2 convolute

 Title   : convolute
 Usage   : my $dist3 = $dist1->convolute($dist2)
 Function: Calculates the convolution of two distributions.
 Example :
 Returns : A new Math::DiscreteDistribution object
 Args    : A Math::DiscreteDistribution object with which to
           convolute the caller.

=cut

sub convolute {
    my $self = shift;

    return $self unless (@_);
   
    my $dist2 = shift;
    $self->confess('I can only convolute with another Math::DiscreteDistribution object')
	unless ($dist2->isa('Math::DiscreteDistribution'));
    
    # getting the basic data
    my @vals1 = @{$self->get_values()};
    my @weis1 = @{$self->get_weights()};

    my @vals2 = @{$dist2->get_values()};
    my @weis2 = @{$dist2->get_weights()};

    # these will hold the new values and weights
    my @vals;
    my @weis;

    for (my $i = 0; $i < @vals1; $i++) {
	for (my $j = 0; $j < @vals2; $j++) {
	    push(@vals, $vals1[$i] + $vals2[$j]);
	    push(@weis, $weis1[$i] * $weis2[$j]);
	}
    }

    # we don''t have to take care about redundant values, because this
    # will be done in the constructor!
    my $d = Math::DiscreteDistribution->new
	(-values => \@vals,
	 -weights => \@weis);
    
    return $d;
}

=head2 _flag_for_recalc

 Title   : _flag_for_recalc
 Usage   : $obj->_flag_for_recalc();
 Function: Sets internal flag, which shows that the basic data has
           been changed and that therefore a recalculation of some
           other data in the object is necessary.
 Example : 
 Returns : Nothing
 Args    : No arguments
=cut

sub _flag_for_recalc {
    my $self = shift;

    $self->{'_need_recalc'} = 1;

    return;
}

=head2 _consistency_check

 Title   : _consistency_check
 Usage   : $self->_consistency_check()
 Function: This internal function should always be called directly
           before any of the basic data of the object is reported to
           the outside or used internally for calculations! It will
           then check whether the basic data of the object is
           consistent. To prevent this checking from occuring too
           often, it is only carried out, if $self->_flag_for_recalc()
           has been called before. This flag is unset at the end.
           It also attaches internally a '_value_hash' which maps the
           values to their positions in the value array. This can be
           used internally for faster lookup of weights.
 Example :
 Returns : Nothing
 Args    : None

=cut

sub _consistency_check {
    my $self = shift;

    # we only do something if we have a reason to
    return unless ($self->{_need_recalc});

    # don''t call official accessors here, because otherwise you get circularity!
    my $v = $self->{'values'};
    my $w = $self->{'weights'};

    # basic checking
    confess("values have to be passed as a reference to an array!")
	unless (ref($v) eq 'ARRAY');
    confess("weights have to be passed as a reference to an array!")
	unless (ref($w) eq 'ARRAY');
    confess("number of values and weights has to be equal!")
	unless (@$w == @$v);
    
    my $bad_v = 0;
    map {$bad_v ||= (int($_) != $_)} @$v;
    confess("values have to be integers!")
	if ($bad_v);

    my $bad_w = 0;
    map {$bad_w ||= ($_ < 0)} @$w;
    confess("weights have to be non-negative!")
	if ($bad_w);

    # making sure that the weights sum to one!
    my $sum_w = 0;
    map {$sum_w += $_} @$w;
    if (abs( $sum_w - 1.0 ) > 1e-12 ) {
	print STDERR "DEBUG: weights maybe don't exactly sum to 1 ($sum_w), renorming!\n";
	my @new_w = map {$_/$sum_w} @$w;
	$self->{'weights'} = \@new_w;
	$w = \@new_w;
    }

    # reducing collapsing possibly redundant values
    my %seen_v;
    for (my $i = 0; $i < @$v; $i++) {
	if (exists($seen_v{$v->[$i]})) {
	    $seen_v{$v->[$i]} += $w->[$i];
	} else {
	    $seen_v{$v->[$i]} = $w->[$i];
	}
    }
    
    my @nv = sort { $a <=> $b } keys(%seen_v);
    my @nw = map { $seen_v{$_} } @nv;
    
    # this is the magic value hash for faster lookup
    my %vh;
    for (my $i = 0; $i < @nv; $i++) {
	$vh{$nv[$i]} = $i;
    }
    $self->{values} = \@nv;
    $self->{weights} = \@nw;
    $self->{_value_hash} = \%vh;
    $self->{_need_recalc} = 0;

    # finally we also internally store the pdf
    my @pdfweights;
    my $sum = 0;
    for (my $i = 0; $i < @nw; $i++) {
	$sum += $nw[$i];
	push(@pdfweights, $sum);
    }
    $self->{pdfweights} = \@pdfweights;

    return;
}




1;
