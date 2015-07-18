#!/usr/bin/env perl
# A perl script to read an One-Time-Pad and a message and either
# encrypt or decrypt the message with the random data found on
# the One-Time-Pad.

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [ --infile FILE | FILE ... ] [ --outfile FILE ] "
          . "[ --pad_number (1..25) ] [ --offset INT ] [ --man | --help | -? | --debug...]";

use strict;
use warnings;
# $version > 2.32 gives --help -\? and --version for free but doesn't unless 2.34 is numeric not '2.34'
# '2.34' as a string with a qw(...) gives a syntax error
# use Getopt::Long '2.34' qw(:config auto_help auto_version); 
use Getopt::Long qw(:config auto_help auto_version);
use Data::Dumper;
use Pod::Usage;

$main::VERSION = 2.1;

# Defaults
my $verbosity = 0;                           # set up connectioned defaults
my $help      = 0;
my $debug     = 0;
my $man       = 0;
my $offsets   = [];
my $opts = { 'infile'      => "message.opt", # set up connections and defaults
             'outfile'     => "message.txt",
#            'help'        => \$help,
             'debug_level' => \$debug,
             'man'         => \$man,
             'pad_number'  => 1,
             'offset'      => 0,
           };
GetOptions ( $opts, "outfile:s", "infile:s", "debug+", "man", "pad_number=i", "offset=i") or pod2usage(2);
pod2usage(-exitval => 0, -verbose => 2) if $man;

read_offsets_from_file( $opts, $offsets );
prepare_otp( $opts, $offsets );
process_file( $opts, $offsets );
write_offsets_to_file( $opts, $offsets );

exit 0;

# --- Subroutines ---

sub prepare_otp {
	my ( $opts, $offsets ) = @_;
    my $padfile = sprintf ("randomness/random-bytes-%02d.txt", $opts->{pad_number} );
    open(RANDOM,"<", $padfile)  || die("$name: Cannot read from '$padfile':  $!\n");
    my $i = 0;
    while ( $i++ < $offsets->[$opts->{pad_number}] ) {
    	print STDERR $i . " chomp \n" if ($debug);
    	<RANDOM>;
    }
    return *RANDOM; # return a filehandle?
}

sub process_file {
	my ( $opts, $offsets ) = @_;
    my $msg;
    my $packed       = '';
    my $lines        = 0;
    
    $/ = \16;
    while ( <> ) {
        my $msg = $_;
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
    $offsets->[$opts->{pad_number}] += $lines;
}

sub read_offsets_from_file {
    my ( $opts, $offsets ) = @_;
    open( OFFS, "<",  $opts->{offsets_file} )
      || die("$name: Cannot read from '$opts->{offsets_file}': $!\n");
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
    my ( $opts, $offsets ) = @_;
    if ($debug) {
        print scalar(@$offsets) . "\n";
    }
    open( OFFS, ">", $opts->{offsets_file} )
      || die("$name: Cannot write to '$opts->{offsets_file}': $!\n");
    print OFFS	join( "\n", @$offsets ) . "\n";
    if ($debug) {
        print       join( " <-\n", @$offsets) . "\n";
    }
    close(OFFS);
}

exit 0;

__END__

=head1 NAME

encrypt_otp.pl - En/De crypt with one of many one-time-pads

=head1 SYNOPSIS

encrypt_otp.pl [options] [file ...]

encrypt_otp.pl --man  to print full manual

=head1 DESCRIPTION

encrypt_otp.pl will encrypt or decrypt input given to it, either via the
--infile option or STDIN.  It will do so using the choose one-time-pad, which
are stored in the subdirectory 'randomness' and named random-bytes-DD.txt where
DD is the zero-padded, decimal number of the pad, which may be set via the
--pad_number option.

The data used to encrypt/decrypt the message is obtained from the one-time-pad
file, after skipping 'offset' lines.  The offset is found in the offsets.txt
file for the given pad or may be explicitly specified with the --offset option.
If the offset is found in the offsets.txt file, then it's value is adjusted by
the number of lines required for the message being Xcrypted and written back to
the offsets.txt file, thus making it ready to use for the next file.

This method of determining the offset in the pad files should work fine in
normal operation while still allowing the option of either editing the
offsets.txt file by hand or keeping a backup copy.  The only information
passed between participants is the length of each message passed between them.

It is understood that this is an fragile solution at best for the present
and a better protocol/method is planned in future versions.  At worst a user
could scan the pad file a set number of lines forward or behind the presently
stored offset for that pad and attempt to use each subsequent line in the range
as the offset for a given message.


=head1 OPTIONS

=over 8

=item B<-pad_number>

Choose which One-Time Pad to use [ 0..25]

=item B<-offset>

Override the offset (in lines) stored in the offsets file for the choosen pad.

=item B<-outfile>

Output filename

=item B<-infile>

Input filename

=item B<-debug_level>

Level of debugging, useful range 0..6

=item B<-verbosity>

Call multiple time to increase the amount of information printed

=item B<-version>

Print a the version, version of GetOpt::Long and perl, then exit.

=item B<-help|-?>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the input file and will either encrypt or decrypt it
with one of the supplied one-time-pads stored in the random subdirectory.

It will keep a history of the checksums of the input files and the corresponding
offset in the given pad.  It should therefore be able to decrypt or encrypt a message
multiple times using the proper offset and only use a new one should the input file
be new.

=cut
