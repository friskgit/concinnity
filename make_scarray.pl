#!/usr/bin/perl
use warnings;
use strict;

my $filename = 'ratios_sc.txt';
my $counter = 0;
my $line;

open(FH, '<', $filename) or die $!;
print "(\n";
while(<FH>){
    $line = $_;
    if($counter % 3 == 0) {
        print "~notesArrays.add(";
        print '[';
    }
    $line =~ s/\n//g;
    print $line;
    if($counter % 3 == 2) {
        print ']); ';
        print "\n";
    } else {
        print ", ";
    }
    $counter++;
}
print ")\n";
close(FH);
