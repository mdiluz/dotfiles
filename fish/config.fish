# Use most for manpages
set -g MANPAGER most

# Source in autojump
if test -f /etc/profile.d/autojump.fish
	source /etc/profile.d/autojump.fish
end

# Source in local specific fish functions
if test -f ~/.config/fish/local.fish
	source ~/.config/fish/local.fish
end

# Shut up gdb
alias gdb "gdb -q"

# Shut up the fish greeting
set fish_greeting

# Use vim
set -x EDITOR vim

# Set up custom paths
set DOTFILESDIR ~/dotfiles/
set -x PATH $HOME/bin $DOTFILESDIR/bin $PATH
set -x PERL5LIB $DOTFILESDIR/perl $PERL5LIB

# Use direnv
direnv hook fish | source
