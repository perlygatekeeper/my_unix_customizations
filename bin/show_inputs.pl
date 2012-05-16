#!/usr/bin/perl

# show all <input> tags in an HTML source

$/=''; #enable paragraph mode
$\="\n"; #enable paragraph mode
while(<>) {
  @inputs = ( $_ =~	m,(<input[^>]+>), );
  @inputs = grep (( ($_ =~ /type\s*=\s*['"]?text["']? /) and not ($_ =~ /maxlength/) ),@inputs);
  print @inputs if (@inputs);
}
print;
