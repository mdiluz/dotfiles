function fish_prompt --description 'Write out the prompt'

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	switch $USER
	case root
		echo -n $USER"@" 
		echo -n $__fish_prompt_hostname
	case '*'
		# Print the current time in HH:MM:SS format
		set_color yellow 
		echo -n "["(date +%H:%M:%S)"]" 
		
		# Print the current user and hostname if needed
		set_color -o blue 
		if test $USER != $LOGNAME
			echo -n $USER"@"
		end 
		echo -n $__fish_prompt_hostname 
	end


	# cwd part of prompt
	set __prompt_cwd_len (pwd | wc -c)
	set __prompt_command_len (echo $__fish_prompt | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | wc -m)
	set __prompt_total_len (math "$__prompt_cwd_len+$__prompt_command_len")
	if math "$__prompt_total_len>$COLUMNS" > /dev/null
		set __prompt_cwd (prompt_pwd)
	else
		set __prompt_cwd (pwd)
	end

	set_color green
	echo -n ":"
	echo $__prompt_cwd
	set_color normal
	echo "> "
end
