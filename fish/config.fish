set fish_greeting ""

# fisherman bootstrap
if not test -f ~/.config/fish/functions/fisher.fish
  echo "Installing fisherman for the first time"
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  fisher
  fisher omf/theme-bobthefish
  fisher omf/theme-batman
end

# path
set -gx PATH $HOME/bin $HOME/.dotfiles/bin $PATH

# abbreviations / aliases
set -gx EDITOR "nvim"
abbr -a -- - 'cd -'

# nvm plugin
# put the shims in a nvm-shims directory
set -gx PATH /usr/local/bin $HOME/.dotfiles/nvm-shims $PATH
set -g nvm_alias_output $HOME/.dotfiles/nvm-shims

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
