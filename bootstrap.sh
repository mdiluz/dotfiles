#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "DOTFILESDIR=$DIR" > ~/.dotfilesdir

# make the tmp directory
mkdir $DIR/tmp

ln -s $DIR/bashrc ~/.bashrc
ln -s $DIR/bash_aliases ~/.bash_aliases
