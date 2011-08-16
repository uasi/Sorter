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
    $self->_quick_sort($values, 0, $#$values);
}

sub _quick_sort {
    my ($self, $values, $from, $to) = @_;

    my ($i, $j) = ($from, $to);
    my $pivot = $$values[($from + $to) / 2];

    while ($i <= $j) {
        $i++ while $$values[$i] < $pivot;
        $j-- while $$values[$j] > $pivot;
        last if $i > $j;
        
        ($$values[$i], $$values[$j]) = ($$values[$j], $$values[$i]);
        $i++;
        $j--;
    }

    return if $from >= $to;
    $self->_quick_sort($values, $from, $j);
    $self->_quick_sort($values, $i, $to);
}

1;
