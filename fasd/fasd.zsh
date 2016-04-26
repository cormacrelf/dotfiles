fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache"  ]; then
  fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

