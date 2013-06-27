#!/usr/bin/perl
#
# A perl-5 script to solve one of the safe puzzles in SafeCracker
# PC game.
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";


# to win each of 6 bars must be acted on 2+4n times, so 2, 6, 10, 14

# there are five wheels that each act on some combiniation of 2 different bars.
# each wheel actually alternates between two sets of 2-bar interactions, eg.
# wheel one will first move bars 1 & 4, then 5 & 6, then 1 & 4 then 5 & 6 and so on.

# I plan to have 5 routines, each representing a wheel, which will keep state and
# act in one of 2 ways.  I will also have a routine that will zero a 6 element array
# representing the bars.  The final routine will check for a winner by applying
# the 2+4n rule to each element in the array (bar).

$state[$_]=0 for (1..5);
  $bar[$_]=0 for (1..6);

# foreach $i (1 .. 5) {
#   print "\$state[$i]=$state[$i]\n";
# }



$w=1; # wheel #1
$wheel->[$w] = sub {
  if ($state[1]) {
    for $b ( 5, 6 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  } else {
    for $b ( 1, 4 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  }
  $state[1] = 1 - $state[1];
};

$w++; print "defining wheel-$w routine.\n";
$wheel->[$w] = sub {
  if ($state[2]) {
    for $b ( 1, 5 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  } else {
    for $b ( 4, 5 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  }
  $state[2] = 1 - $state[2];
};

$w++; print "defining wheel-$w routine.\n";
$wheel->[$w] = sub {
  if ($state[3]) {
    for $b ( 1, 4 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  } else {
    for $b ( 2, 3 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  }
  $state[3] = 1 - $state[3];
};

$w++; print "defining wheel-$w routine.\n";
$wheel->[$w] = sub {
  if ($state[4]) {
    for $b ( 1, 2 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  } else {
    for $b ( 2, 6 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  }
  $state[4] = 1 - $state[4];
};

$w++; print "defining wheel-$w routine.\n";
$wheel->[$w] = sub {
  if ($state[5]) {
    for $b ( 1, 4 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  } else {
    for $b ( 3, 5 ) {
      $bar[$b]++; $bar[$b] %= 4;
    }
  }
  $state[5] = 1 - $state[5];
};

sub solved_yet {
  if    ($bar[1]!=2) { return 0; }
  elsif ($bar[2]!=2) { return 0; }
  elsif ($bar[3]!=2) { return 0; }
  elsif ($bar[4]!=2) { return 0; }
  elsif ($bar[5]!=2) { return 0; }
  elsif ($bar[6]!=2) { return 0; }
  return 1;
}


$count=0;
foreach $i (0..3) {
  foreach $j (0..3) {
    foreach $k (0..3) {
      foreach $m (0..3) {
        foreach $n (0..3) {
          $count++;
          $bar[$_]=0 for (1..6); # reset puzzle first bars, then wheel states
          $state[$_]=0 for (1..5);
	  $ii = $i; while ($ii) { $ii--; &{$wheel->[1]}; }  # turn wheel #1 i times, i is 0 1 or 2
	    print "1 ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
	  $jj = $j; while ($jj) { $jj--; &{$wheel->[2]}; } 
	    print "2 ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
	  $kk = $k; while ($kk) { $kk--; &{$wheel->[3]}; print "$kk:$state[3] "} 
	    print "3 ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
	  $mm = $m; while ($mm) { $mm--; &{$wheel->[4]}; } 
	    print "4 ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
	  $nn = $n; while ($nn) { $nn--; &{$wheel->[5]}; } 
	    print "5 ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
          if ( &solved_yet() ) {
	    print "Found a solution, ($i, $j, $k, $m, $n), after $count attempts!\n";
	    print "Final configuration of bars are as follows ($bar[1],$bar[2],$bar[3],$bar[4],$bar[5],$bar[6])\n";
	    exit 0;
	  }
        }
      }
    }
  }
}
print "No solution found after $count attempts... *SIGH* \n";


exit 0;

__END__


           /-------\
          ( wheel 1 )
           \_______/

                        /-------\
                       ( wheel 2 )
                        \_______/

           /-------\
          ( wheel 3 )
           \_______/

                        /-------\
                       ( wheel 4 )
                        \_______/

           /-------\
          ( wheel 5 )
           \_______/


