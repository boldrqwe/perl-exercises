#! usr/bin/perl

use strict;
use warnings;


my @users_list = ( 'Mike', 'Jack', 'Kek' );

print 'Enter name: ';
my $user = <STDIN>;
chomp( $user );

my $find = 0;


for my $user_name( @users_list ){
    print "Processing with user $user_name from \@users_list \n";
    if ( $user eq $user_name ) {
        $find = 1;
        last;
    }
}

if ( $find == 1 ) {
    print "Добро пожаловать, $user !\n";
} else {
    print "Ты кто такой, $user?!\n";
}


