#!/usr/bin/env perl

use strict;
use warnings;

package Chmod;

sub new {
    die "Usage:\n\tchmod <permissions> <target>...\n" if @_ < 3;

    my $class = shift;
    my $self = {
        perms => $_[0],
        files => [@_]
    };
    shift @{$self->{files}};

    die "Invalid mode\n" unless ($self->{perms} =~ /^[0-7]{3}$/);

    return bless $self;
}

sub run {
    my $self = shift;

    foreach my $file (@{$self->{files}}) {
        unless (-e $file) {
            warn "$file: File does not exist.\n";
        }

        else {
            chmod oct ($self->{perms}), $file
                                or warn "$file: Could not set permissions.\n";
        }
    }
}

1;
