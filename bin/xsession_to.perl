#!/usr/bin/perl
#
# Will create an xsession on HOSTNAME displaying on
# the most recent setting of DISPLAY, typically
# through a tunnel set up via ssh to chemistry.
# We assume that HOSTNAME doesn't share chemistry's
# /home/.Xauthority.
#
# Requirements:
# - need .rhosts access to destination HOSTNAME
# - need /usr/local/bin/exec_xsession on HOSTNAME
#   that contains everything to start xsession; this
#   script will need to use the file $HOME/.latest_display
#   to set the display appropriately
# - need the following in $HOME/.login.personal:  
# ---------------------------------------------------
#    # Record the latest $DISPLAY setting, to be
#    # used in $ugb/xterm_to and xsession_to scripts.
#    if ($?DISPLAY) then
#      echo $DISPLAY >! ~/.latest_display
#    endif
# ---------------------------------------------------
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name HOSTNAME [REMOTE_USERNAME]";

$remote_host=	 "$ARGV[0]"; shift;
$remote_username="$ARGV[0]";    # this will be null string if only 1 argument
$remote_username=s/(.)/-l \1/;  # change first char, x, to '-l x'; only works if there IS a first char
# $DISPLAY=`cat $ENV{HOME}/.latest_display`; # not needed; display determined on remote host
$remote_command="/usr/local/bin/exec_xsession";

system "rcp $remote_user $ENV{HOME}/.Xauthority	${remote_host}:";
system "rcp $remote_user $ENV{HOME}/.latest_display	${remote_host}:";
system "rsh $remote_user $remote_host $remote_command";

exit 0;

__END__
