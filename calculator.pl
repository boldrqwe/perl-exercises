#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

print 'Введите первое число: ';
my $first_num = <STDIN>;
chomp($first_num);
check_number($first_num);

print 'Введите операцию (+, -, *, /): ';
my $operation = <STDIN>;
chomp($operation);
if ( $operation !~ /^[+\-*\/]$/ ) {
    die "Введена некорректная операция: $operation\n";
}

print 'Введите второе число: ';
my $second_num = <STDIN>;
chomp($second_num);
check_number($second_num);

my $os = $^O;

if ( $os eq "MSWin32" ) {
    system("cls");
} else {
    system("clear");
}

if ( $operation eq '+' ) {
    print "Результат: ", $first_num + $second_num, "\n";
} elsif ( $operation eq '-' ) {
    print "Результат: ", $first_num - $second_num, "\n";
} elsif ( $operation eq '*' ) {
    print "Результат: ", $first_num * $second_num, "\n";
} elsif ( $operation eq '/' ) {
    if ( $second_num == 0 ) {
        die "На ноль делить нельзя!\n";
    }
    print "Результат: ", $first_num / $second_num, "\n";
}

sub check_number{
    my($number) = @_;
    if ( $number !~ /^-?\d+(\.\d+)?$/ ) {
        die('это не число');
    }
}





