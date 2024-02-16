#!/usr/bin/perl
use strict;
use warnings;

my %users_prms = (
    'Mike' => '123',
    'Jack' => '123',
    'Kek'  => '123'
);

my $user = $ENV{ user_name };
my $user_password = $ENV{ user_password };

if ( !defined($user) ) {
    die('не указано имя пользователя')
}

if ( !defined($user_password) ) {
    die('не указан пароль пользователя')
}

if (_check_password($user_password)) {
    print "Добро пожаловать '$user'!";
}
else {
    print 'Неверный логин или пароль.';
}

sub _check_password {
    my ($user_passwd) = @_;
    if ( exists($users_prms{$user}) ) {
        return $user_passwd == $users_prms{$user};
    }
}
