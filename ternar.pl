#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
print('enter total tickets');
my $total_tickets = <STDIN>;
print('enter tickets in day');
my $tickets_in_day = <STDIN>;
print('enter tickets_come_in_day');
my $tickets_come_in_day = <STDIN>;

my $sprint_value = 10;
my $delta = $tickets_in_day - $tickets_come_in_day;
my $days = sprintf("%.0f", $total_tickets / $tickets_in_day);
my $sprints = sprintf("%.0f", $days / $sprint_value);

my $result = $delta < 0 ? 'no, he can`t' : "will handle it in $sprints  sprints";

print($result);