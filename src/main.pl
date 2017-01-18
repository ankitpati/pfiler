#!/usr/bin/env perl

use lib 'commands';

unless (@ARGV) {
    die "Usage:\n\tpfiler.pl <operation> [argument]...\n";
}

$command = shift @ARGV;

eval {
};
die $@ if $@;
