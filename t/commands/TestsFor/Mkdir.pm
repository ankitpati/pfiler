use strict;
use warnings;

package TestsFor::Mkdir;

use Test::Class::Moose;

use File::Basename;
use File::Path;

require foreach (glob dirname (__FILE__).'/../../../src/commands/*.pm');

sub test_startup {
    new Mkdir("check-single-directory")->run;
    new Mkdir("check/inexistent/path")->run;
    new Mkdir("check/existent/path")->run;
    new Mkdir("check/multiple/arguments0", "check/multiple/arguments1")->run;
}

sub test_mkdir {
    ok -d "check-single-directory", "Single Directory";
    ok -d "check/inexistent/path", "Inexistent Path";
    ok -d "check/existent/path", "Existent Path";
    ok -d "check/multiple/arguments0", "Multiple Arguments 0";
    ok -d "check/multiple/arguments1", "Multiple Arguments 1";
}

sub test_shutdown {
    rmtree([glob 'check*']) or warn "check*/: Not cleaned up.\n";
    unlink or warn "$_: Not cleaned up.\n" foreach (glob 'check*');
}

1;
