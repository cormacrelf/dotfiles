function fish_user_key_bindings
    # redo fzf ones
    # \ct was transpose-char
    # \cf was find file, but more useful as complete full line
    bind \ct '__fzf_find_file'
    bind -M insert \ct '__fzf_find_file'
    bind \cf 'forward-char'
    bind -M insert \cf 'forward-char'
end
