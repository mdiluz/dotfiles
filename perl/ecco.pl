#! /usr/bin/perl

# Use the ecco perl module
use ecco qw(ecco eccow eccoe eccoe);

my $primary = $ARGV[0];

if ( $primary =~ m/::/ )
{
	ecco @ARGV;
}
elsif ( $primary =~ m/:WARNING:/ )
{
	eccow @ARGV;
}
elsif ( $primary =~ m/:ERROR:/ )
{
	eccoe @ARGV;
}
elsif ( $primary =~ m/:SUCCESS:/ )
{
	eccoe @ARGV;
}
else
{
	system("echo",@ARGV);
}