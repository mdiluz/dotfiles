#! /usr/bin/perl
# Find all svn working copies within the current working directory and update them
# TODO: Use the same revision number if all working copies come from the same repository
# TODO: Use threads for each update

use strict;
use warnings;
use ecco qw(ecco);

# ====================================================================================
# File rule finding
use File::Find::Rule;

# Current working directory
use Cwd;

# ====================================================================================
# Get all directories matching filter
sub getAllDirectories 
{
	my $directory = shift;
	my $filter = shift;

	my $dirrule = File::Find::Rule->new;
    $dirrule->directory;
    $dirrule->name( $filter );

    return $dirrule->in( $directory );
}

# ====================================================================================
# Filter out any child directories in a list
sub removeAllChildDirectories
{
	# Sort directories (otherwise iteration will not work as intended)
	my @dirs = sort @_;

	my @outdirs=();

	my $lastPath = "\0";
	foreach my $path (@dirs)
    {
        if ( $path =~ /^$lastPath/ )
        {
        	next;
        }

        $lastPath = $path;
        push(@outdirs,$lastPath)
    }

	return @outdirs;
}

# ====================================================================================
# Main function
sub recursivelyUpdateSVN
{
	ecco "Fetching all svn working copies";
	our @dirs = getAllDirectories(getcwd,".svn");

	# Remove all .svn components of paths
	foreach my $dir (@dirs)
	{
	    $dir =~ s/.svn$//;
	}

	ecco "Filtering out subdirectories";
	@dirs = removeAllChildDirectories(@dirs);

	ecco "Updating all working copies";
	# Call svn update on each directory
	foreach our $dir (sort @dirs)
	{
		system("svn","update",$dir);
	}
}
recursivelyUpdateSVN;