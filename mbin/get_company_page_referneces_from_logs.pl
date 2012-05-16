#!/usr/bin/env perl

if ( $ARGV[0] =! /-h(our)?|-t(ime)?/i and $ARGV[1] ) {
  if ($ARGV[1] =~ /^(201[0-9])?([ 01][0-9]|[[:alpah:]]{3,9})?([ 0-3][0-9]|today)?([0-6][0-9])$/) {

    $year  = $1 || $thisyear;

    ($sec,$thismin,$thishour,$mday,$thismon,$thisyear,$wday,$yday,$isdst)=localtime(time);
    @mo = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    @mo_full = qw(January February March April May June July August September October November December);
    # following line will load $mo_byname hash key by abbreviations (and full month names if defined).
    foreach $mo (0 .. $#mo) {
	  $mo_byname{ $mo[$mo] }=$mo;
	  $mo_byname{ lc $mo[$mo] }=$mo;
	  if (@mo_full) {
	    $mo_byname{ $mo_full[$mo] }=$mo;
	    $mo_byname{ lc $mo_full[$mo] }=$mo;
	  }
	}

	if ($2 and $2=~/[ 01][0-9]/) {
      $month = $2 - 1;
	} elsif ($2 and 


    $day   = $3;
    $hour  = $4;
  }
}

@production_servers = (
	'ecnext55.ecnext.com',
	'ecnext56.ecnext.com',
	'ecnext57.ecnext.com',
	'ecnext58.ecnext.com',
	'ecnext59.ecnext.com',
	'ecnext98.ecnext.com',
);


# Create a user agent object
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

$filename = "company_links";
open(FH,">$filename")
  || die("Can not write to '$filename': $!\n");

$start=time;
foreach $server (@production_servers) {
	my $r={};
	$uri="http://$server:8888/logs/manta_cp_main_access";

	# Create a request
	my $req = HTTP::Request->new(GET => $uri);
	$req->content_type('application/x-www-form-urlencoded');
	# $req->content('query=libwww-perl&mode=dist');

	print STDERR "reaping logs from $server.\n";

	# Pass request to the user agent and get a response back
	my $res = $ua->request($req);

	# Check the outcome of the response
	if ($res->is_success) {
		$content = $res->content;
		$lines = ($content =~ tr/\n/\n/);
		$bytes = length $content;
		# note: internation companies will be /ic/...
		map { m,"GET (/c/m[a-z0-9]{6}/[^&?/;=]+) HTTP/1\.0" 200 ,; $r->{$1}++ if ($1); } split('\n',$content);
		$total += ( $server_count->{$server} = scalar(keys %$r) );
		print FH for keys %$r;
		printf STDERR "%s=>\t%d unique US companies found: (%d lines, %d bytes)\n", $uri, $server_count->{$server}, $lines, $bytes;
	} else {
		print $res->status_line . "\n";
	}
}
$end=time;

$duration=$end-$start;
$min=int($duration/60); $sec=$duration%60;

printf STDERR "Finished reaping logs from %d servers in %2d:%02d for a total of %d US company page links.\n" , scalar(@production_servers), $min, $sec, $total;

close(FH);
