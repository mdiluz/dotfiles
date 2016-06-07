function fish_right_prompt -d "Write out the right prompt"

	set -l __last_status $status

	set_color blue
	if test $__last_status -gt 0
		set_color red
	end
	echo -n "$CMD_DURATION" ms
	set_color normal
end
