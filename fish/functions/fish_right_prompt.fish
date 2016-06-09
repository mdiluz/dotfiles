function fish_right_prompt -d "Write out the right prompt"

	set -l __last_status $status
	set -l __time (__fish_ms_to_human $CMD_DURATION)
	set_color blue
	if test $__last_status -gt 0
		set_color red
	end
	echo -n "$__time"
	set_color normal
end
