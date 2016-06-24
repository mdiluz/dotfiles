function __fish_test_string
    # has string? (latest fish)
    if not set -q __fish_has_string
        if type string > /dev/null
            set -g __fish_has_string 0
        else
            set -g __fish_has_string 1
        end 
    end
	return $__fish_has_string
end
