#!/bin/bash
# Script to consume a single track from a playlist
REMOTE_ROOT="/media/radioferal"
LOCAL_ROOT="/home/mdiluzio/radioferal"
LOCAL_DATA_ROOT="$LOCAL_ROOT/data"

# grab the playlist file
PLAYLIST_FILE="$LOCAL_ROOT/icecast-playlist.txt"

# Track marker file
TRACK_QUEUE_FILE="$REMOTE_ROOT/track_queue.txt"
if [ ! -f "$TRACK_QUEUE_FILE" ]; then
	 cat "$PLAYLIST_FILE" > "$TRACK_QUEUE_FILE"
fi

# Grab the track name and echo it out
CURRENT_TRACK_NAME=$( head -n 1 "${TRACK_QUEUE_FILE}" )
echo "$LOCAL_DATA_ROOT/$CURRENT_TRACK_NAME"

# Remove any empty lines
sed '/^$/d' $TRACK_QUEUE_FILE > $TRACK_QUEUE_FILE.tmp
# Then remove the first line and add back a newline
sed 1d $TRACK_QUEUE_FILE.tmp | sed -e '$a\' > ${TRACK_QUEUE_FILE}

# Get the number of queued tracks
TRACK_QUEUE_NUM=$( wc -l ${TRACK_QUEUE_FILE} | awk '{print $1}' )

# If we've still got items, then carry on as normal, otherwise find the next file
if [ $TRACK_QUEUE_NUM -lt 1 ]; then
	# Get line number of current track
	# -n for number, -x for whole line, -F for literal
	# Empty if not found, which then will default to 0 for the ++ below
	LINE_NUMBER=$( grep -nxF "$CURRENT_TRACK_NAME" "$PLAYLIST_FILE" | cut -d : -f 1 )

	# Grab the number of lines
	NUM_LINES=$( wc -l $PLAYLIST_FILE | awk '{print $1}' )

	# Grab the next line until it finds one that exists
	while [ ! -f "$LOCAL_DATA_ROOT/$( head -1 $TRACK_QUEUE_FILE )" ]; do
		LINE_NUMBER=$((++LINE_NUMBER))
		if [[ $LINE_NUMBER -ge $NUM_LINES ]]; then
			LINE_NUMBER=1
		fi

		awk "NR > $LINE_NUMBER" $PLAYLIST_FILE > $TRACK_QUEUE_FILE 
	done
fi

# Remove the empty tmp file
rm ${TRACK_QUEUE_FILE}.tmp

