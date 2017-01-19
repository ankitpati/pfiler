#!/usr/bin/env perl

use strict;
use warnings;

package Touch;

sub new {
    die "Usage:\n\ttouch <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    my $self = shift;

    foreach my $file (@$self) {
        if (-e $file) {
            warn "$file: File/Directory exists.\n";
        }

        else {
            open my $fh, '>>', $file or die $!."\n";
            close $fh or die $!."\n";
        }
    }
}

1;
