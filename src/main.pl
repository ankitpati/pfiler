#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;
require $_ foreach (glob dirname (__FILE__).'/commands/*.pm');

unless (@ARGV) {
    die "Usage:\n\tpfiler.pl <operation> [argument]...\n";
}

my $command = lc shift @ARGV;

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
    elsif ($command eq "append") {
        new Append(@ARGV)->run();
    }
    elsif ($command eq "ls") {
        new Ls(@ARGV)->run();
    }
    elsif ($command eq "mkdir") {
        new Mkdir(@ARGV)->run();
    }
    elsif ($command eq "ll") {
        new Ll(@ARGV)->run();
    }
    elsif ($command eq "chmod") {
        new Chmod(@ARGV)->run();
    }
    elsif ($command eq "cp") {
        new Cp(@ARGV)->run();
    }
    elsif ($command eq "mv") {
        new Mv(@ARGV)->run();
    }
    else {
        die "pfiler: Unrecognised operation!\n";
    }
} or die $@."\n";
