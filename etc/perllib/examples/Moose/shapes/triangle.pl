#!/usr/bin/perl
# A perl script to try out regular_n_gon

use strict;
use warnings;

my $name = $0;
   $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

my $true=1; my $false=0;

use regular_n_gon;

$triangle = regular_n_gon->new( { sides => 3 } );

print $triangle->internal_angle() . "\n";

exit 0;

__END__
