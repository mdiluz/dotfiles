#! /usr/bin/perl
# Grab all new files and directories in a given path and archive them
use strict;
use warnings;
use ecco qw(ecco eccow);

# File rule finding
use File::Find::Rule; 
use File::Basename;


# Current working directory
use Cwd;

# For current time
use POSIX qw/strftime/;

our $archive_suffix="_archive";
our $time = strftime('%d-%m-%Y',localtime);

# archive method
sub archive
{
	# Allow for arrays to be given as a parameter
	foreach my $path (@_)
	{
		# Create rule for all files/folders in the directory
	    my $rule = File::Find::Rule->new;
	    $rule->maxdepth(1);
	    $rule->mindepth(1);
	    $rule->not( File::Find::Rule->new->name( "*$archive_suffix" )->prune );

	    my @objects = $rule->in( $path );

	    # if we have objects to move
	    if( scalar(@objects) )
	    {
		    my $newDir = $path."/".basename($path)."_".$time.$archive_suffix;

			ecco "Creating directory $newDir";
		    system("mkdir","$newDir");

		    # Copy over each object into the archive
		    foreach my $object (@objects)
		    {
		    	system("mv", $object, "$newDir/");
		    }
	    }
	    else
	    {
	    	eccow "No files in $path to archive";
	    }
	}
}

# If given arguments, use them, otherwise use the current working directory
if ( scalar @ARGV ) {
	archive(@ARGV);
}
else {
	archive(getcwd);
}