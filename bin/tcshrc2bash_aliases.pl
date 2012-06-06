#!/usr/bin/perl
#
# A perl script to reap the aliases from ~/.tcshrc and put them in
# ~/.bash_aliases
#

use strict;
use warnings;

my $name = $0; $name =~ s'.*/''; # remove path--like basename
my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";


  my $infile  = ".tcshrc";
  my $outfile = ".bash_aliases";
  open(INFILE,"<$infile") || die("$name: Cannot read from '$infile': $!\n");
  open(OUTFILE,">$outfile") || die("$name: Cannot write to '$outfile': $!\n");


  my $history_lines;
  $history_lines = << '  EOF';
  HISTCONTROL=erasedups:ignorespace
  # append to the history file, don't overwrite it
  shopt -s histappend
  HISTSIZE=2048
  HISTFILESIZE=2048

  EOF
  $history_lines =~ s/^\s{2}//gm;
  print OUTFILE $history_lines;

  while (<INFILE>) {
    next unless ( /alias|^a / );
	s/^a (\S+)\s+(\S.*)/sprintf "a %10s = %s", $1, $2/e;
	s/^alias\s+(\S+)\s+(\S.*)/sprintf "alias %6s = %s", $1, $2/e;
    print OUTFILE;
  }

  close(OUTFILE);
  close(INFILE);

exit 0;

__END__
