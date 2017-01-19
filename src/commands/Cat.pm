#!/usr/bin/env perl

package Cat;

sub new {
    die "Usage:\n\tcat <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    $self = shift;

    foreach my $file (@$self) {
        unless (-e $file) {
            warn "$file: File does not exist.\n";
        }

        elsif (-d $file) {
            warn "$file: Is a directory.\n";
        }

        else {
            open $fin, '<', $file or die $!;
            while (<$fin>) {
                print $_;
            }
            close $fin or die $!;
        }
    }
}

1;
