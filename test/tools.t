#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use FindBin;
use File::Spec;
use lib File::Spec -> catdir( $FindBin::Bin, File::Spec -> updir(), 'lib' );
use Test::More;
use File::Temp qw/tempfile/;

BEGIN { use_ok( 'tools' ) }

my $test_conf_file = "test_conf.txt";
open( my $fh, '>', $test_conf_file ) or die "Не могу создать тестовый файл конфигурации: $!";
print $fh "user1=password1\n";
print $fh "user2=password2\n";

close( $fh );

ok( tools::_check_user_passwd( 'ValidPass1!' ), "Проверка пароля: Валидный пароль 'ValidPass1!'" );
ok( !eval { tools::_check_user_passwd( 'short' ) }, "Проверка пароля: Пароль слишком короткий" );
ok( !eval { tools::_check_user_passwd( 'longpassword' ) }, "Проверка пароля: Пароль 'longpassword' достаточной длины, но не содержит необходимых символов" );

my @lines = tools::read_conf( $test_conf_file );
is( scalar @lines, 2, 'Чтение конфигурации: Прочитано 2 строки из файла конфигурации' );

my %config = tools::get_hash( @lines );
is( $config{user1}, 'password1', 'Получение хеша: пользователь user1 есть в хеше' );
is( $config{user2}, 'password2', 'Получение хеша: пользователь user2 есть в хеше' );

my ( $fhs, $filename ) = tempfile();

ok( eval { tools::add_line_to_file( $filename, "test_user=test_password" ) }, "Добавление строки в файл: Добавлена строка" );
is( _read_file_content( $filename ), "test_user=test_password\n", "Проверка содержимого файла после добавления строки" );

my %hash = ( 'test_user2' => 'New_password!1' );
my %conf = ( 'test_user1' => 'new_password' );

ok( eval { tools::reg_user( \%hash, \%conf, $filename ) }, "Регистрация пользователя: Зарегистрирован новый пользователь" );
is( _read_file_content( $filename ), "test_user=test_password\ntest_user2=New_password!1\n", "Проверка содержимого файла после регистрации пользователя" );

ok( eval { tools::del( 'test_user', $filename ) }, "Удаление пользователя: Пользователь удален" );
is( _read_file_content( $filename ), "test_user2=New_password!1\n", "Проверка содержимого файла после удаления пользователя" );

ok( eval { tools::change_password( 'test_user2', 'Changed_password!1', $filename ) }, "Смена пароля: Пароль изменен" );
is( _read_file_content( $filename ), "test_user2=Changed_password!1\n", "Проверка содержимого файла после смены пароля" );


# Очистка тестового окружения
END {
    unlink $test_conf_file or warn "Не могу удалить тестовый файл конфигурации: $!";
}

done_testing();

sub _read_file_content {
    my ( $file_name ) = @_;
    open( my $temp_fh, '<', $file_name ) or die "Не могу открыть файл '$file_name': $!";
    local $/;
    my $content = <$temp_fh>;
    close( $temp_fh );
    chomp( $content );
    return $content;
}
