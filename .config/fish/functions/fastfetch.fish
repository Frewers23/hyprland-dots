function fastfetch --description 'wrapper for dynamic scaling'
    if test $COLUMNS -lt 75
        command fastfetch --logo none $argv
    else
        command fastfetch $argv
    end
end
