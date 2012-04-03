#!/usr/bin/perl
#
# A perl-5 script to make files with all permissions
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name";

$debug=1;

foreach $owner_perm ( 0 .. 7 ) {
  $o_perm = '00' . $owner_perm;
  foreach $group_perm ( 0 .. 7 ) {
    $o_g_perm = $o_perm .  $group_perm;
    foreach $other_perm ( 0 .. 7 ) {
      $perm=$o_g_perm . $other_perm;
      $filename="f" . $perm;
      open(FH,">$filename") || die("$name: Cannot create to '$filename': $!\n");
#     print OUTFILE "stuff\n";
      close(OUTFILE);
      chmod $perm, $filename;
      print "$filename\n" if ($debug);
    }
  }
}

foreach $extrabits ( 1, 2, 4, 7 ) {
  foreach $rest ( '666', '777' ) {
      $perm='0' . $extrabits . $rest;
      $filename="f" . $perm;
      open(FH,">$filename") || die("$name: Cannot create to '$filename': $!\n");
#     print OUTFILE "stuff\n";
      close(OUTFILE);
      chmod $perm, $filename;
      print "$filename\n" if ($debug);
  }
}

exit 0;

sub  initialize {
  my($perm_string, $perm_string_S, $perm_string_s, $perm_string_l,
     $perm_string_T, $perm_string_t, $perm);
  push(@perms,'---');	  # $perms{'---'}=0;
  push(@perms,'--x');	  # $perms{'--x'}=1;
  push(@perms,'-w-');	  # $perms{'-w-'}=2;
  push(@perms,'-wx');	  # $perms{'-wx'}=3;
  push(@perms,'r--');	  # $perms{'r--'}=4;
  push(@perms,'r-x');	  # $perms{'r-x'}=5;
  push(@perms,'rw-');	  # $perms{'rw-'}=6;
  push(@perms,'rwx');	  # $perms{'rwx'}=7;

  for ($perm=$[; $perm<=$#perms; $perm++) {
    $perm_string=$perms[$perm];
    $perm{$perm_string}=$perm;
    if ($perm_string=~/-$/) {
      $extra_bits{($perm_string_S=$perm_string) =~ s/-$/S/}=4;
      $extra_bits{($perm_string_l=$perm_string) =~ s/-$/l/}=2;
      $extra_bits{($perm_string_T=$perm_string) =~ s/-$/T/}=1;
      $perm{$perm_string_T}=
      $perm{$perm_string_S}=
      $perm{$perm_string_l}=$perm;
    } else {
      $extra_bits{($perm_string_s=$perm_string) =~ s/x$/s/}=6;
      $extra_bits{($perm_string_t=$perm_string) =~ s/x$/t/}=1;
      $perm{$perm_string_t}=
      $perm{$perm_string_s}=$perm;
    }
  }
}	

__END__
-rwSrwlrwT   1 root     other          0 Mar 22 10:33 f07666
-rwsrwsrwt   1 root     other          0 Mar 22 10:29 f07777
