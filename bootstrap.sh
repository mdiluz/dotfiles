#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# bashrc setup
TEXT="# Dotfile configuration
export DOTFILESDIR=$DIR
source \$DOTFILESDIR/config/bashrc"
if ! grep -q 'DOTFILESDIR' ~/.bashrc; then
	echo "Adding to .bashrc"
	echo "$TEXT" >> ~/.bashrc
fi

# Extra commands
echo "Linking configs"
ln -s "$DIR/config/vimrc" ~/.vimrc
ln -s "$DIR/config/tmux.conf" ~/.tmux.conf

# Linking fish
echo "Linking fish"
FISHDIR=~/.config/fish
mkdir -p $FISHDIR
ln -s $DIR/fish/config.fish $FISHDIR/
for FISHES in $( find $DIR/fish/ -maxdepth 1 -mindepth 1 -type d -printf "%f\n" ); do
	mkdir -p $FISHDIR/$FISHES
	ln -s $DIR/fish/$FISHES/* $FISHDIR/$FISHES/
done
