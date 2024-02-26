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
    my ( $hash1_ref, $hash2_ref, $path ) = @_;
    my %new_user_and_password = %$hash1_ref;
    my %config = %$hash2_ref;

    my @arr = keys( %new_user_and_password );
    my $new_user = $arr[0];
    my $existing_user = $config{$new_user};
    if ( defined( $existing_user ) ) {
        die 'такой пользователь уже зарегистрирован'
    }
    _check_user_name( keys( %new_user_and_password ));
    my $password = $new_user_and_password{$new_user};
    _check_user_passwd( $password );

    add_line_to_file( $path, "$new_user=$password" )
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
    for ( my $i = 0 ; $i < @array ; $i++ ) {
        my $array_element = $array[$i];
        $array_element =~ s/ //g;
        chomp( $array_element );
        my @split = split /=/, $array_element;

        if ( @split > 1 ) {
            $hash{$split[0]} = $split[1];
        }
    }
    return %hash;
}

sub del {
    my ( $user_name, $path ) = @_;

    my @lines = read_conf( $path );

    open( my $fh, '>', $path ) or die "Can't write to path $path: $!";

    foreach my $line ( @lines ) {
        chomp( $line );
        if ( $line =~ /^\Q$user_name\E\s*=/ ) {
            next;
        }
        else {
            print $fh $line . "\n";
        }
    }

    close( $fh );
}

sub change_password {
    my ( $user_name, $new_password, $path ) = @_;
    my @lines = read_conf( $path );

    open( my $fh, '>', $path ) or die "Can't write to path $path: $!";

    foreach my $line ( @lines ) {
        chomp( $line );
        if ( $line =~ /^\Q$user_name\E\s*=/ ) {
            $line =~ s/=(.*)$/'= ' . $new_password/e;
            print $fh $line . "\n";
        }
        else {
            print $fh $line . "\n";
        }
    }

    close( $fh );
}

sub _check_user_name {
    my ( $username ) = @_;
    die "логин должен содержать латинские буквы и цыфры\n" unless $username =~ /^[a-zA-Z][a-zA-Z0-9_-]*[a-zA-Z0-9]$/
        && $username !~ /[А-Яа-я]/;
}

sub _check_user_passwd {
    my ( $passwd ) = @_;
    die "Пароль должен быть не менее 8 символов\n" if length( $passwd ) < 8;
    die "Пароль должен начинаться с латинской буквы\n" unless $passwd =~ /^[a-zA-Z]/;
    die "Пароль должен содержать минимум один спецсимвол (!@#\$%^&*())\n" unless $passwd =~ /[!@#\$%^&*()]/;
    die "Пароль должен содержать минимум один символ в верхнем регистре\n" unless $passwd =~ /[A-Z]/;
    die "Пароль должен содержать минимум одну цифру\n" unless $passwd =~ /\d/;
    return 1;
}
1;