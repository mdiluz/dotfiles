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
mkdir -p "~/.config/alacritty/"
ln -s "$DIR/config/alacrity.yml" ~/.config/

# Linking fish
echo "Linking fish"
FISHDIR=~/.config/fish/
ln -s "$DIR/fish/config.fish" $FISHDIR
while IFS= read -r -d '' FISHES
do
	FISHNAME=$( basename "$FISHES" )
	mkdir -p "$FISHDIR/$FISHNAME"
	ln -s "$DIR/fish/$FISHNAME/"* "$FISHDIR/$FISHNAME"
done < <( find "$DIR/fish/" -maxdepth 1 -mindepth 1 -type d -print0 )
