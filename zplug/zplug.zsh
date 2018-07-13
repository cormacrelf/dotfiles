export ZPLUG_HOME="$HOME/.zplug"
source "$ZPLUG_HOME/init.zsh" 2>/dev/null

local has-zplug () { command -v zplug 2>/dev/null >/dev/null; }
if ! [[ -d "$ZPLUG_HOME" ]]; then
    git clone --depth=1 https://github.com/zplug/zplug $ZPLUG_HOME
    source "$ZPLUG_HOME/init.zsh" && zplug update --self
    if ! has-zplug; then
        echo "Failed to install zplug."
    fi
fi

# oh-my-zsh overrides, so it knows where it is.
export DISABLE_AUTO_UPDATE="true"
export ZSH=$ZPLUG_HOME/repos/robbyrussell/oh-my-zsh
export ZSH_THEME=""

# plugins
# zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:-1
zplug "lib/*", from:oh-my-zsh, nice:0
zplug "plugins/dirhistory/dirhistory.plugin.zsh", from:oh-my-zsh, nice:0
zplug "jreese/zsh-titles"
zplug "unixorn/tumult.plugin.zsh" # osx
zplug "peterhurford/git-it-on.zsh" # term->github
zplug "supercrabtree/k" # ls for git
zplug "chrissicool/zsh-256color"

# themes
zplug "oskarkrawczyk/honukai-iterm-zsh"
# zplug "tylerreckart/hyperzsh"
# zplug "cormacrelf/blunt-zsh"

# Set the priority when loading
# zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", nice:18
# this goes super last
zplug "zsh-users/zsh-history-substring-search", nice:19

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

### CONFIGURATION ###

# OPTION 1: for most systems
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# OPTION 2: for iTerm2 running on Apple MacBook laptops
zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

# Editing modes
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# remember: <C-u>/^U will abort the search.

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=bold,underline'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,standout'
