#!/usr/bin/perl
use strict;
use warnings;
use Encode qw(decode);
use JSON qw(decode_json);
use XML::Simple;
use Data::Dumper;
use FindBin;
use File::Spec;
use utf8;
use open qw(:std :utf8);

my $filename = 'lib.xml';
my $path = File::Spec -> catfile( $FindBin::Bin, $filename );

open( my $fh, '<:encoding(UTF-8)', $path ) or die "Не могу открыть файл '$filename': $!";
my $file_content = do {
    local $/;
    <$fh>
};
close( $fh );

my %parsers = (
    '^\s*\{'     => sub {
        my $content = shift;
        return eval { decode_json( $content ) } || die "Ошибка при парсинге JSON: $@";
    },
    '^\s*\['     => sub {
        my $content = shift;
        return eval { decode_json( $content ) } || die "Ошибка при парсинге JSON: $@";
    },
    '^\s*<\?xml' => sub {
        my $content = shift;
        return eval { XML::Simple -> new -> XMLin( $content, ForceArray => 1, KeyAttr => [] ) } || die "Ошибка при парсинге XML: $@";
    },
);

my $data;
foreach my $regex ( keys %parsers ) {
    if ( $file_content =~ /$regex/ ) {
        $data = $parsers{$regex} -> ( $file_content );
        last;
    }
}

die "Неизвестный формат данных" unless defined $data;

print Dumper( $data );
