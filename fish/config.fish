# separate fisher install
set -l normal_fish $HOME/.config/fish
set -g fisher_path $HOME/.config/fish/erman
mkdir -p $fisher_path
set -g fish_function_path $normal_fish/functions $fisher_path/functions $fish_function_path 
set -g fish_complete_path $normal_fish/completions $fisher_path/completions $fish_complete_path
function source_confd
  for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
  end
end
# fisherman bootstrap
if not test -f $fisher_path/functions/fisher.fish
  echo "... installing fisher to $fisher_path ..."
  curl https://git.io/fisher --create-dirs -sLo $fisher_path/functions/fisher.fish
  fisher
end
source_confd

set fish_greeting ""

set -g fishconfig ~/.config/fish/config.fish

# pure uses this deliberately. ugh.
function fish_default_mode_prompt; end

function fish_mode_prompt --description 'Displays the current mode'
  # Do nothing if not in vi mode
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color --bold red
        echo "N"
      case insert
        set_color --bold green
        echo "⌁"
      case replace_one
        set_color --bold green
        echo "R"
      case visual
        set_color --bold brmagenta
        echo "V"
      end
    set_color normal
    echo -n " "
  end
end
function fish_vi_cursor; end

fish_vi_key_bindings

set -g default_user cormac # for themes

# path -- don't add segments if they don't exist, so fish doesn't complain
function _pathadd
  test -d $argv; and set -gx PATH $argv $PATH
end
_pathadd $HOME/bin
_pathadd $HOME/.dotfiles/bin
_pathadd $HOME/Library/Python/2.7/bin
_pathadd $HOME/Library/Python/3.7/bin
_pathadd $HOME/go/bin
_pathadd $HOME/.local/bin
_pathadd $HOME/esp/xtensa-lx106-elf/bin

set -gx IDF_PATH "$HOME/esp/ESP8266_RTOS_SDK"
# last specified has priority

# abbreviations / aliases
set -gx EDITOR "nvim"
set -g DOTFILES "$HOME/.dotfiles"
set -g CONFIG "$HOME/.config"
set -g FISHCONFIG "$HOME/.config/fish/config.fish"
abbr -a -- - 'cd -'
alias ef="$EDITOR $CONFIG/fish/config.fish"
alias tf="terraform"

# fzf native
set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# fzf via fish plugin
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_FIND_FILE_COMMAND "fd --type f"
set -U FZF_CD_COMMAND "fd --type d"
set -U FZF_CD_WITH_HIDDEN_COMMAND "fd --type d --hidden"
set -U FZF_FIND_AND_EXECUTE_COMMAND "fd --type x"
# set -u FZF_REVERSE_ISEARCH_COMMAND "..."
set -U FZF_OPEN_COMMAND "fd --type f"

abbr :q 'exit'
abbr md 'mkdir -p'

function bsr
  brew services restart $argv
end

function bss
  brew services start $argv
end

function bsstop
  brew services stop $argv
end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cormac/google-cloud-sdk/path.fish.inc' ]; . '/Users/cormac/google-cloud-sdk/path.fish.inc'; end

# opam configuration
source /Users/cormac/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

source /usr/local/Cellar/asdf/0.8.0/asdf.fish
