#!/usr/bin/env perl

use strict;
use warnings;

package Append;

use File::Basename;
use File::Path;

sub new {
    die "Usage:\n\tappend <target>\n" if @_ != 2;

    my $class = shift;
    my $self = [@_];

    return bless $self;
}

sub run {
    my $self = shift;
    my $file = @$self[0];

    -d $file and die "$file: Is a directory.\n";

    eval {
        mkpath dirname $file unless (-e dirname $file);
    } or die "Necessary directories could not be created.\n";

    open my $fout, '>>', $file or die "$!\n";

    print "Enter text to append, terminate with EOF.\n";
    while (<STDIN>) {
        print $fout $_;
    }

    close $fout or die "$!\n";
}

1;
