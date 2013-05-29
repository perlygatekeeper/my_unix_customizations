#!/usr/local/bin/perl
# A perl script to test extract_matching subroutine

$name = $0;
$name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name";

$true=1; $false=0;

$test=2;

require("extract_matching.pl");

if ($test == 1) {
# push(@test_strings,'\title{simple text}');
# push(@test_strings,"\\title{simple text\nwith two lines}");
# push(@test_strings,"\\title{\nsimple text\nwith two lines\n}");
  push(@test_strings,
    '\title{simple text}',
    "\\title{simple text\nwith two lines}",
    "\\title{\nsimple text\nwith two lines\n}",
    "\\title{simple text {stuff} with embedded delimiters}",
    "\\title{multilined text\n{\n}\nwith embedded delimiters}",
    "\\title{multilined text #first commnent\n{\n#comment line\n}\nwith comments}",
    "pre-stuff\\title{multilined text #first commnent\n{\n#comment line\n}\nwith comments}post-stuff",
  );
  foreach $string (@test_strings) {
    @matches=&extract_matching($string,'\title');
    print "Matches from string:\n";
    print "$string\n";
    print ">----\n";
    print join("\n-----\n",@matches);
    print "\n<----\n";
  }

} elsif ( $test == 2 ) {

  @test_strings=();
  $infile="/home/mss96/abstracts/p021.tex";
  open(INFILE,"<$infile") || die("$name: Cannot read from '$infile': $!\n");
  while (<INFILE>) {
    chop;
#   push(@test_strings,$_);
    $string.=$_."\n";
  }
  close(INFILE);

  print "'$string'\n";
  foreach $regexp ('\title', '\timereq', '\category',
                   '\comment', '\author', '\address' ) {
    @matches=&extract_matching($string,$regexp,'{','}','\\','%');
    print "Matches for regexp:\n";
    print "$regexp\n";
    print ">----\n";
    print join("\n-----\n",@matches);
    print "\n<----\n";
  }

} elsif ( $test == 3 ) {
  $a=' 15 ';
  print "'$a'\n";
  $a=~s/^\s*|\s*$//g;
  print "'$a'\n";
}

exit 0;

__END__
