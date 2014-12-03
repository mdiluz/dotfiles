#! /bin/bash
# Script to attempt a shutdown if there is no lock file

LOCKFILE="/tmp/.shutdownlock"

if [ -e "$LOCKFILE" ]; then
	echo ":: Cannot shutdown - lockfile exists"
else
	echo ":: Shutting down"
	shutdown
fi


