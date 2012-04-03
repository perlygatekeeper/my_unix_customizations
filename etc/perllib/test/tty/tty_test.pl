#!/usr/bin/perl
#
# A perl-5 script to test if run from an interactive shell or
# in the background, as in a process started by cron or at.
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name";

use sigtrap 'handler' => \&handle_ttou, 'TTOU';

$outfile="$name.out";
open(OUTFILE,">>$outfile") || die("$name: Cannot append to '$outfile': $!\n");

if (-t) {
  $string ="I predict that this is a tty\n";
  $string.="You must have run me interactively :)\n";
# $stty=`stty -a`;
  if (-t STDOUT) {
    $string.="I enjoy the attention you give me.\n";
  } else {
    $string.="Although you started me from a prompt you then threw\n" .
	     "me in the background like so much discarded stuff.\n";
  }
} else {
  $string ="I predict that this is *NOT* a tty\n";
  $string.="I am lonely as I execute alone here in the BACKGROUND :(\n";
}
#print         $string;
print OUTFILE $string;

$tty=`tty`;
$date=`date`;
$string=$tty . $date . "\n";
#print         $string;
print OUTFILE $string;
close(OUTFILE);

#$outfile="$name.$$";
#open(OUTFILE,">$outfile") || die("$name: Cannot write to '$outfile': $!\n");
## print OUTFILE `env`;
print OUTFILE `stty -a`;
#close(OUTFILE);

exit 0;

sub handle_ttou {
  print OUTFILE "ARG!\n";
}

__END__

#if ($tty !~ /not a tty/i) {
#  $string="You must have run me interactively :)\n";
#  print         $string;
#  print OUTFILE $string;
#} else {
#  $string="I am lonely as I execute alone here in the BACKGROUND :(\n";
#  print         $string;
#  print OUTFILE $string;
#}

# $string=<>;
# print         $string;
# print OUTFILE $string;
