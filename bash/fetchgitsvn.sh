#! /bin/bash
# Script runs a git svn fetch bit with logging output and lockfile checking
# Intended to be used as a cron job to run in the background
#               
# For hourly svn fetches, add the following lines to your crontab with "crontab -e" :                  
# 0 * * * * "{dotfiles root}/bin/fetchgitsvn {directory}"
#

NAME=`basename $0`

# Grab path
MYPATH=$1

# Early out if no env variable
if [ -z "$MYPATH" ]; then
	echo ":ERROR: no path passed to $NAME"
	exit 1
fi

# Early out if no root
if [ ! -e "$MYPATH/.git/svn" ]; then
	echo ":ERROR: $MYPATH does not appear to be a git-svn repository"
	exit 1
fi

# Check if we're locked to prevent concurrent updating
UPDATESVNLOCKFILE="/tmp/.fetchgitsvn_lock"
if [ -e "$UPDATESVNLOCKFILE" ]; then
	echo ":WARNING: $NAME already running "
	echo ":WARNING: $UPDATESVNLOCKFILE still exists "
	exit 0
fi

# Create the lock file
date > $UPDATESVNLOCKFILE

# cd to our svn 
cd $MYPATH

# scope for logging output
{

# print the header
echo ================$(date)================= 

# Using nicely formatted git log a la https://coderwall.com/p/euwpig 
git log --graph --pretty=format:'%h -%d %s (%cr) <%an>' --abbrev-commit -n 10 
# echo here since git log doesn't end in a new line
echo 
echo ===========================FETCH============================= 
# Fetch from svn
git svn fetch 
echo ============================END============================== 
echo 

# tee the output into a log file in the home directory
} | tee -a "/tmp/fetchgitsvn_log.txt"

# Remove the lockfile
rm $UPDATESVNLOCKFILE

echo ":SUCCESS: $NAME finished"
