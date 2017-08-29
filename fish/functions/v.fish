function v
	fzf > /tmp/fzf.result
	and set -l __file (cat /tmp/fzf.result | sed 's/ /\\\ /g')
	and commandline "vim $__file"
end
