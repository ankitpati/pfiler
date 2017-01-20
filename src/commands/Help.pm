#!/usr/bin/env perl

use strict;
use warnings;

package Help;

sub new {
    die "Usage:\n\thelp <command>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    my $self = shift;

    foreach my $command (@$self) {
        $command = lc $command;

        if ($command eq "touch") {
            print "Usage:\n\ttouch <target>...\n";
        }
        elsif ($command eq "cat") {
            print "Usage:\n\tcat <source>...\n";
        }
        elsif ($command eq "rm") {
            print "Usage:\n\trm <target>...\n";
        }
        elsif ($command eq "append") {
            print "Usage:\n\tappend <target>\n";
        }
        elsif ($command eq "ls") {
            print "Usage:\n\tls [target]...\n";
        }
        elsif ($command eq "mkdir") {
            print "Usage:\n\tmkdir <target>...\n";
        }
        elsif ($command eq "ll") {
            print "Usage:\n\tll [target]...\n";
        }
        elsif ($command eq "chmod") {
            print "Usage:\n\tchmod <permissions> <target>...\n";
        }
        elsif ($command eq "cp") {
            print "Usage:\n\tcp <source> <target>\n";
        }
        elsif ($command eq "mv") {
            print "Usage:\n\tmv <source> <target>\n";
        }
        elsif ($command eq "help") {
            print "Usage:\n\thelp <command>...\n";
        }
        else {
            warn "Unrecognised command!\n";
        }
    }
}

1;
