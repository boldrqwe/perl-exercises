#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

print('enter number to find: ');
my $number = <STDIN>;
chomp($number);

if ( $number !~ /^-?\d+(\.\d+)?$/ ) {
    die( 'it`s not number' );
}

my @arr = (20, 2, 3, 5, 6, 1, 8, 9, 11, 10, 12, 313, 645, 123, 2, 334, 32, 87, 291);

for ( my $i = 0; $i < @arr; $i++ ) {
    for ( my $j = 0; $j < @arr - 1; $j++ ) {
        if ( $arr[$j] > $arr[$j + 1] ) {
            my $temp = $arr[$j];
            $arr[$j] = $arr[$j + 1];
            $arr[$j + 1] = $temp;
        }
    }
}

my $first_index = 0;
my $last_index = scalar(@arr);

my $result = binary_search( $first_index, $last_index, $number );

if ( defined($result) ) {
    print("found $result");
}
else {
    print("$number not found");
}

sub binary_search {
    my ($first_i, $last_i, $number_to_found) = @_;

    if ( $last_i == -1 ) {
        return undef;
    }

    if ( $last_i == 1 ) {
        if ( $number_to_found == $arr[1] ){
            return $number_to_found;
        }
        return undef;
    }

    my $middle = ($first_i + $last_i) / 2;

    if ( $first_i >= $last_i || $last_i <= $first_i ) {
        return undef;
    }

    if ( $arr[$middle] == $number_to_found ) {
        return $number_to_found;
    }

    if ( $arr[$middle] > $number_to_found ) {
        return (binary_search($first_i, $middle, $number_to_found));
    }
    else {
        return (binary_search($middle, $last_i, $number_to_found));
    }

}
