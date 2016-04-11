#!/usr/bin/env perl
# A perl script to test word breaking

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

use strict;
use warnings;

$a=qq(Jack ate some pancakes.);
while ($a=~/(\W|^)(\w+)(?=\W|$)/g) {
     print "($2)\n";
}

exit 0;

__END__
perl -le '$a=qq(Jack ate some pancakes.); while ($a=~/(\W|^)(\w+)(?=\W|$)/g) { print "($2)"; }'
