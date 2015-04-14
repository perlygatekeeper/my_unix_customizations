#!/usr/bin/env perl
#
# A perl-5 script to submit a Gaussian 98 job to an NQS or PBS batch queue.
#
#! $1      -- name of queue.
#! $2      -- name of input file.
#! $3      -- inter-queue priority (default value is 31)
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$last_mod_date='TUE, Mar 19 2002';
$version="1.0";   # first version based on csh script by Chris Hadad
$version="2.0";   # rewrite by GR for PBS in addition to NQS
$version="2.1";   # small mods so that this works on Linux as well

$debug=0;

&detect_batch_system;
&initialize;
&parse_args;

if (not -f $com_file) {
  print "No com file '$com_file'.\n";
  print $usage;
  exit 0;
}
if (not $queue) {
  print "No queue selected.\n";
  print $usage;
  exit 0;
}
&create_job_file;

print "Submitting job on $HOST using command file '$com_file'" . 
      "to queue '$queue'.\n" if ($debug);
if ($PBS) {
  &system("qsub -q $queue -p $pri -r n -j oe -V -o $batch_file $job_file",1,1);
} else {
  &system("qsub -q $queue -p $pri -nr -eo -r $file -x -o $batch_file $job_file",1,1);
}
# unlink $job_file;

# qsub command options:
#
#	PBS	NQS
#	-r n	-nr		job not restartable
#	-j oe	-eo		standard error and standard output will be merged
#				and mixed on standard output
#	-V	-x		export all environment variable to the job
#		-r		name for the batch request
#	-o	-o		standard output

exit 0;

sub create_job_file {
  my($debug)=0;
# print "Creating Job File as '$jobfile'.\n" if ($verbose || $debug);
  open(JOBFILE,">$job_file")
    || die("$name: Cannot write to '$job_file': $!\n");
  print JOBFILE "#!/bin/tcsh\n";
  print JOBFILE "setenv g98root /usr/local/gaussian\n";
  print JOBFILE "if -x /usr/local/gaussian/g98/bsd/g98.login source  /usr/local/gaussian/g98/bsd/g98.login\n";
  if ($PBS) {
    print JOBFILE "cd \$PBS_O_WORKDIR\n";
  } else {
    print JOBFILE "unlimit filesize\n";
    print JOBFILE "unlimit datasize\n";
    print JOBFILE "unlimit stacksize\n";
    print JOBFILE "unlimit memoryuse\n";
    print JOBFILE "nice +19\n";
    print JOBFILE "cd \$QSUB_WORKDIR\n";
  }
  print JOBFILE " /usr/local/gaussian/g98/g98 < $com_file >&! $log_file\n";
  close(JOBFILE);
}

sub assign_queue {
  my($debug)=0;
  my($possible_queue)=@_;
  my($prefixed,$small,$queue);
# full queue name
  if ($queue{$possible_queue}) {
    $queue=$possible_queue;
    print "full queue: '$queue'\n" if ($debug);
# check for other queue names prefixed with 'host_'
# for example the digit queues, eg. md_1 or md_small
  } elsif ( $queue{$prefixed="$host_abbrevs{$HOST}" . "_$possible_queue"}) {
    $queue=$prefixed;
    print "the prefixed queue: '$queue'\n" if ($debug);
# check for small queue (specified with an 's'), eg. md_small
  } elsif ( $queue{$small="$host_abbrevs{$HOST}" . "_${possible_queue}mall"}) {
    $queue=$small;
    print "the small queue: '$queue'\n" if ($debug);
  } else {
    $queue='';
    print "suspected queue '$possible_queue'... wasn't\n" if ($debug);
  }
  return $queue;
}

sub initialize {
  my($debug)=0;
  $HOST= $ENV{HOST} || $ENV{Hostname} || (chomp ($junk=`uname -a`),$junk);
  $HOST=~ s/\.mps\.ohio-state\.edu//;
  %host_abbrevs=("mendelevium" => "md",
                 "nobelium" => "no",
                 "lawrencium" => "lr",
                 "saturn" => "saturn",
                 "orion" => "orion",
                 "calypso" => "calypso",
                 "titan" => "titan");
  $pri=31;
# get a list of valid queue names on this host and store in both array and hash
  if ($PBS) {
    $command="qstat -Q |";
  } else {
    $command="qstat -as |";
  }
  open(QSTAT,"$command") ||
  die("$name: Cannot get a list of queues with '$command': $!.");
  local(@results)=<QSTAT>;
  close(QSTAT);
  if ($PBS) {
    @queues=grep(s/^(\S+).*Execution.*\n$/$1/,@results);
  } else {
    @queues=grep(s/\s*(\S+)\@.*\n$/$1/,@results);
  }
  print "queues: " . join (", ", @queues) . "\n" if ($debug);
  foreach $queue (@queues) { $queue{$queue}++; }

# define usage string
  $usage = "\n  Usage: \n";
  $usage.= "        subgauss queue_name job_name <PRI#>\n";
  $usage.= "  e.g.  subgauss md_1 water                \n\n";
# $usage.= "  <PRI#> default: 31 -- larger value = higher priority (<=63).\n\n";
  $usage.= "  ($HOST's Queues:";
  if ($PBS) {
    $usage.= join(", ", keys %queues) . " -- qstat -q for details.)\n\n";
  } else {
    $usage.= join(", ", keys %queues) . " -- qstat -as for details.)\n\n";
  }

  ($var="t94ebbg")
    =~ tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
  ($ENV{$var}="/hfe/ybpny/.tnhffvna")
    =~ tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
  eval "\${$var}=\$ENV{$var}";
  ($var="TNHFFNEP")
    =~ tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
  ($ENV{$var}="/fpe/nepu") =~
    tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
  ($var="TNHFF_FPEQVE")
    =~ tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
  ($ENV{$var}="/fpe/gzc") =~
    tr/a-mA-Mn-zN-Z/n-zN-Za-mA-M/;
}

sub parse_args {
  my($debug)=0;
  while ( @ARGV >= 1 ) {
    if      ( ($ARGV[0] eq '-help' )
           || ($ARGV[0] eq '-?' ) ) {
      &help($usage);
      shift(@ARGV);
    } elsif ( -f $ARGV[0] or -f "$ARGV[0].com" ) {
      ($file=$ARGV[0]) =~ s/\.com$//;
      if (-f "$file.com") {
        $batch_file=	"$file.batch_log";
        $job_file=	"$file.Job";
        $com_file=	"$file.com";
        $log_file=	"$file.log";
      } else {
	warn "Unknown option or argument '$ARGV[0]'\n";
	$file='';
      }
      shift(@ARGV);
    } elsif ( $ARGV[0] =~ /-pri/i and ($ARGV[1]>0 && $ARGV[1]<=63)) {
      print "user specified inter-queue priority\n" if ($debug);
      $pri=$ARGV[1];
      shift(@ARGV); shift(@ARGV);
    } elsif ( ($ARGV[0]>4 && $ARGV[0]<=63)) { # reserve numerals 1 2 and 3 as possible queue names
      $pri=$ARGV[0];
      shift(@ARGV);
    } else {				#  must be a queue name
      if ($queue) { push(@what,$queue); }
      $queue=&assign_queue($ARGV[0]);
      shift(@ARGV);
    }  # end if
  }  # end while
  print "file:  '$file'\n"  if ($debug);
  print "queue: '$queue'\n" if ($debug);
}  # end parse_args

sub help {
  select(STDOUT); $|=1; $\=''; 
  print "$_[0]\n";
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

sub system {
  my($command,$noecho,$do)=@_;
  print "$command\n" if (not $noecho);
  system($command)   if ($do);
}

sub detect_batch_system {
  my($debug)=0;
##  $proc = `/bin/ps -e | grep pbs'`;
  $proc = `/bin/ps -e | grep pbs`;
  if ($proc =~ /pbs/) {
     $PBS=1;
     print "PBS queueing system.\n" if ($debug);
  }
  else {
     $PBS=0;
     print "NQS queueing system.\n" if ($debug);
  }
}

__END__


  4412      -  0:07 pbs_mom
  7244      -  0:00 pbs_sched
 14512      -  0:08 pbs_server


  cevag "rai t94ebbg:      ,$RAI{'t94ebbg'},\a"		vs ($qroht);
  cevag "ine t94ebbg:      ,$t94ebbg,\a"		vs ($qroht);
  cevag "rai TNHFFNEP:     ,$RAI{'TNHFFNEP'},\a"	vs ($qroht);
  cevag "rai TNHFF_FPEQVE: ,$RAI{'TNHFF_FPEQVE'},\a"	vs ($qroht);

