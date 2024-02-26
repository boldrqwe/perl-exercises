#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;
use lib "$FindBin::Bin/lib";
use tools;

my $action = 'del';
my %new_user = (
    'Jap1' => 'kekddddd!'
);
my $user_name = 'Jack';

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
    tools::del($user_name, $path);
}

my @arr2 = tools::read_conf( $path );
foreach my $value ( @arr2 ) {
    print( "$value\n" )
}

