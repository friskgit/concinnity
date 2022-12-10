#!/usr/bin/perl
my $filename = './ratios_sc.txt';
my $line;

open(FH, '<', $filename) or die $!;
while(<FH>){
    if (index($_, "1/1") != -1) {
        last;
    }
    $line = $line.$_;
}
close(FH);
print $line;
