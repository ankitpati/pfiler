#!/usr/bin/env perl

use File::Basename;
require $_ foreach (glob dirname (__FILE__).'/commands/*.pm');

unless (@ARGV) {
    die "Usage:\n\tpfiler.pl <operation> [argument]...\n";
}

$command = lc shift @ARGV;

eval {
    if ($command eq "touch") {
        new Touch(@ARGV)->run();
    }
    elsif ($command eq "cat") {
        new Cat(@ARGV)->run();
    }
    elsif ($command eq "rm") {
        new Rm(@ARGV)->run();
    }
    else {
        die "pfiler: Unrecognised operation!\n";
    }
};
die $@ if $@;
