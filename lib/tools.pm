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

sub login {
    my ( $self ) = @_;

}
sub reg_user {
    my ($hash1_ref, $hash2_ref, $path) = @_;  # Получаем ссылки на хеши
    my %new_user_password = %$hash1_ref;  # Разыменование ссылки для получения хеша
    my %config = %$hash2_ref;

    my @arr = keys( %new_user_password );
    my $new_user = $arr[0];
    my $existing_user = $config{$new_user};
    if ( defined( $existing_user ) ) {
        die 'такой пользователь уже зарегистрирован'
    }
    add_line_to_file( $path, "$new_user=$new_user_password{$new_user}" )
}

sub add_line_to_file {
    my ( $path, $new_line ) = @_;
    open( my $fh, '>>', $path ) or die "Не удалось открыть файл '$path' $!";
    print $fh "$new_line\n";
    close( $fh );
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
        chomp( $array_element );
        my @split = split /=/, $array_element;

        if ( @split > 1 ) {
            $hash{$split[0]} = $split[1];
        }
    }
    return %hash;
}

1;