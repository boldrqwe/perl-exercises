#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use FindBin;
use File::Spec;

my $file_name = <STDIN>;
my $path = File::Spec->catfile($FindBin::Bin, 'newsletter', $file_name);
my @arr = _read_conf($path);
my $prepared_line = _prepare_line(@arr);
my @sorted_words = _get_sorted_arr($prepared_line);
my %word_counted_hash = _get_hash_count_words(@sorted_words);
my $length = scalar @sorted_words;
print("total words $length\n");
_print_hash(%word_counted_hash);
_print_wrong_words(%word_counted_hash);

sub _print_wrong_words {
    my (%hash) = @_;
    my @wrong_words = ('blya', 'pisdes');
    foreach my $word (@wrong_words) {
        my $value = $hash{$word};
        if (defined($value)) {
            print("file has wrong word: $word")
        }
    }
}

sub _print_hash {
    my (%hash) = @_;
    my @sorted_values = sort {$hash{$b} <=> $hash{$a}} keys %hash;

    foreach my $key (@sorted_values) {
        print("word: $key , count = $hash{$key}\n")
    }
}

sub _read_conf {
    my ($p) = @_;
    chomp($p);
    my $fh;
    if (-e $p) {
        open($fh, '<', $p) or die "Can't read path $p: $!";
    }
    else {
        die "File does not exist at path $p";
    }
    my @lines = <$fh>;
    close($fh);
    return @lines;
}

sub _prepare_line {
    my (@array) = @_;
    my $line;
    for (my $i = 0; $i < @array; $i++) {
        $array[$i] =~ s/[=]//g;
        $array[$i] =~ s/\n/ /g;
        if ($array[$i] =~ /-/ && defined($array[$i + 1])) {
            my @split = split(/\s+/, $array[$i + 1]);
            my $second_word_part = $split[0];
            my $pre_line = $array[$i] . $second_word_part;
            $pre_line =~ s/-//g;
            $pre_line =~ s/ //g;
            $line .= $pre_line;
            $array[$i + 1] =~ s/$second_word_part//g;
        }
        else {
            $line .= $array[$i];
        }
    }
    return $line;
}

sub _get_sorted_arr {
    my ($line) = @_;
    my @words = split(/\s+/, $line);

    my @words_arr = sort @words;
    return @words_arr;
}

sub _get_hash_count_words {
    my (@words_arr) = @_;
    my %hash;
    for (my $i = 0; $i < @words_arr; $i++) {
        if (defined($hash{$words_arr[$i]})) {
            my $count = $hash{$words_arr[$i]};
            $count++;
            $hash{$words_arr[$i]} = $count;
        }
        else {
            $hash{$words_arr[$i]} = 1;
        }
    }
    return %hash;
}
