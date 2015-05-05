#!/usr/bin/env perl
# rip_pkg - rip apart Solaris pkg's and get the binaries out
#
# 2008 - Mike Golvach - eggi@comcast.net
# 2015 - Steve Parker - parker.12@osu.edu
# Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License

use strict;
use warnings;

my $debug = 1;
my $preserve = 1;

if ( $#ARGV != 0 ) {
  print "Usage: $0 pkg_file\n";
  exit(1);
}

my $pkg_file = $ARGV[0];
my $magic = '070701000';
my $pkg_name;

if ( not -f $pkg_file ) {
  print STDERR "pkg file given ($pkg_file) does not exist.\n";
  exit 0;
} else {
  open(PKG,"<", $pkg_file) || die("rip_pkg.pl: Cannot read from '$pkg_file': $!\n");
  my $first_line = <PKG>;
  if ( $first_line !~ /package datastream/i ) {
    print STDERR "$pkg_file doesn't appear to be a valid SVR4 pkg DataStream file. $first_line\n\n Exiting...\n";
	exit 1;
  } else {
  	my $second_line = <PKG>;
  	$second_line =~ /^(\S+)\s+\d+\s+\d+/;
  	$pkg_name = $1;
    seek(PKG, 0, 0); # preserve first line for while loop below
  } 
}

# Split out header information and kludgey cpio file with binary contents
open(P_HEADERS, ">", "$pkg_file.headers") || die("rip_pkg.pl: Cannot write to '$pkg_file.headers': $!\n");
open(P_CPIO1,   ">", "$pkg_file.cpio1")   || die("rip_pkg.pl: Cannot write to '$pkg_file.cpio1':   $!\n");
open(P_CPIO2,   ">", "$pkg_file.cpio2")   || die("rip_pkg.pl: Cannot write to '$pkg_file.cpio2':   $!\n");

# HEADER
while ( my $line = <PKG> ) {
    print P_HEADERS $line;
    if ( $line =~ /end of header/ ) {
        close(P_HEADERS);
        last;
    }
}

my $first_line = 1;
my $count = 0;

# CPIO #1
while ( my $line = <PKG> ) {
	print STDERR "1" if ($debug);
	if ( $line =~ /PKG=(\S+)/ ) {
		$pkg_name ||= $1;
	}
	if ( $first_line ) {
		$first_line = 0;
		$line =~ s/^\0*//; # remove leading nulls
	}
    if ( $line =~ /^(\0*$magic[[:xdigit:]]+TRAILER!!!\0+)(.*)$/ ) {
        print P_CPIO1 $1;
        print P_CPIO1 "\n";
        close(P_CPIO1);
#		$count++;
#	    print ".\n";
		$line = $2;
        $line =~ s/^\0*//; # remove leading nulls
        print P_CPIO2 $line;
        print P_CPIO2 "\n";
		last;;
    } else {
        print P_CPIO1 $line;
	}
}

# while ( my $line = <PKG> ) {
# $count++;
# print "2 $count '$magic'\n";
# if ( $count > 1 and $count < 15 ) {
# print "\n $line\n";
# }
# if ( $line =~ /$magic/ ) {
# $line =~ s/^\0*//; # remove leading nulls
# print P_CPIO2 $line;
# last;
# }
# }
print "\n";

# CPIO #2
while ( my $line = <PKG> ) {
	$count++;
	print STDERR "3" if ($debug and $count < 100);;
    print P_CPIO2 $line;
    if ( $line =~ /^(\0*$magic[[:xdigit:]]+TRAILER!!!\0+)$/ ) {
        last;
	}
}
close(P_CPIO2);
close(PKG);
print STDERR "\n" if ($debug);;

if ( $pkg_name ) {
  $pkg_name =~ s/^SMC//;
  print STDERR "package name is found to be ($pkg_name)\n" if ($debug);
  if ( not -d $pkg_name ) {
    print STDERR "making directory for ($pkg_name)\n" if ($debug);
    mkdir("$pkg_name") || die("Couldn't make directory ($pkg_name): $!");
  }
  chdir("$pkg_name");
} else {
  die("Couldn't determine package name for directory.");
}

# system("cpio    -H newc -iv                    <../$pkg_file.cpio >/dev/null 2>&1");
# use Archive::Cpio;
# system("gnucpio -H newc -iv --make_directories <../$pkg_file.cpio1 >/dev/null 2>&1");
# system("gnucpio -H newc -iv --make_directories <../$pkg_file.cpio2 >/dev/null 2>&1");
if ($debug) {
  system("/bin/cpio.exe -H newc -iv <../$pkg_file.cpio1");
  system("/bin/cpio.exe -H newc -iv <../$pkg_file.cpio2");
} else {
  system("/bin/cpio.exe -H newc -iv <../$pkg_file.cpio1 >/dev/null 2>&1");
  system("/bin/cpio.exe -H newc -iv <../$pkg_file.cpio2 >/dev/null 2>&1");
}

if ( -d "reloc" ) {
  print "Relocating reloc!\n";
  chdir("reloc");
  system("tar cpf - *|(cd ../;tar xpf -)");
  chdir("../");
  use File::Path qw(rmtree);
  rmtree( [ "reloc" ] );
}
chdir("../"); # return from package dir
if (not $preserve) {
  unlink("$pkg_file.cpio1")   if ( -f "$pkg_file.cpio1");
  unlink("$pkg_file.cpio2")   if ( -f "$pkg_file.cpio2");
  unlink("$pkg_file.headers") if ( -f "$pkg_file.headers");
  print STDERR "cleaned up headers ($pkg_file.headers) and cpio's ($pkg_file.cpio?) temporary files.\n";
}

exit 0;
__END__
