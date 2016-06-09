function fish_right_prompt -d "Write out the right prompt"

	set -l __last_status $status
	set -l __time (__fish_ms_to_human $CMD_DURATION)
	set_color blue
	if test $__last_status -gt 0
		set_color red
	end

	# print last command
	set __last_cmd $history[1]
	# Limit to max length
	set __length_last 20
	if [ (string length $__last_cmd) -gt $__length_last ];
		set __last_cmd ( printf "%s…" ( string sub --length $__length_last $__last_cmd ) )
	end

	printf "[%s] %s" $__last_cmd $__time
	set_color normal
end
