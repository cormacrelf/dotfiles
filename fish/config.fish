
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

# fisherman bootstrap
if not test -f ~/.config/fish/functions/fisher.fish
  echo "Installing fisherman for the first time"
  curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
  fisher
end

set -g default_user cormac # for themes

# path -- don't add segments if they don't exist, so fish doesn't complain
function _pathadd
  test -d $argv; and set -gx PATH $argv $PATH
end
_pathadd $HOME/bin
_pathadd $HOME/.dotfiles/bin
_pathadd $HOME/Library/Python/2.7/bin
_pathadd $HOME/go/bin
_pathadd $HOME/.local/bin
# last specified has priority

# abbreviations / aliases
set -gx EDITOR "nvim"
set -g DOTFILES "$HOME/.dotfiles"
set -g CONFIG "$HOME/.config"
set -g FISHCONFIG "$HOME/.config/fish/config.fish"
abbr -a -- - 'cd -'
alias ef="$EDITOR $CONFIG/fish/config.fish"

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
source ~/.asdf/asdf.fish

function bsr
  brew services restart $argv
end

function bss
  brew services start $argv
end

function bsstop
  brew services stop $argv
end

