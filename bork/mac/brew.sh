register types/pip3.sh

ok brew
ok brew-tap Homebrew/cask

ok brew bork
ok brew git
ok brew fzf
ok brew ripgrep
ok brew fd
ok brew jq
ok brew coreutils
ok brew moreutils
ok brew binutils
ok brew rsync
ok brew ssh-copy-id
ok brew tree
ok brew hexedit
ok brew wget
ok brew repl
ok brew ispell
ok brew nmap
ok brew cmake
ok brew tig
ok brew ranger

plug_install () {
  nvim +PlugInstall +UpdateRemotePlugins +qa
}
ok brew python
ok brew neovim
if did_install; then plug_install; fi
ok pip3 neovim
if did_update; then plug_install; fi

ok brew fish
if did_install; then
  echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

# for pbcopy support
ok brew reattach-to-user-namespace
ok brew tmux

ok brew rustup-init
if did_install; then
  rustup-init
fi

