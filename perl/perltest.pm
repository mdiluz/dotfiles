#! /usr/bin/perl
# perltest perl library
package perltest;

use strict;
use warnings;
no warnings 'experimental::smartmatch';

# Export functions
use Exporter qw(import);
our @EXPORT_OK = qw(testfunction0to1 testfunction1to1 testfunctionManyto1 testfunction1toMany testfunctionManytoMany getTestsResult resetTestsResult);

use ecco qw(ecco eccoe eccow eccos);

# Store global retults;
our $testingResult = 0;

# Test a function
# testfunction( true/false for inline,"test name" \&function, numInput, ...input... , numExpectedResults, ...results... )
sub _testfunction 
{
	my $inline = shift;
	my $name = shift;
	my $function = shift;

	# Grab all the input
	my $inputNum = shift;
	my @input;
	for (1..$inputNum)
	{	
		push(@input,shift);
	}

	# grab expectated returns
	my $expectNum = shift;
	my @expect;
	for (1..$expectNum)
	{
		push(@expect,shift);
	}

	ecco "===== Performing $name test =====";

	my @result;
	my $fail;
	if( $inline )
	{	
		# Store the input
		my @inputStore = @input;

		# Call the function
		$function->(@input);

		# Set the result
		@result = @input;

		# Check the result
		$fail = !(@expect ~~ @result);
	}
	else
	{
		# Call the function
		@result = $function->(@input);

		# Check the result
		$fail = !(@expect ~~ @result);
	}

	if( $fail )
	{
		eccoe "Failed - expected \"@expect\", got \"@result\"";
	}

	ecco "===== Finished $name test =====";
	$testingResult += $fail;

	return $fail;
}

# no input and 1 output
sub testfunction0to1
{
	_testfunction(shift,shift,shift,0,1,shift);
}

# 1 input 1 output
sub testfunction1to1
{
	_testfunction(shift,shift,shift,1,shift,1,shift);
}

# 1 input many outputs
sub testfunction1toMany
{
	my $inline = shift;
	my $name = shift;
	my $function = shift;
	my $input = shift;
	my $num = scalar(@_);
	_testfunction($inline,$name,$function,1,$input,$num,@_);
}

# many inputs 1 output
sub testfunctionManyto1
{
	my $inline = shift;
	my $name = shift;
	my $function = shift;
	my $num = shift;
	my @input;
	for(1..$num)
	{
		push(@input,shift);
	}
	my $expect = shift;
	_testfunction($inline,$name,$function,$num,@input,1,$expect);
}

# many inputs and many outputs
sub testfunctionManytoMany
{
	_testfunction(@_);
}

# get the full test results
sub getTestsResult
{
	return $testingResult
}

# reset the test results
sub resetTestsResult
{
	$testingResult = 0;
}

1; # Return true