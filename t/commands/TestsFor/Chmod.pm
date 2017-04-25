use strict;
use warnings;

package TestsFor::Chmod;

use Test::Class::Moose;

use File::Basename;
use File::Path;

use lib dirname (__FILE__).'/../../../src/commands';

use Touch;
use Mkdir;
use Chmod;

sub test_startup {
    new Touch("check-single-file")->run;
    new Mkdir("check-single-directory")->run;
    new Touch("check/nested/file")->run;
}

sub test_chmod {
    new Chmod("644", "check-single-file")->run;
    new Chmod("755", "check-single-directory")->run;
    new Chmod("777", "check/nested")->run;
    new Chmod("777", "check/nested/file")->run;

    is ((stat "check-single-file")[2] & 0777, 0644, "Single File");
    is ((stat "check-single-directory")[2] & 0777, 0755, "Single Directory");
    is ((stat "check/nested/file")[2] & 0777, 0777, "Nested File");
    is ((stat "check/nested")[2] & 0777, 0777, "Nested Directory");

    eval {
        new Chmod("855", "invalid-mode");
    };
    is $@, "Invalid mode\n", "Invalid Mode";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
