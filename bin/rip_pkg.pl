#!/usr/bin/perl

#
# rip_pkg - rip apart Solaris pkg's and get the binaries out
#
# 2008 - Mike Golvach - eggi@comcast.net
# Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License
#

if ( $#ARGV != 0 ) {
 print "Usage: $0 pkg_file\n";
 exit(1);
}

$pkg_name = $ARGV[0];

# check and make sure it's a SVR4 DataStream Pkg

chomp($simple_header_check=`grep -i "package datastream" $pkg_name >/dev/null 2>&1;echo \$?`);

if ( $simple_header_check != 0 ) {
 print "This doesn't appear to be a valid SVR4 DataStream pkg file.  Exiting...\n";
 exit;
}

# Memory Hogging Here - Until This Cold Quits Me And I Can Think My Way Out Of This ;)

open(PKG, "<$pkg_name");
@pkg_file = <PKG>;
close(PKG);

# Split out header information and kludgey cpio file with binary contents

$header_end = 0;
$cpio_start = 0;
open (P_HEADERS, ">$pkg_name.headers");
foreach $line (@pkg_file)   {
 if ( $header_end == 0 && $line =~ /TRAILER/ && $line =~ /pkginfo/ )  {
  print P_HEADERS $line;
  $header_end = 1;
 } elsif ( $header_end == 1 && $line =~ /pkginfo/ ) {
  print P_HEADERS $line;
  close(P_HEADERS);
  $cpio_start = 1;
  open(P_CPIO, ">$pkg_name.cpio");
 } elsif ( $cpio_start == 0 ) {
  print P_HEADERS $line;
 } elsif ( $cpio_start == 1 ) {
  print P_CPIO $line;
 } else {
  print STDERR "WTF?\n";
 }
}
close(P_CPIO);

open(P_HEADERS, "<$pkg_name.headers");
@p_headers = <P_HEADERS>;
close(P_HEADERS);

$output_dir = 0;
$pkginfo_start = 0;
$pkginfo_seek = 0;
$pkgmap_start = 0;
foreach $p_head (@p_headers)  {
 if ( $output_dir eq 1 && $pkginfo_seek == 0 )  {
  $output_dir = $p_head;
  $output_dir =~ s/^(\w+)\W*.*$/$1/;
  chomp($output_dir);
  $pkginfo_seek = 1;
 } elsif ( $output_dir eq 0 && $p_head =~ /datastream/i ) {
  $output_dir = 1;
 } elsif ( $output_dir eq 0 && $pkginfo_start == 0 ) {
  next;
 } elsif ( $output_dir ne 0 && $p_head =~ /pkgmap/ ) {
  $pkgmap_start = 1;
  $pkginfo_start = 0;
 } elsif ( $pkgmap_start == 1 && $p_head =~ /pkginfo/ ) {
  chomp($p_head);
  push(@pkgmap, $p_head);
  last;
 } elsif ( $output_dir ne 0 && $p_head =~ /pkginfo.*PKG=/ ) {
  $pkginfo_start = 1;
 } elsif ( $output_dir ne 0 && $pkgmap_start == 1 ) {
  chomp($p_head);
  push(@pkgmap, $p_head);
 } elsif ( $output_dir ne 0 && $pkginfo_start == 1 ) {
  chomp($p_head);
  push(@pkginfo, $p_head);
 } else {
  print "WTF NOTHING MATCHED\n OD $output_dir PST $pkginfo_start PS $pkginfo_seek PMST $pkgmap_start\n$p_head\n";
 }
}

mkdir("$output_dir");
chdir("$output_dir");
open(PKGINFO_OUT, ">>pkginfo");
foreach $info (@pkginfo) {
 print PKGINFO_OUT "$info\n";
}
open(PKGMAP_OUT, ">>pkgmap");
foreach $map (@pkgmap) {
 print PKGMAP_OUT "$map\n";
}
open(PROTO_OUT, ">>prototype");
foreach $proto (@pkgmap) {
 @proto = split(" ", $proto);
 print PROTO_OUT "$proto[1] $proto[2] $proto[3] $proto[4] $proto[5] $proto[6]\n";
}
system("cpio -iv <../$pkg_name.cpio >/dev/null 2>&1");
chdir("reloc");
system("tar cpf - *|(cd ../;tar xpf -)");
chdir("../");
system("rm -r reloc");
chdir("../");
unlink "$pkg_name.headers";
unlink "$pkg_name.cpio";
