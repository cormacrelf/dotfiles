ok directory $HOME/git
ok github $HOME/git/alacritty jwilm/alacritty
if did_update; then
  needs_exec "cargo" || exit $STATUS_FAILED_PRECONDITION
  include alacritty.sh
fi

# mac app store

ok brew
ok brew mas

ok mas 904280696 Things
ok mas 403504866 PCalc
ok mas 443987910 1Password6.9

# casks

ok cask firefox
ok cask google-chrome
ok cask alfred
ok cask gitup
ok cask keybase
ok cask hex-fiend
ok cask dropbox
