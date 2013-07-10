#!/usr/bin/perl

use strict;
use warnings;

use PadWalker qw/peek_our peek_my/;
use Data::Dumper;

our $foo = 1;
our $bar = 2;

{
    my $foo = 3;
    print 'inside block: ' . Dumper in_scope_variables();
}

print 'outside block: ' . Dumper in_scope_variables();

sub in_scope_variables {
    my %in_scope = %{peek_our(1)};
    my $lexical  = peek_my(1);
    #lexicals hide package variables
    while (my ($var, $ref) = each %$lexical) {
    	$in_scope{$var} = $ref;
    }
    ##############################################
    #FIXME: need to add globals to %in_scope here#
    ##############################################
    return \%in_scope;
}
