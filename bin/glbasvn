#! /bin/bash
# Get Last commit By Author in Svn
# Will get the last commit by an author in svn

commit=$( git svn log --limit=10000 | sed -n "/$1/,/-----$/ p" | head -n 5 | sed '/-----------------/q' )
echo "$commit" | sed '$ d'
