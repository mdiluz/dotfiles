#! /usr/bin/perl

use strict;
use warnings;

our $files = `git status -uno @ARGV`;

our @filteredfiles = ($files =~ /^\s+modified:\s+(.*)$/gm );

our $filestring = "";
for our $file ( @filteredfiles )
{
	print "modified: $file\n";
	$filestring =  "\"".$file."\" ".$filestring;
}

if ( length($filestring) > 0 )
{
	print("git add -p ".$filestring."\n");
	system("git add -p ".$filestring);
}
else
{
	print "nothing to add\n";
}
