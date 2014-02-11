#!/usr/bin/env perl
#
# A perl script to check hash elements in various ways,
# demonstrating the differences.
#
$name = $0; $name =~ s'.*/''; # remove path--like basename
$usage = "usage:\n$name [-opt1] [-opt2] [-opt3]";

$hash{'number'}=2;
$hash{'string'}='a string';
$hash{'zero'}=0;
$hash{'null_string'}='';
$hash{'undef'}=undef;

check(\%hash,'number');
check(\%hash,'string');
check(\%hash,'zero');
check(\%hash,'null_string');
check(\%hash,'undef');
check(\%hash,'not_a_key');

print "now I am going to undef  the key 'string'...\n\n"; undef  $hash{'string'};
check(\%hash,'string');


print "now I am going to delete the key 'number'...\n\n"; delete $hash{'number'};
check(\%hash,'number');

sub check{
		my ($hash_ref,$key_to_check) = @_;
		print "key is: '$key_to_check'\nhash value is: '$hash_ref->{$key_to_check}'\n";
		print "Checks on \$hash_ref{\$key_to_check}\n";
		if ( exists  $hash_ref->{$key_to_check}) { print "exists.\n"; }
		if ( defined $hash_ref->{$key_to_check}) { print "defined.\n"; }
		if (         $hash_ref->{$key_to_check}) { print "is true.\n"; }
		if ( $hash_ref->{$key_to_check}  > 0   ) { print "is  > 0 .\n"; }
		if ( $hash_ref->{$key_to_check} >= 0   ) { print "is >= 0 .\n"; }
		if ( $hash_ref->{$key_to_check} == 0   ) { print "is == 0 .\n"; }
		if ( $hash_ref->{$key_to_check} != 0   ) { print "is != 0 .\n"; }
		if ( $hash_ref->{$key_to_check} eq ''  ) { print "is eq ''.\n"; }
		if ( $hash_ref->{$key_to_check} ne ''  ) { print "is ne ''.\n"; }
		print "-" x 40 . "\n";
}

exit 0;

__END__
