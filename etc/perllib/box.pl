#!/usr/local/bin/curseperl

$VERT = unpack('c', '|');	# or 0 if supported
$HORZ = unpack('c', '-');	# ditto

sub BOX {
  local($win)=@_;
  $win=&newwin(10,10,2,2) if (!$win);
  &box($win,$VERT,$HORZ);
  &wrefresh($win);

  $win;				# this returns $win as the value
}

&initscr();
$newwin = &BOX(0);		# create a new window
&wmove($newwin, 3, 3);
&waddstr($newwin, "hi");	# add some text
&wrefresh($newwin);
#&endwin();
