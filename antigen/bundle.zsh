ANTIGEN_DIR=$HOME/.antigen-clone
ANTIGEN_ZSH=$ANTIGEN_DIR/antigen.zsh

if [[ -a $ANTIGEN_ZSH ]]; then
    # all good!
else
    git clone https://github.com/zsh-users/antigen.git $ANTIGEN_DIR
fi

source $ANTIGEN_ZSH

antigen use oh-my-zsh

antigen bundle git
antigen bundle brew
antigen bundle pip
antigen bundle lein
antigen bundle npm
antigen bundle rbenv
antigen bundle virtualenv
antigen bundle dirhistory
antigen bundle osx
antigen bundle gem
antigen bundle history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme oskarkrawczyk/honukai-iterm-zsh honukai
# antigen theme cormacrelf/blunt-zsh blunt

antigen apply

