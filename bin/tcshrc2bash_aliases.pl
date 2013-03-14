#!/usr/bin/perl
#
# A perl script to reap the aliases from ~/.tcshrc and put them in
# ~/.bash_aliases
#

use strict;
use warnings;

  my $name = $0; $name =~ s'.*/''; # remove path--like basename
  my $usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

  my $histsize;
  my $histfilesize;

  my $infile  = ".tcshrc";
  my $outfile = ".bash_aliases";
  open(INFILE,"<$infile") || die("$name: Cannot read from '$infile': $!\n");
  open(OUTFILE,">$outfile") || die("$name: Cannot write to '$outfile': $!\n");


  while (<INFILE>) {
    if ( /^[^#]*history\s*=\s*(\d+)/     ) { print OUTFILE "HISTSIZE=$1\n";     $histsize++;}
    if ( /^[^#]*savehist\s*=[\s(]*(\d+)/ ) { print OUTFILE "HISTFILESIZE=$1\n"; $histfilesize++;}
    next unless ( /alias|^a / );
	s/^a (\S+)\s+(\S.*)/sprintf "a %10s='%s'", $1, $2/e;
	s/^alias\s+(\S+)\s+(\S.*)/sprintf "alias %6s='%s'", $1, $2/e;
    print OUTFILE;
  }

  my $history_lines;
  $history_lines = << '  EOF';
  HISTCONTROL=erasedups:ignorespace
  # append to the history file, don't overwrite it
  shopt -s histappend
  
  EOF
  $history_lines =~ s/^\s{2}//gm;
  print OUTFILE "HISTSIZE=2048\n"     if (not $histsize);
  print OUTFILE "HISTFILESIZE=2048\n" if (not $histfilesize);
  print OUTFILE $history_lines;

  print OUTFILE qq(bind '"\\ep": history-search-backward'\n);

  close(OUTFILE);
  close(INFILE);

exit 0;

__END__
