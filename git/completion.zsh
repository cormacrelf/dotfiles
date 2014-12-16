# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
# completion=/usr/local/etc/bash_completion.d/git-completion.bash
# completion=export FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"

#if test -f $completion
#then
#  source $completion
#fi

# error WARNING: this script is deprecated, please see git-completion.zsh
# fixed by using https://github.com/mxcl/homebrew/issues/16992

if test -f /usr/local/share/zsh/site-functions/_git
then
  zstyle ':completion:*:*:git:*' source /usr/local/share/zsh/site-functions/_git
fi
