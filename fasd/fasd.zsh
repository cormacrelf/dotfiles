# Set up cache and hooks

fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache"  ]; then
  fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# Set aliases

alias v='fasd -a -e  vim' # quick opening files with vim
alias m='fasd -a -e mvim' # quick opening files with mvim
alias o='a -e open' # quick opening files with xdg-open

alias a='fasd -a'
alias si='fasd -si'
alias sid='fasd -sid'
alias sif='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
# function to execute built-in cd
fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
  fi
}

# quick cd into directories, mimicking autojump and z
alias z='fasd_cd -d'
alias j='fasd_cd -d'
alias zz='fasd_cd -d -i'
