#! /usr/bin/perl
use strict;
use warnings;

use Cwd;

# Pull in ecco
use ecco qw(ecco eccoe eccow eccos);

# Pull in testing function
use perltest qw(testfunction0to1 testfunction1to1 testfunction1toMany testfunctionManyto1 testfunctionManytoMany getTestsResult resetTestsResult);

print "================================\n";
print "The following are visual tests\n";

# Test the ecco module (visual check)
print "Expect \"BLUE\" in blue\n";
ecco "BLUE";
print "Expect \"YELLOW\" in yellow\n";
eccow "YELLOW";
print "Expect \"RED\" in red\n";
eccoe "RED";
print "Expect \"GREEN\" in green\n";
eccos "GREEN";

#TODO: ask for user input?

# =================================================================
# Test our tests to make sure they work as intended
print "================================\n";
print "Automatic test the tester tests\n";

# Reset the test results before starting
resetTestsResult();

# 0 to 1 tests
sub test0to1 {
	return "success";
}
testfunction0to1( 0, "0to1 intended success", \&test0to1 , "success" ) and die "Intended success test failed";
testfunction0to1( 0, "0to1 intended failure", \&test0to1 , "fail" ) or die "Intended success test failed";

# 1 to 1 tests
sub test1to1 {
	my $input = $_[0];
	$_[0] = "success";
	return $input;
}
testfunction1to1( 0, "1to1 intended success", \&test1to1 , "success", "success" ) and die "Intended success test failed";
testfunction1to1( 0, "1to1 intended failure", \&test1to1 , "success", "fail" ) or die "Intended success test failed";
testfunction1to1( 1, "Inline 1to1 intended success", \&test1to1 , "fail" , "success" ) and die "Intended success test failed";
testfunction1to1( 1, "Inline 1to1 intended failure", \&test1to1 , "success", "fail" ) or die "Intended success test failed";

# 1 to many tests
sub test1toMany {
	my @output = ($_[0],$_[0]);
	return @output;
}
testfunction1toMany( 0, "1toMany intended success", \&test1toMany , "success", "success", "success" ) and die "Intended success test failed";
testfunction1toMany( 0, "1toMany intended failure", \&test1toMany , "success", "success", "fail" ) or die "Intended success test failed";

# many to 1 tests
sub testManyto1 {
	my @output = ($_[0],$_[0]);
	return "success";
}
testfunctionManyto1( 0, "Manyto1 intended success", \&testManyto1 , 2, "success", "success", "success" ) and die "Intended success test failed";
testfunctionManyto1( 0, "Manyto1 intended failure", \&testManyto1 , 2, "success", "success", "fail" ) or die "Intended success test failed";

# many to many tests
sub testManytoMany {
	my @output = ($_[1],$_[0]);
	$_[0] = "success1";
	$_[1] = "success2";
	return @output;
}
testfunctionManytoMany( 0, "ManytoMany intended success", \&testManytoMany , 2, "success1", "success2", 2, "success2", "success1" ) and die "Intended success test failed";
testfunctionManytoMany( 0, "ManytoMany intended failure", \&testManytoMany , 2, "success1", "success2", 2, "success1", "success2" ) or die "Intended success test failed";
testfunctionManytoMany( 1, "Inline ManytoMany intended success", \&testManytoMany , 2, "fail", "fail", 2, "success1", "success2" ) and die "Intended success test failed";
testfunctionManytoMany( 1, "Inline ManytoMany intended failure", \&testManytoMany , 2, "success1", "success2", 2, "success2", "success1" ) or die "Intended success test failed";

# Reset the tests results
resetTestsResult();

# =================================================================
# Now perform the actual tests
print "================================\n";
print "The following are automated tests\n";

# ======================
# pathtools module tests
use pathtools qw(fixUpPaths swapBasePath);

# Test non-array functions
testfunction1to1( 1, "fixUpPaths with .", \&fixUpPaths, ".", getcwd );
testfunction1to1( 1, "fixUpPaths with ./thing", \&fixUpPaths, "./thing", getcwd."/thing" );
testfunction1to1( 1, "fixUpPaths with thing", \&fixUpPaths, "thing", getcwd."/thing" );
testfunctionManytoMany( 1, "swapBasePath with single param", \&swapBasePath , 3 , ".", "/other/test/path", "thing" , 3 , ".", "/other/test/path", "/other/test/path/thing" );

# Test pathing functions with arrays
my @paths1=(".","./thing","thing");
my @paths2=(getcwd,getcwd."/thing",getcwd."/thing");
testfunctionManytoMany(1, "fixUpPaths with array parameter", \&fixUpPaths, scalar(@paths1), @paths1, scalar(@paths2), @paths2 );

my @paths=(".", "/other/test/path" , "thing","/stuff/thats/not/in/path","./thing","/other/test/path/otherPath");
my @pathsresult=( ".", "/other/test/path", "/other/test/path/thing","/stuff/thats/not/in/path","/other/test/path/thing",getcwd."/otherPath");
testfunctionManytoMany(1, "fixUpPaths with array parameter", \&swapBasePath, scalar(@paths), @paths, scalar(@pathsresult), @pathsresult );

# =================================================================
print "================================\n";

my $result = getTestsResult();
resetTestsResult();

# Summarise tests
if ($result > 0)
{
	print "ERROR: Tests failed\n";
}
else
{
	print "SUCESS: Tests succeeded\n";
}

exit $result;