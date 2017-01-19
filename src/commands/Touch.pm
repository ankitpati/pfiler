#!/usr/bin/env perl

package Touch;

sub new {
    die "Usage:\n\ttouch <target>...\n" if @_ < 2;

    my $class = shift;
    my $self = [@_];

    bless $self, $class;
    return $self;
}

sub run {
    $self = shift;

    foreach my $file (@$self) {
        if (-e $file) {
            warn "$file: File/Directory exists.\n";
        }

        else {
            open $fh, '>>', $file or die $!;
            close $fh or die $!;
        }
    }
}

1;
