#!/usr/bin/env perl

use File::Basename;
require $_ foreach (glob dirname (__FILE__).'/commands/*.pm');

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
