#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEXT="# Auto added by ${BASH_SOURCE[0]} on $(date)
export DOTFILESDIR=$DIR
source \$DOTFILESDIR/config/bashrc"

echo "$TEXT" >> ~/.bashrc

# TODO: Test setup worked with new shell
