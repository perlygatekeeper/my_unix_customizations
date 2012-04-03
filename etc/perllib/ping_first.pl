#   ***   Ping a computer before taking an action   ***
sub ping_first {

  my($debug)=0;
  my($host,$timeout)=@_;
  my($negative_response)='no answer from';
  foreach $command ( '/usr/etc/ping', '/usr/sbin/ping', '/etc/ping',
                     '/usr/bin/ping', '') {
    last if (-f $command);
  }
  if (! $command) { $command = `which ping`; }
  if (! $timeout) { $timeout = 1; }

  print "$command $host $timeout\n" if ($debug);
  my($response)=`$command $host $timeout`;
  if ( ( $? ) || ( $response =~ /$negative_response/i ) ) {
    $answered=0;
  } else {
    $answered=1;
  }
  if ($debug) {
    print STDERR "From subroutine 'ping_first' for '$host'\n" if ($debug);
    print STDERR "  \$? '$?'     \$response '$response'\n"    if ($debug);
  }
  return $answered;
}  # end ping_first
