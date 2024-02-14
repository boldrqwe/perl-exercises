#! usr/bin/perl


use strict;
use warnings;


my @users_list = ( 'Mike', 'Jack', 'Kek' );

# foreach my $arg (@ARGV) {
#     print "argument: $arg\n";
# }

print 'Enter name: ';
my $user = %ENV{ user_name };
my $user_passwd = %ENV{ user_passwd };

chomp($user);

my $find = 0;


for my $user_name( @users_list ){
    if ( $user eq $user_name ) {
        $find = 1;
        last;
    }
}

if ( $find == 1 ) {
    print "Добро пожаловать, $user !\n Твой пароль $user_passwd";
} else {
    print "Ты кто такой, $user?!\n";
}


