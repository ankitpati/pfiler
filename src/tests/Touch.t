#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 5;
use File::Basename;
use File::Path;
require foreach (glob dirname (__FILE__).'/../commands/*.pm');

print "testing Touch.pm...\n";

sub setup {
    new Touch("check-single-file")->run;
    new Touch("check/inexistent/path")->run;
    new Touch("check/existent/path")->run;
    new Touch("check/multiple/arguments0", "check/multiple/arguments1")->run;
}

sub test {
    ok -e "check-single-file", "Single File";
    ok -e "check/inexistent/path", "Inexistent Path";
    ok -e "check/existent/path", "Existent Path";
    ok -e "check/multiple/arguments0", "Multiple Arguments 0";
    ok -e "check/multiple/arguments1", "Multiple Arguments 1";
}

sub teardown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

setup;
test;
teardown;
