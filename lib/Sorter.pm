package Sorter;

use 5.012;
use warnings;

sub new {
    my ($class) = @_;
    bless {values => []}, $class;
}

sub get_values {
    my ($self) = @_;
    @{$self->{values}};
}

sub set_values {
    my ($self, @values) = @_;
    $self->{values} = \@values;
}

sub sort {
    my ($self) = @_;
    my $values = $self->{values};

    # XXX Implement quicksort
    @$values = sort { $a <=> $b } @$values;
}

1;
