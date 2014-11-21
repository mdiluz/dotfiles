#! /usr/bin/perl
# pathtools perl library
package pathtools;

use strict;
use warnings;
no warnings 'experimental::smartmatch';

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(pathtools_test_single pathtools_test_array fixUpPaths appendSlash swapBasePath);

# Use ecco
use ecco qw(ecco ecco eccow);
use Cwd;

# Make sure when given a "." path we use the cwd
sub fixUpPaths
{
	foreach my $path (@_)
	{	
		my $cwd = getcwd;

		# Adjust for single dot
		if ( $path eq "." )
		{
			$path = $cwd;
		}
		# Adjust for ./
		elsif ( $path =~ m/^\.\// )
		{
			$path =~ s/^\.\//$cwd\//;
		}
		# adjust for not starting in /
		elsif ( $path =~ m/^[^\/]/ )
		{
			$path =~ s/^/$cwd\//;
		}
	}
}

# Append a slash if not one already
sub appendSlash
{
	$_[0] =~ s/([^\/])$/$1\//;
}

# Swap out the base path of a full path given two alternate bases
sub swapBasePath
{
	my $baseOne = shift;
	my $baseTwo = shift;

	# Correct for fullstops
	fixUpPaths($baseOne); 
	fixUpPaths($baseTwo);
	fixUpPaths(@_);

	appendSlash($baseOne);
	appendSlash($baseTwo);

	foreach my $path (@_)
	{	
		if ( $path =~ m/^$baseOne/ )
		{
			$path =~ s/^$baseOne/$baseTwo/;
		}
		elsif ( $path =~ m/^$baseTwo/ )
		{
			$path =~ s/^$baseTwo/$baseOne/;
		}
	}
}

1; # True statement