#!/usr/bin/env perl -w

#------------------------------------------------------------#
# Scrape images.google.com for images matching a specific    #
# keyword.                                                   #
#------------------------------------------------------------#
# ./imgo.pl --query "perl monks"                             #
#------------------------------------------------------------#
use HTML::Parser;
use LWP::UserAgent;
use Parallel::ForkManager;
use Getopt::Long;
use URI::Escape;
use strict;

#------------------------------------------------------------#
# Options and other variables we'll need.                    #
#------------------------------------------------------------#

# Defaults
my %opt = (
   dir   => ".",
   safe  => "0",
   procs => "5",
   ua    => "Mozilla/5.0",
   query => "",
);

# Options from the commandline.
GetOptions( 
   'verbose' => \$opt{'verbose'},
   'help'    => \$opt{'help'   },
   'safe'    => \$opt{'safe'   },
   'query=s' => \$opt{'query'  },
   'procs=i' => \$opt{'procs'  },
   'ua=s'    => \$opt{'ua'     },
   'dir=s'   => \$opt{'dir'    },
);

# Compose our base URL for images.google.com.
$opt{'query'} = uri_escape($opt{'query'});

my $url = "http://images.google.com/images" . 
   "?q=$opt{'query'}" .
   "\&safe=" . ($opt{'safe'} ? "on" : "off");
$url .= "&tbs=itp:lineart";
$opt{'verbose'} && print "URL sought is '" . $url. "'\n";

# Initial image offset (Page 1 of results)
my $start = "0";

# Validate input and display help if needed.
&help if ($opt{'help'} || !$opt{'query'});

#------------------------------------------------------------#
# Create objects we'll need.                                 #
#------------------------------------------------------------#

# LWP for HTTP requests.
my $ua = new LWP::UserAgent;
$ua->agent($opt{'ua'}); # Google doesn't like LWP.
 
# HTML::Parser for scraping HTML.
my $p = new HTML::Parser (
   api_version => 3,
   start_h     => [\&tag, "tagname, attr"],
);

# Parallel::ForkManager to handle simultaneous downloads.
my $pfm = new Parallel::ForkManager($opt{'procs'});

#------------------------------------------------------------#
# Parse each page of HTML for images.  Stored in @images.    #
#------------------------------------------------------------#
# $start will be passed to google to tell it which page of   #
# results to display.  20 images per page.                   #
#------------------------------------------------------------#
# $test is used to see if we need another page.              #
#------------------------------------------------------------#
my @images;
my $done = 0;
my $page = 1;
until ($done) {
   $opt{'verbose'} && print "Fetching page " . $page++ . " of results.\n";
   my $test = $start;
   my $req = HTTP::Request->new(GET => $url . "\&start=$start");
   $p->parse($ua->request($req)->content);
   $start += 20 if ($start<=200);
   $done = 1 if ($test == $start);
}

#------------------------------------------------------------#
# Fetch all images stored in @images.                        #
#------------------------------------------------------------#
foreach my $img (@images) {

   # Fork a child to execute code in this loop.
   $pfm->start and next;

   # Get our image URL, refering URL and a unique filename.
   my ($imgurl, $filename, $refurl) = @$img;
   $filename = unique($filename);

   $opt{'verbose'} && print "Fetching $imgurl as $filename\n";

   # Download the image and save it to disk.
   my $req = HTTP::Request->new(GET => "$imgurl");
   $req->referer($refurl);
   $ua->request($req, "$opt{'dir'}/$filename");

   # Indicate this child process is finished.
   $pfm->finish;
}

#------------------------------------------------------------#
# Wait for all children to finish and exit cleanly.          #
#------------------------------------------------------------#
$pfm->wait_all_children;
exit 0;

#------------------------------------------------------------#
# tag() is our HTML::Parser callback for handling start tags #
#------------------------------------------------------------#
sub tag {
   my ($tagname, $attr) = (@_);

   #
   # If we see the "nav_next.gif" image, we know we should go
   # to the next page to collect more images.  $start is our
   # offset for the next page.
   #
   if ($attr->{'src'} && ($attr->{'src'} eq "/nav_next.gif" )) {
      print "BAM! found nav_next.gif, so there will be another page.\n";
      $start += 20;
   }

   #
   # Look for links to "imgres".  This will show our image URL
   # and the page it's used on.  We'll use the latter to spoof
   # our refering URL in case the host doesn't allow offsite
   # image linking (tripod, etc.).
   #
   return unless ($tagname eq 'a');
   return unless (
      $attr->{'href'} =~ /imgres\?imgurl=(.*\/([^\&]*))\&imgrefurl=([^
+\&]*)\&/
   );

   #
   # We've got a real image, so we'll remember it for downloading.
   #
   push(@images, [ $1, $2, $3 ]); # imgurl, filename, refurl

}

#------------------------------------------------------------#
# unique() ensures we're not overwriting existing files by   #
# returning an unused filename based on the one provided.    #
#------------------------------------------------------------#
sub unique {
   my $f = shift;
   return $f unless -e "$opt{'dir'}/$f";

   my $count = 1;
   while (-e "$opt{'dir'}/$count.$f") {
      $count++;
   }

   return "$count.$f";
}

#------------------------------------------------------------#
# help() displays usage information.                         #
#------------------------------------------------------------#
sub help {

print <<ENDHELP

$0 scrapes images.google.com for images matching the keyword
specified on the commandline.  Images are downloaded and placed
in the current directory by default.

Usage:   $0 --query "image keyword(s)" [OPTIONS]

Options:

   --query string  Search string for images.
                   Required.  No default.

   --verbose       Show what the script is doing as it goes.
                   Defaults to off.
                
   --safe          Use google's safesearch to filter naughty pictures.
                   Defaults to off.

   --procs n       Number of simultaneous image downloads to run.
                   Defaults to 20.

   --dir path      Directory to store downloaded images to.
                   Defaults to "." (current directory)

   --ua string     images.google.com doesn't like robots.  This is
                   the user-agent string we spoof.
                   Defaults to "Mozilla/1.0"

   --help          You're looking at it, cowboy.

Notes:

   Images are given unique filenames by prepending a number.  For
   example, "10.header.jpg"

   Usage may violate Google's TOS.  Use at your own risk.

ENDHELP

}
