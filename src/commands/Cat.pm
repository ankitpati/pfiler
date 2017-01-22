#!/usr/bin/env perl

use strict;
use warnings;

package Cat;

sub new {
    die "Usage:\n\tcat <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        unless (-e $file) {
            warn "$file: File does not exist.\n";
        }

        elsif (-d $file) {
            warn "$file: Is a directory.\n";
        }

        else {
            open my $fin, '<', $file or die "$!\n";
            while (<$fin>) {
                print;
            }
            close $fin or die "$!\n";
        }
    }
}

1;
