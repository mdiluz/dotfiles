#! /usr/bin/perl
# ecco perl library
package ecco;

use strict;
use warnings;

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(ecco);

# Needed features
use Term::ANSIColor ':constants';
use feature 'say';

# Simply echo the given string
sub ecco
{
	say @_;
}

1; # True statement