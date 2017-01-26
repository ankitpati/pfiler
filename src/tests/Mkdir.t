#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 5;
use File::Basename;
use File::Path;
require foreach (glob dirname (__FILE__).'/../commands/*.pm');

print "testing Mkdir.pm...\n";

sub setup {
    new Mkdir("check-single-directory")->run;
    new Mkdir("check/inexistent/path")->run;
    new Mkdir("check/existent/path")->run;
    new Mkdir("check/multiple/arguments0", "check/multiple/arguments1")->run;
}

sub test {
    ok -d "check-single-directory", "Single Directory";
    ok -d "check/inexistent/path", "Inexistent Path";
    ok -d "check/existent/path", "Existent Path";
    ok -d "check/multiple/arguments0", "Multiple Arguments 0";
    ok -d "check/multiple/arguments1", "Multiple Arguments 1";
}

sub teardown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

setup;
test;
teardown;
