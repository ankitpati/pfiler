use strict;
use warnings;

package TestsFor::Mv;

use Test::Class::Moose;

use File::Basename;
use File::Path;

require foreach (glob dirname (__FILE__).'/../../../src/commands/*.pm');

sub test_startup {
    new Touch("check-single-file")->run;
    new Mkdir("check-single-directory")->run;
    new Touch("check/nested/nonempty/directory")->run;

    new Mv("check-single-file", "check-single-file-copy")->run;
    new Mv("check-single-directory", "check-single-directory-copy")->run;
    new Mv("check/nested", "check/nested-copy")->run;
}

sub test_mv {
    ok -f "check-single-file-copy", "Single File Copied";
    ok -d "check-single-directory-copy", "Single Directory Copied";
    ok -d "check/nested-copy", "Nested Nonempty Directory Copied";

    ok not (-f "check-single-file"), "Single File Removed";
    ok not (-d "check-single-directory"), "Single Directory Removed";
    ok not (-d "check/nested"), "Nested Nonempty Directory Removed";

    eval {
        new Mv("check-inexistent-file", "check-inexistent-file-copy")->run;
    };
    ok $@, "Inexistent File";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
