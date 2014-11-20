#! /usr/bin/perl
# ecco perl library
package ecco;

use strict;
use warnings;

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(ecco_visual_test ecco eccow eccoe eccos);

# Needed features
use Term::ANSIColor ':constants';
use feature 'say';

# simply echo the given string
sub ecco
{
	say BLUE, "@_", RESET;
}

# echo given warning
sub eccow
{
	say YELLOW, "WARNING: @_", RESET;
}

# echo an error
sub eccoe
{
	say RED, "ERROR: @_", RESET;
}

# echo a success
sub eccos
{
	say GREEN, "SUCCESS: @_", RESET;
}

# test the ecco module
sub ecco_visual_test
{
	print "Expect \"BLUE\" in blue\n";
	ecco "BLUE";
	print "Expect \"WARNING: YELLOW\" in yellow\n";
	eccow "YELLOW";
	print "Expect \"ERROR: RED\" in red\n";
	eccoe "RED";
	print "Expect \"SUCCESS: GREEN\" in green\n";
	eccos "GREEN";
}

1; # True statement