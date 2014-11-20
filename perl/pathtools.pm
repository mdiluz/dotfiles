#! /usr/bin/perl
# pathtools perl library
package pathtools;

use strict;
use warnings;
no warnings 'experimental::smartmatch';

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(pathtools_test_single pathtools_test_array correctForFullStop);

# Use ecco
use ecco qw(ecco ecco);
use Cwd;

# Make sure when given a "." path we use the cwd
sub correctForFullStop
{
	foreach my $path (@_)
	{	
		if ( $path eq "." )
		{
			$path = getcwd;
		}
	}
}

# Test single parameter functions
sub pathtools_test_single
{
	my $path=".";
	correctForFullStop($path);

	return !( $path eq getcwd )
}

# Test multipl parameter functions
sub pathtools_test_array
{
	my @paths1=(".");
	my @paths2=(getcwd);
	correctForFullStop(@paths1);

	return !( @paths1 ~~ @paths2 );
}

1; # True statement