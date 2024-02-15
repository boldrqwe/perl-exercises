#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use constant {
    OPERATION_PATTERN => qr/^[+\-*\/]$/,
    NUMBER_PATTERN    => qr/^-?\d+(\.\d+)?$/,
    OPERATION_TEXT    => 'Введите операцию (+, -, *, /): ',
    NUMBER_TEXT       => 'Введите число: ',
};

my $os = $^O;
my @arguments = ();
my $operation;
my $pre_result;
my $operation_sequence;

while ( 1 ) {
    @arguments = ();
    my $first_num;
    if ( !defined($pre_result) ) {
        $first_num = _enter_value(NUMBER_PATTERN, NUMBER_TEXT);
        $operation_sequence .= $first_num;
    }
    else {
        $first_num = $pre_result;
    }
    push(@arguments, $first_num);
    $operation = _enter_value(OPERATION_PATTERN, OPERATION_TEXT);
    if ( $operation =~ /=/ && defined($pre_result) ) {
        last;
    }
    $operation_sequence .= $operation;
    push(@arguments, $operation);
    my $second_num = _enter_value(NUMBER_PATTERN, NUMBER_TEXT);
    $operation_sequence .= $second_num;
    push(@arguments, $second_num);

    _clear_console(1);

    $pre_result = _execute_args(@arguments);

    print("предварительный результат  = $pre_result \n");

    $operation_sequence = _add_brackets($operation_sequence);
}

print("Операции $operation_sequence = ");
print("$pre_result");

sub check_value {
    my ($number, $pattern) = @_;
    if ( $number !~ $pattern ) {
        return 1;
    }
    return 0;
}

sub _enter_value {
    my ($pattern, $text) = @_;
    my $run = 1;
    my $value;
    while ( $run == 1 ) {
        print $text;
        $value = <STDIN>;
        chomp($value);
        if ( $value =~ /0/ && $operation eq '/' ) {
            print("на ноль делить нельзя попробуйте другое число \n");
            next;
        }
        if ( $value =~ /=/ && defined($pre_result) ) {
            return $value;
        }
        $run = check_value($value, $pattern);
    };
    return $value;
}

sub _clear_console {
    if ( $os eq "MSWin32" ) {
        system("cls");
    }
    else {
        system("clear");
    }
}

sub _execute_args {
    my (@arr) = @_;
    return (_execute($arr[0], $arr[2], $arr[1]));
}

sub _execute {
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

sub _add_brackets {
    my ($string) = @_;
    return ("($string)")
}
