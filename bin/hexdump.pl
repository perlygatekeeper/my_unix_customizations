#!/usr/bin/env perl
#
# @(#) $Id: bin2hex.pl,v 1.9 1999/03/02 13:17:53 jaalto Exp $
# @(#) Perl -- FILE, Convert binary file to hex dump
#
# File id
#
#.Copyright (C) 1998-1999 Jari Aalto
#.Created:1998-05
#	.Contactid:	<jari.aalto@poboxes.com>
#	.Keywords:	Perl file conversion bin hex
#	.Url:		http://www.netforward.com/poboxes/?jari.aalto
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License as
#published by the Free Software Foundation; either version 2 of
#the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful, but
#WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#General Public License for more details.
#
#You should have received a copy of the GNU General Public License along
#with this program; if not, write to the Free Software Foundation,
#Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#About program layout
#
#Code written with Unix Emacs and indentation controlled with
#Emacs package tinytab.el, a generic tab minor mode for programming.
#
#The {{ }}} marks you see in this file are party of file "fold"
#control package called folding.el (Unix Emacs lisp package).
#ftp://ftp.csd.uu.se/pub/users/andersl/beta/ to get the latest.
#
#There is also lines that look like # ....... &tag ... and they
#are generated by Emacs Lisp package `tinybm.el', which is also
#document structure tool. You can jump between the blocks with
#Ctrl-up and Ctrl-down keys and create those "bookmarks" with
#Emacs M-x tibm-insert. See www contact site below.
#
#Funny identifiers at the top of file
#
#The GNU RCS ident(1) program can print useful information out
#of all variables that are in format $ IDENTIFIER: text $
#See also Unix man pages for command what(1) which outputs all lines
#matching @( # ). Try commands:
#
#% what PRGNAME
#% ident PRGNAME
#
#Change Log (none)
# {{{ Initial setup
BEGIN { require 5.004 }
#A U T O L O A D
#
#The => operator quotes only words, and File::Basename is not
#Perl "word"
use autouse 'Pod::Text' => qw( pod2text );
use integer;
use strict;
#Standard perl modules
use English;
use Getopt::Long;
use vars qw ( $VERSION );
#This is for use of Makefile.PL and ExtUtils::MakeMaker
#So that it puts the tardist number in format YYYY.MMDD
#The REAL version number is defined later
#The following variable is updated by my Emacs setup whenever
#this file is saved
$VERSION = '1999.0302';
# ****************************************************************************
#
#DESCRIPTION
#
#Set global variables for the program
#
#INPUT PARAMETERS
#
#none
#
#RETURN VALUES
#
#none
#
# ****************************************************************************
sub Initialize ()
{
use vars qw
(
$PROGNAME
$LIB
$FILE_ID
$VERSION
$CONTACT
$URL
);
$PROGNAME = "bin2hex.pl";# Hard-coded. Not looked from $0
$LIB = $PROGNAME; # library where each function belongs: PRGNAME
$FILE_ID= q$Id: bin2hex.pl,v 1.9 1999/03/02 13:17:53 jaalto Exp $;
$VERSION = (split ' ', $FILE_ID)[2];# version number in format N.NN+
$CONTACT = "<jari.aalto\@poboxes.com>"; # Who is the maintainer
$URL = "";
$OUTPUT_AUTOFLUSH = 1;
}
# }}}
# {{{ usage/help
# ***************************************************************** &help ****
#
#DESCRIPTION
#
#Print help and exit.
#
#INPUT PARAMETERS
#
#$msg[optional] Reason why function was called.
#
#RETURN VALUES
#
#none
#
# ****************************************************************************
=pod
=head1 NAME
bin2hex.pl - Print file in standard hex format
=head1 SYNOPSIS
bin2hex.pl file
bin2hex.pl --width 16 file
bin2hex.pl --base-hex file
=head1 OPTIONS
=head2 General options
=over 4
=item B<--offset N>
Start counting offset from number N instead of zero.
=item B<--width N>
Use width N, default is 10. Must be divideable by 2.
=item B<--base-hex>
The offset counter to the left runs normally in base 10. If you
rather want to see hex based offsets, select this option.
=item B<--extension EXT>
Output to FILE + EXT.
=item B<--Eval PERL-CODE>
Evaluate PERL-CODE to find out the filename. The input filename is
in $ARG which you can modify with standard perl commands.
=item B<--low-nybble>
Use "h20" (pack) format where low nybble comes first Default is "H20".
=item B<--raw>
Dump raw hex data only, without any address or filename tags
66 00 a9 0d 56 00 01 00 ff 35
ff ff ff 20 02 05 00 06 06 06
...
=back
=head2 Miscellaneous options
=over 4
=item B<--debug LEVEL -d LEVEL>
Turn on debug with positive LEVEL number. Zero means no debug.
=item B<--help -h>
Print help page.
=item B<--verbose v>
Turn on verbose messages.
=item B<--Version -V>
Print program version and contact info.
=bac
=head1 README
Print file in hex format:
00000: 66 00 a9 0d 56 00 01 00 ff 35f...V ....5
00010: ff ff ff 20 02 05 00 06 06 06..... .....
00020: 00 12 11 09 61 13 ff ff ff ff....a .....
00030: 48 00 01 00 00 00 11 11 09 61H.... ....a
=head1 EXAMPLES
None.
=head1 ENVIRONMENT
No environment settings.
=head1 SEE ALSO
od(1)
=head1 AVAILABILITY
CPAN entry is http://www.perl.com/CPAN-local//scripts/
Reach author at jari.aalto@poboxes.com or
http://www.netforward.com/poboxes/?jari.aalto
=head1 SCRIPT CATEGORIES
CPAN/Administrative
=head1 PREREQUISITES
No CPAN modules required.
=head1 COREQUISITES
No optional CPAN modules needed.
=head1 OSNAMES
C<any>
=head1 VERSION
$Id: bin2hex.pl,v 1.9 1999/03/02 13:17:53 jaalto Exp $
=head1 AUTHOR
Copyright (C) 1996-1999 Jari Aalto. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself or in terms of Gnu General Public licence v2 or later.
=cut
sub Help (;$)
{
my $id = "$LIB.Help";
my $msg = shift; # optional arg, why are we here...
pod2text $PROGRAM_NAME;
$msg and print "$id: >> $msg\n";
exit 1;
}
# }}}
# {{{ Args parsing
# ************************************************************** &args *******
#
#DESCRIPTION
#
#Read and interpret command line arguments
#
#INPUT PARAMETERS
#
#none
#
#RETURN VALUES
#
#none
#
# ****************************************************************************
sub HandleCommandLineArgs ()
{
my $id = "$LIB.HandleCommandLineArgs";
my ( $version, $help);
# .......................................... command line options ...
use vars qw
(
	$RAW
	$WIDTH
	$EVAL_CODE
	$PACK_CHAR
	$LOW_NYBBLE
	$OFFSET_HEX
	$OFFSET_START
	$EXTENSION
	$USE_EXTENSION
	$USE_EXTENSION_DROP
	$debug
	$verb
);
$WIDTH	= 10;
$WIDTH	= 16;
$EXTENSION	= ".hex";
$PACK_CHAR	= "H";
$OFFSET_HEX	= "1";
# .................................................... read args ...
Getopt::Long::config( qw
(
	ignore_case
require_order
));
GetOptions # Getopt::Long
(
	 "h|help"	=> \$help
	, "verbose"	=> \$verb
	, "Version"	=> \$version
	, "debug"	=> \$debug
	, "base-hex"	=> \$OFFSET_HEX
	, "offset=i"	=> \$OFFSET_START
	, "low-nybble"	=> \$LOW_NYBBLE
	, "width=i"	=> \$WIDTH
	, "raw"		=> \$RAW
	, "extension=s" => \$EXTENSION
	, "Eval=s"	=> \$EVAL_CODE
);
$version	and die "$VERSION $PROGNAME $CONTACT $URL\n";
$help and Help();
$verb = 1	if $debug;
$LOW_NYBBLE	and $PACK_CHAR = "h";
}
# }}}
# {{{ Main
# ............................................................. &main ...
Initialize();
HandleCommandLineArgs();
my $id = "$LIB.main";
not @ARGV	and die "$id: No files";
my $packFormat = $PACK_CHAR . 2*$WIDTH;
my( $writeTo , $file, $count, $buf, $str, $desc, $i, $val, $dec, $ch);
my( $strOut , $pack , $OUT );
local ( *OUT, *IN );
for $file ( @ARGV )
{
$writeTo = "";
# ........................................... select destination ...
$OUT = \*STDOUT;
if ( $EVAL_CODE )
{
	local $ARG = $file;
	eval $EVAL_CODE;
	$EVAL_ERROR	and die"$id: [$EVAL_CODE] $EVAL_ERROR";
	$debug		and print "$id: [$EVAL_CODE] $file --> $ARG\n";
	$writeTo = $ARG;
	open OUT, ">$writeTo"	or die "$id: $writeTo $ERRNO";
	$OUT = *OUT;
}
elsif ( $USE_EXTENSION )
{
	$writeTo = "$file$EXTENSION";			# Default
	open OUT, ">$writeTo"	or die "$id: $writeTo $ERRNO";
	$OUT = *OUT;
}
# ......................................................... open ...
not $RAW		and print "file: $file\n";
# print "OFFSET_HEX is '$OFFSET_HEX'\n";
open IN,"$file"	or die "$id: $file $ERRNO";
binmode F;
# ......................................................... read ...
$count = $OFFSET_START;
while ( read IN, $buf, $WIDTH )
{
	$str = "";
	#Note: using "H" or "h" is important, see od(1),
	#which is the right byte order.
	$pack= unpack $packFormat , $buf;
	$str	= ""; $desc = "| ";
	for ( $i=0; $i < $WIDTH; $i++ )
	{
	$val = substr $pack, $i*2,2;
	$str .= "$val ";
	$dec = hex $val;
	$ch = ".";
	if ( !$RAW and $dec > 32 and $dec < 128 )
	{
		$ch = pack 'C', $dec; 		# only valid characters
	}
	$desc .= $ch;
	if ( $i == $WIDTH/2 -1 )		# additional break
	{
		$str .= " ";
		$desc .= " ";
	}
	}
	$desc .= " |";
# ....................................... write hex contents ...
	if ( $OFFSET_HEX )
	{
	$strOut = sprintf " %05X: %s%s\n", $count, $str, $desc;
	}
	else
	{
	$strOut = sprintf "%05d: %s%s\n", $count, $str, $desc;
	}
	print "$str\n"	if $RAW;
	print $OUT $strOut if not $RAW;
	$count += $WIDTH;
}
close IN;
if ( $USE_EXTENSION )
{
	close OUT;
	print "out: $writeTo\n";
}
}
# }}}
0;
__END__

