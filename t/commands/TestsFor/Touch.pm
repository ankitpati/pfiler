use strict;
use warnings;

package TestsFor::Touch;

use Test::Class::Moose;

use File::Basename;
use File::Path;

require foreach (glob dirname (__FILE__).'/../../../src/commands/*.pm');

sub test_startup {
    new Touch("check-single-file")->run;
    new Touch("check/inexistent/path")->run;
    new Touch("check/existent/path")->run;
    new Touch("check/multiple/arguments0", "check/multiple/arguments1")->run;
}

sub test_touch {
    ok -e "check-single-file", "Single File";
    ok -e "check/inexistent/path", "Inexistent Path";
    ok -e "check/existent/path", "Existent Path";
    ok -e "check/multiple/arguments0", "Multiple Arguments 0";
    ok -e "check/multiple/arguments1", "Multiple Arguments 1";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
