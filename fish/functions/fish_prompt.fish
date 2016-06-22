function fish_prompt --description 'Write out the prompt'

	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	# Grab hostname and user
	set -l __prompt_user_host ""	
	switch $USER
	case root
		set __prompt_user_host "root@"$__fish_prompt_hostname
	case '*'
		# Only use the current user if needed
		if test $USER != $LOGNAME
			set __prompt_user_host $USER"@"$__fish_prompt_hostname
		else
			set __prompt_user_host $__fish_prompt_hostname
		end
	end

	# Construct a base prompt with space for colors
	set __prompt_base "%s╔═ %s"(date +%H:%M:%S)" %s"$__prompt_user_host

	# Sort out the CWD shortened if needed 
	set __prompt_cwd_len (pwd | wc -c)
	set __prompt_command_len (echo $__prompt_base | sed -r "s/%s//g" | wc -m)
	set __prompt_total_len (math "$__prompt_cwd_len+$__prompt_command_len")
	if math "$__prompt_total_len>$COLUMNS" > /dev/null
		set __prompt_cwd (prompt_pwd)
	else
		set __prompt_cwd (pwd)
	end

	# Assemble our top and bottom lines
	set __prompt_full_top $__prompt_base"%s:%s"$__prompt_cwd
	set __prompt_bottom_line "%s╚═%s "

	# Colorise the output
	printf $__prompt_full_top (set_color blue) \
	                          (set_color yellow) \
	                          (set_color -o blue) \
	                          (set_color 444444) \
	                          (set_color green)
	# newline
	echo ""
	printf $__prompt_bottom_line (set_color blue) \
	                             (set_color normal)

end
