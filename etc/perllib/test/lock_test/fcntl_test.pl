#!/usr/local/bin/p5
#
# A perl-5 script to SCRIPT_DESCRIPTION
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

$max_attempts=1;
$time_between_attempts=5;
$log=1;

$file_to_be_locked='/tmp/lock';

open(FH,"+>>$file_to_be_locked")
  || die "can't open '$file_to_be_locked' to write.";

if ($log) {
  $logfile=$ARGV[0] || "log.$$";
  open(LOG,">>$logfile") || die("$name: Cannot write to '$logfile': $!\n");
}

$not_written=$attempts=1;
while ($not_written and $attempts<=$max_attempts) {
  print "\nAttempt $attempts\n";
  if ( $lock_result=&lock_file(FH,$lock_info={}) ) {
    $date=localtime;
    printf FH "%s (%5d) after %2d attempts lock result was '%s',\n%s obtained lock: %s\n",
              $name, $$, $attempts, $lock_result, " " x length($name), $date;
    sleep 2;
    $date=localtime;
    printf FH "%s released lock: %s\n",
              " " x length($name), $date;
    $not_written=0;
  } else {
    sleep $time_between_attempts;
    $attempts++;
  }
}

if ($not_written) {
  $date=localtime;
  if ($log) {
    print LOG "File lock not obtained after $max_attempts.\n";
    print LOG "Last attempt gave a lock result of '$lock_result'\n";
    if ( ! ( $lock_result=&query_lock(FH,$lock_info={},1) )  ) {
      print LOG "Lock on file '$file_to_be_locked' appearently owned by\n";
      print LOG "process ($lock_info->{l_pid}) on system ($lock_info->{l_sysid})\n";
    } else {
      print LOG "strange... query_lock reports lock is obtainable,\n";
      print LOG "since query_lock routine returned '$lock_result'.\n";
    }
    print LOG "$date\n";
    close(LOG);
  } else {
    print "$name ($$): file lock not obtained after $max_attempts.\n";
  }
} else {
  $date=localtime;
  if ($log) {
    print LOG "$name ($$) got a lock at $date, after $attempts attempts.\n";
    close(LOG);
  }
}
close(FH);
&unlock_file(FH, $lock_info={});
exit 0;

sub unlock_file {
  my($filehandle_to_be_unlocked,$lock_info)= @_;
  my($ref,$retval,$fcntl_t);

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::unlock_file lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  use Fcntl;
  $fcntl_t="ssllllllll";

  # remove lock (F_UNLCK)
  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      (($lock_info->{'l_type'}   or $lock_info->{'l_type'}=F_UNLCK),
       ($lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0),
       ($lock_info->{'l_start'}  or $lock_info->{'l_start'}=0),
       ($lock_info->{'l_len'}    or $lock_info->{'l_len'}=0),
       ($lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0),
       ($lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0),
       ($lock_info->{'pad'}      or $lock_info->{'pad'}=(0,0,0,0))
      )
    );
print STDERR "fcntl::unlock_file lock_info->l_type is '$lock_info->{'l_type'}'\n";

  ($retval=fcntl($filehandle_to_be_unlocked, F_SETLK, $packed_ret_buff))
    || ($retval=-1);
  if ( $retval == -1 ) { # did release the lock
    if (wantarray) {
      return (0,$retval);
    } else {
      return 0;
    }
  } else { # released the lock
    if (wantarray) {
      return (1,$retval);
    } else {
      return $retval; # could be the string '0 but true' which is ok since
		      # perl will inturp this as TRUE in an if.
    }
  }
}

sub lock_file {
  my($filehandle_to_be_locked,$lock_info) = @_;
  my($ref,$retval,$fcntl_t,$packed_ret_buffer);

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::lock_file lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  use Fcntl;
  $fcntl_t="ssllllllll";

  # read (F_RDLCK) write (F_WRLCK) locks,
  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      (($lock_info->{'l_type'}   or $lock_info->{'l_type'}=F_WRLCK),
       ($lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0),
       ($lock_info->{'l_start'}  or $lock_info->{'l_start'}=0),
       ($lock_info->{'l_len'}    or $lock_info->{'l_len'}=0),
       ($lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0),
       ($lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0),
       ($lock_info->{'pad'}      or $lock_info->{'pad'}=(0,0,0,0))
      )
    );

# unpack and print to DEBUG
      ( $lock_info->{'l_type'},
        $lock_info->{'l_whence'},
        $lock_info->{'l_start'},
        $lock_info->{'l_len'},
        $lock_info->{'l_sysid'},
        $lock_info->{'l_pid'},
        $lock_info->{'pad'} ) = unpack($fcntl_t, $packed_ret_buff);
  if (my($print)=1) {
    print "lock_file on '$filehandle_to_be_locked':\n";
    print "fcntl($filehandle_to_be_locked, F_SETLK, $packed_ret_buff)\n";
    print "type:  	'$lock_info->{'l_type'}'\n";
    print "whence:	'$lock_info->{'l_whence'}'\n";
    print "start: 	'$lock_info->{'l_start'}'\n";
    print "len:   	'$lock_info->{'l_len'}'\n";
    print "sysid: 	'$lock_info->{'l_sysid'}'\n";
    print "pid:   	'$lock_info->{'l_pid'}'\n";
  }
# unpack and print to DEBUG

  ($retval=fcntl($filehandle_to_be_locked, F_SETLK, $packed_ret_buff))
    || ($retval=-1);
  if ( $retval == -1 ) { # didn't get the lock
    if (wantarray) {
      return (0,$retval);
    } else {
      return 0;
    }
  } else { # got the lock
    if (wantarray) {
      return (1,$retval);
    } else {
      return $retval; # could be the string '0 but true' which is ok since
		      # perl will inturp this as TRUE in an if.
    }
  }
}

sub query_lock {
  my($filehandle_to_be_locked,$lock_info,$print)= @_;
  my($ref,$retval,$fcntl_t);

  use Fcntl;
  $fcntl_t="ssllllllll";

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::query_lock lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      (($lock_info->{'l_type'}   or $lock_info->{'l_type'}=F_WRLCK),
       ($lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0),
       ($lock_info->{'l_start'}  or $lock_info->{'l_start'}=0),
       ($lock_info->{'l_len'}    or $lock_info->{'l_len'}=0),
       ($lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0),
       ($lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0),
       ($lock_info->{'pad'}      or $lock_info->{'pad'}=(0,0,0,0)),
      )
    );
print STDERR "fcntl::query_lock lock_info->l_type is '$lock_info->{'l_type'}'\n";
  if ($print) {
    print "query_lock on '$filehandle_to_be_locked' (before fcntl):\n";
    print "type:  	'$lock_info->{'l_type'}'\n";
    print "whence:	'$lock_info->{'l_whence'}'\n";
    print "start: 	'$lock_info->{'l_start'}'\n";
    print "len:   	'$lock_info->{'l_len'}'\n";
    print "sysid: 	'$lock_info->{'l_sysid'}'\n";
    print "pid:   	'$lock_info->{'l_pid'}'\n";
  }

  ($retval=fcntl($filehandle_to_be_locked, F_GETLK, $packed_ret_buff))
    || ($retval=-1);
      ( $lock_info->{'l_type'},
        $lock_info->{'l_whence'},
        $lock_info->{'l_start'},
        $lock_info->{'l_len'},
        $lock_info->{'l_sysid'},
        $lock_info->{'l_pid'},
        $lock_info->{'pad'} ) = unpack($fcntl_t, $packed_ret_buff);

  if ($print) {
    print "query_lock on '$filehandle_to_be_locked' (after fcntl):\n";
    print "type:  	'$lock_info->{'l_type'}'\n";
    print "whence:	'$lock_info->{'l_whence'}'\n";
    print "start: 	'$lock_info->{'l_start'}'\n";
    print "len:   	'$lock_info->{'l_len'}'\n";
    print "sysid: 	'$lock_info->{'l_sysid'}'\n";
    print "pid:   	'$lock_info->{'l_pid'}'\n";
  }

  if ( $retval == -1 ) { # wouldn't be granted the lock
    if (wantarray) {
      return (0,$retval);
    } else {
      return 0;
    }
  } else { # would be granted the lock
    if (wantarray) {
      return (1,$retval);
    } else {
      return $retval; # could be the string '0 but true' which is ok since
		      # perl will inturp this as TRUE in an if.
    }
  }
}

exit 0;

__END__
