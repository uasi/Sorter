package Sorter;

use 5.012;
use warnings;
use Carp;

my %sort_strategies = (
    builtin    => \&_builtin_sort,
    merge_sort => \&_merge_sort,
    quick_sort => \&_quick_sort
);

my $default_strategy = 'quick_sort';

sub new {
    my ($class, $strategy) = @_;
    $strategy //= $default_strategy;
    unless (exists $sort_strategies{$strategy}) {
        carp "Unknown sort strategy '$strategy' given; falls back to $default_strategy";
        $strategy = $default_strategy;
    }
    bless {
        values => [],
        sort   => $sort_strategies{$strategy}
    }, $class;
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
    $self->{sort}->($values);
}

sub sort_strategies {
    %sort_strategies;
}

sub register_sort_strategy {
    my (undef, $name, $func) = @_;
    if (exists $sort_strategies{$name}) {
        croak "Strategy named '$name' already registered";
    }
    $sort_strategies{$name} = $func;
}

sub _builtin_sort {
    my ($values) = @_;
    @$values = sort { $a <=> $b }, @$values;
}

sub _merge_sort {
    my ($values) = @_;
    croak 'NYI';
}

sub _quick_sort {
    my ($values) = @_;
    _do_quick_sort($values, 0, $#$values);
}

sub _do_quick_sort {
    my ($values, $from, $to) = @_;

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
    _do_quick_sort($values, $from, $j);
    _do_quick_sort($values, $i, $to);
}

1;
