#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use constant {
    PATH => 't/perl-exercises/conf.ini',
};

foreach my $line (_read_conf(PATH)) {
    print "$line\n";
}

sub _read_conf {
    my ($path) = @_;
    open(my $fh, '<', $path) or die "cant read path $path";
    my @lines = <$fh>;
    close($fh);
    chomp @lines;
    return @lines;
}