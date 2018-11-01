# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
    alias ls="gls -F --color"
    alias l="gls -lAh --color"
    alias ll="gls -l --color"
    alias la='gls -A --color'
fi

alias deactivate-dynamic-pager="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
alias activate-dynamic-pager="sudo launchctl load -wF /System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
