use strict;
use warnings;

package TestsFor::Cp;

use Test::Class::Moose;

use File::Basename;
use File::Path;

require foreach (glob dirname (__FILE__).'/../*.pm');

sub test_startup {
    new Touch("check-single-file")->run;
    new Mkdir("check-single-directory")->run;
    new Touch("check/nested/nonempty/directory")->run;
}

sub test_cp {
    new Cp("check-single-file", "check-single-file-copy")->run;
    new Cp("check-single-directory", "check-single-directory-copy")->run;
    new Cp("check/nested", "check/nested-copy")->run;

    ok -f "check-single-file-copy", "Single File";
    ok -d "check-single-directory-copy", "Single Directory";
    ok -d "check/nested-copy", "Nested Nonempty Directory";

    eval {
        new Cp("check-inexistent-file", "check-inexistent-file-copy")->run;
    };
    ok $@, "Inexistent File";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
