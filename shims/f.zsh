eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp)"


alias v='fasd -a -e  vim' # quick opening files with vim
alias m='fasd -a -e mvim' # quick opening files with mvim
alias j='fasd_cd -d' # quick cd into directories, mimicking autojump and z
alias o='a -e open' # quick opening files with xdg-open
