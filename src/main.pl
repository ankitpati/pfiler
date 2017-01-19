#!/usr/bin/env perl

@commands = split /\//, $0;
$commands[$#commands] = 'commands';
require (glob join ('/', @commands) . '/*.pm');

unless (@ARGV) {
    die "Usage:\n\tpfiler.pl <operation> [argument]...\n";
}

$command = shift @ARGV;

eval {
    if ($command eq "touch") {
        new touch(@ARGV)->run();
    }
    elsif ($command eq "cat") {
        new cat(@ARGV)->run();
    }
    elsif ($command eq "rm") {
        new rm(@ARGV)->run();
    }
    else {
        die "pfiler: Unrecognised operation!\n";
    }
};
die $@ if $@;
