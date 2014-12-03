#! /usr/bin/perl
use strict;
use warnings;

use Cwd;
use ecco qw(ecco eccoe);
use pathtools qw(fixUpPaths);

our $tmpfile = `mktemp /tmp/copygitstate.XXXXXXXXXXXX`;
our $USAGE="Usage - copyGitState {[source] [destination] / [destination]}";

our $source 		= shift;
our $destination 	= shift;

# if no params
if ( ! $source )
{
	eccoe "No parameters passed";
	eccoe $USAGE;
	exit 1;
}

# If only one param
if ( ! $destination )
{
	$destination = $source;
	$source = getcwd;
}

# Adjust "." paths
fixUpPaths( ($source,$destination) );

# If dest and src are the same
if ( $destination eq $source )
{
	eccoe "Source and Destination are the same";
	eccoe $USAGE;
	exit 1;
}

# Get a diff from the source
ecco "Getting diff from $source";
chdir $source;
our $diff = `git --no-pager diff --patch`;

# Output diff to a temporary file
open(my $fh, '>', $tmpfile) or die "Could not open file '$tmpfile' $!";
print $fh $diff;
close $fh;

# Apply the diff
ecco "Applying diff to $destination";
chdir $destination;
our $error = system("patch -p1 < $tmpfile");

if( $error )
{
	eccoe "patch returned error"
}

exit $error;