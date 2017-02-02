function v
	fzf > $TMPDIR/fzf.result
	and set -l __file (cat $TMPDIR/fzf.result | sed 's/ /\\\ /g')
	and commandline "vim $__file"
end
