#! /bin/bash
# Short script to do command on each line of file

file=$1
cmd=$2

# early out
if [ ! -e $file ]; then
	eccoe "$file does not exist"
	exit 0
fi

# early out
if [ -e $cmd ]; then
	eccoe "no command"
	exit 0
fi

# Perform the command on each line
while read line           
do           
    eval "$cmd $line"           
done <$file