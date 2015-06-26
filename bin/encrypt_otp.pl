#!/usr/bin/env perl
<<<<<<< HEAD
# A perl script to read an One-Time-Pad and a message and either
# encrypt or decrypt the message with the random data found on
# the One-Time-Pad.

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name";
=======
# A perl script to read bytes

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";
>>>>>>> 274012b81a50ddda1ea1edcadfc0549813efdcd4

use strict;
use warnings;

$main::VERSION = 2.0;
use Getopt::Long 2.34;  # $version > 2.32 gives --help -\? and --version for
use Data::Dumper;
use Pod::Usage;

# Defaults
my $otp_number   =  1;
my $debug        =  0;
my $offsets_file = "offsets.txt";
my $offsets      = [];

my $help      = 0;
my $debug     = 0;
my $man       = 0;
my $opts = { 'infile'      => "message.opt", # set up connections and defaults
             'outfile'     => "message.txt",
             'debug+'      => \$debug,
             'man'         => \$man,
           };


GetOptions ( $opts, 'outfile:s', "infile:s", "verbosity+", "debug+", 'man' ) or pod2usage(2);
pod2usage(-exitval => 0, -verbose => 2) if $man;

my $infile       = sprintf ("randomness/random-bytes-%02d.txt", $options{opt_number} );

open(RANDOM,"<", $infile)  || die("$name: Cannot read from '$infile':  $!\n");
my $i = 0;
while ( $i++ < $offsets->[$file_number] ) {
	print $i . " chomp \n" if ($debug);
	<RANDOM>;
}

my $msg;
my $packed       = '';
my $lines        = 0;

$/ = \16;
while ( <> ) {
    my $$msg = $_;
    my $length = length($msg);
    if ($debug) {
        print "message is " . length($msg) . " characters long.\n";
	    print ". ";
	}
	if ( $length and $length < 16 ) {
		$msg .= " " x ( 16 - $length );
	}
	my $rand_numbers_line = <RANDOM>;
    print $rand_numbers_line if ($debug);
    chomp $rand_numbers_line;
    $packed = pack( "H2" x 16, split( / /, $rand_numbers_line ) );
    my $m;
    my $r;
    foreach ( 1 .. 16 ) {
        $r = substr($packed, 0, 1, '');
    	$m = substr($msg,    0, 1, '');
    	printf "%02d ->%d,%d<-\n", $_, ord($r), ord($m) if ($debug>1);
    	printf "%c", ( ord($r) ^ ord($m));
	}
    if ($debug) {
        foreach my $char ( split(//, $packed) ) {
            printf("(%02X, %d) ", ord($char), ord($char) );
        }
	}
	$lines++;
}
close(RANDOM);
$offsets->[$file_number] += $lines;

print STDERR "\n";

sub read_offsets_from_file {
    my ( $options, $offsets ) = @_;
    open( OFFS, "<",  $options->{offsets_file} )
      || die("$name: Cannot read from '$options->{offsets_file}': $!\n");
    while (<OFFS>) {
        chomp;
	    if ($debug) {
	        print "($_)";
	    }
	    push( @$offsets, "$_" );
    }
    close(OFFS);
    if ($debug) {
        print scalar(@$offsets) . "\n";
        print       join( " <=\n", @$offsets ) . "\n";
    }
}

sub write_offsets_to_file {
    my ( $options, $offsets ) = @_;
    if ($debug) {
        print scalar(@$offsets) . "\n";
    }
    open( OFFS, ">", $options->{offsets_file} )
      || die("$name: Cannot write to '$options->{offsets_file}': $!\n");
    print OFFS	join( "\n", @$offsets ) . "\n";
    if ($debug) {
        print       join( " <-\n", @$offsets) . "\n";
    }
    close(OFFS);
}

exit 0;

__END__
a4 51 5d cb af 09 24 39 ec bc 72 86 98 3e 4e 24
4c c1 0d dd 18 26 f7 75 6f d8 7f 41 78 9f 4c 0d
b4 a2 ae 0a e1 d6 8c 3e 43 be dc 34 4c cd 3e c4
78 3a 36 04 67 7b d9 50 a2 1a 90 a3 81 d9 a6 8c
c0 ee f7 a5 c9 46 c8 71 45 57 4f 88 15 03 27 42
e3 1b 3a ec ef a9 2d 09 f4 e8 72 6a 55 2a e5 9d
c6 09 38 fa 21 c8 26 52 21 63 d5 94 36 e9 86 b5
a7 c6 33 1a d2 d5 54 81 bf 16 65 cd 13 c0 2a ff
fc af 6f aa cd 9d fd 5e e5 a4 8e a7 3e c9 1c a9
f8 0d 97 5c 39 57 96 4d a5 b2 2c 67 d2 90 15 96


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



=head1 NAME

sample - Using Getopt::Long and Pod::Usage

=head1 SYNOPSIS

sample [options] [file ...]

Options:
  -help|-?         brief help message
  -man             full documentation
  -outfile         output filename
  -infile          input filename
  -debug_level     level of debugging, useful range 0..6
  -verbosity       call multiple time to up the amount of info printed

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
