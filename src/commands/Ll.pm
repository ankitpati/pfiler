#!/usr/bin/env perl

use strict;
use warnings;

package Ll;

use File::Basename;

sub new {
    die "Usage:\n\tll [target]...\n" if @_ < 1;

    my $class = shift;
    my $self = [@_];

    push @$self, "." if @_ == 0;

    bless $self, $class;
    return $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        unless (-e $file) {
            warn "$file: No such file or directory.\n\n";
        }

        elsif (-d $file) {
            print "$file:\n";
            printf "%03o  ".basename ($_)."\n", (stat)[2] & 0777
                                                    foreach (glob $file.'/*');
            print "\n";
        }

        else {
            printf "%03o  $file\n\n", (stat $file)[2] & 0777;
        }
    }
}

1;
