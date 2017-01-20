#!/usr/bin/env perl

use strict;
use warnings;

package Cp;

use File::Basename;
use File::Path;
use File::Spec::Functions qw (rel2abs abs2rel catfile);
use File::Copy;
use File::Find;

sub new {
    &illegal_arguments if @_ != 3;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub illegal_arguments {
    die "Usage:\n\tcp <source> <target>\n";
}

sub core_action {
    copy shift, shift or die "Could not be copied.\n";
}

sub post_action {
}

sub action {
    my ($source, $target) = @_;

    local *per_file = sub {
        my $src = $_;
        my $dst = catfile $target, abs2rel $src, $source;

        if (-d $src) {
            eval {
                mkpath $dst;
            };
            if ($@) {
                die "$dst: Cannot create directory.\n";
            }
        }

        else {
            core_action $src, $dst;
        }
    };

    find {wanted => \&per_file, no_chdir => 1}, $source;

    post_action $source;
}

sub run {
    my $self = shift;

    $_ = rel2abs $_ foreach (@$self);
    my ($source, $target) = @$self;

    unless (-e $source) {
        die "$source: File does not exist.\n";
    }

    unless (-e $target) {
        eval {
            mkpath dirname $target
        };
        if ($@) {
            die "Necessary directories could not be created.\n";
        }
    }

    elsif (-d $target) {
        $target = catfile $target, basename $source;
    }

    action $source, $target;
}

1;
