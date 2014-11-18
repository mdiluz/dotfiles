#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR/bin ~/bin
ln -s $DIR/bashrc ~/.bashrc
ln -s $DIR/bash_aliases ~/.bash_aliases
