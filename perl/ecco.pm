#! /usr/bin/perl
# ecco perl library
package ecco;

use strict;
use warnings;

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(ecco eccow eccoe eccos);

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

1; # True statement