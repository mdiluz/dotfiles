#! /usr/bin/perl
# perltest perl library
package perltest;

use strict;
use warnings;
no warnings 'experimental::smartmatch';

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(testfunction perltest_test);

use ecco qw(ecco eccoe eccos);

# Test a function
sub testfunction 
{
	my $name = shift;
	my $expect = shift;
	my $function = shift;
	my @options = @_;

	ecco "===== Performing $name test =====";

	# Call the function
	my $result = $function->(@options);

	# Check the result
	if( !($result ~~ $expect) )
	{
		eccoe "$name failed - expected $expect, got $result";
		return 1;
	}
	else
	{
		eccos "$name";
		return 0;
	}
}

# Function to use in tests
sub testfunc
{
	my ( $a, $b ) = @_;
	return $a.$b;
}

# test the perltest module
sub perltest_test
{
	my $success = testfunction("intended success", "ab" ,\&testfunc,"a","b");
	my $fail = testfunction("intended failure", "ac" ,\&testfunc,"a","b");

	return ( $success and !$fail );
}
