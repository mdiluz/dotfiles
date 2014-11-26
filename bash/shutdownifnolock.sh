#! /bin/bash
# Script to attempt a shutdown if there is no lock file

LOCKFILE="/tmp/.shutdownlock"

if [ -e "$LOCKFILE" ]; then
	ecco Cannot shutdown - lockfile exists
else
	ecco Shutting down
	shutdown
fi


