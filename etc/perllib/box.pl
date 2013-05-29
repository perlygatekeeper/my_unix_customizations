#!/usr/bin/curseperl

my $vert = unpack('c', '|');	# or 0 if supported
my $horz = unpack('c', '-');	# ditto

sub box {
  my($win) = @_;
  $win=&newwin(10,10,2,2) if (!$win);
  box($win,$vert,$horz);
  wrefresh($win);

  $win;				# this returns $win as the value
}

initscr();
my $newwin = &box(0);		# create a new window
wmove($newwin, 3, 3);
waddstr($newwin, "hi");	# add some text
wrefresh($newwin);
#&endwin();
