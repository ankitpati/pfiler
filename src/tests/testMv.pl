#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 6;
use File::Basename;
use File::Path;
require foreach (glob dirname (__FILE__).'/../commands/*.pm');

print "testing Mv.pm...\n";

sub setup {
    new Touch("check-single-file")->run();
    new Mkdir("check-single-directory")->run();
    new Touch("check/nested/nonempty/directory")->run();

    new Mv("check-single-file", "check-single-file-copy")->run();
    new Mv("check-single-directory", "check-single-directory-copy")->run();
    new Mv("check/nested", "check/nested-copy")->run();
}

sub test {
    ok -f "check-single-file-copy", "Single File Copied";
    ok -d "check-single-directory-copy", "Single Directory Copied";
    ok -d "check/nested-copy", "Nested Nonempty Directory Copied";

    ok not (-f "check-single-file"), "Single File Removed";
    ok not (-d "check-single-directory"), "Single Directory Removed";
    ok not (-d "check/nested"), "Nested Nonempty Directory Removed";
}

sub teardown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

setup;
test;
teardown;
