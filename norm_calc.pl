#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use constant {
    OPERATION_PATTERN => qr/^[+\-*\/]$/,
    NUMBER_PATTERN    => qr/^-?\d+(\.\d+)?$/,
    OPERATION_TEXT    => 'Введите операцию (+, -, *, /): ',
    NUMBER_TEXT       => "Введите число:",
};

my $os = $^O;

my @arguments = ();
my $operation;
my $pre_result;
while ( 1 ) {
    @arguments = ();
    my $first_num;
    if (!defined($pre_result)) {
        $first_num = enter_value(NUMBER_PATTERN, NUMBER_TEXT);
    }
    else {
        $first_num = $pre_result;
    }
    push(@arguments, $first_num);
    $operation = enter_value(OPERATION_PATTERN, OPERATION_TEXT);
    if ($operation =~ /=/ && defined($pre_result)) {
        last;
    }
    push(@arguments, $operation);
    my $second_num = enter_value(NUMBER_PATTERN, NUMBER_TEXT);
    push(@arguments, $second_num);

    clear_console(1);

    $pre_result = executeArgs(@arguments);

    print("предварительный результат  = $pre_result \n");
}

print("результат $pre_result");

sub check_value {
    my ( $number, $pattern ) = @_;
    if ( $number !~ $pattern ) {
        return 1;
    }
    return 0;
}

sub enter_value {
    my ( $pattern, $text ) = @_;
    my $run = 1;
    my $value;
    while ( $run == 1 ) {
        print $text;
        $value = <STDIN>;
        chomp($value);
        if ($value =~ /0/ && $operation eq '/') {
            print("на ноль делить нельзя попробуйте другое число \n");
            next;
        }
        if ($value =~ /=/ && defined($pre_result)) {
            return $value;
        }
        $run = check_value($value, $pattern);
    };
    return $value;
}

sub clear_console {
    if ( $os eq "MSWin32" ) {
        system("cls");
    }
    else {
        system("clear");
    }
}

sub executeArgs {
    my ( @arr ) = @_;
    return (execute( $arr[0], $arr[2], $arr[1] ));
}

sub execute {
    my ($first, $second, $oper) = @_;
    if ( $oper eq '+' ) {
        return ($first + $second);
    }
    elsif ( $oper eq '-' ) {
        return ($first - $second);
    }
    elsif ( $oper eq '*' ) {
        return ($first * $second);
    }
    elsif ( $oper eq '/' ) {
        if ( $second == 0 ) {
            die "На ноль делить нельзя!\n";
        }
        return ($first / $second);
    }
}
