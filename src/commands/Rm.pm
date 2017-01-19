#!/usr/bin/env perl

package Rm;

use File::Path;

sub new {
    die "Usage:\n\trm <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    $self = shift;

    foreach my $file (@{$self}) {
        unless (-e $file) {
            warn "$file: File does not exist.\n";
        }

        elsif (-d $file) {
            rmtree([$file]) or die $!;
        }

        else {
            unlink $file or die $!;
        }
    }
}

1;
