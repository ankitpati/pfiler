#!/usr/bin/env perl

use strict;
use warnings;

package Rm;

use File::Path;

sub new {
    die "Usage:\n\trm <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    return bless $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        unless (-e $file) {
            warn "$file: File does not exist.\n";
        }

        elsif (-d $file) {
            rmtree([$file]) or die "$!\n";
        }

        else {
            unlink $file or die "$!\n";
        }
    }
}

1;
