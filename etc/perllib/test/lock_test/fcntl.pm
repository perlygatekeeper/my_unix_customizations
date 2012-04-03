package fcntl;

=head1 NAME

fcntl - lock_file, unlock_file, and query_lock routines

=head1 SYNOPSIS

  use fcntl;
  $lock_info->{'l_type'}=F_UNLCK;
  $lock_info->{'l_whence'}=0;
  $lock_info->{'l_start'}=0;
  $lock_info->{'l_len'}=0;
  $lock_info->{'l_sysid'}=0;
  $lock_info->{'l_pid'}=0;
  $lock_info->{pad}=(0,0,0,0);
   or 
  $lock_info={}; # pointer to empty hash
  $unlock_result = &unlock_file($filehandle_to_be_unlocked,$lock_info);

  use fcntl;
  $lock_info->{'l_type'}=F_WRLCK or F_RDLCK;
  $lock_info->{'l_whence'}=0;
  $lock_info->{'l_start'}=0;
  $lock_info->{'l_len'}=0;
  $lock_info->{'l_sysid'}=0;
  $lock_info->{'l_pid'}=0;
  $lock_info->{pad}=(0,0,0,0);
   or 
  $lock_info={}; # pointer to empty hash
  $lock_result   = &lock_file($filehandle_to_be_unlocked,$lock_info);

  use fcntl;
  $lock_info->{'l_type'}=F_WRLCK or F_RDLCK;
  $lock_info->{'l_whence'}=0;
  $lock_info->{'l_start'}=0;
  $lock_info->{'l_len'}=0;
  $lock_info->{'l_sysid'}=0;
  $lock_info->{'l_pid'}=0;
  $lock_info->{pad}=(0,0,0,0);
   or 
  $lock_info={}; # pointer to empty hash
  $query_result=&query_lock($filehandle_to_be_locked,$lock_info,$print_flag);

=head1 DESCRIPTION

These routines impliment SYS V fcntl type file locking.

From perlfunc:fcntl and perlfunc:ioctl

  The return value of ioctl (and fcntl) is as follows:
       if OS returns:          then Perl returns:
           -1                    undefined value
            0                  string "0 but true"
       anything else               that number

lock_file, unlock_file and query_lock all return either success_of_attempt
in scalar context, or (success_of_attempt, return_value_from_fcntl_call) in
array context.

query_lock will, on failure, replace members of $lock_info with information on
pid and system of the process blocking the lock described.  query_lock will
print to stdout it's findings if $print_flag is true.

See perlfunc:fcntl, Fcntl(3), fcntl(2) and fcntl(5) for more info.

=cut

# This package implements handy routines for modules that wish to throw
# exceptions outside of the current package.

$CarpLevel = 0;		# How many extra package levels to skip on carp.

require Exporter;
@ISA = Exporter;
@EXPORT = qw(unlock_file lock_file query_lock);

sub unlock_file {
  my($filehandle_to_be_unlocked,$lock_info)= @_;
  my($ref,$retval,$fcntl_t,$packed_ret_buffer);

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::unlock_file lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  use Fcntl;
  $fcntl_t="sslllll";

  # remove lock (F_UNLCK)
  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      ( $lock_info->{'l_type'}   or $lock_info->{'l_type'}=F_UNLCK,
        $lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0,
        $lock_info->{'l_start'}  or $lock_info->{'l_start'}=0,
        $lock_info->{'l_len'}    or $lock_info->{'l_len'}=0,
        $lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0,
        $lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0,
        $lock_info->{pad}      or $lock_info->{pad}=(0,0,0,0)
      )
    );
print STDERR "fcntl::unlock_file lock_info->l_type is '$lock_info->{'l_type'}'\n";

  ($retval=fcntl($filehandle_to_be_unlocked, F_SETLK, $packed_ret_buff))
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

sub lock_file {
  my($filehandle_to_be_locked,$lock_info) = @_;
  my($ref,$retval,$fcntl_t,$packed_ret_buffer);

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::lock_file lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  use Fcntl;
  $fcntl_t="sslllll";

  # read (F_RDLCK) write (F_WRLCK) locks,
  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      ( $lock_info->{'l_type'}   || ($lock_info->{'l_type'}=F_WRLCK),
        $lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0,
        $lock_info->{'l_start'}  or $lock_info->{'l_start'}=0,
        $lock_info->{'l_len'}    or $lock_info->{'l_len'}=0,
        $lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0,
        $lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0,
        $lock_info->{pad}      or $lock_info->{pad}=(0,0,0,0)
      )
    );
print STDERR "fcntl::lock_file lock_info->l_type is '$lock_info->{'l_type'}'\n";
$packed_ret_buff=pack($fcntl_t,2,0,0,0,0,0);
print join ("\n", unpack($fcntl_t, $packed_ret_buff) );
@array=
      ( $lock_info->{'l_type'}   || ($lock_info->{'l_type'}=F_WRLCK),
        $lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0,
        $lock_info->{'l_start'}  or $lock_info->{'l_start'}=0,
        $lock_info->{'l_len'}    or $lock_info->{'l_len'}=0,
        $lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0,
        $lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0,
        $lock_info->{pad}      or $lock_info->{pad}=(0,0,0,0)
      );
print "\n_";
print join ("\n> ", @array );
print "\n~\n";
      ( $lock_info->{'l_type'},
        $lock_info->{'l_whence'},
        $lock_info->{'l_start'},
        $lock_info->{'l_len'},
        $lock_info->{'l_sysid'},
        $lock_info->{'l_pid'},
        $lock_info->{pad} ) = unpack($fcntl_t, $packed_ret_buff);

  if (my($print)=1) {
    print "lock_file on '$filehandle_to_be_locked':\n";
    print "type:  	'$lock_info->{'l_type'}'\n";
    print "whence:	'$lock_info->{'l_whence'}'\n";
    print "start: 	'$lock_info->{'l_start'}'\n";
    print "len:   	'$lock_info->{'l_len'}'\n";
    print "sysid: 	'$lock_info->{'l_sysid'}'\n";
    print "pid:   	'$lock_info->{'l_pid'}'\n";
  }

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
  my($ref,$retval,$fcntl_t,$packed_ret_buffer);

  use Fcntl;
  $fcntl_t="ssllllllll";

  if (($ref=ref($lock_info)) ne "HASH" ) {
    print STDERR "fcntl::query_lock lock_info is not a hash it's a '$ref'\n";
    return 0;
  }

  # assume write or exclusive lock on whole file if not specified
  $packed_ret_buff
    =pack($fcntl_t,
      ( $lock_info->{'l_type'}   or $lock_info->{'l_type'}=F_WRLCK,
        $lock_info->{'l_whence'} or $lock_info->{'l_whence'}=0,
        $lock_info->{'l_start'}  or $lock_info->{'l_start'}=0,
        $lock_info->{'l_len'}    or $lock_info->{'l_len'}=0,
        $lock_info->{'l_sysid'}  or $lock_info->{'l_sysid'}=0,
        $lock_info->{'l_pid'}    or $lock_info->{'l_pid'}=0,
        $lock_info->{pad}      or $lock_info->{pad}=(0,0,0,0)
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
        $lock_info->{pad} ) = unpack($fcntl_t, $packed_ret_buff);

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
