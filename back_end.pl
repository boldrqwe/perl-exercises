#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;
use lib "$FindBin::Bin/lib";
use tools;

my $action = 'reg';
my %new_user = (
    'Jap' => 'kekddddd!'
);

if ( $action eq 'log' ) {
    tools::login;
    exit 0;
}

my $file_name = 'conf.ini';
my $path = File::Spec -> catfile( $FindBin::Bin, 'newsletter', $file_name );
my @arr = tools::read_conf( $path );
my %hash_map_from_config = tools::get_hash( @arr );

tools::reg_user( \%new_user, \%hash_map_from_config, $path );

my @arr2 = tools::read_conf( $path );
foreach my $value ( @arr2 ) {
    print( "$value\n" )
}

