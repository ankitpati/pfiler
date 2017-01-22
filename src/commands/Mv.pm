#!/usr/bin/env perl

use strict;
use warnings;

package Mv;

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
    die "Usage:\n\tmv <source> <target>\n";
}

sub core_action {
    move shift, shift or die "Could not be moved.\n";
}

sub post_action {
    my $source = shift;
    rmtree([$source]) if (-e $source);
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
            my $per_file_dest = $dst;
            $per_file_dest =~ s/\/.$//;
            core_action $src, $per_file_dest;
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
            mkpath dirname $target;
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
