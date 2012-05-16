#!/usr/bin/perl
#
# Will create an xterm on HOSTNAME displaying on
# the most recent setting of DISPLAY, typically
# through a tunnel set up via ssh to chemistry.
# We assume that HOSTNAME doesn't share chemistry's
# /home/.Xauthority.
#
# Requirements:
# - need .rhosts access to destination HOSTNAME
# - need the following in $HOME/.login.personal:
# ---------------------------------------------------
#    # Record the latest $DISPLAY setting, to be
#    # used in $ugb/xterm_to and xsession_to scripts.
#    if ($?DISPLAY) then
#      echo $DISPLAY >! ~/.latest_display
#    endif
# ---------------------------------------------------
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name HOSTNAME [REMOTE_USERNAME]";

$remote_host=	 "$ARGV[0]"; shift;
$remote_username="$ARGV[0]";    # this will be null string if only 1 argument
$remote_username=s/(.)/-l \1/;  # change first char, x, to '-l x'; only works if there IS a first char
$DISPLAY=`cat $ENV{HOME}/.latest_display`;
system "rcp $ENV{HOME}/.Xauthority ${remote_host}:";
if ( $remote_host =~ /^spec|^tamic|^hires/i ) {
  $remote_command="/usr/X11R6/bin/nxterm";
} else {
  $remote_command="xterm";
}

system("rsh $remote_host $remote_user $remote_command -ls -display $DISPLAY");

exit 0;

__END__
