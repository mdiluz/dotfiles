# Use most for manpages
set -g MANPAGER most

# Source in autojump 
if test -f /etc/profile.d/autojump.fish
	source /etc/profile.d/autojump.fish
end
