#! /bin/bash

# The two files
FILE="$1"
BACKUP="$FILE.bkp"
FORCED="$2"

if [ ! -e $BACKUP ]; then
	echo ":: $BACKUP does not exist to restore from"
	exit 0;
fi

bkp="0"

# ask if we haven't forced
if [ ! -n "$FORCED" ]; then
	read -p "$( echo ":: Are you sure you want to restore from \'$BACKUP\' ? [yN]:" )" yn
	case $yn in
	    [Yy]* ) bkp="1";;
	    [Nn]* ) bkp="0";;
	esac
else
	bkp="1"
fi

if [ "$bkp" == "1" ]; then 
	echo ":: Restoring backup"
	echo ":: running command rsync -au $BACKUP $FILE"

	rsync -au $BACKUP $FILE
else
	echo ":: aborting backup"
fi