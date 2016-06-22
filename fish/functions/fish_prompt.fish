function fish_prompt --description 'Write out the prompt'

	# Grab the last status
	set -l __last_status $status
	
	# Just calculate these once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end

	# Grab hostname and user
	set -l __prompt_user_host $__fish_prompt_hostname	
	switch $USER
	case root
		set __prompt_user_host "root@"$__fish_prompt_hostname
	case '*'
		# Only use the current user if needed
		if test $USER != $LOGNAME
			set __prompt_user_host $USER"@"$__fish_prompt_hostname
		end
	end

	# Construct a base prompt with space for colors
	set __prompt_base "%s╔═ %s"(date +%H:%M:%S)" "$__prompt_user_host

	# Sort out the CWD shortened only if needed
	set __prompt_command_len (echo $__prompt_base $PWD | sed -r "s/%s//g" | wc -m)
	if math "$__prompt_command_len>$COLUMNS" > /dev/null
		set -g fish_prompt_pwd_dir_length 1
	else
		set -g fish_prompt_pwd_dir_length 0
	end

	# Assemble our top and bottom lines
	set __prompt_full_top $__prompt_base"%s:%s"(prompt_pwd)"\n"
	set __prompt_bottom_line "%s╚═%s "

	# Choose colour
	set __main_color 004488
	set __decoration_colour 444444 
	if test $__last_status -gt 0
		set __decoration_colour red
	end

	# Colorise the output
	printf $__prompt_full_top (set_color $__decoration_colour) \
	                          (set_color $__main_color) \
	                          (set_color $__decoration_colour) \
	                          (set_color -o $__main_color)

	printf $__prompt_bottom_line (set_color $__decoration_colour) \
	                             (set_color normal)

end
