#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;
use lib "$FindBin::Bin/lib";
use tools;

sub _print_help {
    print << 'HELP';
######################################################
# back_end.pl usage
# ./back_end.pl action=reg user_name=NAME user_passwd=PASSWD - registration new user in system;
# ./back_end.pl action=log user_name=NAME user_passwd=PASSWD - login in system;
# ./back_end.pl action=del user_name=NAME - remove user from system;
# ./back_end.pl action=change_passwd user_name=NAME user_passwd=PASSWD - change user password;
######################################################
HELP
}
my %args;
foreach my $arg (@ARGV) {
    my ($key, $value) = split /=/, $arg, 2;
    $args{$key} = $value if defined $value;
}

unless (exists $args{action} && exists $args{user_name}) {
    _print_help();
    exit;
}

my $action = $args{action};
my $user_name = $args{user_name};
my $user_passwd = $args{user_passwd};
my %new_user = ($args{user_name} => $args{$user_passwd});

if ( $action eq 'log' ) {
    tools::login;
    exit 0;
}

my $file_name = 'conf.ini';
my $path = File::Spec -> catfile( $FindBin::Bin, 'newsletter', $file_name );
my @arr = tools::read_conf( $path );
my %hash_map_from_config = tools::get_hash( @arr );

if ( $action eq 'reg' ) {
    tools::reg_user( \%new_user, \%hash_map_from_config, $path );
}
if ( $action eq 'del' ) {
    tools::del( $user_name, $path );
}

if ( $action eq 'change_passwd' ) {
    tools::change_password( $user_name, $user_passwd, $path );
}

my @arr2 = tools::read_conf( $path );
foreach my $value ( @arr2 ) {
    print( "$value\n" )
}

