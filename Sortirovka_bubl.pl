#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

my @arr = ( 20, 2, 3, 5, 6, 1, 8, 9, 11, 10, 12, 313, 645, 123, 2, 334, 32, 87, 291 );

print "Исходный массив: @arr\n";

for ( my $i = 0; $i < @arr; $i++ ) {
    for ( my $j = 0; $j < @arr - 1; $j++ ) {
        if ( $arr[$j] > $arr[$j + 1] ) {
            my $temp = $arr[$j];
            $arr[$j] = $arr[$j + 1];
            $arr[$j + 1] = $temp;
        }
    }
}

print "Отсортированный массив: @arr\n";

