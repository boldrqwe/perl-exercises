package tools;
use strict;
use warnings FATAL => 'all';

sub print_hash {
    my ( %hash ) = @_;
    my @sorted_values = keys %hash;

    foreach my $key ( @sorted_values ) {
        print( "key: $key , value = $hash{$key}\n" )
    }
}


sub read_conf {
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

sub get_hash {
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

sub change_hash {
    my ( %hash_map, %check_user) = @_;
    foreach my $key ( keys %hash_map ) {
        my $user_password = $check_user{$key};
        if ( defined( $user_password ) ) {
            $check_user{$key} = $hash_map{$key};
        }
    }
}
1;