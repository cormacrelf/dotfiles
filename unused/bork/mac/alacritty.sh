#!/bin/bash

cd $HOME/git/alacritty
git pull
make app
cargo install --force --path .
rm -rf /Applications/Alacritty.app
cp -r target/release/osx/Alacritty.app /Applications/
cp alacritty-completions.fish $HOME/.dotfiles/fish/completions/
sudo tic -x alacritty.info # install terminfo database entry
