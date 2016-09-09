#!/bin/bash
REMOTE_ROOT=/media/radioferal
LOCAL_ROOT=/home/mdiluzio/radioferal
LOCAL_DATA_ROOT=$LOCAL_ROOT/data
LOGFILE=$REMOTE_ROOT/debug/log.txt
PLAYLIST="${LOCAL_ROOT}/icecast-playlist.txt"

# Begin the log
echo "
== log for update at $(date) ==" >> $LOGFILE

# rsync the directories
if [[ -e $REMOTE_ROOT/playlist.txt ]]; then
	echo "Station mounted correctly" | tee -a $LOGFILE
else
	# Script to mount the radio channel first
	echo "Re-mounting station" | tee -a $LOGFILE
	sudo $LOCAL_ROOT/mount-radio.sh
fi

# Sync up the station data
rsync -avz --delete --exclude debug $REMOTE_ROOT/ $LOCAL_DATA_ROOT/ | tee -a $LOGFILE


# Generate a playlist with full paths
echo "# Auto-generated playlist
# !!!WARNING!!! ALL EDITS WILL BE LOST
#" > $PLAYLIST
$LOCAL_ROOT/gen-playlist.sh $LOCAL_DATA_ROOT/playlist.txt >> $PLAYLIST

# Store the playlist back on the server, for debugging
cp $PLAYLIST $REMOTE_ROOT/debug/final_playlist.txt

# If the next file has a 1 in it then skip to the next track
NEXT_FILE="$LOCAL_DATA_ROOT/skip_track.txt"
if grep 1 $NEXT_FILE > /dev/null; then
	echo "skip_track has a 1 so skipping to next track" | tee -a $LOGFILE
	kill -USR1 $( pidof ezstream )
	echo 0 > $REMOTE_ROOT/skip_track.txt
fi

# make sure the logfile doesn't get too big
cat $LOGFILE | tail -500 > /tmp/radioferal_log.txt 
cp /tmp/radioferal_log.txt $LOGFILE
