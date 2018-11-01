alias reload!="source $HOME/.zshrc"
alias szh='source ~/.zshrc'
alias ql='qlmanage -p "$@" >& /dev/null'
alias bi="brew install"
alias bu="brew upgrade"
# Disable capturing of <C-s> by tty
# alias vim="stty stop '' -ixoff ; vim"
alias vtop="vtop --theme brew"
alias curl-resume="curl -C - -L"
alias statm="stat -c '%a %n'"
alias g=git
alias weather="ansiweather -l Canberra -a false"

alias bs "brew services"
alias bsr="brew services restart"
alias bss="brew services start"
alias bsx="brew services stop"
alias kc="kubectl"
alias tf=terraform
