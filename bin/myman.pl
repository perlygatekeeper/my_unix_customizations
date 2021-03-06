#!/usr/bin/env perl
#
# A perl script to output a nroffable 'man' file in the present directory
#
$name = $0;
$name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name manpage_file";

# $EQN=    (chop ($junk=`which neqn`),$junk)
#       || (chop ($junk=`which eqn`),$junk);
$EQN='/usr/bin/neqn';
# $TBL=    (chop ($junk=`which tbl`),$junk);
$TBL='/usr/bin/tbl';
# $COL=    (chop ($junk=`which col`),$junk);
$COL='/usr/bin/col';
# $REFER=  (chop ($junk=`which refer`),$junk);
$REFER='/usr/bin/refer';
#$VGRIND= (chop ($junk=`which vgrind`),$junk);
$VGRIND='/usr/bin/vgrind';

#$NROFF=(chop ($junk=`which nroff`),$junk);
$NROFF='/usr/bin/nroff';
# $PAGER= $ENV{PAGER}
#        || (chop ($junk=`which less`),$junk)
#        || (chop ($junk=`which more`),$junk)
#        || (chop ($junk=`which pg`),$junk);
$PAGER= $ENV{PAGER}
        || '/usr/local/bin/less'
        || '/usr/bin/more';

@extension_list=( 'l', '1', '3', '5', '8', 'n', '2', '4', '6', '7');

# check for file existence.
print "trying $ARGV[0]...\n";

if ( ( -f "$ARGV[0]" ) && ( -r "$ARGV[0]" ) ) {
  $manfile="$ARGV[0]";
} else {
  foreach $extension ( @extension_list ) {
#   print "trying $ARGV[0].$extension...
    if (( -f "$ARGV[0].$extension" ) && ( -r "$ARGV[0].$extension" )) {
      $manfile="$ARGV[0].$extension";
      last;
    }
  }
  if (! $manfile) {
    print "$name: no file $ARGV[0] or $ARGV[0].?\n";
    exit 1;
  }
}

# do the 'man'.
#if (( `grep -c '^\.\\\" t' $manfile` >= 1 ) ||     ( $force_tbl eq 1 )) {
#  tbl $manfile | nroff -man | /usr/bin/col | ${pager:-more};
#} else {
#  nroff -man $manfile | ${pager:-more};
#}
# '\" t

$infile=$manfile;
open(INFILE,"<$infile") || die("$name: Cannot read from '$infile': $!\n");
$macros=<>;
close(INFILE);

if ( $macros =~ /^'\\" ([terv]+)/ ) {
  $macros=$1;
  if ( $macros =~ /t/ ) {
    $command = "$TBL $manfile";
  }
  if ( $macros =~ /e/ ) {
    $command = ($command) ? $command . " | $EQN " : "$EQN $manfile";
  }
  if ( $macros =~ /r/ ) {
    $command = ($command) ? $command . " | $REFER " : "$REFER $manfile";
  }
  if ( $macros =~ /v/ ) {
    $command = ($command) ? $command . " | $VGRIND " : "$VGRIND $manfile";
  }
}

$command = ($command) ?
           $command . " $NROFF -man $manfile" :
           "$NROFF -man $manfile";
$command .= " | $COL | $PAGER";

system("$command");

exit 0;

__END__
