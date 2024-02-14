#!/usr/bin/perl
use strict;
use warnings;

my %users_prms = (
    'Mike' => '123',
    'Jack' => '123',
    'Kek'  => '123'
);

print 'Enter name: ';
my $user = %ENV{ user_name };
my $user_password = %ENV{ user_password };

my $user_passwd;
if (exists($users_prms{$user})) {
    $user_passwd = %users_prms{$user};
}

if ( defined($user_passwd)  && $user_passwd == $user_password) {
    print "Добро пожаловать '$user'!";
}
else {
    print 'Неверный логин или пароль.';
}
