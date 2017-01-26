#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 3;
use File::Basename;
use File::Path;
require foreach (glob dirname (__FILE__).'/../commands/*.pm');

print "testing Rm.pm...\n";

sub setup {
    new Touch("check-single-file")->run;
    new Mkdir("check-single-directory")->run;
    new Touch("check/nested/nonempty/directory")->run;

    new Rm("check-single-file")->run;
    new Rm("check-single-directory")->run;
    new Rm("check/nested")->run;
}

sub test {
    ok not (-e "check-single-file"), "Single File";
    ok not (-e "check-single-directory"), "Single Directory";
    ok not (-e "check/nested"), "Nested Nonempty Directory";
}

sub teardown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

setup;
test;
teardown;
