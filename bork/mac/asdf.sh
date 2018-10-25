COMPL="$HOME/.config/fish/completions"

ok github $HOME/.asdf asdf-vm/asdf --ref=v0.6.0
ok directory "$COMPL"
ok symlink "$COMPL/asdf.fish" "$HOME/.asdf/asdf.fish"

fish -c 'asdf plugin-add nodejs'
bash $HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring
fish -c 'asdf install nodejs 10.12.0'
