alias reload!="source $HOME/.zshrc"

alias ok="echo 'F.A.B., Thunderbird 2.'"
alias szh='source ~/.zshrc'
alias ql='qlmanage -p "$@" >& /dev/null'

alias bi="brew install"

alias vime="vim -u ~/.vimencrypt -x"
# Disable capturing of <C-s> by tty
# alias vim="stty stop '' -ixoff ; vim"

alias vtop="vtop --theme brew"

eval "$(thefuck --alias)"
alias FUCK='fuck'
alias fucking='fuck' # fucking bleep

alias curl-resume="curl -C - -L"

alias statm="stat -c '%a %n'"

alias g=git
