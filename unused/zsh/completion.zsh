# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/functions $fpath)
