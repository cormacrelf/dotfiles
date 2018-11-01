# bindkey -v
# bindkey "^[[A" up-history
# bindkey "^[[B" down-history
# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line
# bindkey "^H" backward-delete-char
# bindkey "^U" backward-kill-line
# bindkey "^?" backward-delete-char
# bindkey "^[[2~" beep
# bindkey "^[[5~" vi-backward-blank-word
# bindkey "^[[6~" vi-forward-blank-word


# set VISUAL to vim so it can edit-command-line (mvim can't)
export VISUAL=vim

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
# Vi style:
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
