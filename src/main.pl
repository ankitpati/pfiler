#!/usr/bin/env perl

use lib 'commands';
use touch;
use cat;
use rm;

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
