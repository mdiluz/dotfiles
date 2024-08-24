#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install dependencies
sudo apt install -y tmux fish direnv git vim

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
FISHDIR=~/.config/fish/
while IFS= read -r -d '' FISHES
do
	FISHNAME=$( basename "$FISHES" )
	mkdir -p "$FISHDIR/$FISHNAME"
	ln -s "$DIR/fish/$FISHNAME/"* "$FISHDIR/$FISHNAME"
done < <( find "$DIR/fish/" -maxdepth 1 -mindepth 1 -type d -print0 )

# Ensure we have git lg
git config --global user.name "Marc Di Luzio" # purposely leave email blank
git config --global core.excludesfile "$DIR/config/gitignore"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
