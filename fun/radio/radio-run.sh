#!/bin/bash
if pidof ezstream > /dev/null ; then
	echo "Already Running..."
else
	ezstream -c /home/mdiluzio/.ezstream/ezstream_mp3.xml
fi
