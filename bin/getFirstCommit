#! /bin/bash
git log --format=%B -n 1 $( git --no-pager log --author $1 --reverse | head -1 | awk -F ' ' '{print $2}' )