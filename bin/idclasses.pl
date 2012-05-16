#!/usr/bin/perl
# A perl script to extract classes and id's from an html file.
$name = ; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

use warnings;
use strict;

while (<>) {
	#      1           2                3      4                  5                6        7
	if ( /<(\S+)\s[^<]+(id|class)\s*=\s*(['"])?([^'"]+)\3?(?:[^<]+(id|class)\s*=\s*(['"]?))?([^'"]+)\3?)?/ ) {
		$tag=$1;
		if      ( $2 =~ /id/i )  {
		  $ids->{$2} = $tag;
		} elsif ( $2 =~ /class/i )  {
		  $classes->{$2}{$tag}++;
		}
	}
}


exit 0;
__END__
snippet	snips
	app				author		AUTO	blank		byteflip	chars
	chgrp			chmod		chown	cl			cmdfrom		cmdto
	copyright		copy		crypt	data		date		day
	days			dir			dowhile	dowhl		dowhn		dowh
	ds				end			eval	fifo		filo		fora
	fore			fork		for		forwhen		fulldays	fullmonths
	givenwhen		help		ifee	ife			if			lastmod
	last			link		ln		localtime	mkdir		months
	move			name		newline	next		onebits		onoff
	passwd			perls		pipe	printuntil	protect		randarray
	randindex		randrand	rand	read		response	revdays
	revmonths		rot13		rw		select		skipuntil	smhd
	#!				sortalpha	sortnum	sortralpha	sortrnum	spliceexplain
	splice			split		stack	stat		strict		sub
	substrexplain	substr		sym		system		template	todo
	unlee			unle		unl		unt			usage		version
	wantarray		wh			write	xfore		xfor		xif
	xunl			xunt		xwh			
