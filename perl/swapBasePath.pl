#! /usr/bin/perl

# Use the pathtools perl module
use pathtools qw(swapBasePath);
use ecco qw(eccoe);

my @paths = @ARGV;

# Verify parameters
if ( scalar(@paths) != 3 )
{
	eccoe "swapBasePaths script must take 3 parameters";
	exit 1;
}

swapBasePath @paths;
printf $paths[2];