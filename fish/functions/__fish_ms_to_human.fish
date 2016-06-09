function __fish_ms_to_human -d "Get last command duration in human readable format"
	set -l __time $argv
	set -l __string ""

	# Print hours
	set __time_hours_total ( math $__time/3600000 )
	if [ "$__time_hours_total" -gt 0 ]
		set __string ( printf "%shrs " $__time_hours_total )
	end

	# Print minutes
	set __time_ms_left ( math $__time%3600000 )
	set __time_mins_total ( math $__time_ms_left/60000 )	
	if [ "$__time_mins_total" -gt 0 ]
		 set __string ( printf "%s%smins " $__string $__time_mins_total )
	end
	
	# Print seconds
	set __time_ms_left ( math $__time%60000 )
	set __time_sec_left ( math $__time_ms_left/1000 )
	if [ "$__time_sec_left" -gt 0 ]
		set __string ( printf "%s%ss " $__string $__time_sec_left )
	end

	# Print ms
	set __time_ms_left ( math $__time%1000 )
	if [ "$__time_ms_left" -gt 0 ] 
		set __string ( printf "%s%sms" $__string $__time_ms_left )
	end

	# If empty use a simple bullet
	if [ ( string length "$__string" ) -eq 0  ]
		set __string "•"
	end

	# output the string
	echo -n $__string

end
