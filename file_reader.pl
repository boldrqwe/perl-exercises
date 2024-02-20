#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;
use tools;

my $file_name = 'conf.ini';
my $path = File::Spec -> catfile( $FindBin::Bin, 'newsletter', $file_name );
my @arr = tools::read_conf( $path );
my %hash_map = tools::get_hash( @arr );
my %check_user = (
    'Jack' => 'kek',
    'Jacc' => 'pek',
);
tools::change_hash( %hash_map, %check_user );
tools::print_hash( %check_user );

