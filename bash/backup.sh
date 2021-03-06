#! /bin/bash

FILE="$1"
# file/folder to backup

# early out
if [ ! -e $FILE ]; then
	echo ":ERROR: $FILE does not exist"
	exit 0
fi

BACKUP="$FILE.bkp"
FORCED="$2"

if [ ! -e $FILE ]; then
	echo ":ERROR: $FILE does not exist to create backup"
	exit 0;
fi

bkp="0"

# ask if we haven't forced
if [ -e $BACKUP ] && [ ! -n "$FORCED" ]; then
	read -p "$( echo "Are you sure you want overwrite backup \'$BACKUP\' ? [yN]:" )" yn
	case $yn in
	    [Yy]* ) bkp="1";;
	    [Nn]* ) bkp="0";;
	esac
else
	bkp="1"
fi

if [ "$bkp" == "1" ]; then 
	echo ":: Backing up $FILE"
	echo ":: running command rsync -au $FILE $BACKUP"
	
	rsync -au $FILE $BACKUP
else
	echo ":ERROR: aborting backup"
fi