#!/usr/bin/bash
if command -v tmux>/dev/null; then
	if [[ ! $TERM =~ screen ]] && [ -z $TMUX ]; then
		SESSION=$( tmux ls -F '#{session_name} #{?session_attached,attached,unattached}' | grep unattached | head -n 1 | awk '{print $1}' )
		if [[ ! -z $SESSION ]]; then
			tmux a -t $SESSION
		else
			tmux
		fi
	fi
fi
