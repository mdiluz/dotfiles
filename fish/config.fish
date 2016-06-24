# Use most for manpages
set -g MANPAGER most

# Source in autojump 
if test -f /etc/profile.d/autojump.fish
	source /etc/profile.d/autojump.fish
end

# Notify on extra long functions
function --on-event fish_postexec __notify_long_command
    if math "$CMD_DURATION > 5000" > /dev/null
        set -l __last_cmd $argv
        if type -q notify-send
            notify-send "cmd done" "$__last_cmd"
        else if type -q osascript
            set -l __last_cmd ( echo $__last_cmd | tr -d \"\' )
            osascript -e "display notification \"$__last_cmd\" with title \"cmd done\""
        end 
    end 
end

