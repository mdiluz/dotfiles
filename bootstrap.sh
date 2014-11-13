#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR/bin ~/bin
ln $DIR/bashrc ~/.bashrc
ln $DIR/bash_aliases ~/.bash_aliases
