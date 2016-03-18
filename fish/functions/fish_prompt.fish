function fish_prompt --description 'Write out the prompt'

	set stat $status

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	#Set the color for the status depending on the value
	set __fish_color_status (set_color -o green)
	if test $stat -gt 0
		set __fish_color_status (set_color -o red)
	end

	switch $USER
	case root
		set __fish_prompt (printf '%s@%s:%s# ' $USER $__fish_prompt_hostname "%s" )
	case '*'
		set __fish_prompt (printf '%s[%s]%s%s@%s:%s%s %s(%s)%s \f\r> ' (set_color yellow) (date "+%H:%M:%S") (set_color -o blue) $USER $__fish_prompt_hostname (set_color green) "%s" "$__fish_color_status" "$stat" (set_color normal))
	end

	# shorter prompt
	set __prompt_cwd_len (pwd | wc -c)
	set __prompt_command_len (echo $__fish_prompt | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | wc -m)
	set __prompt_total_len (math "$__prompt_cwd_len+$__prompt_command_len")
	if math "$__prompt_total_len>$COLUMNS" > /dev/null
		set __prompt_cwd (prompt_pwd)
	else
		set __prompt_cwd (pwd)
	end

	printf "$__fish_prompt" "$__prompt_cwd"
end
