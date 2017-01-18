#!/usr/bin/env perl

use lib 'commands';
use touch;

unless (@ARGV) {
    die "Usage:\n\tpfiler.pl <operation> [argument]...\n";
}

$command = shift @ARGV;

eval {
    if ($command eq "touch") {
        new touch(@ARGV)->run();
    }
    else {
        die "pfiler: Unrecognised operation!\n";
    }
};
die $@ if $@;
