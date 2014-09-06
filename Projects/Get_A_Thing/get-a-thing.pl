#!/usr/bin/env perl -w

#-----------------------------------------------------------------#
# Given a thing by number get all interest stuff trom thingiverse # 
#-----------------------------------------------------------------#

use HTML::Parser;
use LWP::UserAgent;
use Getopt::Long;
use URI::Escape;
use strict;

#------------------------------------------------------------#
# Options and other variables we'll need.                    #
#------------------------------------------------------------#

# Defaults
my %opt = (
   dir   => ".",
   thing => "398548",
   ua    => "Mozilla/1.0",
   query => "",
);

# Options from the commandline.
GetOptions( 
   'verbose' => \$opt{'verbose'},
   'help'    => \$opt{'help'   },
   'thing=i' => \$opt{'thing'  },
   'ua=s'    => \$opt{'ua'     },   # user agent
   'dir=s'   => \$opt{'dir'    },
);
my @images;

# Compose our base URL for images.google.com.
$opt{'query'} = uri_escape($opt{'query'});

my $url = "http://www.thingiverse.com/thing:$opt{'thing'}";

# Validate input and display help if needed.
&help if ($opt{'help'} || !$opt{'thing'});

#------------------------------------------------------------#
# Create objects we'll need.                                 #
#------------------------------------------------------------#

# LWP for HTTP requests.
my $ua = new LWP::UserAgent;
$ua->agent($opt{'ua'});
 
# HTML::Parser for scraping HTML.
my $p = new HTML::Parser (
   api_version => 3,
   # start_h     => [\&tag, "tagname, attr"],
);


# Retrieve thing's main page (Thing Info)

$opt{'verbose'} && print "Fetching pages for thing # $opt{'thing'}.\n";
my $req = HTTP::Request->new(GET => $url );
$p->parse($ua->request($req)->content);







exit 0;

#------------------------------------------------------------#
# tag() is our HTML::Parser callback for handling start tags #
#------------------------------------------------------------#
sub tag {
   my ($tagname, $attr) = (@_);
   my ($start);

   #
   # If we see the "nav_next.gif" image, we know we should go
   # to the next page to collect more images.  $start is our
   # offset for the next page.
   #
   if ($attr->{'src'} && ($attr->{'src'} eq "/nav_next.gif" )) {
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

$0 downloads one or more things from thingiverse.com, whose numbers are
specified on the commandline. 

Usage:   $0 --thing THING# [OPTIONS]

Options:

   --thing ######  Download thing whose number is given.
                   Required.  No default.

   --verbose       Show what the script is doing as it goes.
                   Defaults to off.
                
   --dir path      Directory to store downloaded thing to.
                   Defaults to "." (current directory)

   --ua string     This is the user-agent string we spoof.
                   Defaults to "Mozilla/1.0"

   --help          You're looking at it, cowboy.

Notes:

      Use at your own risk.

ENDHELP

}
