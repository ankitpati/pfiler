use strict;
use warnings;

package TestsFor::Rm;

use Test::Class::Moose;

use File::Basename;
use File::Path;

require foreach (glob dirname (__FILE__).'/../*.pm');

sub test_startup {
    new Touch("check-single-file")->run;
    new Mkdir("check-single-directory")->run;
    new Touch("check/nested/nonempty/directory")->run;

    new Rm("check-single-file")->run;
    new Rm("check-single-directory")->run;
    new Rm("check/nested")->run;
}

sub test_rm {
    ok not (-e "check-single-file"), "Single File";
    ok not (-e "check-single-directory"), "Single Directory";
    ok not (-e "check/nested"), "Nested Nonempty Directory";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
