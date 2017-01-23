#!/usr/bin/env perl

use strict;
use warnings;

package Ls;

use File::Basename;

sub new {
    die "Usage:\n\tls [target]...\n" if @_ < 1;

    my $class = shift;
    my $self = [@_];

    push @$self, "." if @_ == 0;

    return bless $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        unless (-e $file) {
            warn "$file: No such file or directory.\n\n";
        }

        elsif (-d $file) {
            print "$file:\n";
            print basename ($_)."  " foreach (glob $file.'/*');
            print "\n\n";
        }

        else {
            print "$file\n\n";
        }
    }
}

1;
