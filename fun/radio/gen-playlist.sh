#!/bin/bash
LOCAL_ROOT=/home/mdiluzio/radioferal
MYSELF=/home/mdiluzio/radioferal/gen-playlist.sh
LOCAL_PLAYLIST="$1"

cd $LOCAL_ROOT
while read line
do
	# Recurse when we find an include
	if [[ "${line:0:8}" = "#include" ]]; then
		FILE=$( echo "$line" | sed -E 's/#include //g' )
		
		$MYSELF "$LOCAL_ROOT/data/$FILE"

	elif [[ "${line:0:5}" = "#shuf" ]]; then
		FILE=$( echo "$line" | sed -E 's/#shuf //g' )
		
		# Shuffle the playlist into a temp file
		TMPFILE=$(mktemp)
		shuf "$LOCAL_ROOT/data/$FILE" > $TMPFILE
		
		$MYSELF "$TMPFILE"

	elif [[ "${line:0:1}" != "#" ]]; then
		echo "$line"
	fi

done < "$LOCAL_PLAYLIST"
