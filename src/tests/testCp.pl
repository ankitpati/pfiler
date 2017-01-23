#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 3;
use File::Basename;
use File::Path;
require foreach (glob dirname (__FILE__).'/../commands/*.pm');

print "testing Cp.pm...\n";

sub setup {
    new Touch("check-single-file")->run();
    new Mkdir("check-single-directory")->run();
    new Touch("check/nested/nonempty/directory")->run();

    new Cp("check-single-file", "check-single-file-copy")->run();
    new Cp("check-single-directory", "check-single-directory-copy")->run();
    new Cp("check/nested", "check/nested-copy")->run();
}

sub test {
    ok -f "check-single-file-copy", "Single File";
    ok -d "check-single-directory-copy", "Single Directory";
    ok -d "check/nested-copy", "Nested Nonempty Directory";
}

sub teardown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

setup;
test;
teardown;
