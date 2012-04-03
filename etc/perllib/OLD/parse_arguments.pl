#   ***   Parse Command Line Argument(s)   ***
sub parse_args {

  local(%abbrev)=();
  local(@args)=('?','help');
  push(@args,'arg1','arg2','arg3','flag_plus_option');
  grep(s/^([^-])/-\1/,@args);

  push(@INC,'/usr/local/lib/perl',"$HOME/perllib");
  require("abbrev.pl");
  &abbrev(*abbrev, @args);

  # foreach $ab ( keys %abbrev) {
  #   print "'$ab'-'$abbrev{$ab}'\n";
  # }

  while ( @ARGV >= 1 ) {
    if      ( $abbrev{$ARGV[0]} eq '-arg1' ) {
      PERL_CODE1;
      shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-arg2' ) {
      PERL_CODE2;
      shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-arg3' ) {
      PERL_CODE3;
      shift(@ARGV);
    } elsif ( $abbrev{$ARGV[0]} eq '-flag_plus_option' ) {
      $option=$ARGV[1];
      shift(@ARGV); shift(@ARGV);
    } elsif ( ($abbrev{$ARGV[0]} eq '-help' )
           || ($abbrev{$ARGV[0]} eq '-?' ) ) {
      do help($usage);
      shift(@ARGV);
    } else {
      last;
    }
  }  # end while
}  # end parse_args
