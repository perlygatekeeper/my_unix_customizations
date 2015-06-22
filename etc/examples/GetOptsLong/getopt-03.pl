#!/usr/bin/env perl
# A perl script to demonstrate simple options via GetOpt::Long

use strict;
use warnings;

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name";


# The argument specification is optional.
#   If omitted, the option is considered boolean,
#   a value of 1 will be assigned when the option is used on the command line.
# A negatable option is specified with an exclamation mark "!" after the option name:

use Getopt::Long 2.34;  # $version > 2.32 gives --help - and --version for
use Pod::Usage;

$main::VERSION = 3.1;
print STDERR "main::VERSION: ($main::VERSION)\n"; 

# Defaults
my $verbosity = 0;
my $help      = 0;
my $debug     = 0;
my $man       = 0;
my $opts = { 'infile'      => "message.opt",
             'outfile'     => "message.txt",
             'verbosity'   => \$verbosity,
             'help'        => \$help,
             'debug_level' => \$debug,
             'man'         => \$man,
           };
GetOptions ( $opts, 'outfile:s', "infile:s", "verbosity+", "debug_level+", 'help|?', 'man', 'version' ) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

exit 0;

__END__

=head1 NAME

sample - Using Getopt::Long and Pod::Usage

=head1 SYNOPSIS

sample [options] [file ...]

Options:
  -help            brief help message
  -man             full documentation

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and do something
useful with the contents thereof.

=cut
