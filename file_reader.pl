#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;

my $file_name = 'conf.ini';
my $path = File::Spec -> catfile( $FindBin::Bin, 'newsletter', $file_name );
my @arr = _read_conf( $path );
my %hash_map = _get_hash( @arr );
my %check_user = (
    'Jack' => 'kek',
    'Jacc' => 'pek',
);

foreach my $key ( keys %hash_map ) {
    my $user_password = $check_user{$key};
    if ( defined( $user_password ) ) {
        $check_user{$key} = $hash_map{$key};
    }
}
_print_hash( %check_user );

sub _print_hash {
    my ( %hash ) = @_;
    my @sorted_values = keys %hash;

    foreach my $key ( @sorted_values ) {
        print( "key: $key , value = $hash{$key}\n" )
    }
}

sub _read_conf {
    my ( $p ) = @_;
    chomp( $p );
    my $fh;
    if ( -e $p ) {
        open( $fh, '<', $p ) or die "Can't read path $p: $!";
    }
    else {
        die "File does not exist at path $p";
    }
    my @lines = <$fh>;
    close( $fh );
    return @lines;
}

sub _get_hash {
    my ( @array ) = @_;
    my %hash;
    for ( my $i = 0; $i < @array; $i++ ) {
        my $array_element = $array[$i];
        if ( $array_element =~ /#/ ) {
            next;
        }
        $array_element =~ s/ //g;
        my @split = split /=/, $array_element;

        if ( @split > 1 ) {
            $hash{$split[0]} = $split[1];
        }
    }
    return %hash;
}