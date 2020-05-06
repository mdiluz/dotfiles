#! /usr/bin/perl

use strict;
use warnings;

our $files = `git status @ARGV`;

our @filteredfiles = ($files =~ /^\s+modified:\s+(.*)$/gm );

our $filestring = "";
for our $file ( @filteredfiles )
{
	print "modified: $file\n";
	$filestring =  "\"".$file."\" ".$filestring;
}

if ( length($filestring) > 0 )
{
	print "git checkout HEAD -p ".$filestring."\n";
	system("git checkout HEAD -p ".$filestring);
}
else
{
	print "nothing to checkout to head\n";
}
