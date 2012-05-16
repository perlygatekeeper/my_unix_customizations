#!/usr/bin/perl
#
# A perl filter to underline text.
#
#
$name = $0;
$name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name [-backspaces] [-starting starting_string]";
$usage.= "[[-underline] underlining_char]";

$underline_char='_';
$starting='';

&parse_args;

while (<>) {
  if ($backspaces) {
    chomp;
    ($line=$_)=~s/^(\s*)//; $leading_white_space=$1;
    $line=~s/(.)/\1\ch$underline_char/g; # \ch is ^H
    print $leading_white_space . $line . "\n";
  } else {
    print;
    chomp;
    ($line=$_)=~s/^(\s*)//;
    print $1 . $underline_char x length($line) . "\n";
  }
}

exit 0;

sub parse_args {

  local(%abbrev)=();
  local($true,$false)=(1,0);

  @args=('?','help');
  @help=('print this message','print this message');

  push(@args,'backspaces','underline','starting');
  push(@help,'transform each char to char+backspace+_',
             'define underlining character',
	     'define string that will start each line');

  grep(s/^([^-])/-\1/,@args);

  push(@INC,'/usr/common/lib/perl',"$HOME/perllib");
  require("abbrev.pl");
  &abbrev(*abbrev, @args);

  while ( @ARGV >= 1 ) {
    if      ( ($abbrev{$ARGV[0]} eq '-help' )
           || ($abbrev{$ARGV[0]} eq '-?' ) ) {
      do help($usage);
      shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-underline' ) {
      $underline_char=$ARGV[1];
      shift(@ARGV); shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-starting' ) {
      $starting=$ARGV[1];
      shift(@ARGV); shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-backspaces' ) {
      $backspaces=$true;
      shift(@ARGV);
    } else {
      $underline_char=$ARGV[0];
      shift(@ARGV);
    }
    print "$debug";
  }  # end while
}  # end parse_args

sub help {
  select(STDOUT); $|=1; $\=''; 
  print "@_[0]\n";
  if (@help) {
    for ($arg=$[; $arg<=$#args; $arg++) {
      printf "%-16s\t%s\n", $args[$arg], $help[$arg];
    }
  } else {
    for ($arg=$[; $arg<=$#args; $arg++) {
      print "$args[$arg]\t";
    }
    print "\n";
  }
  exit 1;
}
__END__
