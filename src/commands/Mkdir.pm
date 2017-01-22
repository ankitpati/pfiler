#!/usr/bin/env perl

use strict;
use warnings;

package Mkdir;

use File::Path;

sub new {
    die "Usage:\n\tmkdir <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        eval {
            mkpath $file unless -e $file;
        } or warn "$file: Cannot create directory(ies).\n";
    }
}

1;
