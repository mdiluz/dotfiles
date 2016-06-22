#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# bashrc setup
TEXT="# Add my dotfiles configuration
export DOTFILESDIR=$DIR
source \$DOTFILESDIR/config/bashrc"
echo "Add the following to .bashrc :"
echo "$TEXT"
echo ""

# Extra commands
echo "Run the following commands after checking them"
echo "ln -s \"$dir/config/vimrc\" \"~/.vimrc\""
echo "ln -s \"$dir/config/tmux.conf\" \"~/.tmux.conf\""
