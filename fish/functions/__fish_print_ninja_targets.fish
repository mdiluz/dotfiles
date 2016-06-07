function __fish_print_ninja_targets
	if test -f build.ninja
		ninja -t targets | cut -d : -f 1 | sed -E '/pch_dephelp/d'
	end
end
