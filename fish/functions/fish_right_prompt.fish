function fish_right_prompt -d "Write out the right prompt"

	set -l __last_status $status
	set -l __time ( __fish_ms_to_human $CMD_DURATION )
	set -l __last_cmd $history[1]

	# test for string
	__fish_test_string
	if test $__fish_has_string
		# format the last command
		# Remove a trailing space
		set __last_cmd ( string replace -r " \$" "" $__last_cmd)
		# Limit to max length
		set __length_last 20
		if [ (string length $__last_cmd) -gt $__length_last ];
			set __last_cmd ( printf "%s…" ( string sub --length $__length_last $__last_cmd ) )
		end
	end

	# Use dark grey unless the last command failed
	set_color 444444
	if test $__last_status -gt 0
		set_color -o red
	end
	printf "[%s] " $__last_cmd
	if [ $__time ]
		printf "%s " $__time
	end 
	set_color normal
end
