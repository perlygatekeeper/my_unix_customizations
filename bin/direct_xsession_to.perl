#!/usr/bin/perl
#
# Will create an xsession on HOSTNAME displaying on
# the host from which the user is logged on. If the connection
# to chemistry was created via ssh, this will bypass the
# ssh X11 forwarding tunnel and direct X from HOSTNAME right back 
# to your (home) computer.
#
# Requirements:
# - need .rhosts access to destination HOSTNAME
# - need /usr/local/bin/exec_xsession on HOSTNAME
#   that contains everything to start xsession; this
#   script will need to use the file $HOME/.latest_display
#   to set the display appropriately
# - need the following in $HOME/.login.personal:  
# ---------------------------------------------------
#    # Record the latest REMOTEHOST setting, to be
#    # used in the $ugb/direct_xsession_to script.
#    if ($?REMOTEHOST) then
#      echo "${REMOTEHOST}:0" >! ~/.remote_display
#    endif
# ---------------------------------------------------
# - X client startup needs to invoke this script via rexec, 
#   not telnet; otherwise REMOTEHOST would be overwritten
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name HOSTNAME [REMOTE_USERNAME]";

$remote_host=	 "$ARGV[0]"; shift;
$remote_username="$ARGV[0]";	# this will be null string if only 1 argument
$remote_username=s/(.)/-l \1/;	# change first char, x, to '-l x'; only works if there IS a first char
# $DISPLAY=`cat $ENV{HOME}/.latest_display`; # not needed; display determined on remote host
$remote_command="/usr/local/bin/exec_xsession";

# system "rcp $remote_user $ENV{HOME}/.Xauthority	${remote_host}:"; # not needed for direct
system "rcp $remote_user $ENV{HOME}/.remote_display	${remote_host}:";
system "rsh $remote_user $remote_host $remote_command";

exit 0;

__END__
