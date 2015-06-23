#!/usr/bin/env perl
# A perl script to demonstrate simple options via GetOpt::Long

use strict;
use warnings;

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [ -arguments ] [ -specifications ] [ -types ] [ -desttypes ] [ -repeats ]";

# type [ desttype ] [ repeat ]

my $VERSION = 2.0;

# The argument specification is optional.
#   If omitted, the option is considered boolean,
#   a value of 1 will be assigned when the option is used on the command line.
# A negatable option is specified with an exclamation mark "!" after the option name:

use Getopt::Long;

my $data    = "file.dat";
my $length  = 24;
my $verbose = 0;
my $debug   = 0;
GetOptions ("length=i"     => \$length,    # numeric
            "file=s"       => \$data,      # string
            "verbose"      => \$verbose,   # flag
            "debug_level+" => \$debug,     # incrementing
           ),
     or die("Error in command line arguments.\n" . $usage);

printf "%-12s is (%s)\n", 'file',         $data;
printf "%-12s is (%d)\n", 'verbosity',    $verbose;
printf "%-12s is (%d)\n", 'debug_level',  $debug;
printf "%-12s is (%d)\n", 'length',       $length;

exit 0;

__END__

NW990585@~/etc/examples/GetOptsLong <337> ./getopt-02.pl
file         is (file.dat)
verbosity    is (0)
debug_level  is (0)
length       is (24)
NW990585@~/etc/examples/GetOptsLong <338> ./getopt-02.pl -l 36
file         is (file.dat)
verbosity    is (0)
debug_level  is (0)
length       is (36)
NW990585@~/etc/examples/GetOptsLong <339> ./getopt-02.pl -l 36 -v -v -v -v
file         is (file.dat)
verbosity    is (1)
debug_level  is (0)
length       is (36)
NW990585@~/etc/examples/GetOptsLong <340> ./getopt-02.pl -l 36 -v -d -d -d -d
file         is (file.dat)
verbosity    is (1)
debug_level  is (4)
length       is (36)
