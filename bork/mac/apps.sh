ok directory $HOME/git
ok github $HOME/git/alacritty jwilm/alacritty
if did_update; then
  needs_exec "cargo" || exit $STATUS_FAILED_PRECONDITION
  cd $HOME/git/alacritty
  make app
  cargo install --path .
  rm -rf /Applications/Alacritty.app
  cp -r target/release/osx/Alacritty.app /Applications/
  cp alacritty-completions.fish $HOME/.dotfiles/fish/completions/
fi

# mac app store

ok brew
ok brew mas

ok mas 904280696 Things
ok mas 403504866 PCalc

# casks

ok cask firefox
ok cask gitup
