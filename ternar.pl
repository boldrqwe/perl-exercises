#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use POSIX;
print('введите количество тикетов');
my $total_tickets = <STDIN>;
print('введите количество тикетов в день');
my $tickets_in_day = <STDIN>;
print('введите количество тикетов поступающих в день');
my $tickets_come_in_day = <STDIN>;

my $sprint_value = 10;
my $delta = $tickets_in_day - $tickets_come_in_day;
my $days = ceil($total_tickets / $tickets_in_day);
my $sprints = ceil($days / $sprint_value);

my $result = $delta < 0 ? 'не сможет' : "сможет за  $sprints  спринтов";

print($result);