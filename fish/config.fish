# Use most for manpages
set -g MANPAGER most

# Source in autojump 
if test -f /etc/profile.d/autojump.fish
	source /etc/profile.d/autojump.fish
end

# Notify on extra long functions
function __notify_long_command --on-event fish_postexec
    if test "$CMD_DURATION" -gt "5000" > /dev/null
        set -l __last_cmd $argv
        if type -q notify-send
            notify-send "cmd done" "$__last_cmd"
        else if type -q osascript
            set -l __last_cmd ( echo $__last_cmd | tr -d \"\' )
            osascript -e "display notification \"$__last_cmd\" with title \"cmd done\""
        end 
    end 
end

# Source in local specific fish functions
if test -f ~/.config/fish/local.fish
	source ~/.config/fish/local.fish
end

# Shut up gdb
alias gdb "gdb -q"
