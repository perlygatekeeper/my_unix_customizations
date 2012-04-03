#!/usr/local/bin/perl
#
# A perl script to convert output of 'arp -a' command into /etc/ethers
# format, and to add 0's to the one digit components of the ethernet address.
#
while (<>) {
  $name='';
  ($name,$ether)=/^([^. ]+).*at (\S*)/;  
  if ($name) {
    $ether=~s/\b([0-9a-f])\b/0\1/g; # convert single hex digit inbetween word
				    # boundrary to '0' + that digit.
    print "$ether\t$name\n";
  } else {
    chop;
    print STDERR "rejected line '$_'\n";
  }
}
