#!/usr/bin/env perl
#
# A perl-5 script to print perl scripts with sub routines
# starting on top of new page when appropriate.
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name";

$version = 1.0; # use print  (try write later)
$debug=0;

# print main program
push (@subs,{"name" => "main"}); $sub=$subs[$#subs];
$sub->{"firstline"}=1;
while (<>) {
  last if ($subline,$subname)=($_=~/^(\s*sub\s*(\S+)\s*\{.*)/);
  push (@{$sub->{"body"}},$_);
  $sub->{"length"}+=1;
}

# may assume subline and subname are set to last found subroutine.
while (not $done) {
  push (@subs,{"name" => $subname}); $sub=$subs[$#subs];
  push (@{$sub->{"body"}},$subline);
  $sub->{"length"}+=1;
  $sub->{"firstline"}=$.;
# print "\n>>$#subs<<\n" if ($debug);
  while(<>) {
    push (@{$sub->{"body"}},$_);
    $sub->{"length"}+=1;
# print '.', $i++ if ($debug);
    if ($_=~/^\}/) {  # last line of a subroutine; look for first line of next one.
      while (<>) {
# print "Skipping...\n"; $subs++ if ($debug);
        last if ($subline,$subname)=($_=~/^(\s*sub\s*(\S+)\s*\{.*)/);
	if (/^__END__$/) {
          $done=$_;
	  last;
	}
      }
      last;
    }
  }
  $done=1 if eof;
}

if ($ARGV=~/-s/i) {
  &sub_stats;
} else {
  &sub_print;
}

exit 0;

sub sub_print {
  $lines_left=
  $page_length=60;
  foreach $sub (@subs) {
    $first_line=${$sub->{"body"}}[0];
    if ($sub->{"name"} !~ /main/i) {
      $info =sprintf "# length: %d begins at %d", $sub->{"length"}, $sub->{"firstline"};
      $info.=sprintf "; lines left before %d,", $lines_left;
      if ($lines_left >= $sub->{"length"}) {
        $lines_left -= $sub->{"length"};
      } else {
        print "\f";
        $lines_left = $page_length - $sub->{"length"};
      }
      $info.=sprintf "after %d,", $lines_left;
      $first_line=~s/^(\s*sub\s*\S+\s*{).*/\1 $info/;
    } else {
      $lines_left -= $sub->{"length"};
    }
    print "$first_line\n";
    for ($line=1; $line<=$#{$sub->{"body"}}; $line++) {
      print ${$sub->{"body"}}[$line];
    }
  }
}

sub sub_stats {
  print "subs count $subs\n" if ($debug);
  $name_length=25;
  $format="%-${name_length}s %4s %4s\n";
  printf $format, "Name", "Length", "Begins on";
  $format="%-${name_length}s %4d %4d\n";
  foreach $sub (@subs) {
    printf $format, $sub->{"name"},
           $sub->{"length"},
           $sub->{"firstline"};
  }
}

__END__
