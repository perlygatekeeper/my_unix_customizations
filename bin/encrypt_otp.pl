#!/usr/bin/env perl
# A perl script to read bytes

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

use strict;
use warnings;

use Getopt::Long;

my $file_number  =  1;
my $debug        =  0;

my $infile       = sprintf ("randomness/random-bytes-%02d.txt", $file_number );
my $offset_file  = "offsets.txt";
my $packed       = '';
my $offsets      = [];
my $lines        = 0;

open(OFFS, "<", $offset_file) || die("$name: Cannot read from '$offset_file': $!\n");
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

open(RANDOM,"<", $infile)  || die("$name: Cannot read from '$infile':  $!\n");
my $i = 0;
while ( $i++ < $offsets->[$file_number] ) {
	print $i . " chomp \n" if ($debug);
	<RANDOM>;
}
#	if ($ARGV[0] and $ARGV[0] =~ /-s(ee)?/i ) {
#		my $m = $msg;
#		$m =~ s/\n/\\n/g;
#	    print STDERR "($m)\n";
#	}

my $msg;

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

if ($debug) {
    print scalar(@$offsets) . "\n";
}
open(OFFS, ">", $offset_file) || die("$name: Cannot write to '$offset_file': $!\n");
print OFFS	join( "\n", @$offsets ) . "\n";
if ($debug) {
    print       join( " <-\n", @$offsets) . "\n";
}
close(OFFS);

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


    read FILEHANDLE,SCALAR,LENGTH,OFFSET
    read FILEHANDLE,SCALAR,LENGTH
            Attempts to read LENGTH characters of data into variable SCALAR
            from the specified FILEHANDLE. Returns the number of characters
            actually read, 0 at end of file, or undef if there was an error
            (in the latter case $! is also set). SCALAR will be grown or
            shrunk so that the last character actually read is the last
            character of the scalar after the read.

            An OFFSET may be specified to place the read data at some place in
            the string other than the beginning. A negative OFFSET specifies
            placement at that many characters counting backwards from the end
            of the string. A positive OFFSET greater than the length of SCALAR
            results in the string being padded to the required size with "\0"
            bytes before the result of the read is appended.

            The call is implemented in terms of either Perl's or your system's
            native fread(3) library function. To get a true read(2) system
            call, see sysread.

            Note the characters: depending on the status of the filehandle,
            either (8-bit) bytes or characters are read. By default, all
            filehandles operate on bytes, but for example if the filehandle
            has been opened with the ":utf8" I/O layer (see "open", and the
            "open" pragma, open), the I/O will operate on UTF8-encoded Unicode
            characters, not bytes. Similarly for the ":encoding" pragma: in
            that case pretty much any characters can be read.

     substr EXPR,OFFSET,LENGTH,REPLACEMENT
     substr EXPR,OFFSET,LENGTH
     substr EXPR,OFFSET

First character is at offset 0

OFFSET is negative   == that far from the end of the string.
no LENGTH            == everything to the end of the string.
LENGTH is negative   == leaves that many characters off the end of the string.

To keep the string the same length you may need to pad
or chop your value using "sprintf".


OFFSET and LENGTH partly outside, only part returned.
OFFSET and LENGTH completely outside, UNDEF returned.

Here's an example showing the behavior for boundary cases:

  my $name = 'fred';
  substr($name, 4) = 'dy';       # $name is now 'freddy'
  my $null = substr $name, 6, 2; # returns '' (no warning)
  my $oops = substr $name, 7;    # returns undef, with warning
  substr($name, 7) = 'gap';      # fatal error

  my $str="abd123hij";		     # 2 ways to replace 123 with efg
  substr($str, 2, 3, 'efg');	 # assign 4th arg.
  substr($str, 2, 3)='efg';	     # substr as an lvalue

AUTOLOAD		getgrnam		readwrite
Getopts			getopt-long		recursive_decent
OLD			getpwnam		regexp
SymbolTable		group			remote
URLS			help			response
abbrev2.pl		here			roman
addr2hex		hostname		rot13
append			if			rw
arp_ethers.pl		ifelse			select
arrays			inout			serial.numbers
arraytohash		inout.faq		setup_case
author			last_mod		shadow
binary			lower			shebang
box.pl			ls			sleep
break			main			sort
byteflip		minutes			sort.old
case			mkdir			special_chars
chem_select		move			splice
command			multidimensional_array	split
copy			multiline		stack
copyright		mytime			stat
croak			name			stderr.faq
crypt			new			stndrd
ctrl-c.ignore		newhelp			sub
data			newline			sub_ascii
date			newtime			sub_case
datetime		number			sub_help
default			onebits			sub_parse_args
directory		open			sub_ping_first
env			parity			sub_sign
eval			parse_args		substr
example_syntax		passwd			system
examples		perl.ans		t5
extract_matching.pl	perl.todo		template
fileperms		perl_number_tester	test
files			perms			test_matching.pl
flags			ping_first.pl		tie
flip			pipeline		tilde-to-home
flush			pointers		time
for			    print			true
for.orig		protect			usage
forarray		protect.chars		user
fori			pwd			version
fork			qqq			wantarray
ftp-telnet.faq		random			while
get_ip_name		read			write


http://perldoc.perl.org/Getopt/Long.html

use Getopt::Long;
GetOptions('color=s' => \$variable); # a string value required
GetOptions('color:s' => \$variable); # a string value is optional
GetOptions('color=i' => \$variable); # an integer value is required
GetOptions('color:i' => \$variable); # an integer value is optional
GetOptions('color=f' => \$variable); # a float value is required
GetOptions('color:f' => \$variable); # a float value is optional

GetOptions('dir|path|location=s' => \$variable);
# The first name specified is the primary name; all the other are called aliases.

# Use the special option '<>' to specify a function that will be called when an unexpected parameter is found.

GetOptions('dir=s' => \$variable, '<>' => \&function);


Without additional configuration, GetOptions() will ignore the case of option names, and allow the options to be abbreviated to uniqueness.

+ The option does not take an argument and will be incremented by 1 every time it appears on the command line. E.g. "more+" ,
  when used with --more --more --more, will increment the value three times, resulting in a value of 3 (provided it was 0 or undefined at first).
  The + specifier is ignored if the option destination is not a scalar.

= type [ desttype ] [ repeat ]
  The option requires an argument of the given type. Supported types are:

s String. An arbitrary sequence of characters. It is valid for the argument to start with - or -- .
i Integer. An optional leading plus or minus sign, followed by a sequence of digits.
o Extended integer, Perl style. This can be either an optional leading plus or minus sign, followed by a sequence of digits,
  or an octal string (a zero, optionally followed by '0', '1', .. '7'), or a hexadecimal string
  (0x followed by '0' .. '9', 'a' .. 'f', case insensitive), or a binary string (0b followed by a series of '0' and '1').
f Real number. For example 3.14 , -6.23E24 and so on.

The desttype can be @ or % to specify that the option is list or a hash valued. This is only needed when the destination
for the option value is not otherwise specified. It should be omitted when not needed.
The repeat specifies the number of values this option takes per occurrence on the command line.
It has the format { [ min ] [ , [ max ] ] }.


#!/usr/bin/env perl
use Getopt::Long;
 
my ($help, @url, $size);
 
#-- prints usage if no command line parameters are passed or there is an unknown
#   parameter or help option is passed
usage() if ( @ARGV < 1 or
          ! GetOptions('help|?' => \$help, 'url=s' => \@url, 'size=i' => \$size)
          or defined $help );
 
sub usage
{
  print "Unknown option: @_\n" if ( @_ );
  print "usage: program [--url URL] [--size SIZE] [--help|-?]\n";
  exit;
}

# ---------
use Getopt::Long;
    use Pod::Usage;
    my $man = 0;
    my $help = 0;
    GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
    pod2usage(1) if $help;
    pod2usage(-exitval => 0, -verbose => 2) if $man;
__END__
=head1 NAME
    sample - Using Getopt::Long and Pod::Usage
=head1 SYNOPSIS
    sample [options] [file ...]
    Options:
       -help            brief help message
       -man             full documentation

auto_version (default:disabled)
Automatically provide support for the --version option if the application did not specify a handler for this option itself.
Getopt::Long will provide a standard version message that includes the program name, its version (if $main::VERSION is defined), and the versions of Getopt::Long and Perl. The message will be written to standard output and processing will terminate.
auto_version will be enabled if the calling program explicitly specified a version number higher than 2.32 in the use or require statement.

auto_help (default:disabled)
Automatically provide support for the --help and -? options if the application did not specify a handler for this option itself.
Getopt::Long will provide a help message using module Pod::Usage. The message, derived from the SYNOPSIS POD section, will be written to standard output and processing will terminate.
auto_help will be enabled if the calling program explicitly specified a version number higher than 2.32 in the use or require statement.
